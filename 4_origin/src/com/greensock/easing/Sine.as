package com.greensock.easing
{
   public class Sine
   {
      
      private static const _HALF_PI:Number = 1.5707963267948966;
       
      
      public function Sine()
      {
         super();
      }
      
      public static function easeIn(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return -c * Math.cos(t / d * 1.5707963267949) + c + b;
      }
      
      public static function easeOut(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return c * Math.sin(t / d * 1.5707963267949) + b;
      }
      
      public static function easeInOut(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return -c * 0.5 * (Math.cos(3.14159265358979 * t / d) - 1) + b;
      }
   }
}
