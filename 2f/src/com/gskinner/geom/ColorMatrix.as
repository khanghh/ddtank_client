package com.gskinner.geom
{
   public dynamic class ColorMatrix extends Array
   {
      
      private static const DELTA_INDEX:Array = [0,0.01,0.02,0.04,0.05,0.06,0.07,0.08,0.1,0.11,0.12,0.14,0.15,0.16,0.17,0.18,0.2,0.21,0.22,0.24,0.25,0.27,0.28,0.3,0.32,0.34,0.36,0.38,0.4,0.42,0.44,0.46,0.48,0.5,0.53,0.56,0.59,0.62,0.65,0.68,0.71,0.74,0.77,0.8,0.83,0.86,0.89,0.92,0.95,0.98,1,1.06,1.12,1.18,1.24,1.3,1.36,1.42,1.48,1.54,1.6,1.66,1.72,1.78,1.84,1.9,1.96,2,2.12,2.25,2.37,2.5,2.62,2.75,2.87,3,3.2,3.4,3.6,3.8,4,4.3,4.7,4.9,5,5.5,6,6.5,6.8,7,7.3,7.5,7.8,8,8.4,8.7,9,9.4,9.6,9.8,10];
      
      private static const IDENTITY_MATRIX:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1];
      
      private static const LENGTH:Number = IDENTITY_MATRIX.length;
       
      
      public function ColorMatrix(param1:Array = null){super();}
      
      public function reset() : void{}
      
      public function adjustColor(param1:Number, param2:Number, param3:Number, param4:Number) : void{}
      
      public function adjustBrightness(param1:Number) : void{}
      
      public function adjustContrast(param1:Number) : void{}
      
      public function adjustSaturation(param1:Number) : void{}
      
      public function adjustHue(param1:Number) : void{}
      
      public function concat(param1:Array) : void{}
      
      public function clone() : ColorMatrix{return null;}
      
      public function toString() : String{return null;}
      
      public function toArray() : Array{return null;}
      
      protected function copyMatrix(param1:Array) : void{}
      
      protected function multiplyMatrix(param1:Array) : void{}
      
      protected function cleanValue(param1:Number, param2:Number) : Number{return 0;}
      
      protected function fixMatrix(param1:Array = null) : Array{return null;}
   }
}
