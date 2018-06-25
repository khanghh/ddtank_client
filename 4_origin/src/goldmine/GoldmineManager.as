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
      
      public function GoldmineManager(target:IEventDispatcher = null)
      {
         _dateStart = new Date();
         _dateEnd = new Date();
         super(target);
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
      
      private function __onIsOpen(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var isOpen:Boolean = pkg.readBoolean();
         _isOpen = isOpen;
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
      
      private function __onInit(e:PkgEvent) : void
      {
         var i:int = 0;
         var j:int = 0;
         var pkg:PackageIn = e.pkg;
         _dateStart = pkg.readDate();
         _dateEnd = pkg.readDate();
         _model.usedTimes = pkg.readInt();
         _model.score = pkg.readInt();
         _model.maxTimes = pkg.readInt();
         _model.goldArr = new Array(_model.maxTimes);
         _model.goldNeedArr = new Array(_model.maxTimes);
         for(i = 0; i < _model.maxTimes; )
         {
            _model.goldArr[i] = pkg.readInt();
            _model.goldNeedArr[i] = pkg.readInt();
            i++;
         }
         _model.mineSmall = pkg.readInt();
         _model.mineMiddle = pkg.readInt();
         _model.mineBig = pkg.readInt();
         var currentTimes:int = 0;
         for(j = 0; j < _model.maxTimes; )
         {
            if(_model.score >= _model.goldArr[j])
            {
               currentTimes++;
            }
            j++;
         }
         _model.currentTimes = currentTimes - _model.usedTimes;
         if(currentTimes <= _model.maxTimes)
         {
            _model.nextScoreNeed = _model.goldArr[currentTimes] - _model.score;
         }
         this.dispatchEvent(new CEvent("goldmine_showview"));
      }
      
      private function __onUse(e:PkgEvent) : void
      {
         var pkg:PackageIn = e.pkg;
         var bindGold:int = pkg.readInt();
         var prizeType:int = -1;
         if(bindGold == _model.mineSmall)
         {
            prizeType = 0;
         }
         else if(bindGold == _model.mineMiddle)
         {
            prizeType = 2;
         }
         else if(bindGold == _model.mineBig)
         {
            prizeType = 1;
         }
         _model.mineSmall = pkg.readInt();
         _model.mineMiddle = pkg.readInt();
         _model.mineBig = pkg.readInt();
         this.dispatchEvent(new CEvent("goldmine_use",[prizeType,bindGold]));
      }
      
      public function testUse(gold:int = 8666) : void
      {
         var bindGold:* = gold;
         var prizeType:int = -1;
         if(bindGold == _model.mineSmall)
         {
            prizeType = 0;
         }
         else if(bindGold == _model.mineMiddle)
         {
            prizeType = 2;
         }
         else if(bindGold == _model.mineBig)
         {
            prizeType = 1;
         }
         this.dispatchEvent(new CEvent("goldmine_use",[prizeType,bindGold]));
      }
      
      public function updataEnterIcon(flag:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("goldmine",flag);
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
