package starling.utils
{
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import starling.errors.AbstractClassError;
   
   public class RectangleUtil
   {
      
      private static const sHelperPoint:Point = new Point();
      
      private static const sPositions:Vector.<Point> = new <Point>[new Point(0,0),new Point(1,0),new Point(0,1),new Point(1,1)];
       
      
      public function RectangleUtil(){super();}
      
      public static function intersect(param1:Rectangle, param2:Rectangle, param3:Rectangle = null) : Rectangle{return null;}
      
      public static function fit(param1:Rectangle, param2:Rectangle, param3:String = "showAll", param4:Boolean = false, param5:Rectangle = null) : Rectangle{return null;}
      
      private static function nextSuitableScaleFactor(param1:Number, param2:Boolean) : Number{return 0;}
      
      public static function normalize(param1:Rectangle) : void{}
      
      public static function getBounds(param1:Rectangle, param2:Matrix, param3:Rectangle = null) : Rectangle{return null;}
   }
}
