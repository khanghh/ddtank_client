package game.animations{   import flash.display.DisplayObject;   import flash.geom.Point;      public class StrDefaultTween extends BaseStageTween   {                   protected var speed:int = 4;            public function StrDefaultTween(data:TweenObject = null) { super(null); }
            override public function get type() : String { return null; }
            override public function copyPropertyFromData(data:TweenObject) : void { }
            override public function update(movie:DisplayObject) : Point { return null; }
            override protected function get propertysNeed() : Array { return null; }
   }}