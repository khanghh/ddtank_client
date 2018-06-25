package com.greensock.easing
{
   public class Bounce
   {
       
      
      public function Bounce()
      {
         super();
      }
      
      public static function easeOut(t:Number, b:Number, c:Number, d:Number) : Number
      {
         t = t / d;
         if(t / d < 0.363636363636364)
         {
            return c * (7.5625 * t * t) + b;
         }
         if(t < 0.727272727272727)
         {
            t = t - 0.545454545454545;
            return c * (7.5625 * (t - 0.545454545454545) * t + 0.75) + b;
         }
         if(t < 0.909090909090909)
         {
            t = t - 0.818181818181818;
            return c * (7.5625 * (t - 0.818181818181818) * t + 0.9375) + b;
         }
         t = t - 0.954545454545455;
         return c * (7.5625 * (t - 0.954545454545455) * t + 0.984375) + b;
      }
      
      public static function easeIn(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return c - easeOut(d - t,0,c,d) + b;
      }
      
      public static function easeInOut(t:Number, b:Number, c:Number, d:Number) : Number
      {
         if(t < d * 0.5)
         {
            return easeIn(t * 2,0,c,d) * 0.5 + b;
         }
         return easeOut(t * 2 - d,0,c,d) * 0.5 + c * 0.5 + b;
      }
   }
}
