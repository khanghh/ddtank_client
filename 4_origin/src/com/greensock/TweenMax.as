package com.greensock
{
   import com.greensock.core.PropTween;
   import com.greensock.core.SimpleTimeline;
   import com.greensock.core.TweenCore;
   import com.greensock.events.TweenEvent;
   import com.greensock.plugins.AutoAlphaPlugin;
   import com.greensock.plugins.BevelFilterPlugin;
   import com.greensock.plugins.BezierPlugin;
   import com.greensock.plugins.BezierThroughPlugin;
   import com.greensock.plugins.BlurFilterPlugin;
   import com.greensock.plugins.ColorMatrixFilterPlugin;
   import com.greensock.plugins.ColorTransformPlugin;
   import com.greensock.plugins.DropShadowFilterPlugin;
   import com.greensock.plugins.EndArrayPlugin;
   import com.greensock.plugins.FrameLabelPlugin;
   import com.greensock.plugins.FramePlugin;
   import com.greensock.plugins.GlowFilterPlugin;
   import com.greensock.plugins.HexColorsPlugin;
   import com.greensock.plugins.RemoveTintPlugin;
   import com.greensock.plugins.RoundPropsPlugin;
   import com.greensock.plugins.ShortRotationPlugin;
   import com.greensock.plugins.TintPlugin;
   import com.greensock.plugins.TweenPlugin;
   import com.greensock.plugins.VisiblePlugin;
   import com.greensock.plugins.VolumePlugin;
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.utils.Dictionary;
   import flash.utils.getTimer;
   
   public class TweenMax extends TweenLite implements IEventDispatcher
   {
      
      public static const version:Number = 11.64;
      
      private static var _overwriteMode:int = !!OverwriteManager.enabled?OverwriteManager.mode:int(OverwriteManager.init(2));
      
      public static var killTweensOf:Function = TweenLite.killTweensOf;
      
      public static var killDelayedCallsTo:Function = TweenLite.killTweensOf;
      
      {
         TweenPlugin.activate([AutoAlphaPlugin,EndArrayPlugin,FramePlugin,RemoveTintPlugin,TintPlugin,VisiblePlugin,VolumePlugin,BevelFilterPlugin,BezierPlugin,BezierThroughPlugin,BlurFilterPlugin,ColorMatrixFilterPlugin,ColorTransformPlugin,DropShadowFilterPlugin,FrameLabelPlugin,GlowFilterPlugin,HexColorsPlugin,RoundPropsPlugin,ShortRotationPlugin,{}]);
      }
      
      protected var _dispatcher:EventDispatcher;
      
      protected var _hasUpdateListener:Boolean;
      
      protected var _repeat:int = 0;
      
      protected var _repeatDelay:Number = 0;
      
      protected var _cyclesComplete:int = 0;
      
      protected var _easePower:int;
      
      protected var _easeType:int;
      
      public var yoyo:Boolean;
      
      public function TweenMax(target:Object, duration:Number, vars:Object)
      {
         super(target,duration,vars);
         this.yoyo = Boolean(this.vars.yoyo);
         _repeat = uint(this.vars.repeat);
         _repeatDelay = !!this.vars.repeatDelay?Number(this.vars.repeatDelay):0;
         this.cacheIsDirty = true;
         if(this.vars.onCompleteListener || this.vars.onInitListener || this.vars.onUpdateListener || this.vars.onStartListener || this.vars.onRepeatListener || this.vars.onReverseCompleteListener)
         {
            initDispatcher();
            if(duration == 0 && _delay == 0)
            {
               _dispatcher.dispatchEvent(new TweenEvent("change"));
               _dispatcher.dispatchEvent(new TweenEvent("complete"));
            }
         }
         if(this.vars.timeScale && !(this.target is TweenCore))
         {
            this.cachedTimeScale = this.vars.timeScale;
         }
      }
      
      public static function to(target:Object, duration:Number, vars:Object) : TweenMax
      {
         return new TweenMax(target,duration,vars);
      }
      
      public static function from(target:Object, duration:Number, vars:Object) : TweenMax
      {
         vars.runBackwards = true;
         if(!("immediateRender" in vars))
         {
            vars.immediateRender = true;
         }
         return new TweenMax(target,duration,vars);
      }
      
      public static function fromTo(target:Object, duration:Number, fromVars:Object, toVars:Object) : TweenMax
      {
         toVars.startAt = fromVars;
         if(fromVars.immediateRender)
         {
            toVars.immediateRender = true;
         }
         return new TweenMax(target,duration,toVars);
      }
      
      public static function allTo(targets:Array, duration:Number, vars:Object, stagger:Number = 0, onCompleteAll:Function = null, onCompleteAllParams:Array = null) : Array
      {
         targets = targets;
         duration = duration;
         vars = vars;
         stagger = stagger;
         onCompleteAll = onCompleteAll;
         onCompleteAllParams = onCompleteAllParams;
         var l:int = targets.length;
         var a:Array = [];
         var curDelay:Number = "delay" in vars?Number(vars.delay):0;
         var onCompleteProxy:Function = vars.onComplete;
         var onCompleteParamsProxy:Array = vars.onCompleteParams;
         var lastIndex:int = l - 1;
         for(var i:int = 0; i < l; )
         {
            var varsDup:Object = {};
            var _loc9_:int = 0;
            var _loc8_:* = vars;
            for(p in vars)
            {
               varsDup[p] = vars[p];
            }
            varsDup.delay = curDelay;
            if(i == lastIndex && onCompleteAll != null)
            {
               varsDup.onComplete = function():void
               {
                  if(onCompleteProxy != null)
                  {
                     onCompleteProxy.apply(null,onCompleteParamsProxy);
                  }
                  onCompleteAll.apply(null,onCompleteAllParams);
               };
            }
            a[i] = new TweenMax(targets[i],duration,varsDup);
            curDelay = curDelay + stagger;
            i = i + 1;
         }
         return a;
      }
      
      public static function allFrom(targets:Array, duration:Number, vars:Object, stagger:Number = 0, onCompleteAll:Function = null, onCompleteAllParams:Array = null) : Array
      {
         vars.runBackwards = true;
         if(!("immediateRender" in vars))
         {
            vars.immediateRender = true;
         }
         return allTo(targets,duration,vars,stagger,onCompleteAll,onCompleteAllParams);
      }
      
      public static function allFromTo(targets:Array, duration:Number, fromVars:Object, toVars:Object, stagger:Number = 0, onCompleteAll:Function = null, onCompleteAllParams:Array = null) : Array
      {
         toVars.startAt = fromVars;
         if(fromVars.immediateRender)
         {
            toVars.immediateRender = true;
         }
         return allTo(targets,duration,toVars,stagger,onCompleteAll,onCompleteAllParams);
      }
      
      public static function delayedCall(delay:Number, onComplete:Function, onCompleteParams:Array = null, useFrames:Boolean = false) : TweenMax
      {
         return new TweenMax(onComplete,0,{
            "delay":delay,
            "onComplete":onComplete,
            "onCompleteParams":onCompleteParams,
            "immediateRender":false,
            "useFrames":useFrames,
            "overwrite":0
         });
      }
      
      public static function getTweensOf(target:Object) : Array
      {
         var i:int = 0;
         var cnt:int = 0;
         var a:Array = masterList[target];
         var toReturn:Array = [];
         if(a)
         {
            i = a.length;
            cnt = 0;
            while(true)
            {
               i--;
               if(i <= -1)
               {
                  break;
               }
               if(!TweenLite(a[i]).gc)
               {
                  cnt++;
                  toReturn[cnt] = a[i];
               }
            }
         }
         return toReturn;
      }
      
      public static function isTweening(target:Object) : Boolean
      {
         var tween:* = null;
         var a:Array = getTweensOf(target);
         var i:int = a.length;
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            tween = a[i];
            if(tween.active || tween.cachedStartTime == tween.timeline.cachedTime && tween.timeline.active)
            {
               return true;
            }
         }
         return false;
      }
      
      public static function getAllTweens() : Array
      {
         var a:* = null;
         var i:int = 0;
         var ml:Dictionary = masterList;
         var cnt:int = 0;
         var toReturn:Array = [];
         var _loc7_:int = 0;
         var _loc6_:* = ml;
         for each(a in ml)
         {
            i = a.length;
            while(true)
            {
               i--;
               if(i <= -1)
               {
                  break;
               }
               if(!TweenLite(a[i]).gc)
               {
                  cnt++;
                  toReturn[cnt] = a[i];
               }
            }
         }
         return toReturn;
      }
      
      public static function killAll(complete:Boolean = false, tweens:Boolean = true, delayedCalls:Boolean = true) : void
      {
         var isDC:* = false;
         var a:Array = getAllTweens();
         var i:int = a.length;
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            isDC = a[i].target == a[i].vars.onComplete;
            if(isDC == delayedCalls || isDC != tweens)
            {
               if(complete)
               {
                  a[i].complete(false);
               }
               else
               {
                  a[i].setEnabled(false,false);
               }
            }
         }
      }
      
      public static function killChildTweensOf(parent:DisplayObjectContainer, complete:Boolean = false) : void
      {
         var curParent:* = null;
         var curTarget:* = null;
         var a:Array = getAllTweens();
         var i:int = a.length;
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            curTarget = a[i].target;
            if(curTarget is DisplayObject)
            {
               curParent = curTarget.parent;
               while(curParent)
               {
                  if(curParent == parent)
                  {
                     if(complete)
                     {
                        a[i].complete(false);
                     }
                     else
                     {
                        a[i].setEnabled(false,false);
                     }
                  }
                  curParent = curParent.parent;
               }
            }
         }
      }
      
      public static function pauseAll(tweens:Boolean = true, delayedCalls:Boolean = true) : void
      {
         changePause(true,tweens,delayedCalls);
      }
      
      public static function resumeAll(tweens:Boolean = true, delayedCalls:Boolean = true) : void
      {
         changePause(false,tweens,delayedCalls);
      }
      
      private static function changePause(pause:Boolean, tweens:Boolean = true, delayedCalls:Boolean = false) : void
      {
         var isDC:* = false;
         var a:Array = getAllTweens();
         var i:int = a.length;
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            isDC = TweenLite(a[i]).target == TweenLite(a[i]).vars.onComplete;
            if(isDC == delayedCalls || isDC != tweens)
            {
               TweenCore(a[i]).paused = pause;
            }
         }
      }
      
      public static function get globalTimeScale() : Number
      {
         return TweenLite.rootTimeline == null?1:Number(TweenLite.rootTimeline.cachedTimeScale);
      }
      
      public static function set globalTimeScale(n:Number) : void
      {
         if(n == 0)
         {
            n = 0.0001;
         }
         if(TweenLite.rootTimeline == null)
         {
            TweenLite.to({},0,{});
         }
         var tl:SimpleTimeline = TweenLite.rootTimeline;
         var curTime:Number = getTimer() * 0.001;
         tl.cachedStartTime = curTime - (curTime - tl.cachedStartTime) * tl.cachedTimeScale / n;
         tl = TweenLite.rootFramesTimeline;
         curTime = TweenLite.rootFrame;
         tl.cachedStartTime = curTime - (curTime - tl.cachedStartTime) * tl.cachedTimeScale / n;
         var _loc4_:* = n;
         TweenLite.rootTimeline.cachedTimeScale = _loc4_;
         TweenLite.rootFramesTimeline.cachedTimeScale = _loc4_;
      }
      
      override protected function init() : void
      {
         var startTween:* = null;
         if(this.vars.startAt)
         {
            this.vars.startAt.overwrite = 0;
            this.vars.startAt.immediateRender = true;
            startTween = new TweenMax(this.target,0,this.vars.startAt);
         }
         if(_dispatcher)
         {
            _dispatcher.dispatchEvent(new TweenEvent("init"));
         }
         super.init();
         if(_ease in fastEaseLookup)
         {
            _easeType = fastEaseLookup[_ease][0];
            _easePower = fastEaseLookup[_ease][1];
         }
      }
      
      override public function invalidate() : void
      {
         this.yoyo = this.vars.yoyo == true;
         _repeat = !!this.vars.repeat?Number(this.vars.repeat):0;
         _repeatDelay = !!this.vars.repeatDelay?Number(this.vars.repeatDelay):0;
         _hasUpdateListener = false;
         if(this.vars.onCompleteListener != null || this.vars.onUpdateListener != null || this.vars.onStartListener != null)
         {
            initDispatcher();
         }
         setDirtyCache(true);
         super.invalidate();
      }
      
      public function updateTo(vars:Object, resetDuration:Boolean = false) : void
      {
         var inv:Number = NaN;
         var endValue:Number = NaN;
         var pt:* = null;
         var curRatio:Number = this.ratio;
         if(resetDuration && this.timeline != null && this.cachedStartTime < this.timeline.cachedTime)
         {
            this.cachedStartTime = this.timeline.cachedTime;
            this.setDirtyCache(false);
            if(this.gc)
            {
               this.setEnabled(true,false);
            }
            else
            {
               this.timeline.insert(this,this.cachedStartTime - _delay);
            }
         }
         var _loc9_:int = 0;
         var _loc8_:* = vars;
         for(var p in vars)
         {
            this.vars[p] = vars[p];
         }
         if(this.initted)
         {
            this.initted = false;
            if(!resetDuration)
            {
               if(_notifyPluginsOfEnabled && this.cachedPT1)
               {
                  onPluginEvent("onDisable",this);
               }
               init();
               if(!resetDuration && this.cachedTime > 0 && this.cachedTime < this.cachedDuration)
               {
                  inv = 1 / (1 - curRatio);
                  pt = this.cachedPT1;
                  while(pt)
                  {
                     endValue = pt.start + pt.change;
                     pt.change = pt.change * inv;
                     pt.start = endValue - pt.change;
                     pt = pt.nextNode;
                  }
               }
            }
         }
      }
      
      public function setDestination(property:String, value:*, adjustStartValues:Boolean = true) : void
      {
         var vars:Object = {};
         vars[property] = value;
         updateTo(vars,!adjustStartValues);
      }
      
      public function killProperties(names:Array) : void
      {
         var v:Object = {};
         var i:int = names.length;
         while(true)
         {
            i--;
            if(i <= -1)
            {
               break;
            }
            v[names[i]] = true;
         }
         killVars(v);
      }
      
      override public function renderTime(time:Number, suppressEvents:Boolean = false, force:Boolean = false) : void
      {
         var isComplete:Boolean = false;
         var repeated:Boolean = false;
         var setRatio:Boolean = false;
         var cycleDuration:Number = NaN;
         var prevCycles:int = 0;
         var power:int = 0;
         var val:Number = NaN;
         var totalDur:Number = !!this.cacheIsDirty?this.totalDuration:Number(this.cachedTotalDuration);
         var prevTime:Number = this.cachedTime;
         if(time >= totalDur)
         {
            this.cachedTotalTime = totalDur;
            this.cachedTime = this.cachedDuration;
            this.ratio = 1;
            isComplete = true;
            if(this.cachedDuration == 0)
            {
               if((time == 0 || _rawPrevTime < 0) && _rawPrevTime != time)
               {
                  force = true;
               }
               _rawPrevTime = time;
            }
         }
         else if(time <= 0)
         {
            if(time < 0)
            {
               this.active = false;
               if(this.cachedDuration == 0)
               {
                  if(_rawPrevTime >= 0)
                  {
                     force = true;
                     isComplete = true;
                  }
                  _rawPrevTime = time;
               }
            }
            else if(time == 0 && !this.initted)
            {
               force = true;
            }
            var _loc14_:* = 0;
            this.ratio = _loc14_;
            _loc14_ = _loc14_;
            this.cachedTime = _loc14_;
            this.cachedTotalTime = _loc14_;
            if(this.cachedReversed && prevTime != 0)
            {
               isComplete = true;
            }
         }
         else
         {
            _loc14_ = time;
            this.cachedTime = _loc14_;
            this.cachedTotalTime = _loc14_;
            setRatio = true;
         }
         if(_repeat != 0)
         {
            cycleDuration = this.cachedDuration + _repeatDelay;
            if(isComplete)
            {
               if(this.yoyo && _repeat % 2)
               {
                  _loc14_ = 0;
                  this.ratio = _loc14_;
                  this.cachedTime = _loc14_;
               }
            }
            else if(time > 0)
            {
               prevCycles = _cyclesComplete;
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
                  this.ratio = 1;
                  setRatio = false;
               }
               if(this.cachedTime <= 0)
               {
                  _loc14_ = 0;
                  this.ratio = _loc14_;
                  this.cachedTime = _loc14_;
                  setRatio = false;
               }
            }
            else
            {
               _cyclesComplete = 0;
            }
         }
         if(prevTime == this.cachedTime && !force)
         {
            return;
         }
         if(!this.initted)
         {
            init();
         }
         if(!this.active && !this.cachedPaused)
         {
            this.active = true;
         }
         if(setRatio)
         {
            if(_easeType)
            {
               power = _easePower;
               val = this.cachedTime / this.cachedDuration;
               if(_easeType == 2)
               {
                  val = 1 - val;
                  this.ratio = 1 - val;
                  while(true)
                  {
                     power--;
                     if(power <= -1)
                     {
                        break;
                     }
                     this.ratio = val * this.ratio;
                  }
                  this.ratio = 1 - this.ratio;
               }
               else if(_easeType == 1)
               {
                  this.ratio = val;
                  while(true)
                  {
                     power--;
                     if(power <= -1)
                     {
                        break;
                     }
                     this.ratio = val * this.ratio;
                  }
               }
               else if(val < 0.5)
               {
                  val = val * 2;
                  this.ratio = val * 2;
                  while(true)
                  {
                     power--;
                     if(power <= -1)
                     {
                        break;
                     }
                     this.ratio = val * this.ratio;
                  }
                  this.ratio = this.ratio * 0.5;
               }
               else
               {
                  val = (1 - val) * 2;
                  this.ratio = (1 - val) * 2;
                  while(true)
                  {
                     power--;
                     if(power <= -1)
                     {
                        break;
                     }
                     this.ratio = val * this.ratio;
                  }
                  this.ratio = 1 - 0.5 * this.ratio;
               }
            }
            else
            {
               this.ratio = _ease(this.cachedTime,0,1,this.cachedDuration);
            }
         }
         if(prevTime == 0 && (this.cachedTotalTime != 0 || this.cachedDuration == 0) && !suppressEvents)
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
         var pt:PropTween = this.cachedPT1;
         while(pt)
         {
            pt.target[pt.property] = pt.start + this.ratio * pt.change;
            pt = pt.nextNode;
         }
         if(_hasUpdate && !suppressEvents)
         {
            this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         if(_hasUpdateListener && !suppressEvents)
         {
            _dispatcher.dispatchEvent(new TweenEvent("change"));
         }
         if(isComplete && !this.gc)
         {
            if(_hasPlugins && this.cachedPT1)
            {
               onPluginEvent("onComplete",this);
            }
            complete(true,suppressEvents);
         }
         else if(repeated && !suppressEvents && !this.gc)
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
         if(!suppressEvents && _dispatcher)
         {
            if(this.cachedTotalTime == this.cachedTotalDuration && !this.cachedReversed)
            {
               _dispatcher.dispatchEvent(new TweenEvent("complete"));
            }
            else if(this.cachedReversed && this.cachedTotalTime == 0)
            {
               _dispatcher.dispatchEvent(new TweenEvent("reverseComplete"));
            }
         }
      }
      
      protected function initDispatcher() : void
      {
         if(_dispatcher == null)
         {
            _dispatcher = new EventDispatcher(this);
         }
         if(this.vars.onInitListener is Function)
         {
            _dispatcher.addEventListener("init",this.vars.onInitListener,false,0,true);
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
         if(_dispatcher)
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
      
      public function get currentProgress() : Number
      {
         return this.cachedTime / this.duration;
      }
      
      public function set currentProgress(n:Number) : void
      {
         if(_cyclesComplete == 0)
         {
            setTotalTime(this.duration * n,false);
         }
         else
         {
            setTotalTime(this.duration * n + _cyclesComplete * this.cachedDuration,false);
         }
      }
      
      public function get totalProgress() : Number
      {
         return this.cachedTotalTime / this.totalDuration;
      }
      
      public function set totalProgress(n:Number) : void
      {
         setTotalTime(this.totalDuration * n,false);
      }
      
      override public function set currentTime(n:Number) : void
      {
         if(_cyclesComplete != 0)
         {
            if(this.yoyo && _cyclesComplete % 2 == 1)
            {
               n = this.duration - n + _cyclesComplete * (this.cachedDuration + _repeatDelay);
            }
            else
            {
               n = n + _cyclesComplete * (this.duration + _repeatDelay);
            }
         }
         setTotalTime(n,false);
      }
      
      override public function get totalDuration() : Number
      {
         if(this.cacheIsDirty)
         {
            this.cachedTotalDuration = _repeat == -1?999999999999:Number(this.cachedDuration * (_repeat + 1) + _repeatDelay * _repeat);
            this.cacheIsDirty = false;
         }
         return this.cachedTotalDuration;
      }
      
      override public function set totalDuration(n:Number) : void
      {
         if(_repeat == -1)
         {
            return;
         }
         this.duration = (n - _repeat * _repeatDelay) / (_repeat + 1);
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
   }
}
