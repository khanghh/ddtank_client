package starling.scene.common{   import com.pickgliss.ui.core.Disposeable;   import flash.geom.Point;   import starling.animation.Tween;   import starling.core.Starling;      public class WalkPlugin implements Disposeable   {            public static const DIRECTION_RT:int = 1;            public static const DIRECTION_LT:int = 2;            public static const DIRECTION_RB:int = 3;            public static const DIRECTION_LB:int = 4;                   private var _entity:Object;            private var _pathArr:Array;            private var _speed:Number = 1;            private var _currentPathIndex:int = 0;            private var _walkTween:Tween;            private var _isFinish:Boolean = false;            private var _isWalk:Boolean = false;            public function WalkPlugin(entity:Object = null, speed:Number = 1, pathArr:Array = null) { super(); }
            public function walk() : void { }
            private function getDirection(startX:Number, startY:Number, endX:Number, endY:Number) : int { return 0; }
            private function onWalkPartComplete() : void { }
            public function stop() : void { }
            public function get entity() : Object { return null; }
            public function set entity(value:Object) : void { }
            public function get pathArr() : Array { return null; }
            public function set pathArr(value:Array) : void { }
            public function get speed() : Number { return 0; }
            public function set speed(value:Number) : void { }
            public function get isFinish() : Boolean { return false; }
            public function dispose() : void { }
   }}