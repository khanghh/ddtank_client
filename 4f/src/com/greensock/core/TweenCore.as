package com.greensock.core
{
   import com.greensock.TweenLite;
   
   public class TweenCore
   {
      
      public static const version:Number = 1.64;
      
      protected static var _classInitted:Boolean;
       
      
      protected var _delay:Number;
      
      protected var _hasUpdate:Boolean;
      
      protected var _rawPrevTime:Number = -1;
      
      public var vars:Object;
      
      public var active:Boolean;
      
      public var gc:Boolean;
      
      public var initted:Boolean;
      
      public var timeline:SimpleTimeline;
      
      public var cachedStartTime:Number;
      
      public var cachedTime:Number;
      
      public var cachedTotalTime:Number;
      
      public var cachedDuration:Number;
      
      public var cachedTotalDuration:Number;
      
      public var cachedTimeScale:Number;
      
      public var cachedPauseTime:Number;
      
      public var cachedReversed:Boolean;
      
      public var nextNode:TweenCore;
      
      public var prevNode:TweenCore;
      
      public var cachedOrphan:Boolean;
      
      public var cacheIsDirty:Boolean;
      
      public var cachedPaused:Boolean;
      
      public var data;
      
      public function TweenCore(param1:Number = 0, param2:Object = null){super();}
      
      public function play() : void{}
      
      public function pause() : void{}
      
      public function resume() : void{}
      
      public function restart(param1:Boolean = false, param2:Boolean = true) : void{}
      
      public function reverse(param1:Boolean = true) : void{}
      
      public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void{}
      
      public function complete(param1:Boolean = false, param2:Boolean = false) : void{}
      
      public function invalidate() : void{}
      
      public function setEnabled(param1:Boolean, param2:Boolean = false) : Boolean{return false;}
      
      public function kill() : void{}
      
      protected function setDirtyCache(param1:Boolean = true) : void{}
      
      protected function setTotalTime(param1:Number, param2:Boolean = false) : void{}
      
      public function get delay() : Number{return 0;}
      
      public function set delay(param1:Number) : void{}
      
      public function get duration() : Number{return 0;}
      
      public function set duration(param1:Number) : void{}
      
      public function get totalDuration() : Number{return 0;}
      
      public function set totalDuration(param1:Number) : void{}
      
      public function get currentTime() : Number{return 0;}
      
      public function set currentTime(param1:Number) : void{}
      
      public function get totalTime() : Number{return 0;}
      
      public function set totalTime(param1:Number) : void{}
      
      public function get startTime() : Number{return 0;}
      
      public function set startTime(param1:Number) : void{}
      
      public function get reversed() : Boolean{return false;}
      
      public function set reversed(param1:Boolean) : void{}
      
      public function get paused() : Boolean{return false;}
      
      public function set paused(param1:Boolean) : void{}
   }
}
