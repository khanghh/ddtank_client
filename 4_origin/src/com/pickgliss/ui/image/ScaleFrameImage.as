package com.pickgliss.ui.image
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import com.pickgliss.utils.StringUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   
   public class ScaleFrameImage extends Image
   {
      
      public static const P_fillAlphaRect:String = "fillAlphaRect";
       
      
      var _currentFrame:uint;
      
      private var _fillAlphaRect:Boolean;
      
      private var _imageLinks:Array;
      
      private var _images:Vector.<DisplayObject>;
      
      public function ScaleFrameImage()
      {
         super();
      }
      
      override public function dispose() : void
      {
         removeImages();
         _images = null;
         _imageLinks = null;
         super.dispose();
      }
      
      public function set fillAlphaRect(value:Boolean) : void
      {
         if(_fillAlphaRect == value)
         {
            return;
         }
         _fillAlphaRect = value;
         onPropertiesChanged("fillAlphaRect");
      }
      
      public function get getFrame() : uint
      {
         return _currentFrame;
      }
      
      override public function setFrame(frameIndex:int) : void
      {
         var i:int = 0;
         super.setFrame(frameIndex);
         _currentFrame = frameIndex;
         for(i = 0; i < _images.length; )
         {
            if(_images[i] != null)
            {
               if(frameIndex - 1 == i)
               {
                  addChild(_images[i]);
                  if(_images[i] is MovieImage)
                  {
                     ((_images[i] as MovieImage).display as MovieClip).gotoAndPlay(1);
                  }
                  if(_width != Math.round(_images[i].width))
                  {
                     _width = Math.round(_images[i].width);
                     _changedPropeties["width"] = true;
                  }
               }
               else if(_images[i] && _images[i].parent)
               {
                  removeChild(_images[i]);
               }
            }
            i++;
         }
         fillRect();
      }
      
      function fillRect() : void
      {
         if(_fillAlphaRect)
         {
            graphics.beginFill(16711935,0);
            graphics.drawRect(0,0,_width,_height);
            graphics.endFill();
         }
      }
      
      override protected function init() : void
      {
         super.init();
      }
      
      override protected function resetDisplay() : void
      {
         _imageLinks = ComponentFactory.parasArgs(_resourceLink);
         removeImages();
         fillImages();
         creatFrameImage(0);
      }
      
      override protected function updateSize() : void
      {
         var i:int = 0;
         if(_images == null)
         {
            return;
         }
         if(_changedPropeties["width"] || _changedPropeties["height"])
         {
            for(i = 0; i < _images.length; )
            {
               if(_images[i] != null)
               {
                  _images[i].width = _width;
                  _images[i].height = _height;
               }
               i++;
            }
         }
      }
      
      private function fillImages() : void
      {
         var i:int = 0;
         _images = new Vector.<DisplayObject>();
         for(i = 0; i < _imageLinks.length; )
         {
            _images.push(null);
            i++;
         }
      }
      
      public function creatFrameImage(index:int) : void
      {
         var i:int = 0;
         var image:* = null;
         for(i = 0; i < _imageLinks.length; )
         {
            if(!StringUtils.isEmpty(_imageLinks[i]) && _images[i] == null)
            {
               image = ComponentFactory.Instance.creat(_imageLinks[i]);
               _width = Math.max(_width,image.width);
               _height = Math.max(_height,image.height);
               _images[i] = image;
               addChild(image);
            }
            i++;
         }
      }
      
      public function getFrameImage(frameIndex:int) : DisplayObject
      {
         return _images[frameIndex];
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
      
      public function get totalFrames() : int
      {
         return _images.length;
      }
   }
}
