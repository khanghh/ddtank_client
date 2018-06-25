package wasteRecycle{   import ddt.events.PkgEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.SocketManager;   import wonderfulActivity.WonderfulActivityManager;      public class WasteRecycleManager   {            private static var _instance:WasteRecycleManager;                   private var _endDate:Date;            private var _isOpen:Boolean;            public function WasteRecycleManager() { super(); }
            public static function get Instance() : WasteRecycleManager { return null; }
            public function setup() : void { }
            private function __onActivity(e:PkgEvent) : void { }
            public function get endDate() : Date { return null; }
            public function get isOpen() : Boolean { return false; }
   }}