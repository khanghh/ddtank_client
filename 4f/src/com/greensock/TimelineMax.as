package com.greensock
{
   import com.greensock.core.TweenCore;
   import com.greensock.events.TweenEvent;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   
   public class TimelineMax extends TimelineLite implements IEventDispatcher
   {
      
      public static const version:Number = 1.64;
       
      
      protected var _repeat:int;
      
      protected var _repeatDelay:Number;
      
      protected var _cyclesComplete:int;
      
      protected var _dispatcher:EventDispatcher;
      
      protected var _hasUpdateListener:Boolean;
      
      public var yoyo:Boolean;
      
      public function TimelineMax(param1:Object = null){super(null);}
      
      private static function onInitTweenTo(param1:TweenLite, param2:TimelineMax, param3:Number) : void{}
      
      private static function easeNone(param1:Number, param2:Number, param3:Number, param4:Number) : Number{return 0;}
      
      public function addCallback(param1:Function, param2:*, param3:Array = null) : TweenLite{return null;}
      
      public function removeCallback(param1:Function, param2:* = null) : Boolean{return false;}
      
      public function tweenTo(param1:*, param2:Object = null) : TweenLite{return null;}
      
      public function tweenFromTo(param1:*, param2:*, param3:Object = null) : TweenLite{return null;}
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void{}
      
      override public function complete(param1:Boolean = false, param2:Boolean = false) : void{}
      
      public function getActive(param1:Boolean = true, param2:Boolean = true, param3:Boolean = false) : Array{return null;}
      
      override public function invalidate() : void{}
      
      public function getLabelAfter(param1:Number = NaN) : String{return null;}
      
      public function getLabelBefore(param1:Number = NaN) : String{return null;}
      
      protected function getLabelsArray() : Array{return null;}
      
      protected function initDispatcher() : void{}
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void{}
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void{}
      
      public function hasEventListener(param1:String) : Boolean{return false;}
      
      public function willTrigger(param1:String) : Boolean{return false;}
      
      public function dispatchEvent(param1:Event) : Boolean{return false;}
      
      public function get totalProgress() : Number{return 0;}
      
      public function set totalProgress(param1:Number) : void{}
      
      override public function get totalDuration() : Number{return 0;}
      
      override public function set currentTime(param1:Number) : void{}
      
      public function get repeat() : int{return 0;}
      
      public function set repeat(param1:int) : void{}
      
      public function get repeatDelay() : Number{return 0;}
      
      public function set repeatDelay(param1:Number) : void{}
      
      public function get currentLabel() : String{return null;}
   }
}
