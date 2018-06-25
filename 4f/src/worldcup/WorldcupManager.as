package worldcup{   import ddt.events.CEvent;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import flash.events.EventDispatcher;   import hallIcon.HallIconManager;      public class WorldcupManager extends EventDispatcher   {            private static var _instance:WorldcupManager;            public static var OPEN_VIEW:String = "openWorldcupView";            public static var CLEAR_GUESS:String = "clearGuess";            public static var GUESS:String = "guess";            public static var GET_PRIZE_OK:String = "getPrizeOk";                   private var _model:WorldcupModel;            public function WorldcupManager(single:inner) { super(); }
            public static function get instance() : WorldcupManager { return null; }
            public function get model() : WorldcupModel { return null; }
            public function setup() : void { }
            private function worldcupHandler(e:CrazyTankSocketEvent) : void { }
            private function checkIcon() : void { }
            private function show() : void { }
            private function openView() : void { }
   }}class inner{          function inner() { super(); }
}