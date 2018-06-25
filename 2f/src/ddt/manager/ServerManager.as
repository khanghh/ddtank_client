package ddt.manager{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.QueueLoader;   import com.pickgliss.manager.CacheSysManager;   import com.pickgliss.manager.WaitTimeAlertManager;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import consortion.ConsortionModelManager;   import ddt.DDT;   import ddt.data.ServerInfo;   import ddt.data.analyze.ServerListAnalyzer;   import ddt.data.player.SelfInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.events.DuowanInterfaceEvent;   import ddt.events.PkgEvent;   import ddt.loader.StartupResourceLoader;   import ddt.view.DailyButtunBar;   import ddt.view.MainToolBar;   import email.MailManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.Timer;   import flash.utils.setTimeout;   import hall.player.HallPlayerView;   import horseRace.controller.HorseRaceManager;   import pet.sprite.PetSpriteManager;   import quest.TaskManager;   import road7th.comm.PackageIn;   import trainer.controller.SystemOpenPromptManager;      [Event(name="change",type="flash.events.Event")]   public class ServerManager extends EventDispatcher   {            public static const CHANGE_SERVER:String = "changeServer";            public static var AUTO_UNLOCK:Boolean = false;            private static const CONNENT_TIME_OUT:int = 30000;            private static var _instance:ServerManager;                   private var _list:Vector.<ServerInfo>;            private var _current:ServerInfo;            private var _zoneName:String;            private var _agentid:int;            public var refreshFlag:Boolean = false;            private var _connentTimer:Timer;            private var _loaderQueue:QueueLoader;            private var _requestCompleted:int;            public function ServerManager() { super(); }
            public static function get Instance() : ServerManager { return null; }
            public function get zoneName() : String { return null; }
            public function set zoneName(value:String) : void { }
            public function get AgentID() : int { return 0; }
            public function set AgentID(value:int) : void { }
            public function set current(value:ServerInfo) : void { }
            public function get current() : ServerInfo { return null; }
            public function get list() : Vector.<ServerInfo> { return null; }
            public function set list(value:Vector.<ServerInfo>) : void { }
            public function setup(analyzer:ServerListAnalyzer) : void { }
            public function canAutoLogin() : Boolean { return false; }
            public function connentCurrentServer() : void { }
            private function searchAvailableServer() : void { }
            public function getServerInfoByID(id:int) : ServerInfo { return null; }
            private function searchServerByState(state:int) : ServerInfo { return null; }
            public function connentServer(info:ServerInfo) : Boolean { return false; }
            private function alertControl(alert:BaseAlerFrame) : void { }
            private function __alertResponse(evt:FrameEvent) : void { }
            private function __onLoginLastServer(e:PkgEvent) : void { }
            private function __onLoginComplete(event:PkgEvent) : void { }
            private function addLoader(loader:BaseLoader) : void { }
            private function addLoaderAgain() : void { }
            private function __onSetupSourceLoadChange(event:Event) : void { }
            private function __onSetupSourceLoadComplete(event:Event) : void { }
            private function releaseLock() : void { }
            private function __onLoginCountHandler(event:CrazyTankSocketEvent) : void { }
            private function __onConfigHandler(event:CrazyTankSocketEvent) : void { }
   }}