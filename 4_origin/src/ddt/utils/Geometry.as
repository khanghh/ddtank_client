package ddt.utils
{
   import flash.geom.Point;
   
   public class Geometry
   {
       
      
      public function Geometry()
      {
         super();
      }
      
      public static function getAngle4(p1x:Number, p1y:Number, p2x:Number, p2y:Number) : Number
      {
         return Math.atan2(p2y - p1y,p2x - p1x);
      }
      
      public static function getAngle(p1:Point, p2:Point) : Number
      {
         return Math.atan2(p2.y - p1.y,p2.x - p1.x);
      }
      
      public static function nextPoint2(px:Number, py:Number, angle:Number, distance:Number) : Point
      {
         return new Point(px + Math.cos(angle) * distance,py + Math.sin(angle) * distance);
      }
      
      public static function nextPoint(p:Point, angle:Number, distance:Number) : Point
      {
         return new Point(p.x + Math.cos(angle) * distance,p.y + Math.sin(angle) * distance);
      }
      
      private static function standardAngle(angle:Number) : Number
      {
         angle = angle % (2 * 3.14159265358979);
         if(angle > 3.14159265358979)
         {
            angle = angle - 2 * 3.14159265358979;
         }
         else if(angle < -3.14159265358979)
         {
            angle = angle + 2 * 3.14159265358979;
         }
         return angle;
      }
      
      public static function crossAngle(firstAngle:Number, secondAngle:Number) : Number
      {
         return standardAngle(standardAngle(firstAngle) - standardAngle(secondAngle));
      }
      
      public static function isClockwish(firstAngle:Number, secondAngle:Number) : Boolean
      {
         return crossAngle(firstAngle,secondAngle) < 0;
      }
      
      public static function cross_x(x11:Number, y11:Number, x12:Number, y12:Number, x21:Number, y21:Number, x22:Number, y22:Number) : Number
      {
         var _local10:Number = (y11 - y12) / (x12 * y11 - x11 * y12);
         var _local11:Number = (x12 - x11) / (x12 * y11 - x11 * y12);
         var _local12:Number = (y21 - y22) / (x22 * y21 - x21 * y22);
         var _local13:Number = (x22 - x21) / (x22 * y21 - x21 * y22);
         var _local14:Number = (_local11 - _local13) / (_local12 * _local11 - _local10 * _local13);
         return _local14;
      }
      
      public static function cross_y(x11:Number, y11:Number, x12:Number, y12:Number, x21:Number, y21:Number, x22:Number, y22:Number) : Number
      {
         var _local10:Number = (y11 - y12) / (x12 * y11 - x11 * y12);
         var _local11:Number = (x12 - x11) / (x12 * y11 - x11 * y12);
         var _local12:Number = (y21 - y22) / (x22 * y21 - x21 * y22);
         var _local13:Number = (x22 - x21) / (x22 * y21 - x21 * y22);
         var _local14:Number = (_local10 - _local12) / (_local13 * _local10 - _local11 * _local12);
         return _local14;
      }
      
      public static function crossPoint2D(x11:Number, y11:Number, x12:Number, y12:Number, x21:Number, y21:Number, x22:Number, y22:Number) : Point
      {
         var _local10:Number = (y11 - y12) / (x12 * y11 - x11 * y12);
         var _local11:Number = (x12 - x11) / (x12 * y11 - x11 * y12);
         var _local12:Number = (y21 - y22) / (x22 * y21 - x21 * y22);
         var _local13:Number = (x22 - x21) / (x22 * y21 - x21 * y22);
         var _local14:Number = (_local11 - _local13) / (_local12 * _local11 - _local10 * _local13);
         var _local15:Number = (_local10 - _local12) / (_local13 * _local10 - _local11 * _local12);
         return new Point(_local14,_local15);
      }
      
      public static function distance(d1:Point, d2:Point) : Number
      {
         return Math.sqrt(distanceSq(d1,d2));
      }
      
      public static function distanceSq(d1:Point, d2:Point) : Number
      {
         return (d1.x - d2.x) * (d1.x - d2.x) + (d1.y - d2.y) * (d1.y - d2.y);
      }
   }
}
