package starling.utils
{
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.geom.Vector3D;
   
   public class VertexData
   {
      
      public static const ELEMENTS_PER_VERTEX:int = 8;
      
      public static const POSITION_OFFSET:int = 0;
      
      public static const COLOR_OFFSET:int = 2;
      
      public static const TEXCOORD_OFFSET:int = 6;
      
      private static var sHelperPoint:Point = new Point();
      
      private static var sHelperPoint3D:Vector3D = new Vector3D();
       
      
      private var mRawData:Vector.<Number>;
      
      private var mPremultipliedAlpha:Boolean;
      
      private var mNumVertices:int;
      
      public function VertexData(param1:int, param2:Boolean = false){super();}
      
      public function clone(param1:int = 0, param2:int = -1) : VertexData{return null;}
      
      public function copyTo(param1:VertexData, param2:int = 0, param3:int = 0, param4:int = -1) : void{}
      
      public function copyTransformedTo(param1:VertexData, param2:int = 0, param3:Matrix = null, param4:int = 0, param5:int = -1) : void{}
      
      public function append(param1:VertexData) : void{}
      
      public function setPosition(param1:int, param2:Number, param3:Number) : void{}
      
      public function getPosition(param1:int, param2:Point) : void{}
      
      public function setColorAndAlpha(param1:int, param2:uint, param3:Number) : void{}
      
      public function setColor(param1:int, param2:uint) : void{}
      
      public function getColor(param1:int) : uint{return null;}
      
      public function setAlpha(param1:int, param2:Number) : void{}
      
      public function getAlpha(param1:int) : Number{return 0;}
      
      public function setTexCoords(param1:int, param2:Number, param3:Number) : void{}
      
      public function getTexCoords(param1:int, param2:Point) : void{}
      
      public function translateVertex(param1:int, param2:Number, param3:Number) : void{}
      
      public function transformVertex(param1:int, param2:Matrix, param3:int = 1) : void{}
      
      public function setUniformColor(param1:uint) : void{}
      
      public function setUniformAlpha(param1:Number) : void{}
      
      public function scaleAlpha(param1:int, param2:Number, param3:int = 1) : void{}
      
      public function getBounds(param1:Matrix = null, param2:int = 0, param3:int = -1, param4:Rectangle = null) : Rectangle{return null;}
      
      public function getBoundsProjected(param1:Matrix3D, param2:Vector3D, param3:int = 0, param4:int = -1, param5:Rectangle = null) : Rectangle{return null;}
      
      public function toString() : String{return null;}
      
      public function get tinted() : Boolean{return false;}
      
      public function setPremultipliedAlpha(param1:Boolean, param2:Boolean = true) : void{}
      
      public function get premultipliedAlpha() : Boolean{return false;}
      
      public function set premultipliedAlpha(param1:Boolean) : void{}
      
      public function get numVertices() : int{return 0;}
      
      public function set numVertices(param1:int) : void{}
      
      public function get rawData() : Vector.<Number>{return null;}
   }
}
