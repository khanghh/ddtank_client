package starling.display.graphics
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.display.graphics.util.TriangleUtil;
   import starling.display.util.StrokeVertexUtil;
   import starling.textures.Texture;
   import starling.utils.MatrixUtil;
   
   public class Stroke extends Graphic
   {
      
      protected static const c_degenerateUseNext:uint = 1;
      
      protected static const c_degenerateUseLast:uint = 2;
      
      protected static var sCollissionHelper:StrokeCollisionHelper = null;
       
      
      protected var _line:Vector.<StrokeVertex>;
      
      protected var _numVertices:int;
      
      protected var _numAllocedVertices:int;
      
      protected var _indexOfLastRenderedVertex:int = -1;
      
      protected var _hasDegenerates:Boolean = false;
      
      protected var _cullDistanceSquared:Number = 0.0;
      
      protected var _lastScale:Number = 1.0;
      
      protected var _isReusingLine:Boolean = false;
      
      public function Stroke(){super();}
      
      [inline]
      protected static function createPolyLinePreAlloc(param1:Vector.<StrokeVertex>, param2:Vector.<Number>, param3:Vector.<uint>, param4:Boolean, param5:int) : void{}
      
      protected static function fixUpPolyLine(param1:Vector.<StrokeVertex>) : int{return 0;}
      
      protected static function cullPolyLineByDistance(param1:Vector.<StrokeVertex>, param2:Number, param3:int) : int{return 0;}
      
      public static function strokeCollideTest(param1:Stroke, param2:Stroke, param3:Point, param4:Vector.<Point> = null) : Boolean{return false;}
      
      protected static function adjustThicknessOfGeometry(param1:Vector.<Number>, param2:Number, param3:Number) : void{}
      
      public function get numVertices() : int{return 0;}
      
      override public function dispose() : void{}
      
      public function setPointCullDistance(param1:Number = 0.0) : void{}
      
      public function clearForReuse() : void{}
      
      public function clear() : void{}
      
      public function addDegenerates(param1:Number, param2:Number) : void{}
      
      protected function setLastVertexAsDegenerate(param1:uint) : void{}
      
      public function lineTo(param1:Number, param2:Number, param3:Number = 1, param4:uint = 16777215, param5:Number = 1) : void{}
      
      public function moveTo(param1:Number, param2:Number, param3:Number = 1, param4:uint = 16777215, param5:Number = 1.0) : void{}
      
      public function modifyVertexPosition(param1:int, param2:Number, param3:Number) : void{}
      
      public function fromBounds(param1:Rectangle, param2:int = 1) : void{}
      
      public function addVertex(param1:Number, param2:Number, param3:Number = 1, param4:uint = 16777215, param5:Number = 1, param6:uint = 16777215, param7:Number = 1) : void{}
      
      protected function addVertexInternal(param1:Number, param2:Number, param3:Number = 1, param4:uint = 16777215, param5:Number = 1, param6:uint = 16777215, param7:Number = 1) : void{}
      
      public function getVertexPosition(param1:int, param2:Point = null) : Point{return null;}
      
      override protected function buildGeometry() : void{}
      
      protected function buildGeometryPreAllocatedVectors() : void{}
      
      override protected function shapeHitTestLocalInternal(param1:Number, param2:Number) : Boolean{return false;}
      
      public function localToParent(param1:Point, param2:Point = null) : Point{return null;}
      
      public function scaleGeometry(param1:Number) : void{}
   }
}

import flash.geom.Point;
import flash.geom.Rectangle;

class StrokeCollisionHelper
{
    
   
   public var localPT1:Point;
   
   public var localPT2:Point;
   
   public var localPT3:Point;
   
   public var localPT4:Point;
   
   public var globalPT1:Point;
   
   public var globalPT2:Point;
   
   public var globalPT3:Point;
   
   public var globalPT4:Point;
   
   public var bounds1:Rectangle;
   
   public var bounds2:Rectangle;
   
   public var testIntersectPoint:Point;
   
   public var s1v0Vector:Vector.<Point> = null;
   
   public var s1v1Vector:Vector.<Point> = null;
   
   public var s2v0Vector:Vector.<Point> = null;
   
   public var s2v1Vector:Vector.<Point> = null;
   
   function StrokeCollisionHelper(){super();}
}
