package church.model
{
   import church.events.WeddingRoomEvent;
   import church.vo.PlayerVO;
   import flash.events.EventDispatcher;
   import road7th.data.DictionaryData;
   
   public class ChurchRoomModel extends EventDispatcher
   {
       
      
      private var _players:DictionaryData;
      
      private var _playerNameVisible:Boolean = true;
      
      private var _playerChatBallVisible:Boolean = true;
      
      private var _playerFireVisible:Boolean = true;
      
      private var _fireEnable:Boolean;
      
      private var _fireTemplateIDList:Array;
      
      public function ChurchRoomModel()
      {
         _fireTemplateIDList = [21002,21006];
         super();
         _players = new DictionaryData(true);
      }
      
      public function get players() : DictionaryData
      {
         return _players;
      }
      
      public function addPlayer(player:PlayerVO) : void
      {
         _players.add(player.playerInfo.ID,player);
      }
      
      public function removePlayer(id:int) : void
      {
         _players.remove(id);
      }
      
      public function getPlayers() : DictionaryData
      {
         return _players;
      }
      
      public function getPlayerFromID(id:int) : PlayerVO
      {
         return _players[id];
      }
      
      public function reset() : void
      {
         dispose();
         _players = new DictionaryData(true);
      }
      
      public function get playerNameVisible() : Boolean
      {
         return _playerNameVisible;
      }
      
      public function set playerNameVisible(value:Boolean) : void
      {
         _playerNameVisible = value;
         dispatchEvent(new WeddingRoomEvent("playerNameVisible"));
      }
      
      public function get playerChatBallVisible() : Boolean
      {
         return _playerChatBallVisible;
      }
      
      public function set playerChatBallVisible(value:Boolean) : void
      {
         _playerChatBallVisible = value;
         dispatchEvent(new WeddingRoomEvent("playerChatBallVisible"));
      }
      
      public function set playerFireVisible(value:Boolean) : void
      {
         _playerFireVisible = value;
      }
      
      public function get playerFireVisible() : Boolean
      {
         return _playerFireVisible;
      }
      
      public function set fireEnable(value:Boolean) : void
      {
         _fireEnable = value;
         dispatchEvent(new WeddingRoomEvent("room fire enable change"));
      }
      
      public function get fireEnable() : Boolean
      {
         return _fireEnable;
      }
      
      public function get fireTemplateIDList() : Array
      {
         return _fireTemplateIDList;
      }
      
      public function dispose() : void
      {
         _players = null;
      }
   }
}
