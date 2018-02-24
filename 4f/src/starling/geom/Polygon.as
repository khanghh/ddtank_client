package starling.geom
{
   import flash.geom.Point;
   import flash.utils.getQualifiedClassName;
   import starling.utils.VectorUtil;
   import starling.utils.VertexData;
   
   public class Polygon
   {
      
      private static var sRestIndices:Vector.<uint> = new Vector.<uint>(0);
       
      
      private var mCoords:Vector.<Number>;
      
      public function Polygon(param1:Array = null){super();}
      
      public static function createEllipse(param1:Number, param2:Number, param3:Number, param4:Number) : Polygon{return null;}
      
      public static function createCircle(param1:Number, param2:Number, param3:Number) : Polygon{return null;}
      
      public static function createRectangle(param1:Number, param2:Number, param3:Number, param4:Number) : Polygon{return null;}
      
      [Inline]
      private static function isConvexTriangle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Boolean{return false;}
      
      private static function isPointInTriangle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Boolean{return false;}
      
      private static function areVectorsIntersecting(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number, param7:Number, param8:Number) : Boolean{return false;}
      
      public function clone() : Polygon{return null;}
      
      public function reverse() : void{}
      
      public function addVertices(... rest) : void{}
      
      public function setVertex(param1:int, param2:Number, param3:Number) : void{}
      
      public function getVertex(param1:int, param2:Point = null) : Point{return null;}
      
      public function contains(param1:Number, param2:Number) : Boolean{return false;}
      
      public function containsPoint(param1:Point) : Boolean{return false;}
      
      public function triangulate(param1:Vector.<uint> = null) : Vector.<uint>{return null;}
      
      public function copyToVertexData(param1:VertexData, param2:int = 0) : void{}
      
      public function copyToVector(param1:Vector.<Number>, param2:int = 0, param3:int = 0) : void{}
      
      public function toString() : String{return null;}
      
      public function get isSimple() : Boolean{return false;}
      
      public function get isConvex() : Boolean{return false;}
      
      public function get area() : Number{return 0;}
      
      public function get numVertices() : int{return 0;}
      
      public function set numVertices(param1:int) : void{}
   }
}

import flash.errors.IllegalOperationError;
import flash.utils.getQualifiedClassName;
import starling.geom.Polygon;

class ImmutablePolygon extends Polygon
{
    
   
   private var mFrozen:Boolean;
   
   function ImmutablePolygon(param1:Array){super(null);}
   
   override public function addVertices(... rest) : void{}
   
   override public function setVertex(param1:int, param2:Number, param3:Number) : void{}
   
   override public function reverse() : void{}
   
   override public function set numVertices(param1:int) : void{}
   
   private function getImmutableError() : Error{return null;}
}

class Ellipse extends ImmutablePolygon
{
    
   
   private var mX:Number;
   
   private var mY:Number;
   
   private var mRadiusX:Number;
   
   private var mRadiusY:Number;
   
   function Ellipse(param1:Number, param2:Number, param3:Number, param4:Number, param5:int = -1){super(null);}
   
   private function getVertices(param1:int) : Array{return null;}
   
   override public function triangulate(param1:Vector.<uint> = null) : Vector.<uint>{return null;}
   
   override public function contains(param1:Number, param2:Number) : Boolean{return false;}
   
   override public function get area() : Number{return 0;}
   
   override public function get isSimple() : Boolean{return false;}
   
   override public function get isConvex() : Boolean{return false;}
}

class Rectangle extends ImmutablePolygon
{
    
   
   private var mX:Number;
   
   private var mY:Number;
   
   private var mWidth:Number;
   
   private var mHeight:Number;
   
   function Rectangle(param1:Number, param2:Number, param3:Number, param4:Number){super(null);}
   
   override public function triangulate(param1:Vector.<uint> = null) : Vector.<uint>{return null;}
   
   override public function contains(param1:Number, param2:Number) : Boolean{return false;}
   
   override public function get area() : Number{return 0;}
   
   override public function get isSimple() : Boolean{return false;}
   
   override public function get isConvex() : Boolean{return false;}
}
