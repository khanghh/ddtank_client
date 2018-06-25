package com.greensock.plugins{   import com.greensock.TweenLite;      public class AutoAlphaPlugin extends TweenPlugin   {            public static const API:Number = 1.0;                   protected var _target:Object;            protected var _ignoreVisible:Boolean;            public function AutoAlphaPlugin() { super(); }
            override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean { return false; }
            override public function killProps(lookup:Object) : void { }
            override public function set changeFactor(n:Number) : void { }
   }}