package com.greensock.easing
{
   public class Circ
   {
       
      
      public function Circ()
      {
         super();
      }
      
      public static function easeIn(t:Number, b:Number, c:Number, d:Number) : Number
      {
         t = t / d;
         return -c * (Math.sqrt(1 - t / d * t) - 1) + b;
      }
      
      public static function easeOut(t:Number, b:Number, c:Number, d:Number) : Number
      {
         t = t / d - 1;
         return c * Math.sqrt(1 - (t / d - 1) * t) + b;
      }
      
      public static function easeInOut(t:Number, b:Number, c:Number, d:Number) : Number
      {
         t = t / (d * 0.5);
         if(t / (d * 0.5) < 1)
         {
            return -c * 0.5 * (Math.sqrt(1 - t * t) - 1) + b;
         }
         t = t - 2;
         return c * 0.5 * (Math.sqrt(1 - (t - 2) * t) + 1) + b;
      }
   }
}
