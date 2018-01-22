package church.model
{
   import ddt.data.ChurchRoomInfo;
   import road7th.data.DictionaryData;
   
   public class ChurchRoomListModel
   {
       
      
      private var _roomList:DictionaryData;
      
      public function ChurchRoomListModel()
      {
         super();
         _roomList = new DictionaryData(true);
      }
      
      public function get roomList() : DictionaryData
      {
         return _roomList;
      }
      
      public function addRoom(param1:ChurchRoomInfo) : void
      {
         if(param1)
         {
            _roomList.add(param1.id,param1);
         }
      }
      
      public function removeRoom(param1:int) : void
      {
         if(_roomList[param1])
         {
            _roomList.remove(param1);
         }
      }
      
      public function updateRoom(param1:ChurchRoomInfo) : void
      {
         if(param1)
         {
            _roomList.add(param1.id,param1);
         }
      }
      
      public function dispose() : void
      {
         _roomList = null;
      }
   }
}
