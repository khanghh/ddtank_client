package com.greensock.plugins{   import com.greensock.TweenLite;   import com.greensock.core.PropTween;      public class TweenPlugin   {            public static const VERSION:Number = 1.4;            public static const API:Number = 1.0;                   public var propName:String;            public var overwriteProps:Array;            public var round:Boolean;            public var priority:int = 0;            public var activeDisable:Boolean;            public var onInitAllProps:Function;            public var onComplete:Function;            public var onEnable:Function;            public var onDisable:Function;            protected var _tweens:Array;            protected var _changeFactor:Number = 0;            public function TweenPlugin() { super(); }
            private static function onTweenEvent(type:String, tween:TweenLite) : Boolean { return false; }
            public static function activate(plugins:Array) : Boolean { return false; }
            public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean { return false; }
            protected function addTween(object:Object, propName:String, start:Number, end:*, overwriteProp:String = null) : void { }
            protected function updateTweens(changeFactor:Number) : void { }
            public function get changeFactor() : Number { return 0; }
            public function set changeFactor(n:Number) : void { }
            public function killProps(lookup:Object) : void { }
   }}