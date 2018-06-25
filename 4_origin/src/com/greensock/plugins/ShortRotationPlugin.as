package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class ShortRotationPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      public function ShortRotationPlugin()
      {
         super();
         this.propName = "shortRotation";
         this.overwriteProps = [];
      }
      
      override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean
      {
         if(typeof value == "number")
         {
            return false;
         }
         var _loc6_:int = 0;
         var _loc5_:* = value;
         for(var p in value)
         {
            initRotation(target,p,target[p],typeof value[p] == "number"?Number(value[p]):target[p] + Number(value[p]));
         }
         return true;
      }
      
      public function initRotation(target:Object, propName:String, start:Number, end:Number) : void
      {
         var dif:Number = (end - start) % 360;
         if(dif != dif % 180)
         {
            dif = dif < 0?dif + 360:Number(dif - 360);
         }
         addTween(target,propName,start,start + dif,propName);
         this.overwriteProps[this.overwriteProps.length] = propName;
      }
   }
}
