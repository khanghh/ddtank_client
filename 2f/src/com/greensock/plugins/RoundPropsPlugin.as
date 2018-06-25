package com.greensock.plugins{   import com.greensock.TweenLite;   import com.greensock.core.PropTween;      public class RoundPropsPlugin extends TweenPlugin   {            public static const API:Number = 1.0;                   protected var _tween:TweenLite;            public function RoundPropsPlugin() { super(); }
            override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean { return false; }
            protected function _initAllProps() : void { }
            protected function _removePropTween(propTween:PropTween) : void { }
            public function add(object:Object, propName:String, start:Number, change:Number) : void { }
   }}