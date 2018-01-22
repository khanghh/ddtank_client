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
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean
      {
         if(typeof param2 == "number")
         {
            return false;
         }
         var _loc6_:int = 0;
         var _loc5_:* = param2;
         for(var _loc4_ in param2)
         {
            initRotation(param1,_loc4_,param1[_loc4_],typeof param2[_loc4_] == "number"?Number(param2[_loc4_]):param1[_loc4_] + Number(param2[_loc4_]));
         }
         return true;
      }
      
      public function initRotation(param1:Object, param2:String, param3:Number, param4:Number) : void
      {
         var _loc5_:Number = (param4 - param3) % 360;
         if(_loc5_ != _loc5_ % 180)
         {
            _loc5_ = _loc5_ < 0?_loc5_ + 360:Number(_loc5_ - 360);
         }
         addTween(param1,param2,param3,param3 + _loc5_,param2);
         this.overwriteProps[this.overwriteProps.length] = param2;
      }
   }
}
