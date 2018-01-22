package goldmine
{
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.IEventDispatcher;
   import goldmine.model.GoldmineModel;
   import hall.IHallStateView;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class GoldmineManager extends CoreManager
   {
      
      public static const SHOW_VIEW:String = "goldmine_showview";
      
      public static const ClOSE_VIEW:String = "goldmine_closeview";
      
      public static const USE_GOLDMINE:String = "goldmine_use";
      
      private static var _instance:GoldmineManager;
       
      
      private var _isOpen:Boolean = false;
      
      private var _icon:BaseButton;
      
      private var _hall:IHallStateView;
      
      private var _dateStart:Date;
      
      private var _dateEnd:Date;
      
      private var _model:GoldmineModel;
      
      public function GoldmineManager(param1:IEventDispatcher = null)
      {
         _dateStart = new Date();
         _dateEnd = new Date();
         super(param1);
         initEvent();
      }
      
      public static function get Instance() : GoldmineManager
      {
         if(_instance == null)
         {
            _instance = new GoldmineManager();
         }
         return _instance;
      }
      
      public function get dateStart() : Date
      {
         return _dateStart;
      }
      
      public function get dateEnd() : Date
      {
         return _dateEnd;
      }
      
      public function get model() : GoldmineModel
      {
         return _model;
      }
      
      public function setup() : void
      {
         _model = new GoldmineModel();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(624,1),__onIsOpen);
         SocketManager.Instance.addEventListener(PkgEvent.format(624,3),__onInit);
         SocketManager.Instance.addEventListener(PkgEvent.format(624,2),__onUse);
      }
      
      private function __onIsOpen(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:Boolean = _loc2_.readBoolean();
         _isOpen = _loc3_;
         if(_isOpen)
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("goldmine.beginTips"));
         }
         else
         {
            ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("goldmine.endTips"));
         }
         updataEnterIcon(_isOpen);
         if(!_isOpen)
         {
            this.dispatchEvent(new CEvent("goldmine_closeview"));
         }
      }
      
      private function __onInit(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc2_:PackageIn = param1.pkg;
         _dateStart = _loc2_.readDate();
         _dateEnd = _loc2_.readDate();
         _model.usedTimes = _loc2_.readInt();
         _model.score = _loc2_.readInt();
         _model.maxTimes = _loc2_.readInt();
         _model.goldArr = new Array(_model.maxTimes);
         _model.goldNeedArr = new Array(_model.maxTimes);
         _loc5_ = 0;
         while(_loc5_ < _model.maxTimes)
         {
            _model.goldArr[_loc5_] = _loc2_.readInt();
            _model.goldNeedArr[_loc5_] = _loc2_.readInt();
            _loc5_++;
         }
         _model.mineSmall = _loc2_.readInt();
         _model.mineMiddle = _loc2_.readInt();
         _model.mineBig = _loc2_.readInt();
         var _loc4_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _model.maxTimes)
         {
            if(_model.score >= _model.goldArr[_loc3_])
            {
               _loc4_++;
            }
            _loc3_++;
         }
         _model.currentTimes = _loc4_ - _model.usedTimes;
         if(_loc4_ <= _model.maxTimes)
         {
            _model.nextScoreNeed = _model.goldArr[_loc4_] - _model.score;
         }
         this.dispatchEvent(new CEvent("goldmine_showview"));
      }
      
      private function __onUse(param1:PkgEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         var _loc4_:int = -1;
         if(_loc2_ == _model.mineSmall)
         {
            _loc4_ = 0;
         }
         else if(_loc2_ == _model.mineMiddle)
         {
            _loc4_ = 2;
         }
         else if(_loc2_ == _model.mineBig)
         {
            _loc4_ = 1;
         }
         _model.mineSmall = _loc3_.readInt();
         _model.mineMiddle = _loc3_.readInt();
         _model.mineBig = _loc3_.readInt();
         this.dispatchEvent(new CEvent("goldmine_use",[_loc4_,_loc2_]));
      }
      
      public function testUse(param1:int = 8666) : void
      {
         var _loc2_:* = param1;
         var _loc3_:int = -1;
         if(_loc2_ == _model.mineSmall)
         {
            _loc3_ = 0;
         }
         else if(_loc2_ == _model.mineMiddle)
         {
            _loc3_ = 2;
         }
         else if(_loc2_ == _model.mineBig)
         {
            _loc3_ = 1;
         }
         this.dispatchEvent(new CEvent("goldmine_use",[_loc3_,_loc2_]));
      }
      
      public function updataEnterIcon(param1:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("goldmine",param1);
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["goldmine"],function():void
         {
            GameInSocketOut.sendGoldmineInfoAttribute();
         });
      }
   }
}
