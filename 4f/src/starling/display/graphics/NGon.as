package starling.display.graphics{   import flash.geom.Matrix;   import flash.geom.Point;   import starling.display.graphics.util.TriangleUtil;      public class NGon extends Graphic   {            private static var _uv:Point;                   private const DEGREES_TO_RADIANS:Number = 0.017453292519943295;            private var _radius:Number;            private var _innerRadius:Number;            private var _startAngle:Number;            private var _endAngle:Number;            private var _numSides:int;            private var _color:uint = 16777215;            private var _textureAlongPath:Boolean = false;            public function NGon(radius:Number = 100, numSides:int = 10, innerRadius:Number = 0, startAngle:Number = 0, endAngle:Number = 360, textureAlongPath:Boolean = false) { super(); }
            private static function buildSimpleNGon(radius:Number, numSides:int, vertices:Vector.<Number>, indices:Vector.<uint>, uvMatrix:Matrix, color:uint) : void { }
            private static function buildHoop(innerRadius:Number, radius:Number, numSides:int, vertices:Vector.<Number>, indices:Vector.<uint>, uvMatrix:Matrix, color:uint, textureAlongPath:Boolean) : void { }
            private static function buildFan(radius:Number, startAngle:Number, endAngle:Number, numSides:int, vertices:Vector.<Number>, indices:Vector.<uint>, uvMatrix:Matrix, color:uint) : void { }
            private static function buildArc(innerRadius:Number, radius:Number, startAngle:Number, endAngle:Number, numSides:int, vertices:Vector.<Number>, indices:Vector.<uint>, uvMatrix:Matrix, color:uint, textureAlongPath:Boolean) : void { }
            public function get endAngle() : Number { return 0; }
            public function set endAngle(value:Number) : void { }
            public function get startAngle() : Number { return 0; }
            public function set startAngle(value:Number) : void { }
            public function get radius() : Number { return 0; }
            public function set color(value:uint) : void { }
            public function set radius(value:Number) : void { }
            public function get innerRadius() : Number { return 0; }
            public function set innerRadius(value:Number) : void { }
            public function get numSides() : int { return 0; }
            public function set numSides(value:int) : void { }
            override protected function buildGeometry() : void { }
            override protected function shapeHitTestLocalInternal(localX:Number, localY:Number) : Boolean { return false; }
   }}