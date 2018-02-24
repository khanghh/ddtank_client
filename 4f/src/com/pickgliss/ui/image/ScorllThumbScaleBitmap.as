package com.pickgliss.ui.image
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import org.bytearray.display.ScaleBitmap;
   
   public class ScorllThumbScaleBitmap extends Image
   {
       
      
      protected var _resource:BitmapData;
      
      protected var _middleBmp:Bitmap;
      
      protected var _middleRect:Rectangle = null;
      
      protected var _boderRect:Rectangle = null;
      
      protected var _isMiddle:Boolean = true;
      
      public function ScorllThumbScaleBitmap(param1:BitmapData = null, param2:String = null, param3:String = null, param4:Boolean = true){super();}
      
      public function set middleRect(param1:String) : void{}
      
      public function set boderRect(param1:String) : void{}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      public function updateMiddlePos() : void{}
      
      public function set resource(param1:BitmapData) : void{}
      
      public function get resource() : BitmapData{return null;}
      
      override protected function resetDisplay() : void{}
      
      protected function updateThumb() : void{}
      
      override protected function addChildren() : void{}
      
      override public function dispose() : void{}
   }
}
