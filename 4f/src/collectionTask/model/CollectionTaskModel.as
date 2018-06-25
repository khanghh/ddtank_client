package collectionTask.model{   import collectionTask.event.CollectionTaskEvent;   import collectionTask.vo.PlayerVO;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import road7th.data.DictionaryData;      public class CollectionTaskModel extends EventDispatcher   {                   private var _players:DictionaryData;            private var _playerNameVisible:Boolean = true;            private var _playerChatBallVisible:Boolean = true;            private var _playerVisible:Boolean = true;            public function CollectionTaskModel(target:IEventDispatcher = null) { super(null); }
            public function addPlayer(player:PlayerVO) : void { }
            public function removePlayer(id:int) : void { }
            public function get playerNameVisible() : Boolean { return false; }
            public function set playerNameVisible(value:Boolean) : void { }
            public function get playerChatBallVisible() : Boolean { return false; }
            public function set playerChatBallVisible(value:Boolean) : void { }
            public function set playerVisible(value:Boolean) : void { }
            public function get playerVisible() : Boolean { return false; }
            public function getPlayers() : DictionaryData { return null; }
   }}