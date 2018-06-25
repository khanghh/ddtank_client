package com.greensock{   import com.greensock.core.TweenCore;   import com.greensock.events.TweenEvent;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;      public class TimelineMax extends TimelineLite implements IEventDispatcher   {            public static const version:Number = 1.64;                   protected var _repeat:int;            protected var _repeatDelay:Number;            protected var _cyclesComplete:int;            protected var _dispatcher:EventDispatcher;            protected var _hasUpdateListener:Boolean;            public var yoyo:Boolean;            public function TimelineMax(vars:Object = null) { super(null); }
            private static function onInitTweenTo(tween:TweenLite, timeline:TimelineMax, fromTime:Number) : void { }
            private static function easeNone(t:Number, b:Number, c:Number, d:Number) : Number { return 0; }
            public function addCallback(callback:Function, timeOrLabel:*, params:Array = null) : TweenLite { return null; }
            public function removeCallback(callback:Function, timeOrLabel:* = null) : Boolean { return false; }
            public function tweenTo(timeOrLabel:*, vars:Object = null) : TweenLite { return null; }
            public function tweenFromTo(fromTimeOrLabel:*, toTimeOrLabel:*, vars:Object = null) : TweenLite { return null; }
            override public function renderTime(time:Number, suppressEvents:Boolean = false, force:Boolean = false) : void { }
            override public function complete(skipRender:Boolean = false, suppressEvents:Boolean = false) : void { }
            public function getActive(nested:Boolean = true, tweens:Boolean = true, timelines:Boolean = false) : Array { return null; }
            override public function invalidate() : void { }
            public function getLabelAfter(time:Number = NaN) : String { return null; }
            public function getLabelBefore(time:Number = NaN) : String { return null; }
            protected function getLabelsArray() : Array { return null; }
            protected function initDispatcher() : void { }
            public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void { }
            public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void { }
            public function hasEventListener(type:String) : Boolean { return false; }
            public function willTrigger(type:String) : Boolean { return false; }
            public function dispatchEvent(e:Event) : Boolean { return false; }
            public function get totalProgress() : Number { return 0; }
            public function set totalProgress(n:Number) : void { }
            override public function get totalDuration() : Number { return 0; }
            override public function set currentTime(n:Number) : void { }
            public function get repeat() : int { return 0; }
            public function set repeat(n:int) : void { }
            public function get repeatDelay() : Number { return 0; }
            public function set repeatDelay(n:Number) : void { }
            public function get currentLabel() : String { return null; }
   }}