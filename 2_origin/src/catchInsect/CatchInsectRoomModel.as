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
      
      public function CatchInsectRoomModel()
      {
         super();
         _players = new DictionaryData(true);
         _playersBuffer = [];
         _mapObjects = new DictionaryData(true);
      }
      
      public function get players() : DictionaryData
      {
         return _players;
      }
      
      public function addPlayer(player:PlayerVO) : void
      {
         _playersBuffer.push(player);
      }
      
      public function getObjects() : DictionaryData
      {
         return _mapObjects;
      }
      
      private function addPlayerToMap() : void
      {
         if(!_players || !_playersBuffer[0])
         {
            return;
         }
         _players.add(_playersBuffer[0].playerInfo.ID,_playersBuffer[0]);
         _playersBuffer.shift();
      }
      
      public function updatePlayerStauts(id:int, status:int, point:Point) : void
      {
         var i:int = 0;
         var playerVO:* = null;
         if(_playersBuffer && _playersBuffer.length > 0)
         {
            for(i = 0; i < _playersBuffer.length; )
            {
               if(id == _playersBuffer[i].playerInfo.ID)
               {
                  playerVO = _playersBuffer[i] as PlayerVO;
                  playerVO.playerStauts = status;
                  playerVO.playerPos = point;
                  return;
               }
               i++;
            }
         }
      }
      
      public function removePlayer(id:int) : void
      {
         _players.remove(id);
      }
      
      public function getPlayers() : DictionaryData
      {
         return _players;
      }
      
      public function getPlayerFromID(id:int) : PlayerVO
      {
         return _players[id];
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
      
      public function set playerNameVisible(value:Boolean) : void
      {
         _playerNameVisible = value;
         dispatchEvent(new CatchInsectRoomEvent("playerNameVisible"));
      }
      
      public function dispose() : void
      {
         _players = null;
         _playersBuffer = null;
      }
   }
}
