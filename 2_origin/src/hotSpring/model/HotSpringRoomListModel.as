package hotSpring.model
{
   import ddt.data.HotSpringRoomInfo;
   import ddt.manager.HotSpringManager;
   import flash.events.EventDispatcher;
   import hotSpring.event.HotSpringRoomListEvent;
   import road7th.data.DictionaryData;
   
   public class HotSpringRoomListModel extends EventDispatcher
   {
      
      private static var _instance:HotSpringRoomListModel;
       
      
      private var _roomList:DictionaryData;
      
      private var _roomSelf:HotSpringRoomInfo;
      
      public function HotSpringRoomListModel()
      {
         _roomList = new DictionaryData();
         super();
      }
      
      public static function get Instance() : HotSpringRoomListModel
      {
         if(_instance == null)
         {
            _instance = new HotSpringRoomListModel();
         }
         return _instance;
      }
      
      public function get roomList() : DictionaryData
      {
         _roomList.list.sortOn("roomNumber",16);
         return _roomList;
      }
      
      public function roomAddOrUpdate(roomVO:HotSpringRoomInfo) : void
      {
         if(HotSpringManager.instance.roomCurrently && HotSpringManager.instance.roomCurrently.roomID == roomVO.roomID)
         {
            HotSpringManager.instance.roomCurrently = roomVO;
         }
         if(_roomList[roomVO.roomID] != null)
         {
            _roomList.add(roomVO.roomID,roomVO);
            dispatchEvent(new HotSpringRoomListEvent("roomUpdate",roomVO));
         }
         else
         {
            _roomList.add(roomVO.roomID,roomVO);
            dispatchEvent(new HotSpringRoomListEvent("roomAdd",roomVO));
            dispatchEvent(new HotSpringRoomListEvent("roomListUpdate"));
         }
      }
      
      public function roomRemove(roomID:int) : void
      {
         _roomList.remove(roomID);
         dispatchEvent(new HotSpringRoomListEvent("roomRemove",roomID));
         dispatchEvent(new HotSpringRoomListEvent("roomListUpdate"));
      }
      
      public function get roomSelf() : HotSpringRoomInfo
      {
         return _roomSelf;
      }
      
      public function set roomSelf(value:HotSpringRoomInfo) : void
      {
         _roomSelf = value;
         dispatchEvent(new HotSpringRoomListEvent("roomCreate",_roomSelf));
      }
      
      public function dispose() : void
      {
         _roomSelf = null;
         if(_roomList)
         {
            _roomList.clear();
         }
         _roomList = null;
         _instance = null;
      }
   }
}
