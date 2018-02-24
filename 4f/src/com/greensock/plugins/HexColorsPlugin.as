package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class HexColorsPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      protected var _colors:Array;
      
      public function HexColorsPlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
      
      public function initColor(param1:Object, param2:String, param3:uint, param4:uint) : void{}
      
      override public function killProps(param1:Object) : void{}
      
      override public function set changeFactor(param1:Number) : void{}
   }
}
