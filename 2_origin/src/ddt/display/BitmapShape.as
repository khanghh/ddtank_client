package ddt.display
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Graphics;
   import flash.display.Shape;
   import flash.geom.Matrix;
   
   public class BitmapShape extends Shape implements Disposeable
   {
       
      
      private var _bitmap:BitmapObject;
      
      private var _matrix:Matrix;
      
      private var _repeat:Boolean;
      
      private var _smooth:Boolean;
      
      public function BitmapShape(bitmap:BitmapObject = null, matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false)
      {
         super();
         _bitmap = bitmap;
         _matrix = matrix;
         _repeat = repeat;
         _smooth = smooth;
         draw();
      }
      
      public function set bitmapObject(val:BitmapObject) : void
      {
      }
      
      public function get bitmapObject() : BitmapObject
      {
         return _bitmap;
      }
      
      protected function draw() : void
      {
         var pen:* = null;
         if(_bitmap)
         {
            pen = graphics;
            pen.clear();
            pen.beginBitmapFill(_bitmap,_matrix,_repeat,_smooth);
            pen.drawRect(0,0,_bitmap.width,_bitmap.height);
            pen.endFill();
         }
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
         }
      }
   }
}
