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
      
      public function BitmapShape(param1:BitmapObject = null, param2:Matrix = null, param3:Boolean = true, param4:Boolean = false){super();}
      
      public function set bitmapObject(param1:BitmapObject) : void{}
      
      public function get bitmapObject() : BitmapObject{return null;}
      
      protected function draw() : void{}
      
      public function dispose() : void{}
   }
}
