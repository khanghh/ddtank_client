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
      
      public function Scale9CornerImage()
      {
         super();
      }
      
      override public function dispose() : void
      {
         graphics.clear();
         removeImages();
         _images = null;
         _imageLinks = null;
         super.dispose();
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
         _images = new Vector.<BitmapData>();
         for(i = 0; i < _imageLinks.length; )
         {
            _images.push(ComponentFactory.Instance.creatBitmapData(_imageLinks[i]));
            i++;
         }
      }
      
      private function drawImage() : void
      {
         graphics.clear();
         var startMatrix:Matrix = new Matrix();
         startMatrix.tx = 0;
         startMatrix.ty = 0;
         graphics.beginBitmapFill(_images[0],startMatrix);
         graphics.drawRect(0,0,_images[0].width,_images[0].height);
         startMatrix.tx = _images[0].width;
         startMatrix.ty = 0;
         graphics.beginBitmapFill(_images[1],startMatrix);
         graphics.drawRect(_images[0].width,0,_width - _images[0].width - _images[2].width,_images[1].height);
         startMatrix.tx = _width - _images[2].width;
         startMatrix.ty = 0;
         graphics.beginBitmapFill(_images[2],startMatrix);
         graphics.drawRect(_width - _images[2].width,0,_images[2].width,_images[2].height);
         startMatrix.tx = 0;
         startMatrix.ty = _images[0].height;
         graphics.beginBitmapFill(_images[3],startMatrix);
         graphics.drawRect(0,_images[0].height,_images[3].width,_height - _images[0].height - _images[6].height);
         startMatrix.tx = _images[0].width;
         startMatrix.ty = _images[0].height;
         graphics.beginBitmapFill(_images[4],startMatrix);
         graphics.drawRect(_images[0].width,_images[0].height,_width - _images[0].width - _images[2].width,_height - _images[0].height - _images[6].height);
         startMatrix.tx = _width - _images[5].width;
         startMatrix.ty = _images[2].height;
         graphics.beginBitmapFill(_images[5],startMatrix);
         graphics.drawRect(_width - _images[5].width,_images[2].height,_images[5].width,_height - _images[2].height - _images[8].height);
         startMatrix.tx = 0;
         startMatrix.ty = _height - _images[6].height;
         graphics.beginBitmapFill(_images[6],startMatrix);
         graphics.drawRect(0,_height - _images[6].height,_images[6].width,_images[6].height);
         startMatrix.tx = _images[6].width;
         startMatrix.ty = _height - _images[7].height;
         graphics.beginBitmapFill(_images[7],startMatrix);
         graphics.drawRect(_images[6].width,_height - _images[7].height,_width - _images[6].width - _images[8].width,_images[7].height);
         startMatrix.tx = _width - _images[8].width;
         startMatrix.ty = _height - _images[8].height;
         graphics.beginBitmapFill(_images[8],startMatrix);
         graphics.drawRect(_width - _images[8].width,_height - _images[8].height,_images[8].width,_images[8].height);
         graphics.endFill();
      }
      
      private function removeImages() : void
      {
         var i:int = 0;
         if(_images == null)
         {
            return;
         }
         graphics.clear();
         for(i = 0; i < _images.length; )
         {
            ObjectUtils.disposeObject(_images[i]);
            i++;
         }
      }
   }
}
