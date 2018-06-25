package com.gskinner.geom
{
   public dynamic class ColorMatrix extends Array
   {
      
      private static const DELTA_INDEX:Array = [0,0.01,0.02,0.04,0.05,0.06,0.07,0.08,0.1,0.11,0.12,0.14,0.15,0.16,0.17,0.18,0.2,0.21,0.22,0.24,0.25,0.27,0.28,0.3,0.32,0.34,0.36,0.38,0.4,0.42,0.44,0.46,0.48,0.5,0.53,0.56,0.59,0.62,0.65,0.68,0.71,0.74,0.77,0.8,0.83,0.86,0.89,0.92,0.95,0.98,1,1.06,1.12,1.18,1.24,1.3,1.36,1.42,1.48,1.54,1.6,1.66,1.72,1.78,1.84,1.9,1.96,2,2.12,2.25,2.37,2.5,2.62,2.75,2.87,3,3.2,3.4,3.6,3.8,4,4.3,4.7,4.9,5,5.5,6,6.5,6.8,7,7.3,7.5,7.8,8,8.4,8.7,9,9.4,9.6,9.8,10];
      
      private static const IDENTITY_MATRIX:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1];
      
      private static const LENGTH:Number = IDENTITY_MATRIX.length;
       
      
      public function ColorMatrix(p_matrix:Array = null)
      {
         super();
         p_matrix = fixMatrix(p_matrix);
         copyMatrix(p_matrix.length == LENGTH?p_matrix:IDENTITY_MATRIX);
      }
      
      public function reset() : void
      {
         var i:* = 0;
         for(i = uint(0); i < LENGTH; )
         {
            this[i] = IDENTITY_MATRIX[i];
            i++;
         }
      }
      
      public function adjustColor(p_brightness:Number, p_contrast:Number, p_saturation:Number, p_hue:Number) : void
      {
         adjustHue(p_hue);
         adjustContrast(p_contrast);
         adjustBrightness(p_brightness);
         adjustSaturation(p_saturation);
      }
      
      public function adjustBrightness(p_val:Number) : void
      {
         p_val = cleanValue(p_val,100);
         if(p_val == 0 || isNaN(p_val))
         {
            return;
         }
         multiplyMatrix([1,0,0,0,p_val,0,1,0,0,p_val,0,0,1,0,p_val,0,0,0,1,0,0,0,0,0,1]);
      }
      
      public function adjustContrast(p_val:Number) : void
      {
         var x:Number = NaN;
         p_val = cleanValue(p_val,100);
         if(p_val == 0 || isNaN(p_val))
         {
            return;
         }
         if(p_val < 0)
         {
            x = 127 + p_val / 100 * 127;
         }
         else
         {
            x = p_val % 1;
            if(x == 0)
            {
               x = DELTA_INDEX[p_val];
            }
            else
            {
               x = DELTA_INDEX[p_val << 0] * (1 - x) + DELTA_INDEX[(p_val << 0) + 1] * x;
            }
            x = x * 127 + 127;
         }
         multiplyMatrix([x / 127,0,0,0,0.5 * (127 - x),0,x / 127,0,0,0.5 * (127 - x),0,0,x / 127,0,0.5 * (127 - x),0,0,0,1,0,0,0,0,0,1]);
      }
      
      public function adjustSaturation(p_val:Number) : void
      {
         p_val = cleanValue(p_val,100);
         if(p_val == 0 || isNaN(p_val))
         {
            return;
         }
         var x:Number = 1 + (p_val > 0?3 * p_val / 100:Number(p_val / 100));
         var lumR:* = 0.3086;
         var lumG:* = 0.6094;
         var lumB:* = 0.082;
         multiplyMatrix([lumR * (1 - x) + x,lumG * (1 - x),lumB * (1 - x),0,0,lumR * (1 - x),lumG * (1 - x) + x,lumB * (1 - x),0,0,lumR * (1 - x),lumG * (1 - x),lumB * (1 - x) + x,0,0,0,0,0,1,0,0,0,0,0,1]);
      }
      
      public function adjustHue(p_val:Number) : void
      {
         p_val = cleanValue(p_val,180) / 180 * 3.14159265358979;
         if(p_val == 0 || isNaN(p_val))
         {
            return;
         }
         var cosVal:Number = Math.cos(p_val);
         var sinVal:Number = Math.sin(p_val);
         var lumR:* = 0.213;
         var lumG:* = 0.715;
         var lumB:* = 0.072;
         multiplyMatrix([lumR + cosVal * (1 - lumR) + sinVal * -lumR,lumG + cosVal * -lumG + sinVal * -lumG,lumB + cosVal * -lumB + sinVal * (1 - lumB),0,0,lumR + cosVal * -lumR + sinVal * 0.143,lumG + cosVal * (1 - lumG) + sinVal * 0.14,lumB + cosVal * -lumB + sinVal * -0.283,0,0,lumR + cosVal * -lumR + sinVal * -(1 - lumR),lumG + cosVal * -lumG + sinVal * lumG,lumB + cosVal * (1 - lumB) + sinVal * lumB,0,0,0,0,0,1,0,0,0,0,0,1]);
      }
      
      public function concat(p_matrix:Array) : void
      {
         p_matrix = fixMatrix(p_matrix);
         if(p_matrix.length != LENGTH)
         {
            return;
         }
         multiplyMatrix(p_matrix);
      }
      
      public function clone() : ColorMatrix
      {
         return new ColorMatrix(this);
      }
      
      public function toString() : String
      {
         return "ColorMatrix [ " + this.join(" , ") + " ]";
      }
      
      public function toArray() : Array
      {
         return slice(0,20);
      }
      
      protected function copyMatrix(p_matrix:Array) : void
      {
         var i:* = 0;
         var l:Number = LENGTH;
         for(i = uint(0); i < l; )
         {
            this[i] = p_matrix[i];
            i++;
         }
      }
      
      protected function multiplyMatrix(p_matrix:Array) : void
      {
         var i:* = 0;
         var j:* = 0;
         var val:* = NaN;
         var k:* = NaN;
         var col:Array = [];
         for(i = uint(0); i < 5; )
         {
            for(j = uint(0); j < 5; )
            {
               col[j] = this[j + i * 5];
               j++;
            }
            for(j = uint(0); j < 5; )
            {
               val = 0;
               for(k = 0; k < 5; )
               {
                  val = Number(val + p_matrix[j + k * 5] * col[k]);
                  k++;
               }
               this[j + i * 5] = val;
               j++;
            }
            i++;
         }
      }
      
      protected function cleanValue(p_val:Number, p_limit:Number) : Number
      {
         return Math.min(p_limit,Math.max(-p_limit,p_val));
      }
      
      protected function fixMatrix(p_matrix:Array = null) : Array
      {
         if(p_matrix == null)
         {
            return IDENTITY_MATRIX;
         }
         if(p_matrix is ColorMatrix)
         {
            p_matrix = p_matrix.slice(0);
         }
         if(p_matrix.length < LENGTH)
         {
            p_matrix = p_matrix.slice(0,p_matrix.length).concat(IDENTITY_MATRIX.slice(p_matrix.length,LENGTH));
         }
         else if(p_matrix.length > LENGTH)
         {
            p_matrix = p_matrix.slice(0,LENGTH);
         }
         return p_matrix;
      }
   }
}
