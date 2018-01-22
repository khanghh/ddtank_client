package com.greensock
{
   import com.greensock.core.PropTween;
   import com.greensock.core.SimpleTimeline;
   import com.greensock.core.TweenCore;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class TweenLite extends TweenCore
   {
      
      public static const version:Number = 11.62;
      
      public static var plugins:Object = {};
      
      public static var fastEaseLookup:Dictionary = new Dictionary(false);
      
      public static var onPluginEvent:Function;
      
      public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
      
      public static var defaultEase:Function = TweenLite.easeOut;
      
      public static var overwriteManager:Object;
      
      public static var rootFrame:Number;
      
      public static var rootTimeline:SimpleTimeline;
      
      public static var rootFramesTimeline:SimpleTimeline;
      
      public static var masterList:Dictionary = new Dictionary(false);
      
      private static var _shape:Shape = new Shape();
      
      protected static var _reservedProps:Object = {
         "ease":1,
         "delay":1,
         "overwrite":1,
         "onComplete":1,
         "onCompleteParams":1,
         "useFrames":1,
         "runBackwards":1,
         "startAt":1,
         "onUpdate":1,
         "onUpdateParams":1,
         "onStart":1,
         "onStartParams":1,
         "onInit":1,
         "onInitParams":1,
         "onReverseComplete":1,
         "onReverseCompleteParams":1,
         "onRepeat":1,
         "onRepeatParams":1,
         "proxiedEase":1,
         "easeParams":1,
         "yoyo":1,
         "onCompleteListener":1,
         "onUpdateListener":1,
         "onStartListener":1,
         "onReverseCompleteListener":1,
         "onRepeatListener":1,
         "orientToBezier":1,
         "timeScale":1,
         "immediateRender":1,
         "repeat":1,
         "repeatDelay":1,
         "timeline":1,
         "data":1,
         "paused":1
      };
       
      
      public var target:Object;
      
      public var propTweenLookup:Object;
      
      public var ratio:Number = 0;
      
      public var cachedPT1:PropTween;
      
      protected var _ease:Function;
      
      protected var _overwrite:int;
      
      protected var _overwrittenProps:Object;
      
      protected var _hasPlugins:Boolean;
      
      protected var _notifyPluginsOfEnabled:Boolean;
      
      public function TweenLite(param1:Object, param2:Number, param3:Object){super(null,null);}
      
      public static function initClass() : void{}
      
      public static function to(param1:Object, param2:Number, param3:Object) : TweenLite{return null;}
      
      public static function from(param1:Object, param2:Number, param3:Object) : TweenLite{return null;}
      
      public static function delayedCall(param1:Number, param2:Function, param3:Array = null, param4:Boolean = false) : TweenLite{return null;}
      
      protected static function updateAll(param1:Event = null) : void{}
      
      public static function killTweensOf(param1:Object, param2:Boolean = false, param3:Object = null) : void{}
      
      protected static function easeOut(param1:Number, param2:Number, param3:Number, param4:Number) : Number{return 0;}
      
      protected function init() : void{}
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void{}
      
      public function killVars(param1:Object, param2:Boolean = true) : Boolean{return false;}
      
      override public function invalidate() : void{}
      
      override public function setEnabled(param1:Boolean, param2:Boolean = false) : Boolean{return false;}
      
      protected function easeProxy(param1:Number, param2:Number, param3:Number, param4:Number) : Number{return 0;}
   }
}
