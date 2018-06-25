package ddt.display
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Graphics;
   import flash.display.Sprite;
   import flash.geom.Matrix;
   
   public class BitmapSprite extends Sprite implements Disposeable
   {
       
      
      protected var _bitmap:BitmapObject;
      
      protected var _matrix:Matrix;
      
      protected var _repeat:Boolean;
      
      protected var _smooth:Boolean;
      
      protected var _w:int;
      
      protected var _h:int;
      
      public function BitmapSprite(bitmap:BitmapObject = null, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false)
      {
         super();
         _bitmap = bitmap;
         _matrix = matrix;
         _repeat = repeat;
         _smooth = smooth;
         configUI();
      }
      
      public function set bitmapObject(val:BitmapObject) : void
      {
         var bitmap:BitmapObject = _bitmap;
         _bitmap = val;
         drawBitmap();
         if(bitmap)
         {
            bitmap.dispose();
         }
      }
      
      public function get bitmapObject() : BitmapObject
      {
         return _bitmap;
      }
      
      protected function drawBitmap() : void
      {
         var pen:* = null;
         graphics.clear();
         if(_bitmap)
         {
            pen = graphics;
            pen.beginBitmapFill(_bitmap,_matrix,_repeat,_smooth);
            pen.drawRect(0,0,_bitmap.width,_bitmap.height);
            pen.endFill();
         }
      }
      
      protected function configUI() : void
      {
         drawBitmap();
      }
      
      public function dispose() : void
      {
         if(parent)
         {
            parent.removeChild(this);
         }
         if(_bitmap)
         {
            _bitmap.dispose();
            _bitmap = null;
         }
      }
   }
}
