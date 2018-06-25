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
      
      public function addRoom(info:ChurchRoomInfo) : void
      {
         if(info)
         {
            _roomList.add(info.id,info);
         }
      }
      
      public function removeRoom(id:int) : void
      {
         if(_roomList[id])
         {
            _roomList.remove(id);
         }
      }
      
      public function updateRoom(info:ChurchRoomInfo) : void
      {
         if(info)
         {
            _roomList.add(info.id,info);
         }
      }
      
      public function dispose() : void
      {
         _roomList = null;
      }
   }
}
