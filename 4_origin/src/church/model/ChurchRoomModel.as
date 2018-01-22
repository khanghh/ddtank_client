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
      
      public function addPlayer(param1:PlayerVO) : void
      {
         _players.add(param1.playerInfo.ID,param1);
      }
      
      public function removePlayer(param1:int) : void
      {
         _players.remove(param1);
      }
      
      public function getPlayers() : DictionaryData
      {
         return _players;
      }
      
      public function getPlayerFromID(param1:int) : PlayerVO
      {
         return _players[param1];
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
      
      public function set playerNameVisible(param1:Boolean) : void
      {
         _playerNameVisible = param1;
         dispatchEvent(new WeddingRoomEvent("playerNameVisible"));
      }
      
      public function get playerChatBallVisible() : Boolean
      {
         return _playerChatBallVisible;
      }
      
      public function set playerChatBallVisible(param1:Boolean) : void
      {
         _playerChatBallVisible = param1;
         dispatchEvent(new WeddingRoomEvent("playerChatBallVisible"));
      }
      
      public function set playerFireVisible(param1:Boolean) : void
      {
         _playerFireVisible = param1;
      }
      
      public function get playerFireVisible() : Boolean
      {
         return _playerFireVisible;
      }
      
      public function set fireEnable(param1:Boolean) : void
      {
         _fireEnable = param1;
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
