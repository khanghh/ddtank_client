package gameStarling.animations{   import flash.geom.Point;   import starling.display.DisplayObject;      public class StrLinearTween extends BaseStageTween   {                   private var _speed:int = 1;            private var _duration:int = 0;            public function StrLinearTween(data:TweenObject = null) { super(null); }
            override public function get type() : String { return null; }
            override public function update(movie:DisplayObject) : Point { return null; }
            public function set speed(value:int) : void { }
            public function get speed() : int { return 0; }
            public function set duration(value:int) : void { }
            public function get duration() : int { return 0; }
            override protected function get propertysNeed() : Array { return null; }
   }}