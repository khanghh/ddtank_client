package starling.utils
{
   import flash.geom.Matrix;
   import flash.geom.Matrix3D;
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import starling.errors.AbstractClassError;
   
   public class MatrixUtil
   {
      
      private static var sRawData:Vector.<Number> = new <Number>[1,0,0,0,0,1,0,0,0,0,1,0,0,0,0,1];
      
      private static var sRawData2:Vector.<Number> = new Vector.<Number>(16,true);
       
      
      public function MatrixUtil(){super();}
      
      public static function convertTo3D(param1:Matrix, param2:Matrix3D = null) : Matrix3D{return null;}
      
      public static function convertTo2D(param1:Matrix3D, param2:Matrix = null) : Matrix{return null;}
      
      public static function transformPoint(param1:Matrix, param2:Point, param3:Point = null) : Point{return null;}
      
      public static function transformPoint3D(param1:Matrix3D, param2:Vector3D, param3:Vector3D = null) : Vector3D{return null;}
      
      public static function transformCoords(param1:Matrix, param2:Number, param3:Number, param4:Point = null) : Point{return null;}
      
      public static function transformCoords3D(param1:Matrix3D, param2:Number, param3:Number, param4:Number, param5:Vector3D = null) : Vector3D{return null;}
      
      public static function skew(param1:Matrix, param2:Number, param3:Number) : void{}
      
      public static function prependMatrix(param1:Matrix, param2:Matrix) : void{}
      
      public static function prependTranslation(param1:Matrix, param2:Number, param3:Number) : void{}
      
      public static function prependScale(param1:Matrix, param2:Number, param3:Number) : void{}
      
      public static function prependRotation(param1:Matrix, param2:Number) : void{}
      
      public static function prependSkew(param1:Matrix, param2:Number, param3:Number) : void{}
   }
}
