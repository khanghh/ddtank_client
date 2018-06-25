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
      
      public function set direction(value:int) : void
      {
         if(_direction == value)
         {
            return;
         }
         _direction = value;
         onPropertiesChanged("direction");
      }
      
      override public function dispose() : void
      {
         graphics.clear();
         ObjectUtils.disposeObject(_brush);
         _brush = null;
         super.dispose();
      }
      
      public function set gape(value:int) : void
      {
         if(_gape == value)
         {
            return;
         }
         _gape = value;
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
         var len:int = 0;
         var startMatrix:* = null;
         var i:int = 0;
         if(_changedPropeties["width"] || _changedPropeties["height"] || _changedPropeties["direction"] || _changedPropeties["gape"])
         {
            len = 0;
            if(_direction != -1)
            {
               if(_direction == 1)
               {
                  len = _height / _brush.height;
               }
               else
               {
                  len = _width / _brush.width;
               }
            }
            graphics.clear();
            graphics.beginBitmapFill(_brush);
            startMatrix = new Matrix();
            for(i = 0; i < len; )
            {
               if(_direction == 1)
               {
                  graphics.drawRect(0,i * _brush.height + _gape,_brush.width,_brush.height);
               }
               else if(_direction > 1)
               {
                  graphics.drawRect(i * _brush.width + _gape,0,_brush.width,_brush.height);
               }
               else
               {
                  graphics.drawRect(0,0,_brush.width,_brush.height);
               }
               i++;
            }
            graphics.endFill();
         }
      }
   }
}
