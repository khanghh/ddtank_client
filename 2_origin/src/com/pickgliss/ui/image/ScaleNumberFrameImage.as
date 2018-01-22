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
      
      public function set cutWidth(param1:int) : void
      {
         if(_cutWidth == param1)
         {
            return;
         }
         _cutWidth = param1;
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
      
      override public function setFrame(param1:int) : void
      {
         if(param1 > 10)
         {
            return;
         }
         _currentFrame = param1;
         if(param1 == 10)
         {
            param1 = 0;
         }
         ObjectUtils.disposeObject(_image);
         var _loc3_:BitmapData = (_display as Bitmap).bitmapData;
         var _loc4_:Rectangle = new Rectangle(_cutWidth * param1,0,_cutWidth,_display.height);
         var _loc2_:BitmapData = new BitmapData(_cutWidth,_display.height);
         _loc2_.copyPixels(_loc3_,_loc4_,new Point(0,0));
         _image = new Bitmap(_loc2_);
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
