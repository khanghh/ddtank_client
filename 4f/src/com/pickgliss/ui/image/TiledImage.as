package com.pickgliss.ui.image
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class TiledImage extends Image
   {
       
      
      private var _imageLink:String;
      
      private var _image:BitmapData;
      
      public function TiledImage(){super();}
      
      override protected function resetDisplay() : void{}
      
      private function creatImages() : void{}
      
      override protected function updateSize() : void{}
      
      private function drawImage() : void{}
      
      private function removeImages() : void{}
      
      override public function dispose() : void{}
   }
}
