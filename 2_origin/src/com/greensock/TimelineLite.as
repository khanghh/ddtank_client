package com.greensock
{
   import com.greensock.core.SimpleTimeline;
   import com.greensock.core.TweenCore;
   
   public class TimelineLite extends SimpleTimeline
   {
      
      public static const version:Number = 1.64;
      
      private static var _overwriteMode:int = !!OverwriteManager.enabled?OverwriteManager.mode:int(OverwriteManager.init(2));
       
      
      protected var _labels:Object;
      
      protected var _endCaps:Array;
      
      public function TimelineLite(vars:Object = null)
      {
         super(vars);
         _endCaps = [null,null];
         _labels = {};
         this.autoRemoveChildren = this.vars.autoRemoveChildren == true;
         _hasUpdate = typeof this.vars.onUpdate == "function";
         if(this.vars.tweens is Array)
         {
            this.insertMultiple(this.vars.tweens,0,this.vars.align != null?this.vars.align:"normal",!!this.vars.stagger?Number(this.vars.stagger):0);
         }
      }
      
      override public function remove(tween:TweenCore, skipDisable:Boolean = false) : void
      {
         if(tween.cachedOrphan)
         {
            return;
         }
         if(!skipDisable)
         {
            tween.setEnabled(false,true);
         }
         var first:TweenCore = !!this.gc?_endCaps[0]:_firstChild;
         var last:TweenCore = !!this.gc?_endCaps[1]:_lastChild;
         if(tween.nextNode)
         {
            tween.nextNode.prevNode = tween.prevNode;
         }
         else if(last == tween)
         {
            last = tween.prevNode;
         }
         if(tween.prevNode)
         {
            tween.prevNode.nextNode = tween.nextNode;
         }
         else if(first == tween)
         {
            first = tween.nextNode;
         }
         if(this.gc)
         {
            _endCaps[0] = first;
            _endCaps[1] = last;
         }
         else
         {
            _firstChild = first;
            _lastChild = last;
         }
         tween.cachedOrphan = true;
         setDirtyCache(true);
      }
      
      override public function insert(tween:TweenCore, timeOrLabel:* = 0) : TweenCore
      {
         var curTween:* = null;
         var tl:* = null;
         if(typeof timeOrLabel == "string")
         {
            if(!(timeOrLabel in _labels))
            {
               addLabel(timeOrLabel,this.duration);
            }
            timeOrLabel = Number(_labels[timeOrLabel]);
         }
         if(!tween.cachedOrphan && tween.timeline)
         {
            tween.timeline.remove(tween,true);
         }
         tween.timeline = this;
         tween.cachedStartTime = Number(timeOrLabel) + tween.delay;
         if(tween.cachedPaused)
         {
            tween.cachedPauseTime = tween.cachedStartTime + (this.rawTime - tween.cachedStartTime) / tween.cachedTimeScale;
         }
         if(tween.gc)
         {
            tween.setEnabled(true,true);
         }
         setDirtyCache(true);
         var first:* = !!this.gc?_endCaps[0]:_firstChild;
         var last:* = !!this.gc?_endCaps[1]:_lastChild;
         if(last == null)
         {
            last = tween;
            first = last;
            var _loc8_:* = null;
            tween.prevNode = _loc8_;
            tween.nextNode = _loc8_;
         }
         else
         {
            curTween = last;
            var st:Number = tween.cachedStartTime;
            while(curTween != null && st < curTween.cachedStartTime)
            {
               curTween = curTween.prevNode;
            }
            if(curTween == null)
            {
               first.prevNode = tween;
               tween.nextNode = first;
               tween.prevNode = null;
               first = tween;
            }
            else
            {
               if(curTween.nextNode)
               {
                  curTween.nextNode.prevNode = tween;
               }
               else if(curTween == last)
               {
                  last = tween;
               }
               tween.prevNode = curTween;
               tween.nextNode = curTween.nextNode;
               curTween.nextNode = tween;
            }
         }
         tween.cachedOrphan = false;
         if(this.gc)
         {
            _endCaps[0] = first;
            _endCaps[1] = last;
         }
         else
         {
            _firstChild = first;
            _lastChild = last;
         }
         if(this.gc && this.cachedStartTime + (tween.cachedStartTime + tween.cachedTotalDuration / tween.cachedTimeScale) / this.cachedTimeScale > this.timeline.cachedTime)
         {
            this.setEnabled(true,false);
            tl = this.timeline;
            while(tl.gc && tl.timeline)
            {
               if(tl.cachedStartTime + tl.totalDuration / tl.cachedTimeScale > tl.timeline.cachedTime)
               {
                  tl.setEnabled(true,false);
               }
               tl = tl.timeline;
            }
         }
         return tween;
      }
      
      public function append(tween:TweenCore, offset:Number = 0) : TweenCore
      {
         return insert(tween,this.duration + offset);
      }
      
      public function prepend(tween:TweenCore, adjustLabels:Boolean = false) : TweenCore
      {
         shiftChildren(tween.totalDuration / tween.cachedTimeScale + tween.delay,adjustLabels,0);
         return insert(tween,0);
      }
      
      public function insertMultiple(tweens:Array, timeOrLabel:* = 0, align:String = "normal", stagger:Number = 0) : Array
      {
         var tween:* = null;
         var i:int = 0;
         var curTime:Number = Number(timeOrLabel) || 0;
         var l:int = tweens.length;
         if(typeof timeOrLabel == "string")
         {
            if(!(timeOrLabel in _labels))
            {
               addLabel(timeOrLabel,this.duration);
            }
            curTime = _labels[timeOrLabel];
         }
         for(i = 0; i < l; )
         {
            tween = tweens[i] as TweenCore;
            insert(tween,curTime);
            if(align == "sequence")
            {
               curTime = tween.cachedStartTime + tween.totalDuration / tween.cachedTimeScale;
            }
            else if(align == "start")
            {
               tween.cachedStartTime = tween.cachedStartTime - tween.delay;
            }
            curTime = curTime + stagger;
            i = i + 1;
         }
         return tweens;
      }
      
      public function appendMultiple(tweens:Array, offset:Number = 0, align:String = "normal", stagger:Number = 0) : Array
      {
         return insertMultiple(tweens,this.duration + offset,align,stagger);
      }
      
      public function prependMultiple(tweens:Array, align:String = "normal", stagger:Number = 0, adjustLabels:Boolean = false) : Array
      {
         var tl:TimelineLite = new TimelineLite({
            "tweens":tweens,
            "align":align,
            "stagger":stagger
         });
         shiftChildren(tl.duration,adjustLabels,0);
         insertMultiple(tweens,0,align,stagger);
         tl.kill();
         return tweens;
      }
      
      public function addLabel(label:String, time:Number) : void
      {
         _labels[label] = time;
      }
      
      public function removeLabel(label:String) : Number
      {
         var n:Number = _labels[label];
         delete _labels[label];
         return n;
      }
      
      public function getLabelTime(label:String) : Number
      {
         return label in _labels?Number(_labels[label]):-1;
      }
      
      protected function parseTimeOrLabel(timeOrLabel:*) : Number
      {
         if(typeof timeOrLabel == "string")
         {
            if(!(timeOrLabel in _labels))
            {
               throw new Error("TimelineLite error: the " + timeOrLabel + " label was not found.");
            }
            return getLabelTime(String(timeOrLabel));
         }
         return Number(timeOrLabel);
      }
      
      public function stop() : void
      {
         this.paused = true;
      }
      
      public function gotoAndPlay(timeOrLabel:*, suppressEvents:Boolean = true) : void
      {
         setTotalTime(parseTimeOrLabel(timeOrLabel),suppressEvents);
         play();
      }
      
      public function gotoAndStop(timeOrLabel:*, suppressEvents:Boolean = true) : void
      {
         setTotalTime(parseTimeOrLabel(timeOrLabel),suppressEvents);
         this.paused = true;
      }
      
      public function goto_(timeOrLabel:*, suppressEvents:Boolean = true) : void
      {
         setTotalTime(parseTimeOrLabel(timeOrLabel),suppressEvents);
      }
      
      override public function renderTime(time:Number, suppressEvents:Boolean = false, force:Boolean = false) : void
      {
         var tween:* = null;
         var isComplete:* = false;
         var rendered:Boolean = false;
         var next:* = null;
         var dur:Number = NaN;
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
               var _loc14_:* = totalDur;
               this.cachedTime = _loc14_;
               this.cachedTotalTime = _loc14_;
               forceChildrenToEnd(totalDur,suppressEvents);
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
               forceChildrenToBeginning(0,suppressEvents);
               this.cachedTotalTime = 0;
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
            _loc14_ = time;
            this.cachedTime = _loc14_;
            this.cachedTotalTime = _loc14_;
         }
         _rawPrevTime = time;
         if(this.cachedTime == prevTime && !force)
         {
            return;
         }
         if(!this.initted)
         {
            this.initted = true;
         }
         if(prevTime == 0 && this.vars.onStart && this.cachedTime != 0 && !suppressEvents)
         {
            this.vars.onStart.apply(null,this.vars.onStartParams);
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
         if(isComplete && (prevStart == this.cachedStartTime || prevTimeScale != this.cachedTimeScale) && (totalDur >= this.totalDuration || this.cachedTime == 0))
         {
            complete(true,suppressEvents);
         }
      }
      
      protected function forceChildrenToBeginning(time:Number, suppressEvents:Boolean = false) : Number
      {
         var next:* = null;
         var dur:Number = NaN;
         var tween:* = _lastChild;
         var prevPaused:Boolean = this.cachedPaused;
         while(tween)
         {
            next = tween.prevNode;
            if(!(this.cachedPaused && !prevPaused))
            {
               if(tween.active || !tween.cachedPaused && !tween.gc && (tween.cachedTotalTime != 0 || tween.cachedDuration == 0))
               {
                  if(time == 0 && (tween.cachedDuration != 0 || tween.cachedStartTime == 0))
                  {
                     tween.renderTime(!!tween.cachedReversed?tween.cachedTotalDuration:0,suppressEvents,false);
                  }
                  else if(!tween.cachedReversed)
                  {
                     tween.renderTime((time - tween.cachedStartTime) * tween.cachedTimeScale,suppressEvents,false);
                  }
                  else
                  {
                     dur = !!tween.cacheIsDirty?tween.totalDuration:Number(tween.cachedTotalDuration);
                     tween.renderTime(dur - (time - tween.cachedStartTime) * tween.cachedTimeScale,suppressEvents,false);
                  }
               }
               tween = next;
               continue;
            }
            break;
         }
         return time;
      }
      
      protected function forceChildrenToEnd(time:Number, suppressEvents:Boolean = false) : Number
      {
         var next:* = null;
         var dur:Number = NaN;
         var tween:* = _firstChild;
         var prevPaused:Boolean = this.cachedPaused;
         while(tween)
         {
            next = tween.nextNode;
            if(!(this.cachedPaused && !prevPaused))
            {
               if(tween.active || !tween.cachedPaused && !tween.gc && (tween.cachedTotalTime != tween.cachedTotalDuration || tween.cachedDuration == 0))
               {
                  if(time == this.cachedDuration && (tween.cachedDuration != 0 || tween.cachedStartTime == this.cachedDuration))
                  {
                     tween.renderTime(!!tween.cachedReversed?0:Number(tween.cachedTotalDuration),suppressEvents,false);
                  }
                  else if(!tween.cachedReversed)
                  {
                     tween.renderTime((time - tween.cachedStartTime) * tween.cachedTimeScale,suppressEvents,false);
                  }
                  else
                  {
                     dur = !!tween.cacheIsDirty?tween.totalDuration:Number(tween.cachedTotalDuration);
                     tween.renderTime(dur - (time - tween.cachedStartTime) * tween.cachedTimeScale,suppressEvents,false);
                  }
               }
               tween = next;
               continue;
            }
            break;
         }
         return time;
      }
      
      public function hasPausedChild() : Boolean
      {
         var tween:TweenCore = !!this.gc?_endCaps[0]:_firstChild;
         while(tween)
         {
            if(tween.cachedPaused || tween is TimelineLite && (tween as TimelineLite).hasPausedChild())
            {
               return true;
            }
            tween = tween.nextNode;
         }
         return false;
      }
      
      public function getChildren(nested:Boolean = true, tweens:Boolean = true, timelines:Boolean = true, ignoreBeforeTime:Number = -9.999999999E9) : Array
      {
         var a:Array = [];
         var cnt:int = 0;
         var tween:TweenCore = !!this.gc?_endCaps[0]:_firstChild;
         while(tween)
         {
            if(tween.cachedStartTime >= ignoreBeforeTime)
            {
               if(tween is TweenLite)
               {
                  if(tweens)
                  {
                     cnt++;
                     a[cnt] = tween;
                  }
               }
               else
               {
                  if(timelines)
                  {
                     cnt++;
                     a[cnt] = tween;
                  }
                  if(nested)
                  {
                     a = a.concat(TimelineLite(tween).getChildren(true,tweens,timelines));
                  }
               }
            }
            tween = tween.nextNode;
         }
         return a;
      }
      
      public function getTweensOf(target:Object, nested:Boolean = true) : Array
      {
         var i:int = 0;
         var tweens:Array = getChildren(nested,true,false);
         var a:Array = [];
         var l:int = tweens.length;
         var cnt:int = 0;
         for(i = 0; i < l; )
         {
            if(TweenLite(tweens[i]).target == target)
            {
               cnt++;
               a[cnt] = tweens[i];
            }
            i = i + 1;
         }
         return a;
      }
      
      public function shiftChildren(amount:Number, adjustLabels:Boolean = false, ignoreBeforeTime:Number = 0) : void
      {
         var tween:TweenCore = !!this.gc?_endCaps[0]:_firstChild;
         while(tween)
         {
            if(tween.cachedStartTime >= ignoreBeforeTime)
            {
               tween.cachedStartTime = tween.cachedStartTime + amount;
            }
            tween = tween.nextNode;
         }
         if(adjustLabels)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _labels;
            for(var p in _labels)
            {
               if(_labels[p] >= ignoreBeforeTime)
               {
                  var _loc6_:* = p;
                  var _loc7_:* = _labels[_loc6_] + amount;
                  _labels[_loc6_] = _loc7_;
               }
            }
         }
         this.setDirtyCache(true);
      }
      
      public function killTweensOf(target:Object, nested:Boolean = true, vars:Object = null) : Boolean
      {
         var tween:* = null;
         var tweens:Array = getTweensOf(target,nested);
         var i:int = tweens.length;
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            tween = tweens[i];
            if(vars != null)
            {
               tween.killVars(vars);
            }
            if(vars == null || tween.cachedPT1 == null && tween.initted)
            {
               tween.setEnabled(false,false);
            }
         }
         return tweens.length > 0;
      }
      
      override public function invalidate() : void
      {
         var tween:TweenCore = !!this.gc?_endCaps[0]:_firstChild;
         while(tween)
         {
            tween.invalidate();
            tween = tween.nextNode;
         }
      }
      
      public function clear(tweens:Array = null) : void
      {
         if(tweens == null)
         {
            tweens = getChildren(false,true,true);
         }
         var i:int = tweens.length;
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            TweenCore(tweens[i]).setEnabled(false,false);
         }
      }
      
      override public function setEnabled(enabled:Boolean, ignoreTimeline:Boolean = false) : Boolean
      {
         var tween:* = null;
         if(enabled == this.gc)
         {
            if(enabled)
            {
               tween = _endCaps[0];
               _firstChild = _endCaps[0];
               _lastChild = _endCaps[1];
               _endCaps = [null,null];
            }
            else
            {
               tween = _firstChild;
               _endCaps = [_firstChild,_lastChild];
               _lastChild = null;
               _firstChild = null;
            }
            while(tween)
            {
               tween.setEnabled(enabled,true);
               tween = tween.nextNode;
            }
         }
         return super.setEnabled(enabled,ignoreTimeline);
      }
      
      public function get currentProgress() : Number
      {
         return this.cachedTime / this.duration;
      }
      
      public function set currentProgress(n:Number) : void
      {
         setTotalTime(this.duration * n,false);
      }
      
      override public function get duration() : Number
      {
         var d:Number = NaN;
         if(this.cacheIsDirty)
         {
            d = this.totalDuration;
         }
         return this.cachedDuration;
      }
      
      override public function set duration(n:Number) : void
      {
         if(this.duration != 0 && n != 0)
         {
            this.timeScale = this.duration / n;
         }
      }
      
      override public function get totalDuration() : Number
      {
         var end:Number = NaN;
         var next:* = null;
         var max:* = NaN;
         if(this.cacheIsDirty)
         {
            max = 0;
            var tween:* = !!this.gc?_endCaps[0]:_firstChild;
            var prevStart:* = -Infinity;
            while(tween)
            {
               next = tween.nextNode;
               if(tween.cachedStartTime < prevStart)
               {
                  this.insert(tween,tween.cachedStartTime - tween.delay);
                  prevStart = Number(tween.prevNode.cachedStartTime);
               }
               else
               {
                  prevStart = Number(tween.cachedStartTime);
               }
               if(tween.cachedStartTime < 0)
               {
                  max = Number(max - tween.cachedStartTime);
                  this.shiftChildren(-tween.cachedStartTime,false,-9999999999);
               }
               end = tween.cachedStartTime + tween.totalDuration / tween.cachedTimeScale;
               if(end > max)
               {
                  max = end;
               }
               tween = next;
            }
            var _loc6_:* = max;
            this.cachedTotalDuration = _loc6_;
            this.cachedDuration = _loc6_;
            this.cacheIsDirty = false;
         }
         return this.cachedTotalDuration;
      }
      
      override public function set totalDuration(n:Number) : void
      {
         if(this.totalDuration != 0 && n != 0)
         {
            this.timeScale = this.totalDuration / n;
         }
      }
      
      public function get timeScale() : Number
      {
         return this.cachedTimeScale;
      }
      
      public function set timeScale(n:Number) : void
      {
         if(n == 0)
         {
            n = 0.0001;
         }
         var tlTime:Number = this.cachedPauseTime || this.cachedPauseTime == 0?this.cachedPauseTime:Number(this.timeline.cachedTotalTime);
         this.cachedStartTime = tlTime - (tlTime - this.cachedStartTime) * this.cachedTimeScale / n;
         this.cachedTimeScale = n;
         setDirtyCache(false);
      }
      
      public function get useFrames() : Boolean
      {
         var tl:SimpleTimeline = this.timeline;
         while(tl.timeline)
         {
            tl = tl.timeline;
         }
         return tl == TweenLite.rootFramesTimeline;
      }
      
      override public function get rawTime() : Number
      {
         if(this.cachedTotalTime != 0 && this.cachedTotalTime != this.cachedTotalDuration)
         {
            return this.cachedTotalTime;
         }
         return (this.timeline.rawTime - this.cachedStartTime) * this.cachedTimeScale;
      }
   }
}
