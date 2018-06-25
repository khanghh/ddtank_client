package game.animations{   import flash.geom.Point;      public dynamic class TweenObject   {                   public var speed:uint;            public var duration:uint;            private var _x:Number;            private var _y:Number;            private var _strategy:String;            public function TweenObject(data:Object = null) { super(); }
            public function set x(value:Number) : void { }
            public function get x() : Number { return 0; }
            public function set y(value:Number) : void { }
            public function get y() : Number { return 0; }
            public function set target(value:Point) : void { }
            public function get target() : Point { return null; }
            public function set strategy(value:String) : void { }
            public function get strategy() : String { return null; }
   }}