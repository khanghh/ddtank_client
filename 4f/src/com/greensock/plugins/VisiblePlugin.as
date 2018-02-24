package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class VisiblePlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      protected var _target:Object;
      
      protected var _tween:TweenLite;
      
      protected var _visible:Boolean;
      
      protected var _initVal:Boolean;
      
      public function VisiblePlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
      
      override public function set changeFactor(param1:Number) : void{}
   }
}
