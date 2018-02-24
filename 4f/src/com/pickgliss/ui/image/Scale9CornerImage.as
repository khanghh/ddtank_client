package com.pickgliss.ui.image
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class Scale9CornerImage extends Image
   {
       
      
      private var _imageLinks:Array;
      
      private var _images:Vector.<BitmapData>;
      
      public function Scale9CornerImage(){super();}
      
      override public function dispose() : void{}
      
      override protected function resetDisplay() : void{}
      
      override protected function updateSize() : void{}
      
      private function creatImages() : void{}
      
      private function drawImage() : void{}
      
      private function removeImages() : void{}
   }
}
