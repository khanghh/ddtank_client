package com.greensock.plugins
{
   import com.greensock.TweenLite;
   
   public class AutoAlphaPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
       
      
      protected var _target:Object;
      
      protected var _ignoreVisible:Boolean;
      
      public function AutoAlphaPlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
      
      override public function killProps(param1:Object) : void{}
      
      override public function set changeFactor(param1:Number) : void{}
   }
}
