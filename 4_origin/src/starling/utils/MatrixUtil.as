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
       
      
      public function MatrixUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function convertTo3D(matrix:Matrix, resultMatrix:Matrix3D = null) : Matrix3D
      {
         if(resultMatrix == null)
         {
            resultMatrix = new Matrix3D();
         }
         sRawData[0] = matrix.a;
         sRawData[1] = matrix.b;
         sRawData[4] = matrix.c;
         sRawData[5] = matrix.d;
         sRawData[12] = matrix.tx;
         sRawData[13] = matrix.ty;
         resultMatrix.copyRawDataFrom(sRawData);
         return resultMatrix;
      }
      
      public static function convertTo2D(matrix3D:Matrix3D, resultMatrix:Matrix = null) : Matrix
      {
         if(resultMatrix == null)
         {
            resultMatrix = new Matrix();
         }
         matrix3D.copyRawDataTo(sRawData2);
         resultMatrix.a = sRawData2[0];
         resultMatrix.b = sRawData2[1];
         resultMatrix.c = sRawData2[4];
         resultMatrix.d = sRawData2[5];
         resultMatrix.tx = sRawData2[12];
         resultMatrix.ty = sRawData2[13];
         return resultMatrix;
      }
      
      public static function transformPoint(matrix:Matrix, point:Point, resultPoint:Point = null) : Point
      {
         return transformCoords(matrix,point.x,point.y,resultPoint);
      }
      
      public static function transformPoint3D(matrix:Matrix3D, point:Vector3D, resultPoint:Vector3D = null) : Vector3D
      {
         return transformCoords3D(matrix,point.x,point.y,point.z,resultPoint);
      }
      
      public static function transformCoords(matrix:Matrix, x:Number, y:Number, resultPoint:Point = null) : Point
      {
         if(resultPoint == null)
         {
            resultPoint = new Point();
         }
         resultPoint.x = matrix.a * x + matrix.c * y + matrix.tx;
         resultPoint.y = matrix.d * y + matrix.b * x + matrix.ty;
         return resultPoint;
      }
      
      public static function transformCoords3D(matrix:Matrix3D, x:Number, y:Number, z:Number, resultPoint:Vector3D = null) : Vector3D
      {
         if(resultPoint == null)
         {
            resultPoint = new Vector3D();
         }
         matrix.copyRawDataTo(sRawData2);
         resultPoint.x = x * sRawData2[0] + y * sRawData2[4] + z * sRawData2[8] + sRawData2[12];
         resultPoint.y = x * sRawData2[1] + y * sRawData2[5] + z * sRawData2[9] + sRawData2[13];
         resultPoint.z = x * sRawData2[2] + y * sRawData2[6] + z * sRawData2[10] + sRawData2[14];
         resultPoint.w = x * sRawData2[3] + y * sRawData2[7] + z * sRawData2[11] + sRawData2[15];
         return resultPoint;
      }
      
      public static function skew(matrix:Matrix, skewX:Number, skewY:Number) : void
      {
         var sinX:Number = Math.sin(skewX);
         var cosX:Number = Math.cos(skewX);
         var sinY:Number = Math.sin(skewY);
         var cosY:Number = Math.cos(skewY);
         matrix.setTo(matrix.a * cosY - matrix.b * sinX,matrix.a * sinY + matrix.b * cosX,matrix.c * cosY - matrix.d * sinX,matrix.c * sinY + matrix.d * cosX,matrix.tx * cosY - matrix.ty * sinX,matrix.tx * sinY + matrix.ty * cosX);
      }
      
      public static function prependMatrix(base:Matrix, prep:Matrix) : void
      {
         base.setTo(base.a * prep.a + base.c * prep.b,base.b * prep.a + base.d * prep.b,base.a * prep.c + base.c * prep.d,base.b * prep.c + base.d * prep.d,base.tx + base.a * prep.tx + base.c * prep.ty,base.ty + base.b * prep.tx + base.d * prep.ty);
      }
      
      public static function prependTranslation(matrix:Matrix, tx:Number, ty:Number) : void
      {
         matrix.tx = matrix.tx + (matrix.a * tx + matrix.c * ty);
         matrix.ty = matrix.ty + (matrix.b * tx + matrix.d * ty);
      }
      
      public static function prependScale(matrix:Matrix, sx:Number, sy:Number) : void
      {
         matrix.setTo(matrix.a * sx,matrix.b * sx,matrix.c * sy,matrix.d * sy,matrix.tx,matrix.ty);
      }
      
      public static function prependRotation(matrix:Matrix, angle:Number) : void
      {
         var sin:Number = Math.sin(angle);
         var cos:Number = Math.cos(angle);
         matrix.setTo(matrix.a * cos + matrix.c * sin,matrix.b * cos + matrix.d * sin,matrix.c * cos - matrix.a * sin,matrix.d * cos - matrix.b * sin,matrix.tx,matrix.ty);
      }
      
      public static function prependSkew(matrix:Matrix, skewX:Number, skewY:Number) : void
      {
         var sinX:Number = Math.sin(skewX);
         var cosX:Number = Math.cos(skewX);
         var sinY:Number = Math.sin(skewY);
         var cosY:Number = Math.cos(skewY);
         matrix.setTo(matrix.a * cosY + matrix.c * sinY,matrix.b * cosY + matrix.d * sinY,matrix.c * cosX - matrix.a * sinX,matrix.d * cosX - matrix.b * sinX,matrix.tx,matrix.ty);
      }
   }
}
