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
      
      public function CollectionTaskModel(param1:IEventDispatcher = null)
      {
         _players = new DictionaryData(true);
         super(param1);
      }
      
      public function addPlayer(param1:PlayerVO) : void
      {
         _players.add(param1.playerInfo.ID,param1);
      }
      
      public function removePlayer(param1:int) : void
      {
         _players.remove(param1);
      }
      
      public function get playerNameVisible() : Boolean
      {
         return _playerNameVisible;
      }
      
      public function set playerNameVisible(param1:Boolean) : void
      {
         _playerNameVisible = param1;
         dispatchEvent(new CollectionTaskEvent("playerNameVisible"));
      }
      
      public function get playerChatBallVisible() : Boolean
      {
         return _playerChatBallVisible;
      }
      
      public function set playerChatBallVisible(param1:Boolean) : void
      {
         _playerChatBallVisible = param1;
         dispatchEvent(new CollectionTaskEvent("playerChatBallVisible"));
      }
      
      public function set playerVisible(param1:Boolean) : void
      {
         _playerVisible = param1;
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
