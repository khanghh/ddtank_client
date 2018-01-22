package dragonBones.cache
{
   import dragonBones.objects.DBTransform;
   import flash.geom.Matrix;
   
   public class FrameCache
   {
      
      private static const ORIGIN_TRAMSFORM:DBTransform = new DBTransform();
      
      private static const ORIGIN_MATRIX:Matrix = new Matrix();
       
      
      public var globalTransform:DBTransform;
      
      public var globalTransformMatrix:Matrix;
      
      public function FrameCache()
      {
         globalTransform = new DBTransform();
         globalTransformMatrix = new Matrix();
         super();
      }
      
      public function copy(param1:FrameCache) : void
      {
         globalTransform = param1.globalTransform;
         globalTransformMatrix = param1.globalTransformMatrix;
      }
      
      public function clear() : void
      {
         globalTransform = ORIGIN_TRAMSFORM;
         globalTransformMatrix = ORIGIN_MATRIX;
      }
   }
}
