package starling.display.graphics{   import flash.geom.Point;   import flash.geom.Rectangle;   import starling.display.graphics.util.TriangleUtil;   import starling.display.util.StrokeVertexUtil;   import starling.textures.Texture;   import starling.utils.MatrixUtil;      public class Stroke extends Graphic   {            protected static const c_degenerateUseNext:uint = 1;            protected static const c_degenerateUseLast:uint = 2;            protected static var sCollissionHelper:StrokeCollisionHelper = null;                   protected var _line:Vector.<StrokeVertex>;            protected var _numVertices:int;            protected var _numAllocedVertices:int;            protected var _indexOfLastRenderedVertex:int = -1;            protected var _hasDegenerates:Boolean = false;            protected var _cullDistanceSquared:Number = 0.0;            protected var _lastScale:Number = 1.0;            protected var _isReusingLine:Boolean = false;            public function Stroke() { super(); }
            [inline]      protected static function createPolyLinePreAlloc(_line:Vector.<StrokeVertex>, vertices:Vector.<Number>, indices:Vector.<uint>, _hasDegenerates:Boolean, indexOfLastRenderedVertex:int) : void { }
            protected static function fixUpPolyLine(vertices:Vector.<StrokeVertex>) : int { return 0; }
            protected static function cullPolyLineByDistance(line:Vector.<StrokeVertex>, cullDistanceSquared:Number, indexOfLastRenderedVertex:int) : int { return 0; }
            public static function strokeCollideTest(s1:Stroke, s2:Stroke, intersectPoint:Point, staticLenIntersectPoints:Vector.<Point> = null) : Boolean { return false; }
            protected static function adjustThicknessOfGeometry(vertices:Vector.<Number>, oldScale:Number, newScale:Number) : void { }
            public function get numVertices() : int { return 0; }
            override public function dispose() : void { }
            public function setPointCullDistance(cullDistance:Number = 0.0) : void { }
            public function clearForReuse() : void { }
            public function clear() : void { }
            public function addDegenerates(destX:Number, destY:Number) : void { }
            protected function setLastVertexAsDegenerate(type:uint) : void { }
            public function lineTo(x:Number, y:Number, thickness:Number = 1, color:uint = 16777215, alpha:Number = 1) : void { }
            public function moveTo(x:Number, y:Number, thickness:Number = 1, color:uint = 16777215, alpha:Number = 1.0) : void { }
            public function modifyVertexPosition(index:int, x:Number, y:Number) : void { }
            public function fromBounds(boundingBox:Rectangle, thickness:int = 1) : void { }
            public function addVertex(x:Number, y:Number, thickness:Number = 1, color0:uint = 16777215, alpha0:Number = 1, color1:uint = 16777215, alpha1:Number = 1) : void { }
            protected function addVertexInternal(x:Number, y:Number, thickness:Number = 1, color0:uint = 16777215, alpha0:Number = 1, color1:uint = 16777215, alpha1:Number = 1) : void { }
            public function getVertexPosition(index:int, prealloc:Point = null) : Point { return null; }
            override protected function buildGeometry() : void { }
            protected function buildGeometryPreAllocatedVectors() : void { }
            override protected function shapeHitTestLocalInternal(localX:Number, localY:Number) : Boolean { return false; }
            public function localToParent(localPoint:Point, resultPoint:Point = null) : Point { return null; }
            public function scaleGeometry(newScale:Number) : void { }
   }}import flash.geom.Point;import flash.geom.Rectangle;class StrokeCollisionHelper{          public var localPT1:Point;      public var localPT2:Point;      public var localPT3:Point;      public var localPT4:Point;      public var globalPT1:Point;      public var globalPT2:Point;      public var globalPT3:Point;      public var globalPT4:Point;      public var bounds1:Rectangle;      public var bounds2:Rectangle;      public var testIntersectPoint:Point;      public var s1v0Vector:Vector.<Point> = null;      public var s1v1Vector:Vector.<Point> = null;      public var s2v0Vector:Vector.<Point> = null;      public var s2v1Vector:Vector.<Point> = null;      function StrokeCollisionHelper() { super(); }
}