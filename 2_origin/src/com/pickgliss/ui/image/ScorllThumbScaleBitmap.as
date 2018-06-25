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
      
      public function ScorllThumbScaleBitmap($resource:BitmapData = null, $middleRectString:String = null, $boderRectString:String = null, $isMiddle:Boolean = true)
      {
         super();
         _isMiddle = $isMiddle;
         resource = $resource;
         middleRect = $middleRectString;
         boderRect = $boderRectString;
      }
      
      public function set middleRect($middleRectString:String) : void
      {
         if($middleRectString == null)
         {
            return;
         }
         var args:Array = ComponentFactory.parasArgs($middleRectString);
         _middleRect = new Rectangle(args[0],args[1],args[2],args[3]);
         updateThumb();
      }
      
      public function set boderRect($boderRectString:String) : void
      {
         if($boderRectString == null)
         {
            return;
         }
         var args:Array = ComponentFactory.parasArgs($boderRectString);
         _boderRect = new Rectangle(args[0],args[1],args[2],args[3]);
         updateThumb();
      }
      
      override public function set width(w:Number) : void
      {
         if(w != width)
         {
            _width = w;
            if(_display)
            {
               _display.width = _width;
            }
            updateMiddlePos();
            onPropertiesChanged("width");
         }
      }
      
      override public function set height(h:Number) : void
      {
         if(h != height)
         {
            _height = h;
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
      
      public function set resource(source:BitmapData) : void
      {
         if(source == _resource)
         {
            return;
         }
         _resource = source;
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
         var middleData:* = null;
         if(!_resource || !_middleRect || !_boderRect)
         {
            return;
         }
         ObjectUtils.disposeObject(_display);
         ObjectUtils.disposeObject(_middleBmp);
         var bgBmpData:BitmapData = new BitmapData(_resource.width,_resource.height - _middleRect.height,true,0);
         bgBmpData.copyPixels(_resource,new Rectangle(0,0,bgBmpData.width,_middleRect.y),new Point(0,0));
         bgBmpData.copyPixels(_resource,new Rectangle(0,_middleRect.y + _middleRect.height,bgBmpData.width,_resource.height),new Point(0,_middleRect.y));
         _display = new ScaleBitmap(bgBmpData);
         _display.scale9Grid = new Rectangle(_boderRect.x,_boderRect.y,bgBmpData.width - (_boderRect.x + _boderRect.width),_middleRect.y - _boderRect.y);
         if(_isMiddle)
         {
            middleData = new BitmapData(_middleRect.width,_middleRect.height,true,0);
            middleData.copyPixels(_resource,_middleRect,new Point(0,0));
            _middleBmp = new Bitmap(middleData);
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
