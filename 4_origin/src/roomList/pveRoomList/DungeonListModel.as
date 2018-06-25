package roomList.pveRoomList
{
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PlayerManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   import room.model.RoomInfo;
   import roomList.pvpRoomList.RoomListController;
   
   public class DungeonListModel extends EventDispatcher
   {
      
      public static const ROOMSHOWMODE_CHANGE:String = "roomshowmodechange";
      
      public static const DUNGEON_LIST_UPDATE:String = "DungeonListUpdate";
       
      
      private var _roomList:DictionaryData;
      
      private var _playerlist:DictionaryData;
      
      private var _self:PlayerInfo;
      
      private var _roomTotal:int;
      
      private var _roomShowMode:int;
      
      private var _temListArray:Array;
      
      private var _isAddEnd:Boolean;
      
      public function DungeonListModel()
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
            if(i == arr.length - 1)
            {
               _isAddEnd = true;
            }
            _roomList.add((arr[i] as RoomInfo).ID,arr[i] as RoomInfo);
            i++;
         }
         dispatchEvent(new Event("DungeonListUpdate"));
      }
      
      public function set roomTotal(value:int) : void
      {
         _roomTotal = value;
      }
      
      public function get roomTotal() : int
      {
         return _roomTotal;
      }
      
      public function getRoomById(id:int) : RoomInfo
      {
         return _roomList[id];
      }
      
      public function getRoomList() : DictionaryData
      {
         return _roomList;
      }
      
      public function addWaitingPlayer(info:PlayerInfo) : void
      {
         _playerlist.add(info.ID,info);
      }
      
      public function removeWaitingPlayer(id:int) : void
      {
         _playerlist.remove(id);
      }
      
      public function getPlayerList() : DictionaryData
      {
         return _playerlist;
      }
      
      public function get roomShowMode() : int
      {
         return _roomShowMode;
      }
      
      public function set roomShowMode(value:int) : void
      {
         _roomShowMode = value;
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
