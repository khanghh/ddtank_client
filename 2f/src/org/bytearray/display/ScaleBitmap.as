package org.bytearray.display
{
   import com.pickgliss.ui.core.Disposeable;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   
   public class ScaleBitmap extends Bitmap implements Disposeable
   {
       
      
      protected var _originalBitmap:BitmapData;
      
      protected var _scale9Grid:Rectangle = null;
      
      public function ScaleBitmap(param1:BitmapData = null, param2:String = "auto", param3:Boolean = false){super(null,null,null);}
      
      override public function set bitmapData(param1:BitmapData) : void{}
      
      public function dispose() : void{}
      
      public function getOriginalBitmapData() : BitmapData{return null;}
      
      override public function set height(param1:Number) : void{}
      
      override public function get scale9Grid() : Rectangle{return null;}
      
      override public function set scale9Grid(param1:Rectangle) : void{}
      
      public function setSize(param1:Number, param2:Number) : void{}
      
      override public function set width(param1:Number) : void{}
      
      protected function resizeBitmap(param1:Number, param2:Number) : void{}
      
      private function assignBitmapData(param1:BitmapData) : void{}
      
      private function validGrid(param1:Rectangle) : Boolean{return false;}
   }
}
