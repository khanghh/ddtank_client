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
      
      public function roomAddOrUpdate(param1:HotSpringRoomInfo) : void
      {
         if(HotSpringManager.instance.roomCurrently && HotSpringManager.instance.roomCurrently.roomID == param1.roomID)
         {
            HotSpringManager.instance.roomCurrently = param1;
         }
         if(_roomList[param1.roomID] != null)
         {
            _roomList.add(param1.roomID,param1);
            dispatchEvent(new HotSpringRoomListEvent("roomUpdate",param1));
         }
         else
         {
            _roomList.add(param1.roomID,param1);
            dispatchEvent(new HotSpringRoomListEvent("roomAdd",param1));
            dispatchEvent(new HotSpringRoomListEvent("roomListUpdate"));
         }
      }
      
      public function roomRemove(param1:int) : void
      {
         _roomList.remove(param1);
         dispatchEvent(new HotSpringRoomListEvent("roomRemove",param1));
         dispatchEvent(new HotSpringRoomListEvent("roomListUpdate"));
      }
      
      public function get roomSelf() : HotSpringRoomInfo
      {
         return _roomSelf;
      }
      
      public function set roomSelf(param1:HotSpringRoomInfo) : void
      {
         _roomSelf = param1;
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
