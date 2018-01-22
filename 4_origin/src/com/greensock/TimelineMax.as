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
      
      public function TimelineMax(param1:Object = null)
      {
         super(param1);
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
      
      private static function onInitTweenTo(param1:TweenLite, param2:TimelineMax, param3:Number) : void
      {
         param2.paused = true;
         if(!isNaN(param3))
         {
            param2.currentTime = param3;
         }
         if(param1.vars.currentTime != param2.currentTime)
         {
            param1.duration = Math.abs(param1.vars.currentTime - param2.currentTime) / param2.cachedTimeScale;
         }
      }
      
      private static function easeNone(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         return param1 / param4;
      }
      
      public function addCallback(param1:Function, param2:*, param3:Array = null) : TweenLite
      {
         var _loc4_:TweenLite = new TweenLite(param1,0,{
            "onComplete":param1,
            "onCompleteParams":param3,
            "overwrite":0,
            "immediateRender":false
         });
         insert(_loc4_,param2);
         return _loc4_;
      }
      
      public function removeCallback(param1:Function, param2:* = null) : Boolean
      {
         var _loc4_:Boolean = false;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         if(param2 == null)
         {
            return killTweensOf(param1,false);
         }
         if(typeof param2 == "string")
         {
            if(!(param2 in _labels))
            {
               return false;
            }
            param2 = _labels[param2];
         }
         _loc3_ = getTweensOf(param1,false);
         _loc5_ = _loc3_.length;
         while(true)
         {
            _loc5_--;
            if(_loc5_ <= -1)
            {
               break;
            }
            if(_loc3_[_loc5_].cachedStartTime == param2)
            {
               remove(_loc3_[_loc5_] as TweenCore);
               _loc4_ = true;
            }
         }
         return _loc4_;
      }
      
      public function tweenTo(param1:*, param2:Object = null) : TweenLite
      {
         var _loc5_:Object = {
            "ease":easeNone,
            "overwrite":2,
            "useFrames":this.useFrames,
            "immediateRender":false
         };
         var _loc7_:int = 0;
         var _loc6_:* = param2;
         for(var _loc4_ in param2)
         {
            _loc5_[_loc4_] = param2[_loc4_];
         }
         _loc5_.onInit = onInitTweenTo;
         _loc5_.onInitParams = [null,this,NaN];
         _loc5_.currentTime = parseTimeOrLabel(param1);
         var _loc3_:TweenLite = new TweenLite(this,Math.abs(_loc5_.currentTime - this.cachedTime) / this.cachedTimeScale || 0.001,_loc5_);
         _loc3_.vars.onInitParams[0] = _loc3_;
         return _loc3_;
      }
      
      public function tweenFromTo(param1:*, param2:*, param3:Object = null) : TweenLite
      {
         var _loc4_:TweenLite = tweenTo(param2,param3);
         _loc4_.vars.onInitParams[2] = parseTimeOrLabel(param1);
         _loc4_.duration = Math.abs(_loc4_.vars.currentTime - _loc4_.vars.onInitParams[2]) / this.cachedTimeScale;
         return _loc4_;
      }
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc6_:* = null;
         var _loc5_:* = false;
         var _loc11_:Boolean = false;
         var _loc13_:Boolean = false;
         var _loc7_:* = null;
         var _loc14_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc9_:int = 0;
         var _loc15_:Boolean = false;
         var _loc17_:* = false;
         var _loc4_:* = false;
         if(this.gc)
         {
            this.setEnabled(true,false);
         }
         else if(!this.active && !this.cachedPaused)
         {
            this.active = true;
         }
         var _loc10_:Number = !!this.cacheIsDirty?this.totalDuration:Number(this.cachedTotalDuration);
         var _loc19_:Number = this.cachedTime;
         var _loc16_:Number = this.cachedStartTime;
         var _loc8_:Number = this.cachedTimeScale;
         var _loc12_:Boolean = this.cachedPaused;
         if(param1 >= _loc10_)
         {
            if(_rawPrevTime <= _loc10_ && _rawPrevTime != param1)
            {
               if(!this.cachedReversed && this.yoyo && _repeat % 2 != 0)
               {
                  forceChildrenToBeginning(0,param2);
                  this.cachedTime = 0;
               }
               else
               {
                  forceChildrenToEnd(this.cachedDuration,param2);
                  this.cachedTime = this.cachedDuration;
               }
               this.cachedTotalTime = _loc10_;
               _loc5_ = !this.hasPausedChild();
               _loc11_ = true;
               if(this.cachedDuration == 0 && _loc5_ && (param1 == 0 || _rawPrevTime < 0))
               {
                  param3 = true;
               }
            }
         }
         else if(param1 <= 0)
         {
            if(param1 < 0)
            {
               this.active = false;
               if(this.cachedDuration == 0 && _rawPrevTime >= 0)
               {
                  param3 = true;
                  _loc5_ = true;
               }
            }
            else if(param1 == 0 && !this.initted)
            {
               param3 = true;
            }
            if(_rawPrevTime >= 0 && _rawPrevTime != param1)
            {
               this.cachedTotalTime = 0;
               forceChildrenToBeginning(0,param2);
               this.cachedTime = 0;
               _loc11_ = true;
               if(this.cachedReversed)
               {
                  _loc5_ = true;
               }
            }
         }
         else
         {
            var _loc20_:* = param1;
            this.cachedTime = _loc20_;
            this.cachedTotalTime = _loc20_;
         }
         _rawPrevTime = param1;
         if(_repeat != 0)
         {
            _loc18_ = this.cachedDuration + _repeatDelay;
            _loc9_ = _cyclesComplete;
            if(_loc5_)
            {
               if(this.yoyo && _repeat % 2)
               {
                  this.cachedTime = 0;
               }
            }
            else if(param1 > 0)
            {
               _cyclesComplete = this.cachedTotalTime / _loc18_ >> 0;
               if(_cyclesComplete == this.cachedTotalTime / _loc18_)
               {
                  _cyclesComplete = Number(_cyclesComplete) - 1;
               }
               if(_loc9_ != _cyclesComplete)
               {
                  _loc13_ = true;
               }
               this.cachedTime = (this.cachedTotalTime / _loc18_ - _cyclesComplete) * _loc18_;
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
            if(_loc13_ && !_loc5_ && (this.cachedTime != _loc19_ || param3))
            {
               _loc15_ = !this.yoyo || _cyclesComplete % 2 == 0;
               _loc17_ = Boolean(!this.yoyo || _loc9_ % 2 == 0);
               _loc4_ = _loc15_ == _loc17_;
               if(_loc9_ > _cyclesComplete)
               {
                  _loc17_ = !_loc17_;
               }
               if(_loc17_)
               {
                  _loc19_ = forceChildrenToEnd(this.cachedDuration,param2);
                  if(_loc4_)
                  {
                     _loc19_ = forceChildrenToBeginning(0,true);
                  }
               }
               else
               {
                  _loc19_ = forceChildrenToBeginning(0,param2);
                  if(_loc4_)
                  {
                     _loc19_ = forceChildrenToEnd(this.cachedDuration,true);
                  }
               }
               _loc11_ = false;
            }
         }
         if(this.cachedTime == _loc19_ && !param3)
         {
            return;
         }
         if(!this.initted)
         {
            this.initted = true;
         }
         if(_loc19_ == 0 && this.cachedTotalTime != 0 && !param2)
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
         if(!_loc11_)
         {
            if(this.cachedTime - _loc19_ > 0)
            {
               _loc6_ = _firstChild;
               while(_loc6_)
               {
                  _loc7_ = _loc6_.nextNode;
                  if(!(this.cachedPaused && !_loc12_))
                  {
                     if(_loc6_.active || !_loc6_.cachedPaused && _loc6_.cachedStartTime <= this.cachedTime && !_loc6_.gc)
                     {
                        if(!_loc6_.cachedReversed)
                        {
                           _loc6_.renderTime((this.cachedTime - _loc6_.cachedStartTime) * _loc6_.cachedTimeScale,param2,false);
                        }
                        else
                        {
                           _loc14_ = !!_loc6_.cacheIsDirty?_loc6_.totalDuration:Number(_loc6_.cachedTotalDuration);
                           _loc6_.renderTime(_loc14_ - (this.cachedTime - _loc6_.cachedStartTime) * _loc6_.cachedTimeScale,param2,false);
                        }
                     }
                     _loc6_ = _loc7_;
                     continue;
                  }
                  break;
               }
            }
            else
            {
               _loc6_ = _lastChild;
               while(_loc6_)
               {
                  _loc7_ = _loc6_.prevNode;
                  if(!(this.cachedPaused && !_loc12_))
                  {
                     if(_loc6_.active || !_loc6_.cachedPaused && _loc6_.cachedStartTime <= _loc19_ && !_loc6_.gc)
                     {
                        if(!_loc6_.cachedReversed)
                        {
                           _loc6_.renderTime((this.cachedTime - _loc6_.cachedStartTime) * _loc6_.cachedTimeScale,param2,false);
                        }
                        else
                        {
                           _loc14_ = !!_loc6_.cacheIsDirty?_loc6_.totalDuration:Number(_loc6_.cachedTotalDuration);
                           _loc6_.renderTime(_loc14_ - (this.cachedTime - _loc6_.cachedStartTime) * _loc6_.cachedTimeScale,param2,false);
                        }
                     }
                     _loc6_ = _loc7_;
                     continue;
                  }
                  break;
               }
            }
         }
         if(_hasUpdate && !param2)
         {
            this.vars.onUpdate.apply(null,this.vars.onUpdateParams);
         }
         if(_hasUpdateListener && !param2)
         {
            _dispatcher.dispatchEvent(new TweenEvent("change"));
         }
         if(_loc5_ && (_loc16_ == this.cachedStartTime || _loc8_ != this.cachedTimeScale) && (_loc10_ >= this.totalDuration || this.cachedTime == 0))
         {
            complete(true,param2);
         }
         else if(_loc13_ && !param2)
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
      
      override public function complete(param1:Boolean = false, param2:Boolean = false) : void
      {
         super.complete(param1,param2);
         if(_dispatcher && !param2)
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
      
      public function getActive(param1:Boolean = true, param2:Boolean = true, param3:Boolean = false) : Array
      {
         var _loc8_:int = 0;
         var _loc5_:Array = [];
         var _loc7_:Array = getChildren(param1,param2,param3);
         var _loc6_:int = _loc7_.length;
         var _loc4_:int = 0;
         _loc8_ = 0;
         while(_loc8_ < _loc6_)
         {
            if(TweenCore(_loc7_[_loc8_]).active)
            {
               _loc4_++;
               _loc5_[_loc4_] = _loc7_[_loc8_];
            }
            _loc8_ = _loc8_ + 1;
         }
         return _loc5_;
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
      
      public function getLabelAfter(param1:Number = NaN) : String
      {
         var _loc4_:int = 0;
         if(!param1 && param1 != 0)
         {
            param1 = this.cachedTime;
         }
         var _loc2_:Array = getLabelsArray();
         var _loc3_:int = _loc2_.length;
         _loc4_ = 0;
         while(_loc4_ < _loc3_)
         {
            if(_loc2_[_loc4_].time > param1)
            {
               return _loc2_[_loc4_].name;
            }
            _loc4_ = _loc4_ + 1;
         }
         return null;
      }
      
      public function getLabelBefore(param1:Number = NaN) : String
      {
         if(!param1 && param1 != 0)
         {
            param1 = this.cachedTime;
         }
         var _loc2_:Array = getLabelsArray();
         var _loc3_:int = _loc2_.length;
         while(true)
         {
            _loc3_--;
            if(_loc3_ <= -1)
            {
               break;
            }
            if(_loc2_[_loc3_].time < param1)
            {
               return _loc2_[_loc3_].name;
            }
         }
         return null;
      }
      
      protected function getLabelsArray() : Array
      {
         var _loc2_:Array = [];
         var _loc4_:int = 0;
         var _loc3_:* = _labels;
         for(var _loc1_ in _labels)
         {
            _loc2_[_loc2_.length] = {
               "time":_labels[_loc1_],
               "name":_loc1_
            };
         }
         _loc2_.sortOn("time",16);
         return _loc2_;
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
      
      public function addEventListener(param1:String, param2:Function, param3:Boolean = false, param4:int = 0, param5:Boolean = false) : void
      {
         if(_dispatcher == null)
         {
            initDispatcher();
         }
         if(param1 == "change")
         {
            _hasUpdateListener = true;
         }
         _dispatcher.addEventListener(param1,param2,param3,param4,param5);
      }
      
      public function removeEventListener(param1:String, param2:Function, param3:Boolean = false) : void
      {
         if(_dispatcher != null)
         {
            _dispatcher.removeEventListener(param1,param2,param3);
         }
      }
      
      public function hasEventListener(param1:String) : Boolean
      {
         return _dispatcher == null?false:Boolean(_dispatcher.hasEventListener(param1));
      }
      
      public function willTrigger(param1:String) : Boolean
      {
         return _dispatcher == null?false:Boolean(_dispatcher.willTrigger(param1));
      }
      
      public function dispatchEvent(param1:Event) : Boolean
      {
         return _dispatcher == null?false:Boolean(_dispatcher.dispatchEvent(param1));
      }
      
      public function get totalProgress() : Number
      {
         return this.cachedTotalTime / this.totalDuration;
      }
      
      public function set totalProgress(param1:Number) : void
      {
         setTotalTime(this.totalDuration * param1,false);
      }
      
      override public function get totalDuration() : Number
      {
         var _loc1_:Number = NaN;
         if(this.cacheIsDirty)
         {
            _loc1_ = super.totalDuration;
            this.cachedTotalDuration = _repeat == -1?999999999999:Number(this.cachedDuration * (_repeat + 1) + _repeatDelay * _repeat);
         }
         return this.cachedTotalDuration;
      }
      
      override public function set currentTime(param1:Number) : void
      {
         if(_cyclesComplete == 0)
         {
            setTotalTime(param1,false);
         }
         else if(this.yoyo && _cyclesComplete % 2 == 1)
         {
            setTotalTime(this.duration - param1 + _cyclesComplete * (this.cachedDuration + _repeatDelay),false);
         }
         else
         {
            setTotalTime(param1 + _cyclesComplete * (this.duration + _repeatDelay),false);
         }
      }
      
      public function get repeat() : int
      {
         return _repeat;
      }
      
      public function set repeat(param1:int) : void
      {
         _repeat = param1;
         setDirtyCache(true);
      }
      
      public function get repeatDelay() : Number
      {
         return _repeatDelay;
      }
      
      public function set repeatDelay(param1:Number) : void
      {
         _repeatDelay = param1;
         setDirtyCache(true);
      }
      
      public function get currentLabel() : String
      {
         return getLabelBefore(this.cachedTime + 1.0e-8);
      }
   }
}
