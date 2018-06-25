package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class HexColorsPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      protected var _colors:Array;
      
      public function HexColorsPlugin()
      {
         super();
         this.propName = "hexColors";
         this.overwriteProps = [];
         _colors = [];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         var _loc6_:int = 0;
         var _loc5_:* = value;
         for(var p in value)
         {
            initColor(target,p,uint(target[p]),uint(value[p]));
         }
         return true;
      }
      
      public function initColor(target:Object, propName:String, start:uint, end:uint) : void
      {
         var r:Number = NaN;
         var g:Number = NaN;
         var b:Number = NaN;
         if(start != end)
         {
            r = start >> 16;
            g = start >> 8 & 255;
            b = start & 255;
            _colors[_colors.length] = [target,propName,r,(end >> 16) - r,g,(end >> 8 & 255) - g,b,(end & 255) - b];
            this.overwriteProps[this.overwriteProps.length] = propName;
         }
      }
      
      override public function killProps(lookup:Object) : void
      {
         var i:int = 0;
         for(i = _colors.length - 1; i > -1; )
         {
            if(lookup[_colors[i][1]] != undefined)
            {
               _colors.splice(i,1);
            }
            i--;
         }
         super.killProps(lookup);
      }
      
      override public function set changeFactor(n:Number) : void
      {
         var a:* = null;
         var i:int = _colors.length;
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            a = _colors[i];
            a[0][a[1]] = a[2] + n * a[3] << 16 | a[4] + n * a[5] << 8 | a[6] + n * a[7];
         }
      }
   }
}
