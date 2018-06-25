package roomList.pvpRoomList{   import ddt.data.player.PlayerInfo;   import ddt.manager.PlayerManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import road7th.data.DictionaryData;   import room.model.RoomInfo;      public class RoomListModel extends EventDispatcher   {            public static const ROOMSHOWMODE_CHANGE:String = "roomshowmodechange";            public static const ROOM_ITEM_UPDATE:String = "roomItemUpdate";                   private var _roomList:DictionaryData;            private var _playerlist:DictionaryData;            private var _self:PlayerInfo;            private var _roomTotal:int;            private var _roomShowMode:int;            private var _temListArray:Array;            private var _isAddEnd:Boolean;            public function RoomListModel() { super(); }
            public function getSelfPlayerInfo() : PlayerInfo { return null; }
            public function get isAddEnd() : Boolean { return false; }
            public function updateRoom(arr:Array) : void { }
            public function set roomTotal(value:int) : void { }
            public function get roomTotal() : int { return 0; }
            public function getRoomById(id:int) : RoomInfo { return null; }
            public function getRoomList() : DictionaryData { return null; }
            public function addWaitingPlayer(info:PlayerInfo) : void { }
            public function removeWaitingPlayer(id:int) : void { }
            public function getPlayerList() : DictionaryData { return null; }
            public function get roomShowMode() : int { return 0; }
            public function set roomShowMode(value:int) : void { }
            public function dispose() : void { }
   }}