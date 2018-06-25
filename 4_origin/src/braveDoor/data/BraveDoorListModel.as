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
      
      public function BraveDoorListModel(target:IEventDispatcher = null)
      {
         super(target);
         _roomList = new DictionaryData(true);
      }
      
      public function updateRoom(arr:Array) : void
      {
         var i:int = 0;
         _roomList.clear();
         _isAddEnd = false;
         if(arr.length == 0)
         {
            return;
         }
         arr = RoomListController.disorder(arr);
         for(i = 0; i < arr.length; )
         {
            _roomList.add((arr[i] as RoomInfo).ID,arr[i] as RoomInfo);
            if(i == arr.length - 1)
            {
               _isAddEnd = true;
            }
            i++;
         }
         dispatchEvent(new Event("BraveDoorRoomListUpdate"));
      }
      
      public function getRoomById(id:int) : RoomInfo
      {
         return _roomList[id];
      }
      
      public function getRoomList() : DictionaryData
      {
         return _roomList;
      }
      
      private function isOutBounds(curPage:*) : Boolean
      {
         if(curPage < 0 || _roomList == null)
         {
            return true;
         }
         var pageOffset:int = _roomList.length % 3;
         var totalPage:int = pageOffset == 0?_roomList.length / 3:Number(_roomList.length / 3 + 1);
         return curPage > totalPage;
      }
      
      public function set roomTotal(value:int) : void
      {
         _roomTotal = value;
      }
      
      public function get roomTotal() : int
      {
         return _roomTotal;
      }
   }
}
