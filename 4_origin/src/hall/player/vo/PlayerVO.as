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
      
      public function PlayerVO(param1:IEventDispatcher = null)
      {
         _walkPath = [];
         super(param1);
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
      
      public function set scenePlayerDirection(param1:SceneCharacterDirection) : void
      {
         _sceneCharacterDirection = param1;
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
      
      public function set playerPos(param1:Point) : void
      {
         _playerPos = param1;
      }
      
      public function get playerMoveSpeed() : Number
      {
         return _playerMoveSpeed;
      }
      
      public function set playerMoveSpeed(param1:Number) : void
      {
         _playerMoveSpeed = param1;
      }
      
      public function get playerInfo() : PlayerInfo
      {
         return _playerInfo;
      }
      
      public function set playerInfo(param1:PlayerInfo) : void
      {
         _playerInfo = param1;
      }
      
      public function get walkPath() : Array
      {
         return _walkPath;
      }
      
      public function set walkPath(param1:Array) : void
      {
         _walkPath = param1;
      }
      
      public function get opposePos() : Point
      {
         return _opposePos;
      }
      
      public function set opposePos(param1:Point) : void
      {
         _opposePos = param1;
      }
   }
}
