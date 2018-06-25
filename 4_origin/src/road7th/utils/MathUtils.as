package road7th.utils
{
   import flash.geom.Point;
   
   public class MathUtils
   {
      
      public static var RADIAN:Number = 0.017453292519943295;
       
      
      public function MathUtils()
      {
         super();
      }
      
      public static function AngleToRadian(angle:Number) : Number
      {
         return angle / 180 * 3.14159265358979;
      }
      
      public static function RadianToAngle(radian:Number) : Number
      {
         return radian / 3.14159265358979 * 180;
      }
      
      public static function atan2(y:Number, x:Number) : Number
      {
         return RadianToAngle(Math.atan2(y,x));
      }
      
      public static function tan(angle:Number) : Number
      {
         return Math.tan(AngleToRadian(angle));
      }
      
      public static function GetAngleTwoPoint(point1:Point, point2:Point) : Number
      {
         var disX:Number = point1.x - point2.x;
         var disY:Number = point1.y - point2.y;
         return Math.floor(RadianToAngle(Math.atan2(disY,disX)));
      }
      
      public static function cos(angle:Number) : Number
      {
         return Math.cos(MathUtils.AngleToRadian(angle));
      }
      
      public static function sin(angle:Number) : Number
      {
         return Math.sin(MathUtils.AngleToRadian(angle));
      }
      
      public static function getValueInRange(value:Number, min:Number, max:Number) : Number
      {
         if(value <= min)
         {
            return min;
         }
         if(value >= max)
         {
            return max;
         }
         return value;
      }
      
      public static function isInRange(value:Number, min:Number, max:Number, equalMin:Boolean = false, equleMax:Boolean = true) : Boolean
      {
         if(value < min || value > max)
         {
            return false;
         }
         if(value == min)
         {
            return equalMin;
         }
         if(value == max)
         {
            return equleMax;
         }
         return true;
      }
   }
}
