package starling.display.graphics{   import flash.geom.Matrix;   import flash.geom.Rectangle;   import starling.display.DisplayObject;      public class Plane extends Graphic   {                   private var _width:Number;            private var _height:Number;            private var _numVerticesX:uint;            private var _numVerticesY:uint;            private var _vertexFunction:Function;            public function Plane(width:Number = 100, height:Number = 100, numVerticesX:uint = 2, numVerticesY:uint = 2, vertexFunction:Function = null) { super(); }
            public static function defaultVertexFunction(column:int, row:int, width:Number, height:Number, numVerticesX:int, numVerticesY:int, output:Vector.<Number>, uvMatrix:Matrix = null) : void { }
            public static function alphaFadeVertically(column:int, row:int, width:Number, height:Number, numVerticesX:int, numVerticesY:int, output:Vector.<Number>, uvMatrix:Matrix = null) : void { }
            public static function alphaFadeHorizontally(column:int, row:int, width:Number, height:Number, numVerticesX:int, numVerticesY:int, output:Vector.<Number>, uvMatrix:Matrix = null) : void { }
            public static function alphaFadeAllSides(column:int, row:int, width:Number, height:Number, numVerticesX:int, numVerticesY:int, output:Vector.<Number>, uvMatrix:Matrix = null) : void { }
            public function set vertexFunction(value:Function) : void { }
            public function get vertexFunction() : Function { return null; }
            override protected function buildGeometry() : void { }
            override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle { return null; }
   }}