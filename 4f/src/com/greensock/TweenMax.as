package com.greensock{   import com.greensock.core.PropTween;   import com.greensock.core.SimpleTimeline;   import com.greensock.core.TweenCore;   import com.greensock.events.TweenEvent;   import com.greensock.plugins.AutoAlphaPlugin;   import com.greensock.plugins.BevelFilterPlugin;   import com.greensock.plugins.BezierPlugin;   import com.greensock.plugins.BezierThroughPlugin;   import com.greensock.plugins.BlurFilterPlugin;   import com.greensock.plugins.ColorMatrixFilterPlugin;   import com.greensock.plugins.ColorTransformPlugin;   import com.greensock.plugins.DropShadowFilterPlugin;   import com.greensock.plugins.EndArrayPlugin;   import com.greensock.plugins.FrameLabelPlugin;   import com.greensock.plugins.FramePlugin;   import com.greensock.plugins.GlowFilterPlugin;   import com.greensock.plugins.HexColorsPlugin;   import com.greensock.plugins.RemoveTintPlugin;   import com.greensock.plugins.RoundPropsPlugin;   import com.greensock.plugins.ShortRotationPlugin;   import com.greensock.plugins.TintPlugin;   import com.greensock.plugins.TweenPlugin;   import com.greensock.plugins.VisiblePlugin;   import com.greensock.plugins.VolumePlugin;   import flash.display.DisplayObject;   import flash.display.DisplayObjectContainer;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.utils.Dictionary;   import flash.utils.getTimer;      public class TweenMax extends TweenLite implements IEventDispatcher   {            public static const version:Number = 11.64;            private static var _overwriteMode:int = !!OverwriteManager.enabled?OverwriteManager.mode:int(OverwriteManager.init(2));            public static var killTweensOf:Function = TweenLite.killTweensOf;            public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;            {         TweenPlugin.activate([AutoAlphaPlugin,EndArrayPlugin,FramePlugin,RemoveTintPlugin,TintPlugin,VisiblePlugin,VolumePlugin,BevelFilterPlugin,BezierPlugin,BezierThroughPlugin,BlurFilterPlugin,ColorMatrixFilterPlugin,ColorTransformPlugin,DropShadowFilterPlugin,FrameLabelPlugin,GlowFilterPlugin,HexColorsPlugin,RoundPropsPlugin,ShortRotationPlugin,{}]);      }            protected var _dispatcher:EventDispatcher;            protected var _hasUpdateListener:Boolean;            protected var _repeat:int = 0;            protected var _repeatDelay:Number = 0;            protected var _cyclesComplete:int = 0;            protected var _easePower:int;            protected var _easeType:int;            public var yoyo:Boolean;            public function TweenMax(target:Object, duration:Number, vars:Object) { super(null,null,null); }
            public static function to(target:Object, duration:Number, vars:Object) : TweenMax { return null; }
            public static function from(target:Object, duration:Number, vars:Object) : TweenMax { return null; }
            public static function fromTo(target:Object, duration:Number, fromVars:Object, toVars:Object) : TweenMax { return null; }
            public static function allTo(targets:Array, duration:Number, vars:Object, stagger:Number = 0, onCompleteAll:Function = null, onCompleteAllParams:Array = null) : Array { return null; }
            public static function allFrom(targets:Array, duration:Number, vars:Object, stagger:Number = 0, onCompleteAll:Function = null, onCompleteAllParams:Array = null) : Array { return null; }
            public static function allFromTo(targets:Array, duration:Number, fromVars:Object, toVars:Object, stagger:Number = 0, onCompleteAll:Function = null, onCompleteAllParams:Array = null) : Array { return null; }
            public static function delayedCall(delay:Number, onComplete:Function, onCompleteParams:Array = null, useFrames:Boolean = false) : TweenMax { return null; }
            public static function getTweensOf(target:Object) : Array { return null; }
            public static function isTweening(target:Object) : Boolean { return false; }
            public static function getAllTweens() : Array { return null; }
            public static function killAll(complete:Boolean = false, tweens:Boolean = true, delayedCalls:Boolean = true) : void { }
            public static function killChildTweensOf(parent:DisplayObjectContainer, complete:Boolean = false) : void { }
            public static function pauseAll(tweens:Boolean = true, delayedCalls:Boolean = true) : void { }
            public static function resumeAll(tweens:Boolean = true, delayedCalls:Boolean = true) : void { }
            private static function changePause(pause:Boolean, tweens:Boolean = true, delayedCalls:Boolean = false) : void { }
            public static function get globalTimeScale() : Number { return 0; }
            public static function set globalTimeScale(n:Number) : void { }
            override protected function init() : void { }
            override public function invalidate() : void { }
            public function updateTo(vars:Object, resetDuration:Boolean = false) : void { }
            public function setDestination(property:String, value:*, adjustStartValues:Boolean = true) : void { }
            public function killProperties(names:Array) : void { }
            override public function renderTime(time:Number, suppressEvents:Boolean = false, force:Boolean = false) : void { }
            override public function complete(skipRender:Boolean = false, suppressEvents:Boolean = false) : void { }
            protected function initDispatcher() : void { }
            public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void { }
            public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void { }
            public function hasEventListener(type:String) : Boolean { return false; }
            public function willTrigger(type:String) : Boolean { return false; }
            public function dispatchEvent(e:Event) : Boolean { return false; }
            public function get currentProgress() : Number { return 0; }
            public function set currentProgress(n:Number) : void { }
            public function get totalProgress() : Number { return 0; }
            public function set totalProgress(n:Number) : void { }
            override public function set currentTime(n:Number) : void { }
            override public function get totalDuration() : Number { return 0; }
            override public function set totalDuration(n:Number) : void { }
            public function get timeScale() : Number { return 0; }
            public function set timeScale(n:Number) : void { }
            public function get repeat() : int { return 0; }
            public function set repeat(n:int) : void { }
            public function get repeatDelay() : Number { return 0; }
            public function set repeatDelay(n:Number) : void { }
   }}