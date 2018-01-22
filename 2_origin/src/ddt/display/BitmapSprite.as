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
      
      public function BitmapSprite(param1:BitmapObject = null, param2:Matrix = null, param3:Boolean = true, param4:Boolean = false)
      {
         super();
         _bitmap = param1;
         _matrix = param2;
         _repeat = param3;
         _smooth = param4;
         configUI();
      }
      
      public function set bitmapObject(param1:BitmapObject) : void
      {
         var _loc2_:BitmapObject = _bitmap;
         _bitmap = param1;
         drawBitmap();
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public function get bitmapObject() : BitmapObject
      {
         return _bitmap;
      }
      
      protected function drawBitmap() : void
      {
         var _loc1_:* = null;
         graphics.clear();
         if(_bitmap)
         {
            _loc1_ = graphics;
            _loc1_.beginBitmapFill(_bitmap,_matrix,_repeat,_smooth);
            _loc1_.drawRect(0,0,_bitmap.width,_bitmap.height);
            _loc1_.endFill();
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
