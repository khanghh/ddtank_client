package hotSpring.model{   import ddt.data.HotSpringRoomInfo;   import ddt.manager.HotSpringManager;   import flash.events.EventDispatcher;   import hotSpring.event.HotSpringRoomListEvent;   import road7th.data.DictionaryData;      public class HotSpringRoomListModel extends EventDispatcher   {            private static var _instance:HotSpringRoomListModel;                   private var _roomList:DictionaryData;            private var _roomSelf:HotSpringRoomInfo;            public function HotSpringRoomListModel() { super(); }
            public static function get Instance() : HotSpringRoomListModel { return null; }
            public function get roomList() : DictionaryData { return null; }
            public function roomAddOrUpdate(roomVO:HotSpringRoomInfo) : void { }
            public function roomRemove(roomID:int) : void { }
            public function get roomSelf() : HotSpringRoomInfo { return null; }
            public function set roomSelf(value:HotSpringRoomInfo) : void { }
            public function dispose() : void { }
   }}