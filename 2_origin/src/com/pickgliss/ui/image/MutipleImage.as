package com.pickgliss.ui.image
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Rectangle;
   
   public class MutipleImage extends Image
   {
      
      public static const P_imageRect:String = "imagesRect";
       
      
      private var _imageLinks:Array;
      
      private var _imageRectString:String;
      
      private var _images:Vector.<DisplayObject>;
      
      private var _imagesRect:Vector.<InnerRectangle>;
      
      public function MutipleImage()
      {
         super();
      }
      
      override public function dispose() : void
      {
         var _loc1_:int = 0;
         if(_images)
         {
            _loc1_ = 0;
            while(_loc1_ < _images.length)
            {
               ObjectUtils.disposeObject(_images[_loc1_]);
               _loc1_++;
            }
         }
         _images = null;
         _imagesRect = null;
         super.dispose();
      }
      
      public function set imageRectString(param1:String) : void
      {
         var _loc2_:int = 0;
         if(_imageRectString == param1)
         {
            return;
         }
         _imagesRect = new Vector.<InnerRectangle>();
         _imageRectString = param1;
         var _loc3_:Array = ComponentFactory.parasArgs(_imageRectString);
         _loc2_ = 0;
         while(_loc2_ < _loc3_.length)
         {
            if(String(_loc3_[_loc2_]) == "")
            {
               _imagesRect.push(null);
            }
            else
            {
               _imagesRect.push(ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",String(_loc3_[_loc2_]).split("|")));
            }
            _loc2_++;
         }
         onPropertiesChanged("imagesRect");
      }
      
      override protected function addChildren() : void
      {
         var _loc1_:int = 0;
         super.addChildren();
         if(_images == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _images.length)
         {
            Sprite(_display).addChild(_images[_loc1_]);
            _loc1_++;
         }
      }
      
      override protected function init() : void
      {
         _display = new Sprite();
         super.init();
      }
      
      override protected function resetDisplay() : void
      {
         _imageLinks = ComponentFactory.parasArgs(_resourceLink);
         removeImages();
         creatImages();
      }
      
      override protected function updateSize() : void
      {
         var _loc2_:int = 0;
         var _loc1_:* = null;
         if(_images == null)
         {
            return;
         }
         if(_changedPropeties["width"] || _changedPropeties["height"] || _changedPropeties["imagesRect"])
         {
            _loc2_ = 0;
            while(_loc2_ < _images.length)
            {
               if(_imagesRect && _imagesRect[_loc2_])
               {
                  _loc1_ = _imagesRect[_loc2_].getInnerRect(_width,_height);
                  _images[_loc2_].x = _loc1_.x;
                  _images[_loc2_].y = _loc1_.y;
                  _images[_loc2_].height = _loc1_.height;
                  _images[_loc2_].width = _loc1_.width;
                  _width = Math.max(_width,_images[_loc2_].width);
                  _height = Math.max(_height,_images[_loc2_].height);
               }
               else
               {
                  _images[_loc2_].width = _width;
                  _images[_loc2_].height = _height;
               }
               _loc2_++;
            }
         }
      }
      
      private function creatImages() : void
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:* = null;
         _images = new Vector.<DisplayObject>();
         _loc3_ = 0;
         while(_loc3_ < _imageLinks.length)
         {
            _loc2_ = String(_imageLinks[_loc3_]).split("|");
            _loc1_ = ComponentFactory.Instance.creat(_loc2_[0]);
            _images.push(_loc1_);
            _loc3_++;
         }
      }
      
      private function removeImages() : void
      {
         var _loc1_:int = 0;
         if(_images == null)
         {
            return;
         }
         _loc1_ = 0;
         while(_loc1_ < _images.length)
         {
            ObjectUtils.disposeObject(_images[_loc1_]);
            _loc1_++;
         }
      }
   }
}
