package collectionTask.model
{
   import collectionTask.event.CollectionTaskEvent;
   import collectionTask.vo.PlayerVO;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import road7th.data.DictionaryData;
   
   public class CollectionTaskModel extends EventDispatcher
   {
       
      
      private var _players:DictionaryData;
      
      private var _playerNameVisible:Boolean = true;
      
      private var _playerChatBallVisible:Boolean = true;
      
      private var _playerVisible:Boolean = true;
      
      public function CollectionTaskModel(target:IEventDispatcher = null)
      {
         _players = new DictionaryData(true);
         super(target);
      }
      
      public function addPlayer(player:PlayerVO) : void
      {
         _players.add(player.playerInfo.ID,player);
      }
      
      public function removePlayer(id:int) : void
      {
         _players.remove(id);
      }
      
      public function get playerNameVisible() : Boolean
      {
         return _playerNameVisible;
      }
      
      public function set playerNameVisible(value:Boolean) : void
      {
         _playerNameVisible = value;
         dispatchEvent(new CollectionTaskEvent("playerNameVisible"));
      }
      
      public function get playerChatBallVisible() : Boolean
      {
         return _playerChatBallVisible;
      }
      
      public function set playerChatBallVisible(value:Boolean) : void
      {
         _playerChatBallVisible = value;
         dispatchEvent(new CollectionTaskEvent("playerChatBallVisible"));
      }
      
      public function set playerVisible(value:Boolean) : void
      {
         _playerVisible = value;
         dispatchEvent(new CollectionTaskEvent("playerVisible"));
      }
      
      public function get playerVisible() : Boolean
      {
         return _playerVisible;
      }
      
      public function getPlayers() : DictionaryData
      {
         return _players;
      }
   }
}
