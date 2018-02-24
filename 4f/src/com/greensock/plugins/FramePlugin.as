package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import flash.display.MovieClip;
   
   public class FramePlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      public var frame:int;
      
      protected var _target:MovieClip;
      
      public function FramePlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
      
      override public function set changeFactor(param1:Number) : void{}
   }
}
