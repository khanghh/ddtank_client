package com.greensock.plugins{   import com.greensock.TweenLite;      public class HexColorsPlugin extends TweenPlugin   {            public static const API:Number = 1.0;                   protected var _colors:Array;            public function HexColorsPlugin() { super(); }
            override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean { return false; }
            public function initColor(target:Object, propName:String, start:uint, end:uint) : void { }
            override public function killProps(lookup:Object) : void { }
            override public function set changeFactor(n:Number) : void { }
   }}