package com.pickgliss.ui.image
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   
   public class ScaleUpDownImage extends Image
   {
       
      
      private var _bitmaps:Vector.<Bitmap>;
      
      private var _imageLinks:Array;
      
      public function ScaleUpDownImage()
      {
         super();
      }
      
      override public function dispose() : void
      {
         removeImages();
         graphics.clear();
         _bitmaps = null;
         super.dispose();
      }
      
      override protected function addChildren() : void
      {
         if(_bitmaps == null)
         {
            return;
         }
         addChild(_bitmaps[0]);
         addChild(_bitmaps[2]);
      }
      
      override protected function resetDisplay() : void
      {
         _imageLinks = ComponentFactory.parasArgs(_resourceLink);
         removeImages();
         creatImages();
      }
      
      override protected function updateSize() : void
      {
         if(_changedPropeties["width"] || _changedPropeties["height"])
         {
            drawImage();
         }
      }
      
      private function creatImages() : void
      {
         var i:int = 0;
         var bitmap:* = null;
         _bitmaps = new Vector.<Bitmap>();
         for(i = 0; i < _imageLinks.length; )
         {
            bitmap = ComponentFactory.Instance.creat(_imageLinks[i]);
            _bitmaps.push(bitmap);
            i++;
         }
      }
      
      private function drawImage() : void
      {
         graphics.clear();
         graphics.beginBitmapFill(_bitmaps[1].bitmapData);
         graphics.drawRect(0,_bitmaps[0].height,_width,_height - _bitmaps[0].height - _bitmaps[2].height);
         graphics.endFill();
         _bitmaps[2].y = _height - _bitmaps[2].height;
      }
      
      private function removeImages() : void
      {
         var i:int = 0;
         if(_bitmaps == null)
         {
            return;
         }
         i = 0;
         while(i < _bitmaps.length)
         {
            ObjectUtils.disposeObject(_bitmaps[i]);
            i++;
         }
      }
   }
}
