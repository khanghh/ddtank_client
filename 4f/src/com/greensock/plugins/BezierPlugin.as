package com.greensock.plugins{   import com.greensock.TweenLite;      public class BezierPlugin extends TweenPlugin   {            public static const API:Number = 1.0;            protected static const _RAD2DEG:Number = 57.29577951308232;                   protected var _target:Object;            protected var _orientData:Array;            protected var _orient:Boolean;            protected var _future:Object;            protected var _beziers:Object;            public function BezierPlugin() { super(); }
            public static function parseBeziers(props:Object, through:Boolean = false) : Object { return null; }
            override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean { return false; }
            protected function init(tween:TweenLite, beziers:Array, through:Boolean) : void { }
            override public function killProps(lookup:Object) : void { }
            override public function set changeFactor(n:Number) : void { }
   }}