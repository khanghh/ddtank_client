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
      
      public function BitmapShape(param1:BitmapObject = null, param2:Matrix = null, param3:Boolean = true, param4:Boolean = false)
      {
         super();
         _bitmap = param1;
         _matrix = param2;
         _repeat = param3;
         _smooth = param4;
         draw();
      }
      
      public function set bitmapObject(param1:BitmapObject) : void
      {
      }
      
      public function get bitmapObject() : BitmapObject
      {
         return _bitmap;
      }
      
      protected function draw() : void
      {
         var _loc1_:* = null;
         if(_bitmap)
         {
            _loc1_ = graphics;
            _loc1_.clear();
            _loc1_.beginBitmapFill(_bitmap,_matrix,_repeat,_smooth);
            _loc1_.drawRect(0,0,_bitmap.width,_bitmap.height);
            _loc1_.endFill();
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
