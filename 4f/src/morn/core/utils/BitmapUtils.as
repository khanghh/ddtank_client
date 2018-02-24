package morn.core.utils
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class BitmapUtils
   {
      
      private static var m:Matrix = new Matrix();
      
      private static var newRect:Rectangle = new Rectangle();
      
      private static var clipRect:Rectangle = new Rectangle();
      
      private static var grid:Rectangle = new Rectangle();
      
      private static var destPoint:Point = new Point();
       
      
      public function BitmapUtils(){super();}
      
      public static function scale9Bmd(param1:BitmapData, param2:Array, param3:int, param4:int) : BitmapData{return null;}
      
      public static function setRect(param1:Rectangle, param2:Number = 0, param3:Number = 0, param4:Number = 0, param5:Number = 0) : Rectangle{return null;}
      
      public static function createClips(param1:BitmapData, param2:int, param3:int) : Vector.<BitmapData>{return null;}
   }
}
