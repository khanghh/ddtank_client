package com.greensock.plugins{   import com.greensock.TweenLite;   import flash.filters.ColorMatrixFilter;      public class ColorMatrixFilterPlugin extends FilterPlugin   {            public static const API:Number = 1.0;            private static var _propNames:Array = [];            protected static var _idMatrix:Array = [1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,1,0];            protected static var _lumR:Number = 0.212671;            protected static var _lumG:Number = 0.71516;            protected static var _lumB:Number = 0.072169;                   protected var _matrix:Array;            protected var _matrixTween:EndArrayPlugin;            public function ColorMatrixFilterPlugin() { super(); }
            public static function colorize(m:Array, color:Number, amount:Number = 1) : Array { return null; }
            public static function setThreshold(m:Array, n:Number) : Array { return null; }
            public static function setHue(m:Array, n:Number) : Array { return null; }
            public static function setBrightness(m:Array, n:Number) : Array { return null; }
            public static function setSaturation(m:Array, n:Number) : Array { return null; }
            public static function setContrast(m:Array, n:Number) : Array { return null; }
            public static function applyMatrix(m:Array, m2:Array) : Array { return null; }
            override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean { return false; }
            override public function set changeFactor(n:Number) : void { }
   }}