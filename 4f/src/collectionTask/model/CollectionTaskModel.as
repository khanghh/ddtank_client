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
      
      public function CollectionTaskModel(param1:IEventDispatcher = null){super(null);}
      
      public function addPlayer(param1:PlayerVO) : void{}
      
      public function removePlayer(param1:int) : void{}
      
      public function get playerNameVisible() : Boolean{return false;}
      
      public function set playerNameVisible(param1:Boolean) : void{}
      
      public function get playerChatBallVisible() : Boolean{return false;}
      
      public function set playerChatBallVisible(param1:Boolean) : void{}
      
      public function set playerVisible(param1:Boolean) : void{}
      
      public function get playerVisible() : Boolean{return false;}
      
      public function getPlayers() : DictionaryData{return null;}
   }
}
