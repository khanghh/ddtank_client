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
       
      
      public function TransformUtil(){super();}
      
      public static function transformToMatrix(param1:DBTransform, param2:Matrix) : void{}
      
      public static function formatRadian(param1:Number) : Number{return 0;}
      
      public static function globalToLocal(param1:DBTransform, param2:DBTransform) : void{}
      
      public static function matrixToTransform(param1:Matrix, param2:DBTransform, param3:Boolean, param4:Boolean) : void{}
      
      public static function normalizeRotation(param1:Number) : Number{return 0;}
   }
}
