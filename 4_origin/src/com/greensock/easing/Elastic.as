package com.greensock.easing
{
   public class Elastic
   {
      
      private static const _2PI:Number = 6.283185307179586;
       
      
      public function Elastic()
      {
         super();
      }
      
      public static function easeIn(t:Number, b:Number, c:Number, d:Number, a:Number = 0, p:Number = 0) : Number
      {
         var s:Number = NaN;
         if(t == 0)
         {
            return b;
         }
         t = t / d;
         if(t / d == 1)
         {
            return b + c;
         }
         if(!p)
         {
            p = d * 0.3;
         }
         if(!a || c > 0 && a < c || c < 0 && a < -c)
         {
            a = c;
            s = p / 4;
         }
         else
         {
            s = p / 6.28318530717959 * Math.asin(c / a);
         }
         t = t - 1;
         return -(a * Math.pow(2,10 * (t - 1)) * Math.sin((t * d - s) * 6.28318530717959 / p)) + b;
      }
      
      public static function easeOut(t:Number, b:Number, c:Number, d:Number, a:Number = 0, p:Number = 0) : Number
      {
         var s:Number = NaN;
         if(t == 0)
         {
            return b;
         }
         t = t / d;
         if(t / d == 1)
         {
            return b + c;
         }
         if(!p)
         {
            p = d * 0.3;
         }
         if(!a || c > 0 && a < c || c < 0 && a < -c)
         {
            a = c;
            s = p / 4;
         }
         else
         {
            s = p / 6.28318530717959 * Math.asin(c / a);
         }
         return a * Math.pow(2,-10 * t) * Math.sin((t * d - s) * 6.28318530717959 / p) + c + b;
      }
      
      public static function easeInOut(t:Number, b:Number, c:Number, d:Number, a:Number = 0, p:Number = 0) : Number
      {
         var s:Number = NaN;
         if(t == 0)
         {
            return b;
         }
         t = t / (d * 0.5);
         if(t / (d * 0.5) == 2)
         {
            return b + c;
         }
         if(!p)
         {
            p = d * 0.45;
         }
         if(!a || c > 0 && a < c || c < 0 && a < -c)
         {
            a = c;
            s = p / 4;
         }
         else
         {
            s = p / 6.28318530717959 * Math.asin(c / a);
         }
         if(t < 1)
         {
            t = t - 1;
            return -0.5 * (a * Math.pow(2,10 * (t - 1)) * Math.sin((t * d - s) * 6.28318530717959 / p)) + b;
         }
         t = t - 1;
         return a * Math.pow(2,-10 * (t - 1)) * Math.sin((t * d - s) * 6.28318530717959 / p) * 0.5 + c + b;
      }
   }
}
