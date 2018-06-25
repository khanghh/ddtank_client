package roomList.pvpRoomList{   import ddt.CoreManager;   import ddt.events.CEvent;      public class RoomListManager extends CoreManager   {            private static var _instance:RoomListManager;                   private var _openMatch:Boolean = false;            public function RoomListManager() { super(); }
            public static function get instance() : RoomListManager { return null; }
            public function enter() : void { }
            public function get openMatch() : Boolean { return false; }
            public function set openMatch(value:Boolean) : void { }
            override protected function start() : void { }
   }}