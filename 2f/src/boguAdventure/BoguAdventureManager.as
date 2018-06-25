package boguAdventure{   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class BoguAdventureManager   {            private static var _this:BoguAdventureManager;                   private var _isOpen:Boolean;            public function BoguAdventureManager() { super(); }
            public static function get instance() : BoguAdventureManager { return null; }
            public function setup() : void { }
            private function __onActivityState(e:CrazyTankSocketEvent) : void { }
            public function checkOpen() : void { }
            public function get isOpen() : Boolean { return false; }
   }}