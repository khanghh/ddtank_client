package catchInsect{   import catchInsect.event.CatchInsectRoomEvent;   import flash.events.EventDispatcher;   import flash.geom.Point;   import flash.utils.setTimeout;   import road7th.data.DictionaryData;      public class CatchInsectRoomModel extends EventDispatcher   {                   private var _players:DictionaryData;            private var _playersBuffer:Array;            public var _mapObjects:DictionaryData;            private var _playerNameVisible:Boolean = true;            public function CatchInsectRoomModel() { super(); }
            public function get players() : DictionaryData { return null; }
            public function addPlayer(player:PlayerVO) : void { }
            public function getObjects() : DictionaryData { return null; }
            private function addPlayerToMap() : void { }
            public function updatePlayerStauts(id:int, status:int, point:Point) : void { }
            public function removePlayer(id:int) : void { }
            public function getPlayers() : DictionaryData { return null; }
            public function getPlayerFromID(id:int) : PlayerVO { return null; }
            public function reset() : void { }
            public function get playerNameVisible() : Boolean { return false; }
            public function set playerNameVisible(value:Boolean) : void { }
            public function dispose() : void { }
   }}