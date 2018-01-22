package roomList.pvpRoomList
{
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PlayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   import room.model.RoomInfo;
   
   public class RoomListModel extends EventDispatcher
   {
      
      public static const ROOMSHOWMODE_CHANGE:String = "roomshowmodechange";
      
      public static const ROOM_ITEM_UPDATE:String = "roomItemUpdate";
       
      
      private var _roomList:DictionaryData;
      
      private var _playerlist:DictionaryData;
      
      private var _self:PlayerInfo;
      
      private var _roomTotal:int;
      
      private var _roomShowMode:int;
      
      private var _temListArray:Array;
      
      private var _isAddEnd:Boolean;
      
      public function RoomListModel()
      {
         super();
         _roomList = new DictionaryData(true);
         _playerlist = new DictionaryData(true);
         _self = PlayerManager.Instance.Self;
         _roomShowMode = 1;
      }
      
      public function getSelfPlayerInfo() : PlayerInfo
      {
         return _self;
      }
      
      public function get isAddEnd() : Boolean
      {
         return _isAddEnd;
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
            if(_loc2_ == param1.length - 1)
            {
               _isAddEnd = true;
            }
            _roomList.add((param1[_loc2_] as RoomInfo).ID,param1[_loc2_] as RoomInfo);
            _loc2_++;
         }
         dispatchEvent(new Event("roomItemUpdate"));
      }
      
      public function set roomTotal(param1:int) : void
      {
         _roomTotal = param1;
      }
      
      public function get roomTotal() : int
      {
         return _roomTotal;
      }
      
      public function getRoomById(param1:int) : RoomInfo
      {
         return _roomList[param1];
      }
      
      public function getRoomList() : DictionaryData
      {
         return _roomList;
      }
      
      public function addWaitingPlayer(param1:PlayerInfo) : void
      {
         _playerlist.add(param1.ID,param1);
      }
      
      public function removeWaitingPlayer(param1:int) : void
      {
         _playerlist.remove(param1);
      }
      
      public function getPlayerList() : DictionaryData
      {
         return _playerlist;
      }
      
      public function get roomShowMode() : int
      {
         return _roomShowMode;
      }
      
      public function set roomShowMode(param1:int) : void
      {
         _roomShowMode = param1;
         dispatchEvent(new Event("roomshowmodechange"));
      }
      
      public function dispose() : void
      {
         _roomList = null;
         _playerlist = null;
         _self = null;
      }
   }
}
