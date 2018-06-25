package farm.player.vo{   import ddt.data.player.PlayerInfo;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.geom.Point;      public class PlayerVO extends EventDispatcher   {                   private var _playerInfo:PlayerInfo;            private var _playerPos:Point;            private var _playerMoveSpeed:Number = 0.15;            private var _sceneCharacterDirection:SceneCharacterDirection;            private var _playerDirection:int = 3;            private var _walkPath:Array;            public var currentWalkStartPoint:Point;            public function PlayerVO(target:IEventDispatcher = null) { super(null); }
            public function get scenePlayerDirection() : SceneCharacterDirection { return null; }
            public function set scenePlayerDirection(value:SceneCharacterDirection) : void { }
            public function get playerPos() : Point { return null; }
            public function set playerPos(value:Point) : void { }
            public function get playerMoveSpeed() : Number { return 0; }
            public function set playerMoveSpeed(value:Number) : void { }
            public function get playerInfo() : PlayerInfo { return null; }
            public function set playerInfo(value:PlayerInfo) : void { }
            public function get walkPath() : Array { return null; }
            public function set walkPath(value:Array) : void { }
   }}