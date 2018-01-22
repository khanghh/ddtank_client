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
      
      public static function transformToMatrix(param1:DBTransform, param2:Matrix) : void
      {
         param2.a = param1.scaleX * Math.cos(param1.skewY);
         param2.b = param1.scaleX * Math.sin(param1.skewY);
         param2.c = -param1.scaleY * Math.sin(param1.skewX);
         param2.d = param1.scaleY * Math.cos(param1.skewX);
         param2.tx = param1.x;
         param2.ty = param1.y;
      }
      
      public static function formatRadian(param1:Number) : Number
      {
         if(param1 > 3.14159265358979)
         {
            param1 = param1 - 6.28318530717959;
         }
         if(param1 < -3.14159265358979)
         {
            param1 = param1 + 6.28318530717959;
         }
         return param1;
      }
      
      public static function globalToLocal(param1:DBTransform, param2:DBTransform) : void
      {
         transformToMatrix(param1,_helpTransformMatrix);
         transformToMatrix(param2,_helpParentTransformMatrix);
         _helpParentTransformMatrix.invert();
         _helpTransformMatrix.concat(_helpParentTransformMatrix);
         matrixToTransform(_helpTransformMatrix,param1,param1.scaleX * param2.scaleX >= 0,param1.scaleY * param2.scaleY >= 0);
      }
      
      public static function matrixToTransform(param1:Matrix, param2:DBTransform, param3:Boolean, param4:Boolean) : void
      {
         param2.x = param1.tx;
         param2.y = param1.ty;
         param2.scaleX = Math.sqrt(param1.a * param1.a + param1.b * param1.b) * (!!param3?1:-1);
         param2.scaleY = Math.sqrt(param1.d * param1.d + param1.c * param1.c) * (!!param4?1:-1);
         var _loc6_:Array = [];
         _loc6_[0] = Math.acos(param1.d / param2.scaleY);
         _loc6_[1] = -_loc6_[0];
         _loc6_[2] = Math.asin(-param1.c / param2.scaleY);
         _loc6_[3] = _loc6_[2] >= 0?3.14159265358979 - _loc6_[2]:Number(_loc6_[2] - 3.14159265358979);
         if(Number(_loc6_[0]).toFixed(4) == Number(_loc6_[2]).toFixed(4) || Number(_loc6_[0]).toFixed(4) == Number(_loc6_[3]).toFixed(4))
         {
            param2.skewX = _loc6_[0];
         }
         else
         {
            param2.skewX = _loc6_[1];
         }
         var _loc5_:Array = [];
         _loc5_[0] = Math.acos(param1.a / param2.scaleX);
         _loc5_[1] = -_loc5_[0];
         _loc5_[2] = Math.asin(param1.b / param2.scaleX);
         _loc5_[3] = _loc5_[2] >= 0?3.14159265358979 - _loc5_[2]:Number(_loc5_[2] - 3.14159265358979);
         if(Number(_loc5_[0]).toFixed(4) == Number(_loc5_[2]).toFixed(4) || Number(_loc5_[0]).toFixed(4) == Number(_loc5_[3]).toFixed(4))
         {
            param2.skewY = _loc5_[0];
         }
         else
         {
            param2.skewY = _loc5_[1];
         }
      }
      
      public static function normalizeRotation(param1:Number) : Number
      {
         param1 = (param1 + 3.14159265358979) % (2 * 3.14159265358979);
         param1 = param1 > 0?param1:Number(2 * 3.14159265358979 + param1);
         return param1 - 3.14159265358979;
      }
   }
}
