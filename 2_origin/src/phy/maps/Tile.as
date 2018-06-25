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
      
      public function Tile(bitmapData:BitmapData, digable:Boolean)
      {
         super(bitmapData);
         _digable = digable;
      }
      
      public function Dig(center:Point, surface:Bitmap, border:Bitmap = null) : void
      {
         var tb:* = null;
         var matrix:Matrix = new Matrix(1,0,0,1,center.x,center.y);
         if(surface && _digable)
         {
            matrix.tx = matrix.tx - surface.width / 2;
            matrix.ty = matrix.ty - surface.height / 2;
            bitmapData.draw(surface,matrix,null,"erase");
         }
         if(border && _digable)
         {
            tb = border.bitmapData.clone();
            matrix.tx = -center.x + border.width / 2;
            matrix.ty = -center.y + border.height / 2;
            tb.draw(this,matrix,null,"alpha");
            matrix.tx = center.x - border.width / 2;
            matrix.ty = center.y - border.height / 2;
            bitmapData.draw(tb,matrix,null,border.blendMode);
            tb.dispose();
         }
      }
      
      public function DigFillRect(rect:Rectangle) : void
      {
         bitmapData.fillRect(rect,0);
      }
      
      public function GetAlpha(x:int, y:int) : uint
      {
         return bitmapData.getPixel32(x,y) >> 24 & 255;
      }
      
      public function dispose() : void
      {
         bitmapData.dispose();
      }
   }
}
