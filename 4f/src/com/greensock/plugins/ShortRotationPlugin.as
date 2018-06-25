package com.greensock.plugins{   import com.greensock.TweenLite;      public class ShortRotationPlugin extends TweenPlugin   {            public static const API:Number = 1.0;                   public function ShortRotationPlugin() { super(); }
            override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean { return false; }
            public function initRotation(target:Object, propName:String, start:Number, end:Number) : void { }
   }}