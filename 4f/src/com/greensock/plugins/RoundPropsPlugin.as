package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.core.PropTween;
   
   public class RoundPropsPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      protected var _tween:TweenLite;
      
      public function RoundPropsPlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
      
      protected function _initAllProps() : void{}
      
      protected function _removePropTween(param1:PropTween) : void{}
      
      public function add(param1:Object, param2:String, param3:Number, param4:Number) : void{}
   }
}
