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
      
      public function BraveDoorListModel(param1:IEventDispatcher = null)
      {
         super(param1);
         _roomList = new DictionaryData(true);
      }
      
      public function updateRoom(param1:Array) : void
      {
         var _loc2_:int = 0;
         _roomList.clear();
         _isAddEnd = false;
         if(param1.length == 0)
         {
            return;
         }
         param1 = RoomListController.disorder(param1);
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _roomList.add((param1[_loc2_] as RoomInfo).ID,param1[_loc2_] as RoomInfo);
            if(_loc2_ == param1.length - 1)
            {
               _isAddEnd = true;
            }
            _loc2_++;
         }
         dispatchEvent(new Event("BraveDoorRoomListUpdate"));
      }
      
      public function getRoomById(param1:int) : RoomInfo
      {
         return _roomList[param1];
      }
      
      public function getRoomList() : DictionaryData
      {
         return _roomList;
      }
      
      private function isOutBounds(param1:*) : Boolean
      {
         if(param1 < 0 || _roomList == null)
         {
            return true;
         }
         var _loc2_:int = _roomList.length % 3;
         var _loc3_:int = _loc2_ == 0?_roomList.length / 3:Number(_roomList.length / 3 + 1);
         return param1 > _loc3_;
      }
      
      public function set roomTotal(param1:int) : void
      {
         _roomTotal = param1;
      }
      
      public function get roomTotal() : int
      {
         return _roomTotal;
      }
   }
}
