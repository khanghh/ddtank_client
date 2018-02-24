package ddtmatch.manager
{
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperUIModuleLoad;
   import ddt.view.chat.ChatData;
   import ddtmatch.data.DDTMatchFightKingInfo;
   import ddtmatch.event.DDTMatchEvent;
   import ddtmatch.model.DDTMatchModel;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   import lanternriddles.analyzer.LanternDataAnalyzer;
   import road7th.comm.PackageIn;
   
   public class DDTMatchManager extends CoreManager
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      public static const SHOWMAINVIEW:String = "showMainView";
      
      private static var _instance:DDTMatchManager;
      
      public static var outsideRedPacket:Boolean = false;
       
      
      public var model:DDTMatchModel;
      
      public var currentViewType:int;
      
      public var expertIsBegin:Boolean;
      
      private var _questionInfo:Object;
      
      public var redPacketIsBegin:Boolean;
      
      public var matchIsBegin:Boolean;
      
      public var fightKingIsBegin:Boolean;
      
      private var itemInfoList:Array;
      
      public var list:Array;
      
      public function DDTMatchManager(){super();}
      
      public static function get instance() : DDTMatchManager{return null;}
      
      public function setup() : void{}
      
      override protected function start() : void{}
      
      private function onLoaded() : void{}
      
      public function questionInfo(param1:LanternDataAnalyzer) : void{}
      
      public function get info() : Object{return null;}
      
      private function __onExpertHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function __onRedpackettHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function __onMatchMessageHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function __onfightKingHandler(param1:CrazyTankSocketEvent) : void{}
      
      public function templateDataSetup(param1:Array) : void{}
      
      private function onBeginTips(param1:PackageIn) : void{}
      
      public function showEnterIcon() : void{}
      
      public function hideEnterIcon() : void{}
   }
}
