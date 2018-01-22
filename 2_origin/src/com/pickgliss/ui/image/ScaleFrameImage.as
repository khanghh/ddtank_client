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
      
      public function set fillAlphaRect(param1:Boolean) : void
      {
         if(_fillAlphaRect == param1)
         {
            return;
         }
         _fillAlphaRect = param1;
         onPropertiesChanged("fillAlphaRect");
      }
      
      public function get getFrame() : uint
      {
         return _currentFrame;
      }
      
      override public function setFrame(param1:int) : void
      {
         var _loc2_:int = 0;
         super.setFrame(param1);
         _currentFrame = param1;
         _loc2_ = 0;
         while(_loc2_ < _images.length)
         {
            if(_images[_loc2_] != null)
            {
               if(param1 - 1 == _loc2_)
               {
                  addChild(_images[_loc2_]);
                  if(_images[_loc2_] is MovieImage)
                  {
                     ((_images[_loc2_] as MovieImage).display as MovieClip).gotoAndPlay(1);
                  }
                  if(_width != Math.round(_images[_loc2_].width))
                  {
                     _width = Math.round(_images[_loc2_].width);
                     _changedPropeties["width"] = true;
                  }
               }
               else if(_images[_loc2_] && _images[_loc2_].parent)
               {
                  removeChild(_images[_loc2_]);
               }
            }
            _loc2_++;
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
         var _loc1_:int = 0;
         if(_images == null)
         {
            return;
         }
         if(_changedPropeties["width"] || _changedPropeties["height"])
         {
            _loc1_ = 0;
            while(_loc1_ < _images.length)
            {
               if(_images[_loc1_] != null)
               {
                  _images[_loc1_].width = _width;
                  _images[_loc1_].height = _height;
               }
               _loc1_++;
            }
         }
      }
      
      private function fillImages() : void
      {
         var _loc1_:int = 0;
         _images = new Vector.<DisplayObject>();
         _loc1_ = 0;
         while(_loc1_ < _imageLinks.length)
         {
            _images.push(null);
            _loc1_++;
         }
      }
      
      public function creatFrameImage(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         _loc3_ = 0;
         while(_loc3_ < _imageLinks.length)
         {
            if(!StringUtils.isEmpty(_imageLinks[_loc3_]) && _images[_loc3_] == null)
            {
               _loc2_ = ComponentFactory.Instance.creat(_imageLinks[_loc3_]);
               _width = Math.max(_width,_loc2_.width);
               _height = Math.max(_height,_loc2_.height);
               _images[_loc3_] = _loc2_;
               addChild(_loc2_);
            }
            _loc3_++;
         }
      }
      
      public function getFrameImage(param1:int) : DisplayObject
      {
         return _images[param1];
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
      
      public function get totalFrames() : int
      {
         return _images.length;
      }
   }
}
