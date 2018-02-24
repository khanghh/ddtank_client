package braveDoor.data
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.data.DictionaryData;
   import room.model.RoomInfo;
   import roomList.pvpRoomList.RoomListController;
   
   public class BraveDoorListModel extends EventDispatcher
   {
      
      public static const BRAVEDOOR_LIST_UPDATE:String = "BraveDoorRoomListUpdate";
      
      private static const PAGE_COUNT:int = 3;
       
      
      private var _roomList:DictionaryData;
      
      private var _roomTotal:int;
      
      private var _isAddEnd:Boolean;
      
      public function BraveDoorListModel(param1:IEventDispatcher = null){super(null);}
      
      public function updateRoom(param1:Array) : void{}
      
      public function getRoomById(param1:int) : RoomInfo{return null;}
      
      public function getRoomList() : DictionaryData{return null;}
      
      private function isOutBounds(param1:*) : Boolean{return false;}
      
      public function set roomTotal(param1:int) : void{}
      
      public function get roomTotal() : int{return 0;}
   }
}
