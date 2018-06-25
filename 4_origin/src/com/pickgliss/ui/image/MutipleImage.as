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
         var i:int = 0;
         if(_images)
         {
            for(i = 0; i < _images.length; )
            {
               ObjectUtils.disposeObject(_images[i]);
               i++;
            }
         }
         _images = null;
         _imagesRect = null;
         super.dispose();
      }
      
      public function set imageRectString(value:String) : void
      {
         var i:int = 0;
         if(_imageRectString == value)
         {
            return;
         }
         _imagesRect = new Vector.<InnerRectangle>();
         _imageRectString = value;
         var rectsData:Array = ComponentFactory.parasArgs(_imageRectString);
         for(i = 0; i < rectsData.length; )
         {
            if(String(rectsData[i]) == "")
            {
               _imagesRect.push(null);
            }
            else
            {
               _imagesRect.push(ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",String(rectsData[i]).split("|")));
            }
            i++;
         }
         onPropertiesChanged("imagesRect");
      }
      
      override protected function addChildren() : void
      {
         var i:int = 0;
         super.addChildren();
         if(_images == null)
         {
            return;
         }
         i = 0;
         while(i < _images.length)
         {
            Sprite(_display).addChild(_images[i]);
            i++;
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
         var i:int = 0;
         var innerRect:* = null;
         if(_images == null)
         {
            return;
         }
         if(_changedPropeties["width"] || _changedPropeties["height"] || _changedPropeties["imagesRect"])
         {
            for(i = 0; i < _images.length; )
            {
               if(_imagesRect && _imagesRect[i])
               {
                  innerRect = _imagesRect[i].getInnerRect(_width,_height);
                  _images[i].x = innerRect.x;
                  _images[i].y = innerRect.y;
                  _images[i].height = innerRect.height;
                  _images[i].width = innerRect.width;
                  _width = Math.max(_width,_images[i].width);
                  _height = Math.max(_height,_images[i].height);
               }
               else
               {
                  _images[i].width = _width;
                  _images[i].height = _height;
               }
               i++;
            }
         }
      }
      
      private function creatImages() : void
      {
         var i:int = 0;
         var image:* = null;
         var imageArgs:* = null;
         _images = new Vector.<DisplayObject>();
         for(i = 0; i < _imageLinks.length; )
         {
            imageArgs = String(_imageLinks[i]).split("|");
            image = ComponentFactory.Instance.creat(imageArgs[0]);
            _images.push(image);
            i++;
         }
      }
      
      private function removeImages() : void
      {
         var i:int = 0;
         if(_images == null)
         {
            return;
         }
         i = 0;
         while(i < _images.length)
         {
            ObjectUtils.disposeObject(_images[i]);
            i++;
         }
      }
   }
}
