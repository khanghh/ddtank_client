package hall.player.vo
{
   import ddt.data.player.PlayerInfo;
   import ddt.view.sceneCharacter.SceneCharacterDirection;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   
   public class PlayerVO extends EventDispatcher
   {
       
      
      protected var _playerInfo:PlayerInfo;
      
      protected var _playerPos:Point;
      
      protected var _playerMoveSpeed:Number = 0.15;
      
      protected var _sceneCharacterDirection:SceneCharacterDirection;
      
      protected var _playerDirection:int = 3;
      
      protected var _walkPath:Array;
      
      public var currentWalkStartPoint:Point;
      
      protected var _opposePos:Point;
      
      public var randomStartPointIndex:int;
      
      public var randomEndPointIndex:int;
      
      public function PlayerVO(target:IEventDispatcher = null)
      {
         _walkPath = [];
         super(target);
         _sceneCharacterDirection = SceneCharacterDirection.RB;
      }
      
      public function get scenePlayerDirection() : SceneCharacterDirection
      {
         if(!_sceneCharacterDirection)
         {
            _sceneCharacterDirection = SceneCharacterDirection.RB;
         }
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
      
      public function get playerPos() : Point
      {
         return _playerPos;
      }
      
      public function set playerPos(value:Point) : void
      {
         _playerPos = value;
      }
      
      public function get playerMoveSpeed() : Number
      {
         return _playerMoveSpeed;
      }
      
      public function set playerMoveSpeed(value:Number) : void
      {
         _playerMoveSpeed = value;
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
      
      public function get opposePos() : Point
      {
         return _opposePos;
      }
      
      public function set opposePos(value:Point) : void
      {
         _opposePos = value;
      }
   }
}
