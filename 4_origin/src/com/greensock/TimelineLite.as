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
      
      public function TimelineLite(param1:Object = null)
      {
         super(param1);
         _endCaps = [null,null];
         _labels = {};
         this.autoRemoveChildren = this.vars.autoRemoveChildren == true;
         _hasUpdate = typeof this.vars.onUpdate == "function";
         if(this.vars.tweens is Array)
         {
            this.insertMultiple(this.vars.tweens,0,this.vars.align != null?this.vars.align:"normal",!!this.vars.stagger?Number(this.vars.stagger):0);
         }
      }
      
      override public function remove(param1:TweenCore, param2:Boolean = false) : void
      {
         if(param1.cachedOrphan)
         {
            return;
         }
         if(!param2)
         {
            param1.setEnabled(false,true);
         }
         var _loc4_:TweenCore = !!this.gc?_endCaps[0]:_firstChild;
         var _loc3_:TweenCore = !!this.gc?_endCaps[1]:_lastChild;
         if(param1.nextNode)
         {
            param1.nextNode.prevNode = param1.prevNode;
         }
         else if(_loc3_ == param1)
         {
            _loc3_ = param1.prevNode;
         }
         if(param1.prevNode)
         {
            param1.prevNode.nextNode = param1.nextNode;
         }
         else if(_loc4_ == param1)
         {
            _loc4_ = param1.nextNode;
         }
         if(this.gc)
         {
            _endCaps[0] = _loc4_;
            _endCaps[1] = _loc3_;
         }
         else
         {
            _firstChild = _loc4_;
            _lastChild = _loc3_;
         }
         param1.cachedOrphan = true;
         setDirtyCache(true);
      }
      
      override public function insert(param1:TweenCore, param2:* = 0) : TweenCore
      {
         var _loc5_:* = null;
         var _loc3_:* = null;
         if(typeof param2 == "string")
         {
            if(!(param2 in _labels))
            {
               addLabel(param2,this.duration);
            }
            param2 = Number(_labels[param2]);
         }
         if(!param1.cachedOrphan && param1.timeline)
         {
            param1.timeline.remove(param1,true);
         }
         param1.timeline = this;
         param1.cachedStartTime = Number(param2) + param1.delay;
         if(param1.cachedPaused)
         {
            param1.cachedPauseTime = param1.cachedStartTime + (this.rawTime - param1.cachedStartTime) / param1.cachedTimeScale;
         }
         if(param1.gc)
         {
            param1.setEnabled(true,true);
         }
         setDirtyCache(true);
         var _loc7_:* = !!this.gc?_endCaps[0]:_firstChild;
         var _loc4_:* = !!this.gc?_endCaps[1]:_lastChild;
         if(_loc4_ == null)
         {
            _loc4_ = param1;
            _loc7_ = _loc4_;
            var _loc8_:* = null;
            param1.prevNode = _loc8_;
            param1.nextNode = _loc8_;
         }
         else
         {
            _loc5_ = _loc4_;
            var _loc6_:Number = param1.cachedStartTime;
            while(_loc5_ != null && _loc6_ < _loc5_.cachedStartTime)
            {
               _loc5_ = _loc5_.prevNode;
            }
            if(_loc5_ == null)
            {
               _loc7_.prevNode = param1;
               param1.nextNode = _loc7_;
               param1.prevNode = null;
               _loc7_ = param1;
            }
            else
            {
               if(_loc5_.nextNode)
               {
                  _loc5_.nextNode.prevNode = param1;
               }
               else if(_loc5_ == _loc4_)
               {
                  _loc4_ = param1;
               }
               param1.prevNode = _loc5_;
               param1.nextNode = _loc5_.nextNode;
               _loc5_.nextNode = param1;
            }
         }
         param1.cachedOrphan = false;
         if(this.gc)
         {
            _endCaps[0] = _loc7_;
            _endCaps[1] = _loc4_;
         }
         else
         {
            _firstChild = _loc7_;
            _lastChild = _loc4_;
         }
         if(this.gc && this.cachedStartTime + (param1.cachedStartTime + param1.cachedTotalDuration / param1.cachedTimeScale) / this.cachedTimeScale > this.timeline.cachedTime)
         {
            this.setEnabled(true,false);
            _loc3_ = this.timeline;
            while(_loc3_.gc && _loc3_.timeline)
            {
               if(_loc3_.cachedStartTime + _loc3_.totalDuration / _loc3_.cachedTimeScale > _loc3_.timeline.cachedTime)
               {
                  _loc3_.setEnabled(true,false);
               }
               _loc3_ = _loc3_.timeline;
            }
         }
         return param1;
      }
      
      public function append(param1:TweenCore, param2:Number = 0) : TweenCore
      {
         return insert(param1,this.duration + param2);
      }
      
      public function prepend(param1:TweenCore, param2:Boolean = false) : TweenCore
      {
         shiftChildren(param1.totalDuration / param1.cachedTimeScale + param1.delay,param2,0);
         return insert(param1,0);
      }
      
      public function insertMultiple(param1:Array, param2:* = 0, param3:String = "normal", param4:Number = 0) : Array
      {
         var _loc5_:* = null;
         var _loc8_:int = 0;
         var _loc6_:Number = Number(param2) || 0;
         var _loc7_:int = param1.length;
         if(typeof param2 == "string")
         {
            if(!(param2 in _labels))
            {
               addLabel(param2,this.duration);
            }
            _loc6_ = _labels[param2];
         }
         _loc8_ = 0;
         while(_loc8_ < _loc7_)
         {
            _loc5_ = param1[_loc8_] as TweenCore;
            insert(_loc5_,_loc6_);
            if(param3 == "sequence")
            {
               _loc6_ = _loc5_.cachedStartTime + _loc5_.totalDuration / _loc5_.cachedTimeScale;
            }
            else if(param3 == "start")
            {
               _loc5_.cachedStartTime = _loc5_.cachedStartTime - _loc5_.delay;
            }
            _loc6_ = _loc6_ + param4;
            _loc8_ = _loc8_ + 1;
         }
         return param1;
      }
      
      public function appendMultiple(param1:Array, param2:Number = 0, param3:String = "normal", param4:Number = 0) : Array
      {
         return insertMultiple(param1,this.duration + param2,param3,param4);
      }
      
      public function prependMultiple(param1:Array, param2:String = "normal", param3:Number = 0, param4:Boolean = false) : Array
      {
         var _loc5_:TimelineLite = new TimelineLite({
            "tweens":param1,
            "align":param2,
            "stagger":param3
         });
         shiftChildren(_loc5_.duration,param4,0);
         insertMultiple(param1,0,param2,param3);
         _loc5_.kill();
         return param1;
      }
      
      public function addLabel(param1:String, param2:Number) : void
      {
         _labels[param1] = param2;
      }
      
      public function removeLabel(param1:String) : Number
      {
         var _loc2_:Number = _labels[param1];
         delete _labels[param1];
         return _loc2_;
      }
      
      public function getLabelTime(param1:String) : Number
      {
         return param1 in _labels?Number(_labels[param1]):-1;
      }
      
      protected function parseTimeOrLabel(param1:*) : Number
      {
         if(typeof param1 == "string")
         {
            if(!(param1 in _labels))
            {
               throw new Error("TimelineLite error: the " + param1 + " label was not found.");
            }
            return getLabelTime(String(param1));
         }
         return Number(param1);
      }
      
      public function stop() : void
      {
         this.paused = true;
      }
      
      public function gotoAndPlay(param1:*, param2:Boolean = true) : void
      {
         setTotalTime(parseTimeOrLabel(param1),param2);
         play();
      }
      
      public function gotoAndStop(param1:*, param2:Boolean = true) : void
      {
         setTotalTime(parseTimeOrLabel(param1),param2);
         this.paused = true;
      }
      
      public function goto_(param1:*, param2:Boolean = true) : void
      {
         setTotalTime(parseTimeOrLabel(param1),param2);
      }
      
      override public function renderTime(param1:Number, param2:Boolean = false, param3:Boolean = false) : void
      {
         var _loc5_:* = null;
         var _loc4_:* = false;
         var _loc9_:Boolean = false;
         var _loc6_:* = null;
         var _loc11_:Number = NaN;
         if(this.gc)
         {
            this.setEnabled(true,false);
         }
         else if(!this.active && !this.cachedPaused)
         {
            this.active = true;
         }
         var _loc8_:Number = !!this.cacheIsDirty?this.totalDuration:Number(this.cachedTotalDuration);
         var _loc13_:Number = this.cachedTime;
         var _loc12_:Number = this.cachedStartTime;
         var _loc7_:Number = this.cachedTimeScale;
         var _loc10_:Boolean = this.cachedPaused;
         if(param1 >= _loc8_)
         {
            if(_rawPrevTime <= _loc8_ && _rawPrevTime != param1)
            {
               var _loc14_:* = _loc8_;
               this.cachedTime = _loc14_;
               this.cachedTotalTime = _loc14_;
               forceChildrenToEnd(_loc8_,param2);
               _loc4_ = !this.hasPausedChild();
               _loc9_ = true;
               if(this.cachedDuration == 0 && _loc4_ && (param1 == 0 || _rawPrevTime < 0))
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
                  _loc4_ = true;
               }
            }
            else if(param1 == 0 && !this.initted)
            {
               param3 = true;
            }
            if(_rawPrevTime >= 0 && _rawPrevTime != param1)
            {
               forceChildrenToBeginning(0,param2);
               this.cachedTotalTime = 0;
               this.cachedTime = 0;
               _loc9_ = true;
               if(this.cachedReversed)
               {
                  _loc4_ = true;
               }
            }
         }
         else
         {
            _loc14_ = param1;
            this.cachedTime = _loc14_;
            this.cachedTotalTime = _loc14_;
         }
         _rawPrevTime = param1;
         if(this.cachedTime == _loc13_ && !param3)
         {
            return;
         }
         if(!this.initted)
         {
            this.initted = true;
         }
         if(_loc13_ == 0 && this.vars.onStart && this.cachedTime != 0 && !param2)
         {
            this.vars.onStart.apply(null,this.vars.onStartParams);
         }
         if(!_loc9_)
         {
            if(this.cachedTime - _loc13_ > 0)
            {
               _loc5_ = _firstChild;
               while(_loc5_)
               {
                  _loc6_ = _loc5_.nextNode;
                  if(!(this.cachedPaused && !_loc10_))
                  {
                     if(_loc5_.active || !_loc5_.cachedPaused && _loc5_.cachedStartTime <= this.cachedTime && !_loc5_.gc)
                     {
                        if(!_loc5_.cachedReversed)
                        {
                           _loc5_.renderTime((this.cachedTime - _loc5_.cachedStartTime) * _loc5_.cachedTimeScale,param2,false);
                        }
                        else
                        {
                           _loc11_ = !!_loc5_.cacheIsDirty?_loc5_.totalDuration:Number(_loc5_.cachedTotalDuration);
                           _loc5_.renderTime(_loc11_ - (this.cachedTime - _loc5_.cachedStartTime) * _loc5_.cachedTimeScale,param2,false);
                        }
                     }
                     _loc5_ = _loc6_;
                     continue;
                  }
                  break;
               }
            }
            else
            {
               _loc5_ = _lastChild;
               while(_loc5_)
               {
                  _loc6_ = _loc5_.prevNode;
                  if(!(this.cachedPaused && !_loc10_))
                  {
                     if(_loc5_.active || !_loc5_.cachedPaused && _loc5_.cachedStartTime <= _loc13_ && !_loc5_.gc)
                     {
                        if(!_loc5_.cachedReversed)
                        {
                           _loc5_.renderTime((this.cachedTime - _loc5_.cachedStartTime) * _loc5_.cachedTimeScale,param2,false);
                        }
                        else
                        {
                           _loc11_ = !!_loc5_.cacheIsDirty?_loc5_.totalDuration:Number(_loc5_.cachedTotalDuration);
                           _loc5_.renderTime(_loc11_ - (this.cachedTime - _loc5_.cachedStartTime) * _loc5_.cachedTimeScale,param2,false);
                        }
                     }
                     _loc5_ = _loc6_;
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
         if(_loc4_ && (_loc12_ == this.cachedStartTime || _loc7_ != this.cachedTimeScale) && (_loc8_ >= this.totalDuration || this.cachedTime == 0))
         {
            complete(true,param2);
         }
      }
      
      protected function forceChildrenToBeginning(param1:Number, param2:Boolean = false) : Number
      {
         var _loc5_:* = null;
         var _loc4_:Number = NaN;
         var _loc3_:* = _lastChild;
         var _loc6_:Boolean = this.cachedPaused;
         while(_loc3_)
         {
            _loc5_ = _loc3_.prevNode;
            if(!(this.cachedPaused && !_loc6_))
            {
               if(_loc3_.active || !_loc3_.cachedPaused && !_loc3_.gc && (_loc3_.cachedTotalTime != 0 || _loc3_.cachedDuration == 0))
               {
                  if(param1 == 0 && (_loc3_.cachedDuration != 0 || _loc3_.cachedStartTime == 0))
                  {
                     _loc3_.renderTime(!!_loc3_.cachedReversed?_loc3_.cachedTotalDuration:0,param2,false);
                  }
                  else if(!_loc3_.cachedReversed)
                  {
                     _loc3_.renderTime((param1 - _loc3_.cachedStartTime) * _loc3_.cachedTimeScale,param2,false);
                  }
                  else
                  {
                     _loc4_ = !!_loc3_.cacheIsDirty?_loc3_.totalDuration:Number(_loc3_.cachedTotalDuration);
                     _loc3_.renderTime(_loc4_ - (param1 - _loc3_.cachedStartTime) * _loc3_.cachedTimeScale,param2,false);
                  }
               }
               _loc3_ = _loc5_;
               continue;
            }
            break;
         }
         return param1;
      }
      
      protected function forceChildrenToEnd(param1:Number, param2:Boolean = false) : Number
      {
         var _loc5_:* = null;
         var _loc4_:Number = NaN;
         var _loc3_:* = _firstChild;
         var _loc6_:Boolean = this.cachedPaused;
         while(_loc3_)
         {
            _loc5_ = _loc3_.nextNode;
            if(!(this.cachedPaused && !_loc6_))
            {
               if(_loc3_.active || !_loc3_.cachedPaused && !_loc3_.gc && (_loc3_.cachedTotalTime != _loc3_.cachedTotalDuration || _loc3_.cachedDuration == 0))
               {
                  if(param1 == this.cachedDuration && (_loc3_.cachedDuration != 0 || _loc3_.cachedStartTime == this.cachedDuration))
                  {
                     _loc3_.renderTime(!!_loc3_.cachedReversed?0:Number(_loc3_.cachedTotalDuration),param2,false);
                  }
                  else if(!_loc3_.cachedReversed)
                  {
                     _loc3_.renderTime((param1 - _loc3_.cachedStartTime) * _loc3_.cachedTimeScale,param2,false);
                  }
                  else
                  {
                     _loc4_ = !!_loc3_.cacheIsDirty?_loc3_.totalDuration:Number(_loc3_.cachedTotalDuration);
                     _loc3_.renderTime(_loc4_ - (param1 - _loc3_.cachedStartTime) * _loc3_.cachedTimeScale,param2,false);
                  }
               }
               _loc3_ = _loc5_;
               continue;
            }
            break;
         }
         return param1;
      }
      
      public function hasPausedChild() : Boolean
      {
         var _loc1_:TweenCore = !!this.gc?_endCaps[0]:_firstChild;
         while(_loc1_)
         {
            if(_loc1_.cachedPaused || _loc1_ is TimelineLite && (_loc1_ as TimelineLite).hasPausedChild())
            {
               return true;
            }
            _loc1_ = _loc1_.nextNode;
         }
         return false;
      }
      
      public function getChildren(param1:Boolean = true, param2:Boolean = true, param3:Boolean = true, param4:Number = -9.999999999E9) : Array
      {
         var _loc7_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:TweenCore = !!this.gc?_endCaps[0]:_firstChild;
         while(_loc5_)
         {
            if(_loc5_.cachedStartTime >= param4)
            {
               if(_loc5_ is TweenLite)
               {
                  if(param2)
                  {
                     _loc6_++;
                     _loc7_[_loc6_] = _loc5_;
                  }
               }
               else
               {
                  if(param3)
                  {
                     _loc6_++;
                     _loc7_[_loc6_] = _loc5_;
                  }
                  if(param1)
                  {
                     _loc7_ = _loc7_.concat(TimelineLite(_loc5_).getChildren(true,param2,param3));
                  }
               }
            }
            _loc5_ = _loc5_.nextNode;
         }
         return _loc7_;
      }
      
      public function getTweensOf(param1:Object, param2:Boolean = true) : Array
      {
         var _loc7_:int = 0;
         var _loc6_:Array = getChildren(param2,true,false);
         var _loc4_:Array = [];
         var _loc5_:int = _loc6_.length;
         var _loc3_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _loc5_)
         {
            if(TweenLite(_loc6_[_loc7_]).target == param1)
            {
               _loc3_++;
               _loc4_[_loc3_] = _loc6_[_loc7_];
            }
            _loc7_ = _loc7_ + 1;
         }
         return _loc4_;
      }
      
      public function shiftChildren(param1:Number, param2:Boolean = false, param3:Number = 0) : void
      {
         var _loc4_:TweenCore = !!this.gc?_endCaps[0]:_firstChild;
         while(_loc4_)
         {
            if(_loc4_.cachedStartTime >= param3)
            {
               _loc4_.cachedStartTime = _loc4_.cachedStartTime + param1;
            }
            _loc4_ = _loc4_.nextNode;
         }
         if(param2)
         {
            var _loc9_:int = 0;
            var _loc8_:* = _labels;
            for(var _loc5_ in _labels)
            {
               if(_labels[_loc5_] >= param3)
               {
                  var _loc6_:* = _loc5_;
                  var _loc7_:* = _labels[_loc6_] + param1;
                  _labels[_loc6_] = _loc7_;
               }
            }
         }
         this.setDirtyCache(true);
      }
      
      public function killTweensOf(param1:Object, param2:Boolean = true, param3:Object = null) : Boolean
      {
         var _loc4_:* = null;
         var _loc5_:Array = getTweensOf(param1,param2);
         var _loc6_:int = _loc5_.length;
         while(true)
         {
            _loc6_--;
            if(_loc6_ <= -1)
            {
               break;
            }
            _loc4_ = _loc5_[_loc6_];
            if(param3 != null)
            {
               _loc4_.killVars(param3);
            }
            if(param3 == null || _loc4_.cachedPT1 == null && _loc4_.initted)
            {
               _loc4_.setEnabled(false,false);
            }
         }
         return _loc5_.length > 0;
      }
      
      override public function invalidate() : void
      {
         var _loc1_:TweenCore = !!this.gc?_endCaps[0]:_firstChild;
         while(_loc1_)
         {
            _loc1_.invalidate();
            _loc1_ = _loc1_.nextNode;
         }
      }
      
      public function clear(param1:Array = null) : void
      {
         if(param1 == null)
         {
            param1 = getChildren(false,true,true);
         }
         var _loc2_:int = param1.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= -1)
            {
               break;
            }
            TweenCore(param1[_loc2_]).setEnabled(false,false);
         }
      }
      
      override public function setEnabled(param1:Boolean, param2:Boolean = false) : Boolean
      {
         var _loc3_:* = null;
         if(param1 == this.gc)
         {
            if(param1)
            {
               _loc3_ = _endCaps[0];
               _firstChild = _endCaps[0];
               _lastChild = _endCaps[1];
               _endCaps = [null,null];
            }
            else
            {
               _loc3_ = _firstChild;
               _endCaps = [_firstChild,_lastChild];
               _lastChild = null;
               _firstChild = null;
            }
            while(_loc3_)
            {
               _loc3_.setEnabled(param1,true);
               _loc3_ = _loc3_.nextNode;
            }
         }
         return super.setEnabled(param1,param2);
      }
      
      public function get currentProgress() : Number
      {
         return this.cachedTime / this.duration;
      }
      
      public function set currentProgress(param1:Number) : void
      {
         setTotalTime(this.duration * param1,false);
      }
      
      override public function get duration() : Number
      {
         var _loc1_:Number = NaN;
         if(this.cacheIsDirty)
         {
            _loc1_ = this.totalDuration;
         }
         return this.cachedDuration;
      }
      
      override public function set duration(param1:Number) : void
      {
         if(this.duration != 0 && param1 != 0)
         {
            this.timeScale = this.duration / param1;
         }
      }
      
      override public function get totalDuration() : Number
      {
         var _loc5_:Number = NaN;
         var _loc3_:* = null;
         var _loc1_:* = NaN;
         if(this.cacheIsDirty)
         {
            _loc1_ = 0;
            var _loc2_:* = !!this.gc?_endCaps[0]:_firstChild;
            var _loc4_:* = -Infinity;
            while(_loc2_)
            {
               _loc3_ = _loc2_.nextNode;
               if(_loc2_.cachedStartTime < _loc4_)
               {
                  this.insert(_loc2_,_loc2_.cachedStartTime - _loc2_.delay);
                  _loc4_ = Number(_loc2_.prevNode.cachedStartTime);
               }
               else
               {
                  _loc4_ = Number(_loc2_.cachedStartTime);
               }
               if(_loc2_.cachedStartTime < 0)
               {
                  _loc1_ = Number(_loc1_ - _loc2_.cachedStartTime);
                  this.shiftChildren(-_loc2_.cachedStartTime,false,-9999999999);
               }
               _loc5_ = _loc2_.cachedStartTime + _loc2_.totalDuration / _loc2_.cachedTimeScale;
               if(_loc5_ > _loc1_)
               {
                  _loc1_ = _loc5_;
               }
               _loc2_ = _loc3_;
            }
            var _loc6_:* = _loc1_;
            this.cachedTotalDuration = _loc6_;
            this.cachedDuration = _loc6_;
            this.cacheIsDirty = false;
         }
         return this.cachedTotalDuration;
      }
      
      override public function set totalDuration(param1:Number) : void
      {
         if(this.totalDuration != 0 && param1 != 0)
         {
            this.timeScale = this.totalDuration / param1;
         }
      }
      
      public function get timeScale() : Number
      {
         return this.cachedTimeScale;
      }
      
      public function set timeScale(param1:Number) : void
      {
         if(param1 == 0)
         {
            param1 = 0.0001;
         }
         var _loc2_:Number = this.cachedPauseTime || this.cachedPauseTime == 0?this.cachedPauseTime:Number(this.timeline.cachedTotalTime);
         this.cachedStartTime = _loc2_ - (_loc2_ - this.cachedStartTime) * this.cachedTimeScale / param1;
         this.cachedTimeScale = param1;
         setDirtyCache(false);
      }
      
      public function get useFrames() : Boolean
      {
         var _loc1_:SimpleTimeline = this.timeline;
         while(_loc1_.timeline)
         {
            _loc1_ = _loc1_.timeline;
         }
         return _loc1_ == TweenLite.rootFramesTimeline;
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
