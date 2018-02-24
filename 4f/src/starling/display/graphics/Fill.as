package starling.display.graphics
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import starling.display.graphics.util.TriangleUtil;
   
   public class Fill extends Graphic
   {
      
      public static const VERTEX_STRIDE:int = 9;
      
      protected static const EPSILON:Number = 1.0E-7;
       
      
      protected var fillVertices:VertexList;
      
      protected var _numVertices:int;
      
      protected var _isConvex:Boolean = true;
      
      public function Fill(){super();}
      
      protected static function triangulate(param1:VertexList, param2:int, param3:Vector.<Number>, param4:Vector.<uint>, param5:Boolean) : void{}
      
      protected static function convertToSimple(param1:VertexList) : Vector.<VertexList>{return null;}
      
      protected static function flatten(param1:Vector.<VertexList>, param2:Vector.<Number>) : void{}
      
      protected static function windingNumberAroundPoint(param1:VertexList, param2:Number, param3:Number) : int{return 0;}
      
      public static function isClockWise(param1:VertexList) : Boolean{return false;}
      
      protected static function windingNumber(param1:VertexList) : int{return 0;}
      
      protected static function isReflex(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Boolean{return false;}
      
      protected static function intersection(param1:VertexList, param2:VertexList, param3:VertexList, param4:VertexList) : Vector.<Number>{return null;}
      
      public function get numVertices() : int{return 0;}
      
      public function clear() : void{}
      
      override public function dispose() : void{}
      
      public function addDegenerates(param1:Number, param2:Number, param3:uint = 16777215, param4:Number = 1) : void{}
      
      public function addVertexInConvexShape(param1:Number, param2:Number, param3:uint = 16777215, param4:Number = 1) : void{}
      
      public function addVertex(param1:Number, param2:Number, param3:uint = 16777215, param4:Number = 1) : void{}
      
      protected function addVertexInternal(param1:Number, param2:Number, param3:uint = 16777215, param4:Number = 1) : void{}
      
      override protected function buildGeometry() : void{}
      
      override public function shapeHitTest(param1:Number, param2:Number) : Boolean{return false;}
      
      override protected function shapeHitTestLocalInternal(param1:Number, param2:Number) : Boolean{return false;}
   }
}
