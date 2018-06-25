package com.greensock{   import com.greensock.core.SimpleTimeline;   import com.greensock.core.TweenCore;      public class TimelineLite extends SimpleTimeline   {            public static const version:Number = 1.64;            private static var _overwriteMode:int = !!OverwriteManager.enabled?OverwriteManager.mode:int(OverwriteManager.init(2));                   protected var _labels:Object;            protected var _endCaps:Array;            public function TimelineLite(vars:Object = null) { super(null); }
            override public function remove(tween:TweenCore, skipDisable:Boolean = false) : void { }
            override public function insert(tween:TweenCore, timeOrLabel:* = 0) : TweenCore { return null; }
            public function append(tween:TweenCore, offset:Number = 0) : TweenCore { return null; }
            public function prepend(tween:TweenCore, adjustLabels:Boolean = false) : TweenCore { return null; }
            public function insertMultiple(tweens:Array, timeOrLabel:* = 0, align:String = "normal", stagger:Number = 0) : Array { return null; }
            public function appendMultiple(tweens:Array, offset:Number = 0, align:String = "normal", stagger:Number = 0) : Array { return null; }
            public function prependMultiple(tweens:Array, align:String = "normal", stagger:Number = 0, adjustLabels:Boolean = false) : Array { return null; }
            public function addLabel(label:String, time:Number) : void { }
            public function removeLabel(label:String) : Number { return 0; }
            public function getLabelTime(label:String) : Number { return 0; }
            protected function parseTimeOrLabel(timeOrLabel:*) : Number { return 0; }
            public function stop() : void { }
            public function gotoAndPlay(timeOrLabel:*, suppressEvents:Boolean = true) : void { }
            public function gotoAndStop(timeOrLabel:*, suppressEvents:Boolean = true) : void { }
            public function goto_(timeOrLabel:*, suppressEvents:Boolean = true) : void { }
            override public function renderTime(time:Number, suppressEvents:Boolean = false, force:Boolean = false) : void { }
            protected function forceChildrenToBeginning(time:Number, suppressEvents:Boolean = false) : Number { return 0; }
            protected function forceChildrenToEnd(time:Number, suppressEvents:Boolean = false) : Number { return 0; }
            public function hasPausedChild() : Boolean { return false; }
            public function getChildren(nested:Boolean = true, tweens:Boolean = true, timelines:Boolean = true, ignoreBeforeTime:Number = -9.999999999E9) : Array { return null; }
            public function getTweensOf(target:Object, nested:Boolean = true) : Array { return null; }
            public function shiftChildren(amount:Number, adjustLabels:Boolean = false, ignoreBeforeTime:Number = 0) : void { }
            public function killTweensOf(target:Object, nested:Boolean = true, vars:Object = null) : Boolean { return false; }
            override public function invalidate() : void { }
            public function clear(tweens:Array = null) : void { }
            override public function setEnabled(enabled:Boolean, ignoreTimeline:Boolean = false) : Boolean { return false; }
            public function get currentProgress() : Number { return 0; }
            public function set currentProgress(n:Number) : void { }
            override public function get duration() : Number { return 0; }
            override public function set duration(n:Number) : void { }
            override public function get totalDuration() : Number { return 0; }
            override public function set totalDuration(n:Number) : void { }
            public function get timeScale() : Number { return 0; }
            public function set timeScale(n:Number) : void { }
            public function get useFrames() : Boolean { return false; }
            override public function get rawTime() : Number { return 0; }
   }}