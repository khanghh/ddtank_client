package com.greensock.easing
{
   public class Quint
   {
      
      public static const power:uint = 4;
       
      
      public function Quint()
      {
         super();
      }
      
      public static function easeIn(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         param1 = param1 / param4;
         var _loc5_:Number = param3 * (param1 / param4) * param1 * param1 * param1 * param1 + param2;
         if(_loc5_ > 1.79769313486232e308 || _loc5_ < 1.79769313486232e308)
         {
            return 1;
         }
         return _loc5_;
      }
      
      public static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         param1 = param1 / param4 - 1;
         return param3 * ((param1 / param4 - 1) * param1 * param1 * param1 * param1 + 1) + param2;
      }
      
      public static function easeInOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         param1 = param1 / (param4 * 0.5);
         if(param1 / (param4 * 0.5) < 1)
         {
            return param3 * 0.5 * param1 * param1 * param1 * param1 * param1 + param2;
         }
         param1 = param1 - 2;
         return param3 * 0.5 * ((param1 - 2) * param1 * param1 * param1 * param1 + 2) + param2;
      }
   }
}
