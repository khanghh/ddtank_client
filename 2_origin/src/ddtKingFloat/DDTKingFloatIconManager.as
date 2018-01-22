package ddtKingFloat
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.TimeManager;
   import dragonBoat.DragonBoatManager;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import road7th.utils.DateUtils;
   
   public class DDTKingFloatIconManager extends CoreManager
   {
      
      public static const END:String = "floatParadeEnd";
      
      private static var _instance:DDTKingFloatIconManager;
       
      
      private var _isStart:Boolean;
      
      private var _isPromptDoubleTime:Boolean = false;
      
      private var _isLoadIconComplete:Boolean;
      
      private var _pkg:PackageIn;
      
      private var _timer:Timer;
      
      private var _hasPrompted:DictionaryData;
      
      private var _endTime:Date;
      
      private var _activityBtn:MovieClip;
      
      private var _hall:Sprite;
      
      public function DDTKingFloatIconManager()
      {
         super();
      }
      
      public static function get instance() : DDTKingFloatIconManager
      {
         if(!_instance)
         {
            _instance = new DDTKingFloatIconManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("ddt_king_float",pkgHandler);
      }
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:Boolean = false;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readByte();
         if(_loc2_ == 1)
         {
            _loc4_.readInt();
            _loc3_ = _loc4_.readBoolean();
            _loc4_.position = _loc4_.position - 6;
            if(_loc3_)
            {
               if(!_isStart)
               {
                  _isStart = true;
                  _pkg = _loc4_;
                  loaderIcon();
                  _endTime = DateUtils.getDateByStr(ServerConfigManager.instance.findInfoByName("NewYearEscortEndDate").Value);
                  _hasPrompted = new DictionaryData();
                  _timer = new Timer(1000);
                  _timer.addEventListener("timer",timerHandler,false,0,true);
                  _timer.start();
               }
            }
            else
            {
               _isStart = false;
               dispatchEventPkg("floatparadepkg",_loc4_);
               dispatchEvent(new Event("floatParadeEnd"));
            }
            return;
         }
         _loc4_.position = _loc4_.position - 1;
         dispatchEventPkg("floatparadepkg",_loc4_);
      }
      
      private function loaderIcon() : void
      {
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadIconCompleteHandler);
         UIModuleLoader.Instance.addUIModuleImp("floatParadeicon");
      }
      
      private function loadIconCompleteHandler(param1:UIModuleEvent) : void
      {
         if(param1.module == "floatParadeicon")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadIconCompleteHandler);
            _isLoadIconComplete = true;
            updateIcon(_hall);
         }
      }
      
      public function dispatchEventPkg(param1:String = null, param2:PackageIn = null) : void
      {
         var _loc3_:DDTKingFloatEvent = new DDTKingFloatEvent(param1);
         _loc3_.savePkg = param2;
         dispatchEvent(_loc3_);
      }
      
      override protected function start() : void
      {
         dispatchEventPkg("floatparadeOpenView",_pkg);
         _pkg = null;
      }
      
      public function get savePkg() : PackageIn
      {
         return _pkg;
      }
      
      public function get isStart() : Boolean
      {
         return _isStart;
      }
      
      private function timerHandler(param1:TimerEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = (_endTime.getTime() - TimeManager.Instance.Now().getTime()) / 1000;
         if(_loc3_ > 0)
         {
            _loc2_ = _loc3_ / 3600 + 1;
            if(!_hasPrompted.hasKey(_loc2_) && _loc2_ <= 48 && _loc2_ > 0)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("floatParade.willEnd.promptTxt",_loc2_));
               _hasPrompted.add(_loc2_,1);
            }
         }
         else
         {
            if(_timer)
            {
               _timer.removeEventListener("timer",timerHandler);
               _timer.stop();
               _timer = null;
            }
            _hasPrompted = null;
            disposeIcion();
         }
      }
      
      public function updateIcon(param1:Sprite) : void
      {
         if(param1 == null)
         {
            return;
         }
         _hall = param1;
         if(ddtKingFloatActivityStart())
         {
            if(_isLoadIconComplete)
            {
               if(!_activityBtn)
               {
                  _activityBtn = ComponentFactory.Instance.creat("asset.hall.floatParadeActivityBtn");
                  _activityBtn.x = 15;
                  _activityBtn.y = 150;
                  _activityBtn.buttonMode = true;
                  _hall.addChild(_activityBtn);
                  _activityBtn.addEventListener("click",__onClickActivityBtn);
               }
            }
            else
            {
               loaderIcon();
            }
         }
      }
      
      public function ddtKingFloatActivityStart() : Boolean
      {
         var _loc3_:Number = DateUtils.getDateByStr(ServerConfigManager.instance.findInfoByName("TankMatchBeginDate").Value).getTime();
         var _loc2_:Number = DateUtils.getDateByStr(ServerConfigManager.instance.findInfoByName("TankMatchEndDate").Value).getTime() + 86400000;
         var _loc1_:Number = TimeManager.Instance.Now().getTime();
         if(_loc3_ < _loc1_ && _loc1_ < _loc2_)
         {
            return true;
         }
         return false;
      }
      
      private function __onClickActivityBtn(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         DragonBoatManager.instance.show();
      }
      
      public function disposeIcion() : void
      {
         if(_activityBtn)
         {
            _activityBtn.removeEventListener("click",__onClickActivityBtn);
         }
         ObjectUtils.disposeObject(_activityBtn);
         _activityBtn = null;
         _hall = null;
      }
   }
}
