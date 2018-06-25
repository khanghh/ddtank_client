package hotSpring.vo
{
   import ddt.data.player.PlayerInfo;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import flash.events.EventDispatcher;
   import flash.geom.Point;
   import hotSpring.event.HotSpringRoomPlayerEvent;
   
   public class PlayerVO extends EventDispatcher
   {
       
      
      private var _playerPos:Point;
      
      private var _playerNickName:String;
      
      private var _playerSex:Boolean;
      
      private var _playerInfo:PlayerInfo;
      
      private var _walkPath:Array;
      
      private var _targetArea:int;
      
      private var _currentlyArea:int;
      
      private var _sceneCharacterDirection:SceneCharacterDirection;
      
      private var _playerDirection:int = 3;
      
      private var _playerMoveSpeed:Number = 0.15;
      
      public var currentWalkStartPoint:Point;
      
      public function PlayerVO()
      {
         _playerPos = new Point(480,560);
         _walkPath = [];
         super();
      }
      
      public function get playerPos() : Point
      {
         return _playerPos;
      }
      
      public function set playerPos(value:Point) : void
      {
         _playerPos = value;
         dispatchEvent(new HotSpringRoomPlayerEvent("playerPosChange",_playerInfo.ID));
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _playerInfo;
      }
      
      public function set playerInfo(value:PlayerInfo) : void
      {
         _playerInfo = value;
      }
      
      public function get walkPath() : Array
      {
         return _walkPath;
      }
      
      public function set walkPath(value:Array) : void
      {
         _walkPath = value;
      }
      
      public function get currentlyArea() : int
      {
         return _currentlyArea;
      }
      
      public function set currentlyArea(value:int) : void
      {
         if(_currentlyArea == value)
         {
            return;
         }
         _currentlyArea = value;
         _playerMoveSpeed = _currentlyArea == 1?0.15:0.075;
      }
      
      public function get scenePlayerDirection() : SceneCharacterDirection
      {
         return _sceneCharacterDirection;
      }
      
      public function set scenePlayerDirection(value:SceneCharacterDirection) : void
      {
         _sceneCharacterDirection = value;
         var _loc2_:* = _sceneCharacterDirection;
         if(SceneCharacterDirection.RT !== _loc2_)
         {
            if(SceneCharacterDirection.LT !== _loc2_)
            {
               if(SceneCharacterDirection.RB !== _loc2_)
               {
                  if(SceneCharacterDirection.LB === _loc2_)
                  {
                     _playerDirection = 4;
                  }
               }
               else
               {
                  _playerDirection = 3;
               }
            }
            else
            {
               _playerDirection = 2;
            }
         }
         else
         {
            _playerDirection = 1;
         }
      }
      
      public function get playerDirection() : int
      {
         return _playerDirection;
      }
      
      public function set playerDirection(value:int) : void
      {
         _playerDirection = value;
         switch(int(_playerDirection) - 1)
         {
            case 0:
               _sceneCharacterDirection = SceneCharacterDirection.RT;
               break;
            case 1:
               _sceneCharacterDirection = SceneCharacterDirection.LT;
               break;
            case 2:
               _sceneCharacterDirection = SceneCharacterDirection.RB;
               break;
            case 3:
               _sceneCharacterDirection = SceneCharacterDirection.LB;
         }
      }
      
      public function get playerMoveSpeed() : Number
      {
         return _playerMoveSpeed;
      }
      
      public function set playerMoveSpeed(value:Number) : void
      {
         if(_playerMoveSpeed == value)
         {
            return;
         }
         _playerMoveSpeed = value;
         dispatchEvent(new HotSpringRoomPlayerEvent("playerMoveSpeedChange",_playerInfo.ID));
      }
      
      public function clone() : PlayerVO
      {
         var playerVO:PlayerVO = new PlayerVO();
         playerVO.playerInfo = _playerInfo;
         playerVO.playerPos = _playerPos;
         playerVO.walkPath = _walkPath;
         playerVO.currentlyArea = _currentlyArea;
         playerVO.playerDirection = _playerDirection;
         playerVO.playerMoveSpeed = _playerMoveSpeed;
         return playerVO;
      }
      
      public function dispose() : void
      {
         while(_walkPath && _walkPath.length > 0)
         {
            _walkPath.shift();
         }
         _walkPath = null;
         _playerInfo = null;
         _sceneCharacterDirection = null;
      }
   }
}
