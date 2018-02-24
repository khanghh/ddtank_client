package church.model
{
   import ddt.data.ChurchRoomInfo;
   import road7th.data.DictionaryData;
   
   public class ChurchRoomListModel
   {
       
      
      private var _roomList:DictionaryData;
      
      public function ChurchRoomListModel(){super();}
      
      public function get roomList() : DictionaryData{return null;}
      
      public function addRoom(param1:ChurchRoomInfo) : void{}
      
      public function removeRoom(param1:int) : void{}
      
      public function updateRoom(param1:ChurchRoomInfo) : void{}
      
      public function dispose() : void{}
   }
}
