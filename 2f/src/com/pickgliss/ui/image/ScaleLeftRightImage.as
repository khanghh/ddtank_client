package com.pickgliss.ui.image
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ScaleLeftRightImage extends Image
   {
       
      
      private var _bitmaps:Vector.<Bitmap>;
      
      private var _imageLinks:Array;
      
      public var cutRect:String;
      
      public function ScaleLeftRightImage(){super();}
      
      override public function dispose() : void{}
      
      override protected function addChildren() : void{}
      
      override protected function resetDisplay() : void{}
      
      override protected function updateSize() : void{}
      
      private function creatImages() : void{}
      
      private function cutImages() : void{}
      
      private function drawImage() : void{}
      
      private function removeImages() : void{}
   }
}
