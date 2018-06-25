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
      
      public function templateDataSetup(dataList:Array) : void
      {
         itemInfoList = dataList;
      }
      
      private function pkgHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var type:int = pkg.readByte();
         switch(int(type) - 1)
         {
            case 0:
               initPlayerData(pkg);
               break;
            case 1:
               updateCount(pkg);
               break;
            case 2:
               startFiveCountDown(pkg);
               break;
            case 3:
               beginRace(pkg);
               break;
            case 4:
               syn_onesecond(pkg);
               break;
            case 5:
               allPlayerRaceEnd(pkg);
               break;
            case 6:
               flush_buffItem(pkg);
               break;
            default:
               flush_buffItem(pkg);
               break;
            case 8:
               playerSpeedChange(pkg);
               break;
            case 9:
               playerRaceEnd(pkg);
               break;
            case 10:
               show_msg(pkg);
         }
      }
      
      private function updateCount(pkg:PackageIn) : void
      {
         horseRaceCanRaceTime = pkg.readInt();
         if(_matchView)
         {
            _matchView.reflushHorseRaceTime();
         }
      }
      
      private function show_msg(pkg:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_SHOW_MSG",pkg));
      }
      
      private function flush_buffItem(pkg:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_BUFF_ITEMFLUSH",pkg));
      }
      
      private function syn_onesecond(pkg:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_SYN_ONESECOND",pkg));
      }
      
      private function allPlayerRaceEnd(pkg:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_ALLPLAYER_RACEEND",pkg));
      }
      
      private function initPlayerData(pkg:PackageIn) : void
      {
         _matchView.dispose2();
         showRaceView();
         dispatchEvent(new HorseRaceEvents("horseRace_initPlayer",pkg));
      }
      
      private function startFiveCountDown(pkg:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_START_FIVE",pkg));
      }
      
      private function beginRace(pkg:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_BEGIN_RACE",pkg));
      }
      
      private function playerSpeedChange(pkg:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_PLAYERSPEED_CHANGE",pkg));
      }
      
      private function playerRaceEnd(pkg:PackageIn) : void
      {
         dispatchEvent(new HorseRaceEvents("HORSERACE_RACE_END",pkg));
      }
      
      private function _open_close(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = event._cmd;
         if(!(int(cmd) - 160))
         {
            openOrclose(pkg);
         }
      }
      
      public function get isShowIcon() : Boolean
      {
         return _isShowIcon;
      }
      
      private function openOrclose(pkg:PackageIn) : void
      {
         _isShowIcon = pkg.readBoolean();
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
         var chatData:ChatData = new ChatData();
         chatData.channel = 21;
         chatData.childChannelArr = [7,14];
         chatData.type = 889;
         chatData.msg = LanguageMgr.GetTranslation("horseRace.sysOpentxt");
         ChatManager.Instance.chat(chatData);
      }
      
      private function disposeEnterIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("horseRace",false);
      }
      
      protected function __onClose(event:Event) : void
      {
         UIModuleSmallLoading.Instance.hide();
         UIModuleSmallLoading.Instance.removeEventListener("close",__onClose);
         UIModuleLoader.Instance.removeEventListener("uiMoudleProgress",__progressShow);
         UIModuleLoader.Instance.removeEventListener("uiModuleComplete",__completeShow);
      }
      
      private function __progressShow(event:UIModuleEvent) : void
      {
         if(event.module == "horseRace")
         {
            UIModuleSmallLoading.Instance.progress = event.loader.progress * 100;
         }
      }
      
      private function __completeShow(event:UIModuleEvent) : void
      {
         if(event.module == "horseRace")
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
