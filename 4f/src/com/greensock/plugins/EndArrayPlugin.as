package com.greensock.plugins{   import com.greensock.TweenLite;      public class EndArrayPlugin extends TweenPlugin   {            public static const API:Number = 1.0;                   protected var _a:Array;            protected var _info:Array;            public function EndArrayPlugin() { super(); }
            override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean { return false; }
            public function init(start:Array, end:Array) : void { }
            override public function set changeFactor(n:Number) : void { }
   }}class ArrayTweenInfo{          public var index:uint;      public var start:Number;      public var change:Number;      function ArrayTweenInfo(index:uint, start:Number, change:Number) { super(); }
}