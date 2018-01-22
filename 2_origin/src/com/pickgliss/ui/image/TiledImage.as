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
      
      public function TiledImage()
      {
         super();
      }
      
      override protected function resetDisplay() : void
      {
         removeImages();
         creatImages();
      }
      
      private function creatImages() : void
      {
         _image = ComponentFactory.Instance.creatBitmapData(_resourceLink);
      }
      
      override protected function updateSize() : void
      {
         if(_changedPropeties["width"] || _changedPropeties["height"])
         {
            drawImage();
         }
      }
      
      private function drawImage() : void
      {
         graphics.clear();
         var _loc1_:Matrix = new Matrix();
         _loc1_.tx = 0;
         _loc1_.ty = 0;
         graphics.beginBitmapFill(_image,_loc1_);
         graphics.drawRect(0,0,width,height);
         graphics.endFill();
      }
      
      private function removeImages() : void
      {
         if(_image == null)
         {
            return;
         }
         graphics.clear();
         ObjectUtils.disposeObject(_image);
      }
      
      override public function dispose() : void
      {
         graphics.clear();
         removeImages();
         _image = null;
         super.dispose();
      }
   }
}
