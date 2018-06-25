package starling.display.graphics{   public class RoundedRectangle extends Graphic   {                   private const DEGREES_TO_RADIANS:Number = 0.017453292519943295;            private var _width:Number;            private var _height:Number;            private var _topLeftRadius:Number;            private var _topRightRadius:Number;            private var _bottomLeftRadius:Number;            private var _bottomRightRadius:Number;            private var strokePoints:Vector.<Number>;            public function RoundedRectangle(width:Number = 100, height:Number = 100, topLeftRadius:Number = 10, topRightRadius:Number = 10, bottomLeftRadius:Number = 10, bottomRightRadius:Number = 10) { super(); }
            override public function set width(value:Number) : void { }
            override public function get height() : Number { return 0; }
            override public function set height(value:Number) : void { }
            public function get cornerRadius() : Number { return 0; }
            public function set cornerRadius(value:Number) : void { }
            public function get topLeftRadius() : Number { return 0; }
            public function set topLeftRadius(value:Number) : void { }
            public function get topRightRadius() : Number { return 0; }
            public function set topRightRadius(value:Number) : void { }
            public function get bottomLeftRadius() : Number { return 0; }
            public function set bottomLeftRadius(value:Number) : void { }
            public function get bottomRightRadius() : Number { return 0; }
            public function set bottomRightRadius(value:Number) : void { }
            public function getStrokePoints() : Vector.<Number> { return null; }
            override protected function buildGeometry() : void { }
   }}