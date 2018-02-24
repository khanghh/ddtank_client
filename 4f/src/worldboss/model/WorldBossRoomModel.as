package worldboss.model
{
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import road7th.data.DictionaryData;
   import worldboss.event.WorldBossRoomEvent;
   import worldboss.player.PlayerVO;
   
   public class WorldBossRoomModel extends EventDispatcher
   {
       
      
      private var _players:DictionaryData;
      
      private var _playersBuffer:Array;
      
      private var _playerNameVisible:Boolean = true;
      
      private var _playerChatBallVisible:Boolean = true;
      
      private var _playerFireVisible:Boolean = true;
      
      public function WorldBossRoomModel(){super();}
      
      public function get players() : DictionaryData{return null;}
      
      public function addPlayer(param1:PlayerVO) : void{}
      
      private function addPlayerToMap() : void{}
      
      public function updatePlayerStauts(param1:int, param2:int, param3:Point) : void{}
      
      public function removePlayer(param1:int) : void{}
      
      public function getPlayers() : DictionaryData{return null;}
      
      public function getPlayerFromID(param1:int) : PlayerVO{return null;}
      
      public function reset() : void{}
      
      public function get playerNameVisible() : Boolean{return false;}
      
      public function set playerNameVisible(param1:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
