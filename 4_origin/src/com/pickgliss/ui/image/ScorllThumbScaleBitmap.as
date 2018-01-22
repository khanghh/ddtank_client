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
      
      public function ScorllThumbScaleBitmap(param1:BitmapData = null, param2:String = null, param3:String = null, param4:Boolean = true)
      {
         super();
         _isMiddle = param4;
         resource = param1;
         middleRect = param2;
         boderRect = param3;
      }
      
      public function set middleRect(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:Array = ComponentFactory.parasArgs(param1);
         _middleRect = new Rectangle(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3]);
         updateThumb();
      }
      
      public function set boderRect(param1:String) : void
      {
         if(param1 == null)
         {
            return;
         }
         var _loc2_:Array = ComponentFactory.parasArgs(param1);
         _boderRect = new Rectangle(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3]);
         updateThumb();
      }
      
      override public function set width(param1:Number) : void
      {
         if(param1 != width)
         {
            _width = param1;
            if(_display)
            {
               _display.width = _width;
            }
            updateMiddlePos();
            onPropertiesChanged("width");
         }
      }
      
      override public function set height(param1:Number) : void
      {
         if(param1 != height)
         {
            _height = param1;
            if(_display)
            {
               _display.height = _height;
            }
            updateMiddlePos();
            onPropertiesChanged("height");
         }
      }
      
      public function updateMiddlePos() : void
      {
         if(_isMiddle && _display)
         {
            _middleBmp.x = _display.x + (_display.width - _middleBmp.width) / 2;
            _middleBmp.y = _display.y + (_display.height - _middleBmp.height) / 2;
         }
      }
      
      public function set resource(param1:BitmapData) : void
      {
         if(param1 == _resource)
         {
            return;
         }
         _resource = param1;
         onPropertiesChanged("resourceLink");
      }
      
      public function get resource() : BitmapData
      {
         return _resource;
      }
      
      override protected function resetDisplay() : void
      {
         if(_resource == null)
         {
            _resource = ClassUtils.CreatInstance(_resourceLink);
         }
         updateThumb();
      }
      
      protected function updateThumb() : void
      {
         var _loc1_:* = null;
         if(!_resource || !_middleRect || !_boderRect)
         {
            return;
         }
         ObjectUtils.disposeObject(_display);
         ObjectUtils.disposeObject(_middleBmp);
         var _loc2_:BitmapData = new BitmapData(_resource.width,_resource.height - _middleRect.height,true,0);
         _loc2_.copyPixels(_resource,new Rectangle(0,0,_loc2_.width,_middleRect.y),new Point(0,0));
         _loc2_.copyPixels(_resource,new Rectangle(0,_middleRect.y + _middleRect.height,_loc2_.width,_resource.height),new Point(0,_middleRect.y));
         _display = new ScaleBitmap(_loc2_);
         _display.scale9Grid = new Rectangle(_boderRect.x,_boderRect.y,_loc2_.width - (_boderRect.x + _boderRect.width),_middleRect.y - _boderRect.y);
         if(_isMiddle)
         {
            _loc1_ = new BitmapData(_middleRect.width,_middleRect.height,true,0);
            _loc1_.copyPixels(_resource,_middleRect,new Point(0,0));
            _middleBmp = new Bitmap(_loc1_);
            addChild(_middleBmp);
         }
         if(_width > 0)
         {
            _display.width = _width;
         }
         else
         {
            _display.width = _resource.width;
         }
         if(_height > 0)
         {
            _display.height = _height;
         }
         else
         {
            _display.height = _resource.height;
         }
         updateMiddlePos();
      }
      
      override protected function addChildren() : void
      {
         if(_display)
         {
            addChild(_display);
         }
         if(_middleBmp)
         {
            addChild(_middleBmp);
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeObject(_resource);
         _resource = null;
         ObjectUtils.disposeObject(_middleBmp);
         _middleBmp = null;
      }
   }
}
