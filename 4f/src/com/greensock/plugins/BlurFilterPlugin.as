package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.filters.BlurFilter;
   
   public class BlurFilterPlugin extends FilterPlugin
   {
      
      public static const API:Number = 1.0;
      
      private static var _propNames:Array = ["blurX","blurY","quality"];
       
      
      public function BlurFilterPlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
   }
}
