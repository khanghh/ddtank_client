package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class BezierThroughPlugin extends BezierPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      public function BezierThroughPlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
   }
}
