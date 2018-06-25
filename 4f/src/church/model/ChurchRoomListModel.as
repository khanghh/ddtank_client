package church.model{   import ddt.data.ChurchRoomInfo;   import road7th.data.DictionaryData;      public class ChurchRoomListModel   {                   private var _roomList:DictionaryData;            public function ChurchRoomListModel() { super(); }
            public function get roomList() : DictionaryData { return null; }
            public function addRoom(info:ChurchRoomInfo) : void { }
            public function removeRoom(id:int) : void { }
            public function updateRoom(info:ChurchRoomInfo) : void { }
            public function dispose() : void { }
   }}