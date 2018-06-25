package ddt.utils{   import flash.geom.Point;      public class Geometry   {                   public function Geometry() { super(); }
            public static function getAngle4(p1x:Number, p1y:Number, p2x:Number, p2y:Number) : Number { return 0; }
            public static function getAngle(p1:Point, p2:Point) : Number { return 0; }
            public static function nextPoint2(px:Number, py:Number, angle:Number, distance:Number) : Point { return null; }
            public static function nextPoint(p:Point, angle:Number, distance:Number) : Point { return null; }
            private static function standardAngle(angle:Number) : Number { return 0; }
            public static function crossAngle(firstAngle:Number, secondAngle:Number) : Number { return 0; }
            public static function isClockwish(firstAngle:Number, secondAngle:Number) : Boolean { return false; }
            public static function cross_x(x11:Number, y11:Number, x12:Number, y12:Number, x21:Number, y21:Number, x22:Number, y22:Number) : Number { return 0; }
            public static function cross_y(x11:Number, y11:Number, x12:Number, y12:Number, x21:Number, y21:Number, x22:Number, y22:Number) : Number { return 0; }
            public static function crossPoint2D(x11:Number, y11:Number, x12:Number, y12:Number, x21:Number, y21:Number, x22:Number, y22:Number) : Point { return null; }
            public static function distance(d1:Point, d2:Point) : Number { return 0; }
            public static function distanceSq(d1:Point, d2:Point) : Number { return 0; }
   }}