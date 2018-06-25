package worldboss.model{   import flash.events.EventDispatcher;   import flash.geom.Point;   import flash.utils.setTimeout;   import road7th.data.DictionaryData;   import worldboss.event.WorldBossRoomEvent;   import worldboss.player.PlayerVO;      public class WorldBossRoomModel extends EventDispatcher   {                   private var _players:DictionaryData;            private var _playersBuffer:Array;            private var _playerNameVisible:Boolean = true;            private var _playerChatBallVisible:Boolean = true;            private var _playerFireVisible:Boolean = true;            public function WorldBossRoomModel() { super(); }
            public function get players() : DictionaryData { return null; }
            public function addPlayer(player:PlayerVO) : void { }
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