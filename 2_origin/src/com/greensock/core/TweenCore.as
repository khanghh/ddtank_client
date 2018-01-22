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
      
      public function TweenCore(param1:Number = 0, param2:Object = null)
      {
         super();
         this.vars = param2 != null?param2:{};
         if(this.vars.isGSVars)
         {
            this.vars = this.vars.vars;
         }
         var _loc4_:* = param1;
         this.cachedTotalDuration = _loc4_;
         this.cachedDuration = _loc4_;
         _delay = !!this.vars.delay?Number(this.vars.delay):0;
         this.cachedTimeScale = !!this.vars.timeScale?Number(this.vars.timeScale):1;
         this.active = Boolean(param1 == 0 && _delay == 0 && this.vars.immediateRender != false);
         _loc4_ = 0;
         this.cachedTime = _loc4_;
         this.cachedTotalTime = _loc4_;
         this.data = this.vars.data;
         if(!_classInitted)
         {
            if(isNaN(TweenLite.rootFrame))
            {
               TweenLite.initClass();
               _classInitted = true;
            }
            else
            {
               return;
            }
         }
         var _loc3_:SimpleTimeline = this.vars.timeline is SimpleTimeline?this.vars.timeline:!!this.vars.useFrames?TweenLite.rootFramesTimeline:TweenLite.rootTimeline;
         _loc3_.insert(this,_loc3_.cachedTotalTime);
         if(this.vars.reversed)
         {
            this.cachedReversed = true;
         }
         if(this.vars.paused)
         {
            this.paused = true;
         }
      }
      
      public function play() : void
      {
         this.reversed = false;
         this.paused = false;
      }
      
      public function pause() : void
      {
         this.paused = true;
      }
      
      public function resume() : void
      {
         this.paused = false;
      }
      
      public function restart(param1:Boolean = false, param2:Boolean = true) : void
      {
         this.reversed = false;
         this.paused = false;
         this.setTotalTime(!!param1?-_delay:0,param2);
      }
      
      public function reverse(param1:Boolean = true) : void
      {
         this.reversed = true;
         if(param1)
         {
            this.paused = false;
         }
         else if(this.gc)
         {
            this.setEnabled(true,false);
         }
      }
      
      public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
      }
      
      public function complete(param1:Boolean = false, param2:Boolean = false) : void
      {
         if(!param1)
         {
            renderTime(this.totalDuration,param2,false);
            return;
         }
         if(this.timeline.autoRemoveChildren)
         {
            this.setEnabled(false,false);
         }
         else
         {
            this.active = false;
         }
         if(!param2)
         {
            if(this.vars.onComplete && this.cachedTotalTime >= this.cachedTotalDuration && !this.cachedReversed)
            {
               this.vars.onComplete.apply(null,this.vars.onCompleteParams);
            }
            else if(this.cachedReversed && this.cachedTotalTime == 0 && this.vars.onReverseComplete)
            {
               this.vars.onReverseComplete.apply(null,this.vars.onReverseCompleteParams);
            }
         }
      }
      
      public function invalidate() : void
      {
      }
      
      public function setEnabled(param1:Boolean, param2:Boolean = false) : Boolean
      {
         this.gc = !param1;
         if(param1)
         {
            this.active = Boolean(!this.cachedPaused && this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
            if(!param2 && this.cachedOrphan)
            {
               this.timeline.insert(this,this.cachedStartTime - _delay);
            }
         }
         else
         {
            this.active = false;
            if(!param2 && !this.cachedOrphan)
            {
               this.timeline.remove(this,true);
            }
         }
         return false;
      }
      
      public function kill() : void
      {
         setEnabled(false,false);
      }
      
      protected function setDirtyCache(param1:Boolean = true) : void
      {
         var _loc2_:TweenCore = !!param1?this:this.timeline;
         while(_loc2_)
         {
            _loc2_.cacheIsDirty = true;
            _loc2_ = _loc2_.timeline;
         }
      }
      
      protected function setTotalTime(param1:Number, param2:Boolean = false) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(this.timeline)
         {
            _loc3_ = !!this.cachedPaused?this.cachedPauseTime:Number(this.timeline.cachedTotalTime);
            if(this.cachedReversed)
            {
               _loc4_ = !!this.cacheIsDirty?this.totalDuration:Number(this.cachedTotalDuration);
               this.cachedStartTime = _loc3_ - (_loc4_ - param1) / this.cachedTimeScale;
            }
            else
            {
               this.cachedStartTime = _loc3_ - param1 / this.cachedTimeScale;
            }
            if(!this.timeline.cacheIsDirty)
            {
               setDirtyCache(false);
            }
            if(this.cachedTotalTime != param1)
            {
               renderTime(param1,param2,false);
            }
         }
      }
      
      public function get delay() : Number
      {
         return _delay;
      }
      
      public function set delay(param1:Number) : void
      {
         this.startTime = this.startTime + (param1 - _delay);
         _delay = param1;
      }
      
      public function get duration() : Number
      {
         return this.cachedDuration;
      }
      
      public function set duration(param1:Number) : void
      {
         var _loc2_:Number = param1 / this.cachedDuration;
         var _loc3_:* = param1;
         this.cachedTotalDuration = _loc3_;
         this.cachedDuration = _loc3_;
         if(this.active && !this.cachedPaused && param1 != 0)
         {
            this.setTotalTime(this.cachedTotalTime * _loc2_,true);
         }
         setDirtyCache(false);
      }
      
      public function get totalDuration() : Number
      {
         return this.cachedTotalDuration;
      }
      
      public function set totalDuration(param1:Number) : void
      {
         this.duration = param1;
      }
      
      public function get currentTime() : Number
      {
         return this.cachedTime;
      }
      
      public function set currentTime(param1:Number) : void
      {
         setTotalTime(param1,false);
      }
      
      public function get totalTime() : Number
      {
         return this.cachedTotalTime;
      }
      
      public function set totalTime(param1:Number) : void
      {
         setTotalTime(param1,false);
      }
      
      public function get startTime() : Number
      {
         return this.cachedStartTime;
      }
      
      public function set startTime(param1:Number) : void
      {
         if(this.timeline != null && (param1 != this.cachedStartTime || this.gc))
         {
            this.timeline.insert(this,param1 - _delay);
         }
         else
         {
            this.cachedStartTime = param1;
         }
      }
      
      public function get reversed() : Boolean
      {
         return this.cachedReversed;
      }
      
      public function set reversed(param1:Boolean) : void
      {
         if(param1 != this.cachedReversed)
         {
            this.cachedReversed = param1;
            setTotalTime(this.cachedTotalTime,true);
         }
      }
      
      public function get paused() : Boolean
      {
         return this.cachedPaused;
      }
      
      public function set paused(param1:Boolean) : void
      {
         if(param1 != this.cachedPaused && this.timeline)
         {
            if(param1)
            {
               this.cachedPauseTime = this.timeline.rawTime;
            }
            else
            {
               this.cachedStartTime = this.cachedStartTime + (this.timeline.rawTime - this.cachedPauseTime);
               this.cachedPauseTime = NaN;
               setDirtyCache(false);
            }
            this.cachedPaused = param1;
            this.active = Boolean(!this.cachedPaused && this.cachedTotalTime > 0 && this.cachedTotalTime < this.cachedTotalDuration);
         }
         if(!param1 && this.gc)
         {
            this.setTotalTime(this.cachedTotalTime,false);
            this.setEnabled(true,false);
         }
      }
   }
}
