package com.pickgliss.ui.image
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class ScaleNumberFrameImage extends ScaleFrameImage
   {
       
      
      private var _cutWidth:int;
      
      private var _image:Bitmap;
      
      public function ScaleNumberFrameImage()
      {
         super();
      }
      
      public function set cutWidth(value:int) : void
      {
         if(_cutWidth == value)
         {
            return;
         }
         _cutWidth = value;
      }
      
      override protected function addChildren() : void
      {
         if(_image)
         {
            addChild(_image);
         }
      }
      
      override protected function resetDisplay() : void
      {
         _display = ComponentFactory.Instance.creat(_resourceLink);
         _display.blendMode = "layer";
         if(_cutWidth == 0)
         {
            cutWidth = _display.width / 10;
         }
      }
      
      override public function setFrame(frameIndex:int) : void
      {
         if(frameIndex > 10)
         {
            return;
         }
         _currentFrame = frameIndex;
         if(frameIndex == 10)
         {
            frameIndex = 0;
         }
         ObjectUtils.disposeObject(_image);
         var data:BitmapData = (_display as Bitmap).bitmapData;
         var rect:Rectangle = new Rectangle(_cutWidth * frameIndex,0,_cutWidth,_display.height);
         var myBtmd:BitmapData = new BitmapData(_cutWidth,_display.height);
         myBtmd.copyPixels(data,rect,new Point(0,0));
         _image = new Bitmap(myBtmd);
         if(_width != Math.round(_image.width))
         {
            _width = Math.round(_image.width);
            _changedPropeties["width"] = true;
         }
         addChildren();
         fillRect();
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_image);
         super.dispose();
      }
   }
}
