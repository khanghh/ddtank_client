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
      
      public function PlayerVO(param1:IEventDispatcher = null){super(null);}
      
      public function get scenePlayerDirection() : SceneCharacterDirection{return null;}
      
      public function set scenePlayerDirection(param1:SceneCharacterDirection) : void{}
      
      public function get playerPos() : Point{return null;}
      
      public function set playerPos(param1:Point) : void{}
      
      public function get playerMoveSpeed() : Number{return 0;}
      
      public function set playerMoveSpeed(param1:Number) : void{}
      
      public function get playerInfo() : PlayerInfo{return null;}
      
      public function set playerInfo(param1:PlayerInfo) : void{}
      
      public function get walkPath() : Array{return null;}
      
      public function set walkPath(param1:Array) : void{}
      
      public function get opposePos() : Point{return null;}
      
      public function set opposePos(param1:Point) : void{}
   }
}
