package starling.display.graphics{   import flash.geom.Matrix;   import flash.geom.Point;   import starling.display.graphics.util.TriangleUtil;      public class Fill extends Graphic   {            public static const VERTEX_STRIDE:int = 9;            protected static const EPSILON:Number = 1.0E-7;                   protected var fillVertices:VertexList;            protected var _numVertices:int;            protected var _isConvex:Boolean = true;            public function Fill() { super(); }
            protected static function triangulate(vertices:VertexList, _numVertices:int, outputVertices:Vector.<Number>, outputIndices:Vector.<uint>, isConvex:Boolean) : void { }
            protected static function convertToSimple(vertexList:VertexList) : Vector.<VertexList> { return null; }
            protected static function flatten(vertexLists:Vector.<VertexList>, output:Vector.<Number>) : void { }
            protected static function windingNumberAroundPoint(vertexList:VertexList, x:Number, y:Number) : int { return 0; }
            public static function isClockWise(vertexList:VertexList) : Boolean { return false; }
            protected static function windingNumber(vertexList:VertexList) : int { return 0; }
            protected static function isReflex(v0x:Number, v0y:Number, v1x:Number, v1y:Number, v2x:Number, v2y:Number) : Boolean { return false; }
            protected static function intersection(a0:VertexList, a1:VertexList, b0:VertexList, b1:VertexList) : Vector.<Number> { return null; }
            public function get numVertices() : int { return 0; }
            public function clear() : void { }
            override public function dispose() : void { }
            public function addDegenerates(destX:Number, destY:Number, color:uint = 16777215, alpha:Number = 1) : void { }
            public function addVertexInConvexShape(x:Number, y:Number, color:uint = 16777215, alpha:Number = 1) : void { }
            public function addVertex(x:Number, y:Number, color:uint = 16777215, alpha:Number = 1) : void { }
            protected function addVertexInternal(x:Number, y:Number, color:uint = 16777215, alpha:Number = 1) : void { }
            override protected function buildGeometry() : void { }
            override public function shapeHitTest(stageX:Number, stageY:Number) : Boolean { return false; }
            override protected function shapeHitTestLocalInternal(localX:Number, localY:Number) : Boolean { return false; }
   }}