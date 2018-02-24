package catchInsect
{
   import catchInsect.event.CatchInsectRoomEvent;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import flash.utils.setTimeout;
   import road7th.data.DictionaryData;
   
   public class CatchInsectRoomModel extends EventDispatcher
   {
       
      
      private var _players:DictionaryData;
      
      private var _playersBuffer:Array;
      
      public var _mapObjects:DictionaryData;
      
      private var _playerNameVisible:Boolean = true;
      
      public function CatchInsectRoomModel(){super();}
      
      public function get players() : DictionaryData{return null;}
      
      public function addPlayer(param1:PlayerVO) : void{}
      
      public function getObjects() : DictionaryData{return null;}
      
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
