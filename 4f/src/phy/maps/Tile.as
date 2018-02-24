package phy.maps
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class Tile extends Bitmap
   {
       
      
      private var _digable:Boolean;
      
      public function Tile(param1:BitmapData, param2:Boolean){super(null);}
      
      public function Dig(param1:Point, param2:Bitmap, param3:Bitmap = null) : void{}
      
      public function DigFillRect(param1:Rectangle) : void{}
      
      public function GetAlpha(param1:int, param2:int) : uint{return null;}
      
      public function dispose() : void{}
   }
}
