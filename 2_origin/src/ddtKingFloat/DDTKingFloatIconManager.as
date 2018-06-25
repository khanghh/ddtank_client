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
      
      private function pkgHandler(event:CrazyTankSocketEvent) : void
      {
         var start:Boolean = false;
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readByte();
         if(cmd == 1)
         {
            pkg.readInt();
            start = pkg.readBoolean();
            pkg.position = pkg.position - 6;
            if(start)
            {
               if(!_isStart)
               {
                  _isStart = true;
                  _pkg = pkg;
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
               dispatchEventPkg("floatparadepkg",pkg);
               dispatchEvent(new Event("floatParadeEnd"));
            }
            return;
         }
         pkg.position = pkg.position - 1;
         dispatchEventPkg("floatparadepkg",pkg);
      }
      
      private function loaderIcon() : void
      {
         UIModuleLoader.Instance.addEventListener("uiModuleComplete",loadIconCompleteHandler);
         UIModuleLoader.Instance.addUIModuleImp("floatParadeicon");
      }
      
      private function loadIconCompleteHandler(event:UIModuleEvent) : void
      {
         if(event.module == "floatParadeicon")
         {
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",loadIconCompleteHandler);
            _isLoadIconComplete = true;
            updateIcon(_hall);
         }
      }
      
      public function dispatchEventPkg(eventType:String = null, pkg:PackageIn = null) : void
      {
         var event:DDTKingFloatEvent = new DDTKingFloatEvent(eventType);
         event.savePkg = pkg;
         dispatchEvent(event);
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
      
      private function timerHandler(event:TimerEvent) : void
      {
         var onTime:int = 0;
         var diff:int = (_endTime.getTime() - TimeManager.Instance.Now().getTime()) / 1000;
         if(diff > 0)
         {
            onTime = diff / 3600 + 1;
            if(!_hasPrompted.hasKey(onTime) && onTime <= 48 && onTime > 0)
            {
               ChatManager.Instance.sysChatAmaranth(LanguageMgr.GetTranslation("floatParade.willEnd.promptTxt",onTime));
               _hasPrompted.add(onTime,1);
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
      
      public function updateIcon(hall:Sprite) : void
      {
         if(hall == null)
         {
            return;
         }
         _hall = hall;
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
         var tmpStartTime:Number = DateUtils.getDateByStr(ServerConfigManager.instance.findInfoByName("TankMatchBeginDate").Value).getTime();
         var tmpEndTime:Number = DateUtils.getDateByStr(ServerConfigManager.instance.findInfoByName("TankMatchEndDate").Value).getTime() + 86400000;
         var currentTime:Number = TimeManager.Instance.Now().getTime();
         if(tmpStartTime < currentTime && currentTime < tmpEndTime)
         {
            return true;
         }
         return false;
      }
      
      private function __onClickActivityBtn(e:MouseEvent) : void
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
