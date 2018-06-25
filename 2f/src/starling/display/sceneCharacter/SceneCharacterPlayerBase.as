package starling.display.sceneCharacter{   import com.pickgliss.utils.StarlingObjectUtils;   import ddt.view.sceneCharacter.SceneCharacterDirection;   import flash.geom.Point;   import starling.animation.Tween;   import starling.core.Starling;   import starling.display.Quad;   import starling.display.Sprite;   import starling.display.sceneCharacter.event.SceneCharacterEvent;   import starling.events.TouchEvent;   import starling.filters.BlurFilter;   import starling.filters.FragmentFilter;      public class SceneCharacterPlayerBase extends Sprite   {                   protected var _sceneCharacterDirection:SceneCharacterDirection;            protected var _sceneCharacterState:SceneCharacterState;            protected var _characterPlayer:Sprite;            protected var _characterTouch:Quad;            protected var _moveSpeed:Number = 0.15;            protected var _walkPath:Array;            public var isWalkPathChange:Boolean = false;            protected var _tween:Tween;            protected var _isPlaying:Boolean = false;            private var _walkDistance:Number;            private var _walkPath0:Point;            private var po1:Point;            private var _playerY:Number;            protected var sceneCharacterDefaultActionState:String = "";            protected var _isDefaultCharacter:Boolean = true;            public function SceneCharacterPlayerBase() { super(); }
            protected function initialize() : void { }
            protected function initEvent() : void { }
            protected function removeEvent() : void { }
            protected function __onTouch(e:TouchEvent) : void { }
            private function __change() : void { }
            private function __finish() : void { }
            public function playerWalk(walkPath:Array) : void { }
            protected function resetTween(sec:Number) : void { }
            public function set sceneCharacterActionState(value:String) : void { }
            public function get playerPoint() : Point { return null; }
            public function set playerPoint(value:Point) : void { }
            public function get moveSpeed() : Number { return 0; }
            public function set moveSpeed(value:Number) : void { }
            public function get walkPath() : Array { return null; }
            public function set walkPath(value:Array) : void { }
            protected function set sceneCharacterState(value:SceneCharacterState) : void { }
            public function update() : void { }
            public function initSceneCharacterState() : void { }
            public function get sceneCharacterDirection() : SceneCharacterDirection { return null; }
            public function setCharacterFilter(value:Boolean) : void { }
            public function set sceneCharacterDirection(value:SceneCharacterDirection) : void { }
            protected function changeCharacterDirection() : void { }
            override public function dispose() : void { }
            public function get playerY() : Number { return 0; }
            public function set playerY(value:Number) : void { }
   }}