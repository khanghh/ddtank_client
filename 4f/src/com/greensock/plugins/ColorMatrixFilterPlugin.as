package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.filters.ColorMatrixFilter;
   
   public class ColorMatrixFilterPlugin extends FilterPlugin
   {
      
      public static const API:Number = 1.0;
      
      private static var _propNames:Array = [];
      
      protected static var _idMatrix:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];
      
      protected static var _lumR:Number = 0.212671;
      
      protected static var _lumG:Number = 0.71516;
      
      protected static var _lumB:Number = 0.072169;
       
      
      protected var _matrix:Array;
      
      protected var _matrixTween:EndArrayPlugin;
      
      public function ColorMatrixFilterPlugin(){super();}
      
      public static function colorize(param1:Array, param2:Number, param3:Number = 1) : Array{return null;}
      
      public static function setThreshold(param1:Array, param2:Number) : Array{return null;}
      
      public static function setHue(param1:Array, param2:Number) : Array{return null;}
      
      public static function setBrightness(param1:Array, param2:Number) : Array{return null;}
      
      public static function setSaturation(param1:Array, param2:Number) : Array{return null;}
      
      public static function setContrast(param1:Array, param2:Number) : Array{return null;}
      
      public static function applyMatrix(param1:Array, param2:Array) : Array{return null;}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
      
      override public function set changeFactor(param1:Number) : void{}
   }
}
