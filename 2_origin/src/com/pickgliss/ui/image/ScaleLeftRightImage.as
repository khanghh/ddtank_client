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
         var _loc2_:int = 0;
         var _loc1_:* = null;
         _bitmaps = new Vector.<Bitmap>();
         _loc2_ = 0;
         while(_loc2_ < _imageLinks.length)
         {
            _loc1_ = ComponentFactory.Instance.creat(_imageLinks[_loc2_]);
            _bitmaps.push(_loc1_);
            _loc2_++;
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
         var _loc4_:* = null;
         var _loc3_:Bitmap = _bitmaps.shift();
         var _loc6_:Array = cutRect.split(",");
         var _loc5_:Rectangle = new Rectangle(0,0,int(_loc6_[0]),_loc3_.height);
         var _loc2_:Rectangle = new Rectangle(_loc5_.width,0,int(_loc6_[1]),_loc3_.height);
         var _loc1_:Rectangle = new Rectangle(_loc2_.x + _loc2_.width,0,_loc3_.width - _loc5_.width - _loc2_.width,_loc3_.height);
         _loc4_ = new BitmapData(_loc5_.width,_loc5_.height);
         _loc4_.copyPixels(_loc3_.bitmapData,_loc5_,new Point(0,0));
         _bitmaps[0] = new Bitmap(_loc4_);
         _loc4_ = new BitmapData(_loc2_.width,_loc2_.height);
         _loc4_.copyPixels(_loc3_.bitmapData,_loc2_,new Point(0,0));
         _bitmaps[1] = new Bitmap(_loc4_);
         _loc4_ = new BitmapData(_loc1_.width,_loc1_.height);
         _loc4_.copyPixels(_loc3_.bitmapData,_loc1_,new Point(0,0));
         _bitmaps[2] = new Bitmap(_loc4_);
         ObjectUtils.disposeObject(_loc3_);
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
         var _loc1_:int = 0;
         if(_bitmaps == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _bitmaps.length)
         {
            ObjectUtils.disposeObject(_bitmaps[_loc1_]);
            _loc1_++;
         }
      }
   }
}
