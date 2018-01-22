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
      
      public function DungeonListModel(){super();}
      
      public function getSelfPlayerInfo() : PlayerInfo{return null;}
      
      public function get isAddEnd() : Boolean{return false;}
      
      public function updateRoom(param1:Array) : void{}
      
      public function set roomTotal(param1:int) : void{}
      
      public function get roomTotal() : int{return 0;}
      
      public function getRoomById(param1:int) : RoomInfo{return null;}
      
      public function getRoomList() : DictionaryData{return null;}
      
      public function addWaitingPlayer(param1:PlayerInfo) : void{}
      
      public function removeWaitingPlayer(param1:int) : void{}
      
      public function getPlayerList() : DictionaryData{return null;}
      
      public function get roomShowMode() : int{return 0;}
      
      public function set roomShowMode(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
