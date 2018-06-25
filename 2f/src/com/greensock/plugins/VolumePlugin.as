package com.greensock.plugins{   import com.greensock.TweenLite;   import flash.media.SoundTransform;      public class VolumePlugin extends TweenPlugin   {            public static const API:Number = 1.0;                   protected var _target:Object;            protected var _st:SoundTransform;            public function VolumePlugin() { super(); }
            override public function onInitTween(target:Object, value:*, tween:TweenLite) : Boolean { return false; }
            override public function set changeFactor(n:Number) : void { }
   }}