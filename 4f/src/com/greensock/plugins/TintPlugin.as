package com.greensock.plugins
{
   import com.greensock.TweenLite;
   import com.greensock.core.PropTween;
   import flash.display.DisplayObject;
   import flash.geom.ColorTransform;
   import flash.geom.Transform;
   
   public class TintPlugin extends TweenPlugin
   {
      
      public static const API:Number = 1.0;
      
      protected static var _props:Array = ["redMultiplier","greenMultiplier","blueMultiplier","alphaMultiplier","redOffset","greenOffset","blueOffset","alphaOffset"];
       
      
      protected var _transform:Transform;
      
      protected var _ct:ColorTransform;
      
      protected var _ignoreAlpha:Boolean;
      
      public function TintPlugin(){super();}
      
      override public function onInitTween(param1:Object, param2:*, param3:TweenLite) : Boolean{return false;}
      
      public function init(param1:DisplayObject, param2:ColorTransform) : void{}
      
      override public function set changeFactor(param1:Number) : void{}
   }
}
