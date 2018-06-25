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
      
      public function ScaleLeftRightImage()
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
         if(_imageLinks.length == 1 && cutRect)
         {
            cutImages();
         }
         _height = _bitmaps[1].bitmapData.height;
         _changedPropeties["height"] = true;
      }
      
      private function cutImages() : void
      {
         var btmd:* = null;
         var oldBtm:Bitmap = _bitmaps.shift();
         var pos:Array = cutRect.split(",");
         var leftRect:Rectangle = new Rectangle(0,0,int(pos[0]),oldBtm.height);
         var contentRect:Rectangle = new Rectangle(leftRect.width,0,int(pos[1]),oldBtm.height);
         var rightRect:Rectangle = new Rectangle(contentRect.x + contentRect.width,0,oldBtm.width - leftRect.width - contentRect.width,oldBtm.height);
         btmd = new BitmapData(leftRect.width,leftRect.height);
         btmd.copyPixels(oldBtm.bitmapData,leftRect,new Point(0,0));
         _bitmaps[0] = new Bitmap(btmd);
         btmd = new BitmapData(contentRect.width,contentRect.height);
         btmd.copyPixels(oldBtm.bitmapData,contentRect,new Point(0,0));
         _bitmaps[1] = new Bitmap(btmd);
         btmd = new BitmapData(rightRect.width,rightRect.height);
         btmd.copyPixels(oldBtm.bitmapData,rightRect,new Point(0,0));
         _bitmaps[2] = new Bitmap(btmd);
         ObjectUtils.disposeObject(oldBtm);
      }
      
      private function drawImage() : void
      {
         graphics.clear();
         graphics.beginBitmapFill(_bitmaps[1].bitmapData);
         graphics.drawRect(_bitmaps[0].width,0,_width - _bitmaps[0].width - _bitmaps[2].width,_height);
         graphics.endFill();
         _bitmaps[2].x = _width - _bitmaps[2].width;
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
