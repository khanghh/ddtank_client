package horseRace.controller
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.view.UIModuleSmallLoading;
   import ddt.view.chat.ChatData;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import hallIcon.HallIconManager;
   import horseRace.events.HorseRaceEvents;
   import horseRace.view.HorseRaceMatchView;
   import horseRace.view.HorseRaceView;
   import road7th.comm.PackageIn;
   
   public class HorseRaceManager extends EventDispatcher
   {
      
      private static var _instance:HorseRaceManager;
      
      public static var loadComplete:Boolean = false;
       
      
      private var _isShowIcon:Boolean;
      
      private var _matchView:HorseRaceMatchView;
      
      public var showBuyCountFram:Boolean = true;
      
      public var showPingzhangBuyFram:Boolean = true;
      
      private var _horseRaceView:HorseRaceView;
      
      public var horseRaceCanRaceTime:int = 0;
      
      public var itemInfoList:Array;
      
      public var buffCD:int;
      
      public function HorseRaceManager()
      {
         super();
      }
      
      public static function get Instance() : HorseRaceManager
      {
         if(_instance == null)
         {
            _instance = new HorseRaceManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("horseRace_open_close",_open_close);
         SocketManager.Instance.addEventListener("horseRace_cmd",pkgHandler);
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         itemInfoList = param1;
      }
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         var _loc3_:int = _loc2_.readByte();
         switch(int(_loc3_) - 1)
         {
            case 0:
               initPlayerData(_loc2_);
               break;
            case 1:
               updateCount(_loc2_);
               break;
            case 2:
               startFiveCountDown(_loc2_);
               break;
            case 3:
               beginRace(_loc2_);
               break;
            case 4:
               syn_onesecond(_loc2_);
               break;
            case 5:
               allPlayerRaceEnd(_loc2_);
               break;
            case 6:
               flush_buffItem(_loc2_);
               break;
            default:
               flush_buffItem(_loc2_);
               break;
            case 8:
               playerSpeedChange(_loc2_);
               break;
            case 9:
               playerRaceEnd(_loc2_);
               break;
            case 10:
               show_msg(_loc2_);
         }
      }
      
      private function updateCount(param1:PackageIn) : void
      {
         horseRaceCanRaceTime = param1.readInt();
         if(_matchView)
         {
            _matchView.reflushHorseRaceTime();
         }
      }
      
      private function show_msg(param1:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_SHOW_MSG",param1));
      }
      
      private function flush_buffItem(param1:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_BUFF_ITEMFLUSH",param1));
      }
      
      private function syn_onesecond(param1:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_SYN_ONESECOND",param1));
      }
      
      private function allPlayerRaceEnd(param1:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_ALLPLAYER_RACEEND",param1));
      }
      
      private function initPlayerData(param1:PackageIn) : void
      {
         _matchView.dispose2();
         showRaceView();
         dispatchEvent(new HorseRaceEvents("horseRace_initPlayer",param1));
      }
      
      private function startFiveCountDown(param1:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_START_FIVE",param1));
      }
      
      private function beginRace(param1:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_BEGIN_RACE",param1));
      }
      
      private function playerSpeedChange(param1:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_PLAYERSPEED_CHANGE",param1));
      }
      
      private function playerRaceEnd(param1:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_RACE_END",param1));
      }
      
      private function _open_close(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = param1._cmd;
         if(!(int(_loc2_) - 160))
         {
            openOrclose(_loc3_);
         }
      }
      
      public function get isShowIcon() : Boolean
      {
         return _isShowIcon;
      }
      
      private function openOrclose(param1:PackageIn) : void
      {
         _isShowIcon = param1.readBoolean();
         if(_isShowIcon)
         {
            addEnterIcon();
         }
         else
         {
            disposeEnterIcon();
            if(_matchView)
            {
               _matchView.dispose();
            }
            LayerManager.Instance.clearnGameDynamic();
         }
      }
      
      public function enterView() : void
      {
         if(loadComplete)
         {
            showMatchView();
         }
         else
         {
            UIModuleSmallLoading.Instance.progress = 0;
            UIModuleSmallLoading.Instance.show();
            UIModuleSmallLoading.Instance.addEventListener("close",__onClose);
            UIModuleLoader.Instance.addEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.addEventListener("uiModuleComplete",__completeShow);
            UIModuleLoader.Instance.addUIModuleImp("horseRace");
         }
      }
      
      private function showMatchView() : void
      {
         _matchView = ComponentFactory.Instance.creatComponentByStylename("horseRace.race.matchView");
         LayerManager.Instance.addToLayer(_matchView,2,true,2);
      }
      
      public function showRaceView() : void
      {
         _horseRaceView = new HorseRaceView();
         LayerManager.Instance.addToLayer(_horseRaceView,2,false,0);
      }
      
      public function addEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("horseRace",true);
         var _loc1_:ChatData = new ChatData();
         _loc1_.channel = 21;
         _loc1_.childChannelArr = [7,14];
         _loc1_.type = 889;
         _loc1_.msg = LanguageMgr.GetTranslation("horseRace.sysOpentxt");
         ChatManager.Instance.chat(_loc1_);
      }
      
      private function disposeEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("horseRace",false);
      }
      
      protected function __onClose(param1:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
      }
      
      private function __progressShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "horseRace")
         {
            UIModuleSmallLoading.Instance.progress = param1.loader.progress * 100;
         }
      }
      
      private function __completeShow(param1:UIModuleEvent) : void
      {
         if(param1.module == "horseRace")
         {
            UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
            UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
            UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
            UIModuleSmallLoading.Instance.hide();
            loadComplete = true;
            showMatchView();
         }
      }
   }
}
