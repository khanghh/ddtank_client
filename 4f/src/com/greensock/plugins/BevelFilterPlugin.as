package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.filters.BevelFilter;
   
   public class BevelFilterPlugin extends FilterPlugin
   {
      
      public static const API:Number = 1.0;
      
      private static var _propNames:Array = ["distance","angle","highlightColor","highlightAlpha","shadowColor","shadowAlpha","blurX","blurY","strength","quality"];
       
      
      public function BevelFilterPlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
   }
}
