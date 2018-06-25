package gameStarling.animations{   import flash.geom.Point;   import starling.display.DisplayObject;      public class BaseStageTween implements IStageTween   {                   protected var _target:Point;            protected var _prepared:Boolean = false;            protected var _isFinished:Boolean;            public function BaseStageTween(data:TweenObject = null) { super(); }
            public function get type() : String { return null; }
            public function initData(data:TweenObject) : void { }
            public function update(movie:DisplayObject) : Point { return null; }
            public function set target(value:Point) : void { }
            public function get target() : Point { return null; }
            public function copyPropertyFromData(data:TweenObject) : void { }
            protected function get propertysNeed() : Array { return null; }
            public function get isFinished() : Boolean { return false; }
   }}