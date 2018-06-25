package church.vo{   import church.events.ChurchScenePlayerEvent;   import ddt.data.player.PlayerInfo;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import flash.events.EventDispatcher;   import flash.geom.Point;      public class PlayerVO extends EventDispatcher   {                   private var _playerPos:Point;            private var _playerNickName:String;            private var _playerSex:Boolean;            private var _playerInfo:PlayerInfo;            private var _walkPath:Array;            private var _sceneCharacterDirection:SceneCharacterDirection;            private var _playerDirection:int = 3;            private var _playerMoveSpeed:Number = 0.15;            public var currentWalkStartPoint:Point;            public function PlayerVO() { super(); }
            public function get playerPos() : Point { return null; }
            public function set playerPos(value:Point) : void { }
            public function get playerInfo() : PlayerInfo { return null; }
            public function set playerInfo(value:PlayerInfo) : void { }
            public function get walkPath() : Array { return null; }
            public function set walkPath(value:Array) : void { }
            public function get scenePlayerDirection() : SceneCharacterDirection { return null; }
            public function set scenePlayerDirection(value:SceneCharacterDirection) : void { }
            public function get playerDirection() : int { return 0; }
            public function set playerDirection(value:int) : void { }
            public function get playerMoveSpeed() : Number { return 0; }
            public function set playerMoveSpeed(value:Number) : void { }
            public function clone() : PlayerVO { return null; }
            public function dispose() : void { }
   }}