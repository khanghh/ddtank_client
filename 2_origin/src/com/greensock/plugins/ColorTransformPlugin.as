package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   
   public class ColorTransformPlugin extends TintPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      public function ColorTransformPlugin()
      {
         super();
         this.propName = "colorTransform";
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         var ratio:Number = NaN;
         if(!(target is DisplayObject))
         {
            return false;
         }
         var end:ColorTransform = target.transform.colorTransform;
         var _loc8_:* = 0;
         var _loc7_:* = value;
         for(var p in value)
         {
            if(p == "tint" || p == "color")
            {
               if(value[p] != null)
               {
                  end.color = int(value[p]);
               }
            }
            else if(!(p == "tintAmount" || p == "exposure" || p == "brightness"))
            {
               end[p] = value[p];
            }
         }
         if(!isNaN(value.tintAmount))
         {
            ratio = value.tintAmount / (1 - (end.redMultiplier + end.greenMultiplier + end.blueMultiplier) / 3);
            end.redOffset = end.redOffset * ratio;
            end.greenOffset = end.greenOffset * ratio;
            end.blueOffset = end.blueOffset * ratio;
            _loc8_ = 1 - value.tintAmount;
            end.blueMultiplier = _loc8_;
            _loc7_ = _loc8_;
            end.greenMultiplier = _loc7_;
            end.redMultiplier = _loc7_;
         }
         else if(!isNaN(value.exposure))
         {
            _loc8_ = 255 * (value.exposure - 1);
            end.blueOffset = _loc8_;
            _loc7_ = _loc8_;
            end.greenOffset = _loc7_;
            end.redOffset = _loc7_;
            _loc8_ = 1;
            end.blueMultiplier = _loc8_;
            _loc7_ = _loc8_;
            end.greenMultiplier = _loc7_;
            end.redMultiplier = _loc7_;
         }
         else if(!isNaN(value.brightness))
         {
            _loc8_ = Math.max(0,(value.brightness - 1) * 255);
            end.blueOffset = _loc8_;
            _loc7_ = _loc8_;
            end.greenOffset = _loc7_;
            end.redOffset = _loc7_;
            _loc8_ = 1 - Math.abs(value.brightness - 1);
            end.blueMultiplier = _loc8_;
            _loc7_ = _loc8_;
            end.greenMultiplier = _loc7_;
            end.redMultiplier = _loc7_;
         }
         _ignoreAlpha = Boolean(tween.vars.alpha != undefined && value.alphaMultiplier == undefined);
         init(target as DisplayObject,end);
         return true;
      }
   }
}
