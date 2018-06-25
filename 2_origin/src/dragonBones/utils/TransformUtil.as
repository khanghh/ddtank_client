package dragonBones.utils
{
   import dragonBones.objects.DBTransform;
   import flash.geom.Matrix;
   
   public final class TransformUtil
   {
      
      public static const ANGLE_TO_RADIAN:Number = 0.017453292519943295;
      
      public static const RADIAN_TO_ANGLE:Number = 57.29577951308232;
      
      private static const HALF_PI:Number = 1.5707963267948966;
      
      private static const DOUBLE_PI:Number = 6.283185307179586;
      
      private static const _helpTransformMatrix:Matrix = new Matrix();
      
      private static const _helpParentTransformMatrix:Matrix = new Matrix();
       
      
      public function TransformUtil()
      {
         super();
      }
      
      public static function transformToMatrix(transform:DBTransform, matrix:Matrix) : void
      {
         matrix.a = transform.scaleX * Math.cos(transform.skewY);
         matrix.b = transform.scaleX * Math.sin(transform.skewY);
         matrix.c = -transform.scaleY * Math.sin(transform.skewX);
         matrix.d = transform.scaleY * Math.cos(transform.skewX);
         matrix.tx = transform.x;
         matrix.ty = transform.y;
      }
      
      public static function formatRadian(radian:Number) : Number
      {
         if(radian > 3.14159265358979)
         {
            radian = radian - 6.28318530717959;
         }
         if(radian < -3.14159265358979)
         {
            radian = radian + 6.28318530717959;
         }
         return radian;
      }
      
      public static function globalToLocal(transform:DBTransform, parent:DBTransform) : void
      {
         transformToMatrix(transform,_helpTransformMatrix);
         transformToMatrix(parent,_helpParentTransformMatrix);
         _helpParentTransformMatrix.invert();
         _helpTransformMatrix.concat(_helpParentTransformMatrix);
         matrixToTransform(_helpTransformMatrix,transform,transform.scaleX * parent.scaleX >= 0,transform.scaleY * parent.scaleY >= 0);
      }
      
      public static function matrixToTransform(matrix:Matrix, transform:DBTransform, scaleXF:Boolean, scaleYF:Boolean) : void
      {
         transform.x = matrix.tx;
         transform.y = matrix.ty;
         transform.scaleX = Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b) * (!!scaleXF?1:-1);
         transform.scaleY = Math.sqrt(matrix.d * matrix.d + matrix.c * matrix.c) * (!!scaleYF?1:-1);
         var skewXArray:Array = [];
         skewXArray[0] = Math.acos(matrix.d / transform.scaleY);
         skewXArray[1] = -skewXArray[0];
         skewXArray[2] = Math.asin(-matrix.c / transform.scaleY);
         skewXArray[3] = skewXArray[2] >= 0?3.14159265358979 - skewXArray[2]:Number(skewXArray[2] - 3.14159265358979);
         if(Number(skewXArray[0]).toFixed(4) == Number(skewXArray[2]).toFixed(4) || Number(skewXArray[0]).toFixed(4) == Number(skewXArray[3]).toFixed(4))
         {
            transform.skewX = skewXArray[0];
         }
         else
         {
            transform.skewX = skewXArray[1];
         }
         var skewYArray:Array = [];
         skewYArray[0] = Math.acos(matrix.a / transform.scaleX);
         skewYArray[1] = -skewYArray[0];
         skewYArray[2] = Math.asin(matrix.b / transform.scaleX);
         skewYArray[3] = skewYArray[2] >= 0?3.14159265358979 - skewYArray[2]:Number(skewYArray[2] - 3.14159265358979);
         if(Number(skewYArray[0]).toFixed(4) == Number(skewYArray[2]).toFixed(4) || Number(skewYArray[0]).toFixed(4) == Number(skewYArray[3]).toFixed(4))
         {
            transform.skewY = skewYArray[0];
         }
         else
         {
            transform.skewY = skewYArray[1];
         }
      }
      
      public static function normalizeRotation(rotation:Number) : Number
      {
         rotation = (rotation + 3.14159265358979) % (2 * 3.14159265358979);
         rotation = rotation > 0?rotation:Number(2 * 3.14159265358979 + rotation);
         return rotation - 3.14159265358979;
      }
   }
}
