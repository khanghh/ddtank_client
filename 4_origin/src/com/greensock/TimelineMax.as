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
      
      public function TimelineMax(vars:Object = null)
      {
         super(vars);
         _repeat = !!this.vars.repeat?Number(this.vars.repeat):0;
         _repeatDelay = !!this.vars.repeatDelay?Number(this.vars.repeatDelay):0;
         _cyclesComplete = 0;
         this.yoyo = this.vars.yoyo == true;
         this.cacheIsDirty = true;
         if(this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null || this.vars.onRepeatListener != null || this.vars.onReverseCompleteListener != null)
         {
            initDispatcher();
         }
      }
      
      private static function onInitTweenTo(tween:TweenLite, timeline:TimelineMax, fromTime:Number) : void
      {
         timeline.paused = true;
         if(!isNaN(fromTime))
         {
            timeline.currentTime = fromTime;
         }
         if(tween.vars.currentTime != timeline.currentTime)
         {
            tween.duration = Math.abs(tween.vars.currentTime - timeline.currentTime) / timeline.cachedTimeScale;
         }
      }
      
      private static function easeNone(t:Number, b:Number, c:Number, d:Number) : Number
      {
         return t / d;
      }
      
      public function addCallback(callback:Function, timeOrLabel:*, params:Array = null) : TweenLite
      {
         var cb:TweenLite = new TweenLite(callback,0,{
            "onComplete":callback,
            "onCompleteParams":params,
            "overwrite":0,
            "immediateRender":false
         });
         insert(cb,timeOrLabel);
         return cb;
      }
      
      public function removeCallback(callback:Function, timeOrLabel:* = null) : Boolean
      {
         var success:Boolean = false;
         var a:* = null;
         var i:int = 0;
         if(timeOrLabel == null)
         {
            return killTweensOf(callback,false);
         }
         if(typeof timeOrLabel == "string")
         {
            if(!(timeOrLabel in _labels))
            {
               return false;
            }
            timeOrLabel = _labels[timeOrLabel];
         }
         a = getTweensOf(callback,false);
         i = a.length;
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            if(a[i].cachedStartTime == timeOrLabel)
            {
               remove(a[i] as TweenCore);
               success = true;
            }
         }
         return success;
      }
      
      public function tweenTo(timeOrLabel:*, vars:Object = null) : TweenLite
      {
         var varsCopy:Object = {
            "ease":easeNone,
            "overwrite":2,
            "useFrames":this.useFrames,
            "immediateRender":false
         };
         var _loc7_:int = 0;
         var _loc6_:* = vars;
         for(var p in vars)
         {
            varsCopy[p] = vars[p];
         }
         varsCopy.onInit = onInitTweenTo;
         varsCopy.onInitParams = [null,this,NaN];
         varsCopy.currentTime = parseTimeOrLabel(timeOrLabel);
         var tl:TweenLite = new TweenLite(this,Math.abs(varsCopy.currentTime - this.cachedTime) / this.cachedTimeScale || 0.001,varsCopy);
         tl.vars.onInitParams[0] = tl;
         return tl;
      }
      
      public function tweenFromTo(fromTimeOrLabel:*, toTimeOrLabel:*, vars:Object = null) : TweenLite
      {
         var tl:TweenLite = tweenTo(toTimeOrLabel,vars);
         tl.vars.onInitParams[2] = parseTimeOrLabel(fromTimeOrLabel);
         tl.duration = Math.abs(tl.vars.currentTime - tl.vars.onInitParams[2]) / this.cachedTimeScale;
         return tl;
      }
      
      override public function renderTime(time:Number, suppressEvents:Boolean = false, force:Boolean = false) : void
      {
         var tween:* = null;
         var isComplete:* = false;
         var rendered:Boolean = false;
         var repeated:Boolean = false;
         var next:* = null;
         var dur:Number = NaN;
         var cycleDuration:Number = NaN;
         var prevCycles:int = 0;
         var forward:Boolean = false;
         var prevForward:* = false;
         var wrap:* = false;
         if(this.gc)
         {
            this.setEnabled(true,false);
         }
         else if(!this.active && !this.cachedPaused)
         {
            this.active = true;
         }
         var totalDur:Number = !!this.cacheIsDirty?this.totalDuration:Number(this.cachedTotalDuration);
         var prevTime:Number = this.cachedTime;
         var prevStart:Number = this.cachedStartTime;
         var prevTimeScale:Number = this.cachedTimeScale;
         var prevPaused:Boolean = this.cachedPaused;
         if(time >= totalDur)
         {
            if(_rawPrevTime <= totalDur && _rawPrevTime != time)
            {
               if(!this.cachedReversed && this.yoyo && _repeat % 2 != 0)
               {
                  forceChildrenToBeginning(0,suppressEvents);
                  this.cachedTime = 0;
               }
               else
               {
                  forceChildrenToEnd(this.cachedDuration,suppressEvents);
                  this.cachedTime = this.cachedDuration;
               }
               this.cachedTotalTime = totalDur;
               isComplete = !this.hasPausedChild();
               rendered = true;
               if(this.cachedDuration == 0 && isComplete && (time == 0 || _rawPrevTime < 0))
               {
                  force = true;
               }
            }
         }
         else if(time <= 0)
         {
            if(time < 0)
            {
               this.active = false;
               if(this.cachedDuration == 0 && _rawPrevTime >= 0)
               {
                  force = true;
                  isComplete = true;
               }
            }
            else if(time == 0 && !this.initted)
            {
               force = true;
            }
            if(_rawPrevTime >= 0 && _rawPrevTime != time)
            {
               this.cachedTotalTime = 0;
               forceChildrenToBeginning(0,suppressEvents);
               this.cachedTime = 0;
               rendered = true;
               if(this.cachedReversed)
               {
                  isComplete = true;
               }
            }
         }
         else
         {
            var _loc20_:* = time;
            this.cachedTime = _loc20_;
            this.cachedTotalTime = _loc20_;
         }
         _rawPrevTime = time;
         if(_repeat != 0)
         {
            cycleDuration = this.cachedDuration + _repeatDelay;
            prevCycles = _cyclesComplete;
            if(isComplete)
            {
               if(this.yoyo && _repeat % 2)
               {
                  this.cachedTime = 0;
               }
            }
            else if(time > 0)
            {
               _cyclesComplete = this.cachedTotalTime / cycleDuration >> 0;
               if(_cyclesComplete == this.cachedTotalTime / cycleDuration)
               {
                  _cyclesComplete = Number(_cyclesComplete) - 1;
               }
               if(prevCycles != _cyclesComplete)
               {
                  repeated = true;
               }
               this.cachedTime = (this.cachedTotalTime / cycleDuration - _cyclesComplete) * cycleDuration;
               if(this.yoyo && _cyclesComplete % 2)
               {
                  this.cachedTime = this.cachedDuration - this.cachedTime;
               }
               else if(this.cachedTime >= this.cachedDuration)
               {
                  this.cachedTime = this.cachedDuration;
               }
               if(this.cachedTime < 0)
               {
                  this.cachedTime = 0;
               }
            }
            else
            {
               _cyclesComplete = 0;
            }
            if(repeated && !isComplete && (this.cachedTime != prevTime || force))
            {
               forward = !this.yoyo || _cyclesComplete % 2 == 0;
               prevForward = Boolean(!this.yoyo || prevCycles % 2 == 0);
               wrap = forward == prevForward;
               if(prevCycles > _cyclesComplete)
               {
                  prevForward = !prevForward;
               }
               if(prevForward)
               {
                  prevTime = forceChildrenToEnd(this.cachedDuration,suppressEvents);
                  if(wrap)
                  {
                     prevTime = forceChildrenToBeginning(0,true);
                  }
               }
               else
               {
                  prevTime = forceChildrenToBeginning(0,suppressEvents);
                  if(wrap)
                  {
                     prevTime = forceChildrenToEnd(this.cachedDuration,true);
                  }
               }
               rendered = false;
            }
         }
         if(this.cachedTime == prevTime && !force)
         {
            return;
         }
         if(!this.initted)
         {
            this.initted = true;
         }
         if(prevTime == 0 && this.cachedTotalTime != 0 && !suppressEvents)
         {
            if(this.vars.onStart)
            {
               this.vars.onStart.apply(null,this.vars.onStartParams);
            }
            if(_dispatcher)
            {
               _dispatcher.dispatchEvent(new TweenEvent("start"));
            }
         }
         if(!rendered)
         {
            if(this.cachedTime - prevTime > 0)
            {
               tween = _firstChild;
               while(tween)
               {
                  next = tween.nextNode;
                  if(!(this.cachedPaused && !prevPaused))
                  {
                     if(tween.active || !tween.cachedPaused && tween.cachedStartTime <= this.cachedTime && !tween.gc)
                     {
                        if(!tween.cachedReversed)
                        {
                           tween.renderTime((this.cachedTime - tween.cachedStartTime) * tween.cachedTimeScale,suppressEvents,false);
                        }
                        else
                        {
                           dur = !!tween.cacheIsDirty?tween.totalDuration:Number(tween.cachedTotalDuration);
                           tween.renderTime(dur - (this.cachedTime - tween.cachedStartTime) * tween.cachedTimeScale,suppressEvents,false);
                        }
                     }
                     tween = next;
                     continue;
                  }
                  break;
               }
            }
            else
            {
               tween = _lastChild;
               while(tween)
               {
                  next = tween.prevNode;
                  if(!(this.cachedPaused && !prevPaused))
                  {
                     if(tween.active || !tween.cachedPaused && tween.cachedStartTime <= prevTime && !tween.gc)
                     {
                        if(!tween.cachedReversed)
                        {
                           tween.renderTime((this.cachedTime - tween.cachedStartTime) * tween.cachedTimeScale,suppressEvents,false);
                        }
                        else
                        {
                           dur = !!tween.cacheIsDirty?tween.totalDuration:Number(tween.cachedTotalDuration);
                           tween.renderTime(dur - (this.cachedTime - tween.cachedStartTime) * tween.cachedTimeScale,suppressEvents,false);
                        }
                     }
                     tween = next;
                     continue;
                  }
                  break;
               }
            }
         }
         if(_hasUpdate && !suppressEvents)
         {
            this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         if(_hasUpdateListener && !suppressEvents)
         {
            _dispatcher.dispatchEvent(new TweenEvent("change"));
         }
         if(isComplete && (prevStart == this.cachedStartTime || prevTimeScale != this.cachedTimeScale) && (totalDur >= this.totalDuration || this.cachedTime == 0))
         {
            complete(true,suppressEvents);
         }
         else if(repeated && !suppressEvents)
         {
            if(this.vars.onRepeat)
            {
               this.vars.onRepeat.apply(null,this.vars.onRepeatParams);
            }
            if(_dispatcher)
            {
               _dispatcher.dispatchEvent(new TweenEvent("repeat"));
            }
         }
      }
      
      override public function complete(skipRender:Boolean = false, suppressEvents:Boolean = false) : void
      {
         super.complete(skipRender,suppressEvents);
         if(_dispatcher && !suppressEvents)
         {
            if(this.cachedReversed && this.cachedTotalTime == 0 && this.cachedDuration != 0)
            {
               _dispatcher.dispatchEvent(new TweenEvent("reverseComplete"));
            }
            else
            {
               _dispatcher.dispatchEvent(new TweenEvent("complete"));
            }
         }
      }
      
      public function getActive(nested:Boolean = true, tweens:Boolean = true, timelines:Boolean = false) : Array
      {
         var i:int = 0;
         var a:Array = [];
         var all:Array = getChildren(nested,tweens,timelines);
         var l:int = all.length;
         var cnt:int = 0;
         for(i = 0; i < l; )
         {
            if(TweenCore(all[i]).active)
            {
               cnt++;
               a[cnt] = all[i];
            }
            i = i + 1;
         }
         return a;
      }
      
      override public function invalidate() : void
      {
         _repeat = !!this.vars.repeat?Number(this.vars.repeat):0;
         _repeatDelay = !!this.vars.repeatDelay?Number(this.vars.repeatDelay):0;
         this.yoyo = this.vars.yoyo == true;
         if(this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null || this.vars.onRepeatListener != null || this.vars.onReverseCompleteListener != null)
         {
            initDispatcher();
         }
         setDirtyCache(true);
         super.invalidate();
      }
      
      public function getLabelAfter(time:Number = NaN) : String
      {
         var i:int = 0;
         if(!time && time != 0)
         {
            time = this.cachedTime;
         }
         var labels:Array = getLabelsArray();
         var l:int = labels.length;
         for(i = 0; i < l; )
         {
            if(labels[i].time > time)
            {
               return labels[i].name;
            }
            i = i + 1;
         }
         return null;
      }
      
      public function getLabelBefore(time:Number = NaN) : String
      {
         if(!time && time != 0)
         {
            time = this.cachedTime;
         }
         var labels:Array = getLabelsArray();
         var i:int = labels.length;
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            if(labels[i].time < time)
            {
               return labels[i].name;
            }
         }
         return null;
      }
      
      protected function getLabelsArray() : Array
      {
         var a:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _labels;
         for(var p in _labels)
         {
            a[a.length] = {
               "time":_labels[p],
               "name":p
            };
         }
         a.sortOn("time",16);
         return a;
      }
      
      protected function initDispatcher() : void
      {
         if(_dispatcher == null)
         {
            _dispatcher = new EventDispatcher(this);
         }
         if(this.vars.onStartListener is Function)
         {
            _dispatcher.addEventListener("start",this.vars.onStartListener,false,0,true);
         }
         if(this.vars.onUpdateListener is Function)
         {
            _dispatcher.addEventListener("change",this.vars.onUpdateListener,false,0,true);
            _hasUpdateListener = true;
         }
         if(this.vars.onCompleteListener is Function)
         {
            _dispatcher.addEventListener("complete",this.vars.onCompleteListener,false,0,true);
         }
         if(this.vars.onRepeatListener is Function)
         {
            _dispatcher.addEventListener("repeat",this.vars.onRepeatListener,false,0,true);
         }
         if(this.vars.onReverseCompleteListener is Function)
         {
            _dispatcher.addEventListener("reverseComplete",this.vars.onReverseCompleteListener,false,0,true);
         }
      }
      
      public function addEventListener(type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false) : void
      {
         if(_dispatcher == null)
         {
            initDispatcher();
         }
         if(type == "change")
         {
            _hasUpdateListener = true;
         }
         _dispatcher.addEventListener(type,listener,useCapture,priority,useWeakReference);
      }
      
      public function removeEventListener(type:String, listener:Function, useCapture:Boolean = false) : void
      {
         if(_dispatcher != null)
         {
            _dispatcher.removeEventListener(type,listener,useCapture);
         }
      }
      
      public function hasEventListener(type:String) : Boolean
      {
         return _dispatcher == null?false:Boolean(_dispatcher.hasEventListener(type));
      }
      
      public function willTrigger(type:String) : Boolean
      {
         return _dispatcher == null?false:Boolean(_dispatcher.willTrigger(type));
      }
      
      public function dispatchEvent(e:Event) : Boolean
      {
         return _dispatcher == null?false:Boolean(_dispatcher.dispatchEvent(e));
      }
      
      public function get totalProgress() : Number
      {
         return this.cachedTotalTime / this.totalDuration;
      }
      
      public function set totalProgress(n:Number) : void
      {
         setTotalTime(this.totalDuration * n,false);
      }
      
      override public function get totalDuration() : Number
      {
         var temp:Number = NaN;
         if(this.cacheIsDirty)
         {
            temp = super.totalDuration;
            this.cachedTotalDuration = _repeat == -1?999999999999:Number(this.cachedDuration * (_repeat + 1) + _repeatDelay * _repeat);
         }
         return this.cachedTotalDuration;
      }
      
      override public function set currentTime(n:Number) : void
      {
         if(_cyclesComplete == 0)
         {
            setTotalTime(n,false);
         }
         else if(this.yoyo && _cyclesComplete % 2 == 1)
         {
            setTotalTime(this.duration - n + _cyclesComplete * (this.cachedDuration + _repeatDelay),false);
         }
         else
         {
            setTotalTime(n + _cyclesComplete * (this.duration + _repeatDelay),false);
         }
      }
      
      public function get repeat() : int
      {
         return _repeat;
      }
      
      public function set repeat(n:int) : void
      {
         _repeat = n;
         setDirtyCache(true);
      }
      
      public function get repeatDelay() : Number
      {
         return _repeatDelay;
      }
      
      public function set repeatDelay(n:Number) : void
      {
         _repeatDelay = n;
         setDirtyCache(true);
      }
      
      public function get currentLabel() : String
      {
         return getLabelBefore(this.cachedTime + 1.0e-8);
      }
   }
}
