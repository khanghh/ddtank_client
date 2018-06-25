package starling.utils
{
   import flash.geom.Point;
   import flash.geom.Vector3D;
   import starling.errors.AbstractClassError;
   
   public class MathUtil
   {
      
      private static const TWO_PI:Number = 6.283185307179586;
       
      
      public function MathUtil()
      {
         super();
         throw new AbstractClassError();
      }
      
      public static function intersectLineWithXYPlane(pointA:Vector3D, pointB:Vector3D, resultPoint:Point = null) : Point
      {
         if(resultPoint == null)
         {
            resultPoint = new Point();
         }
         var vectorX:Number = pointB.x - pointA.x;
         var vectorY:Number = pointB.y - pointA.y;
         var vectorZ:Number = pointB.z - pointA.z;
         var lambda:Number = -pointA.z / vectorZ;
         resultPoint.x = pointA.x + lambda * vectorX;
         resultPoint.y = pointA.y + lambda * vectorY;
         return resultPoint;
      }
      
      public static function normalizeAngle(angle:Number) : Number
      {
         angle = angle % 6.28318530717959;
         if(angle < -3.14159265358979)
         {
            angle = angle + 6.28318530717959;
         }
         if(angle > 3.14159265358979)
         {
            angle = angle - 6.28318530717959;
         }
         return angle;
      }
      
      public static function clamp(value:Number, min:Number, max:Number) : Number
      {
         return value < min?min:Number(value > max?max:Number(value));
      }
   }
}
