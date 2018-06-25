package starling.utils{   import flash.geom.Matrix;   import flash.geom.Matrix3D;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.geom.Vector3D;      public class VertexData   {            public static const ELEMENTS_PER_VERTEX:int = 8;            public static const POSITION_OFFSET:int = 0;            public static const COLOR_OFFSET:int = 2;            public static const TEXCOORD_OFFSET:int = 6;            private static var sHelperPoint:Point = new Point();            private static var sHelperPoint3D:Vector3D = new Vector3D();                   private var mRawData:Vector.<Number>;            private var mPremultipliedAlpha:Boolean;            private var mNumVertices:int;            public function VertexData(numVertices:int, premultipliedAlpha:Boolean = false) { super(); }
            public function clone(vertexID:int = 0, numVertices:int = -1) : VertexData { return null; }
            public function copyTo(targetData:VertexData, targetVertexID:int = 0, vertexID:int = 0, numVertices:int = -1) : void { }
            public function copyTransformedTo(targetData:VertexData, targetVertexID:int = 0, matrix:Matrix = null, vertexID:int = 0, numVertices:int = -1) : void { }
            public function append(data:VertexData) : void { }
            public function setPosition(vertexID:int, x:Number, y:Number) : void { }
            public function getPosition(vertexID:int, position:Point) : void { }
            public function setColorAndAlpha(vertexID:int, color:uint, alpha:Number) : void { }
            public function setColor(vertexID:int, color:uint) : void { }
            public function getColor(vertexID:int) : uint { return null; }
            public function setAlpha(vertexID:int, alpha:Number) : void { }
            public function getAlpha(vertexID:int) : Number { return 0; }
            public function setTexCoords(vertexID:int, u:Number, v:Number) : void { }
            public function getTexCoords(vertexID:int, texCoords:Point) : void { }
            public function translateVertex(vertexID:int, deltaX:Number, deltaY:Number) : void { }
            public function transformVertex(vertexID:int, matrix:Matrix, numVertices:int = 1) : void { }
            public function setUniformColor(color:uint) : void { }
            public function setUniformAlpha(alpha:Number) : void { }
            public function scaleAlpha(vertexID:int, factor:Number, numVertices:int = 1) : void { }
            public function getBounds(transformationMatrix:Matrix = null, vertexID:int = 0, numVertices:int = -1, resultRect:Rectangle = null) : Rectangle { return null; }
            public function getBoundsProjected(transformationMatrix:Matrix3D, camPos:Vector3D, vertexID:int = 0, numVertices:int = -1, resultRect:Rectangle = null) : Rectangle { return null; }
            public function toString() : String { return null; }
            public function get tinted() : Boolean { return false; }
            public function setPremultipliedAlpha(value:Boolean, updateData:Boolean = true) : void { }
            public function get premultipliedAlpha() : Boolean { return false; }
            public function set premultipliedAlpha(value:Boolean) : void { }
            public function get numVertices() : int { return 0; }
            public function set numVertices(value:int) : void { }
            public function get rawData() : Vector.<Number> { return null; }
   }}