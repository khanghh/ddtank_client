package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   
   public class FrameLabelPlugin extends FramePlugin
   {
      
      public static const API:Number = 1.0;
       
      
      public function FrameLabelPlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
   }
}
