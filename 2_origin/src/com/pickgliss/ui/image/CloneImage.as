package com.pickgliss.ui.image
{
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.BitmapData;
   import flash.geom.Matrix;
   
   public class CloneImage extends Image
   {
      
      public static const P_direction:String = "direction";
      
      public static const P_gape:String = "gape";
       
      
      protected var _brush:BitmapData;
      
      protected var _direction:int = -1;
      
      protected var _gape:int = 0;
      
      private var _brushHeight:Number;
      
      private var _brushWidth:Number;
      
      public function CloneImage()
      {
         super();
      }
      
      public function set direction(param1:int) : void
      {
         if(_direction == param1)
         {
            return;
         }
         _direction = param1;
         onPropertiesChanged("direction");
      }
      
      override public function dispose() : void
      {
         graphics.clear();
         ObjectUtils.disposeObject(_brush);
         _brush = null;
         super.dispose();
      }
      
      public function set gape(param1:int) : void
      {
         if(_gape == param1)
         {
            return;
         }
         _gape = param1;
         onPropertiesChanged("gape");
      }
      
      override protected function resetDisplay() : void
      {
         graphics.clear();
         _brushWidth = _width;
         _brushHeight = _height;
         _brush = ClassUtils.CreatInstance(_resourceLink,[0,0]);
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         if(_changedPropeties["width"] || _changedPropeties["height"] || _changedPropeties["direction"] || _changedPropeties["gape"])
         {
            _loc1_ = 0;
            if(_direction != -1)
            {
               if(_direction == 1)
               {
                  _loc1_ = _height / _brush.height;
               }
               else
               {
                  _loc1_ = _width / _brush.width;
               }
            }
            graphics.clear();
            graphics.beginBitmapFill(_brush);
            _loc2_ = new Matrix();
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               if(_direction == 1)
               {
                  graphics.drawRect(0,_loc3_ * _brush.height + _gape,_brush.width,_brush.height);
               }
               else if(_direction > 1)
               {
                  graphics.drawRect(_loc3_ * _brush.width + _gape,0,_brush.width,_brush.height);
               }
               else
               {
                  graphics.drawRect(0,0,_brush.width,_brush.height);
               }
               _loc3_++;
            }
            graphics.endFill();
         }
      }
   }
}
