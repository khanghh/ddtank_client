package church.model{   import church.events.WeddingRoomEvent;   import church.vo.PlayerVO;   import flash.events.EventDispatcher;   import road7th.data.DictionaryData;      public class ChurchRoomModel extends EventDispatcher   {                   private var _players:DictionaryData;            private var _playerNameVisible:Boolean = true;            private var _playerChatBallVisible:Boolean = true;            private var _playerFireVisible:Boolean = true;            private var _fireEnable:Boolean;            private var _fireTemplateIDList:Array;            public function ChurchRoomModel() { super(); }
            public function get players() : DictionaryData { return null; }
            public function addPlayer(player:PlayerVO) : void { }
            public function removePlayer(id:int) : void { }
            public function getPlayers() : DictionaryData { return null; }
            public function getPlayerFromID(id:int) : PlayerVO { return null; }
            public function reset() : void { }
            public function get playerNameVisible() : Boolean { return false; }
            public function set playerNameVisible(value:Boolean) : void { }
            public function get playerChatBallVisible() : Boolean { return false; }
            public function set playerChatBallVisible(value:Boolean) : void { }
            public function set playerFireVisible(value:Boolean) : void { }
            public function get playerFireVisible() : Boolean { return false; }
            public function set fireEnable(value:Boolean) : void { }
            public function get fireEnable() : Boolean { return false; }
            public function get fireTemplateIDList() : Array { return null; }
            public function dispose() : void { }
   }}