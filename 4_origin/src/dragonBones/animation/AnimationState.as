package dragonBones.animation
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.Slot;
   import dragonBones.§core:dragonBones_internal§._group;
   import dragonBones.§core:dragonBones_internal§._layer;
   import dragonBones.§core:dragonBones_internal§.resetTimelineStateList;
   import dragonBones.§core:dragonBones_internal§.updateTimelineStates;
   import dragonBones.events.AnimationEvent;
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SlotTimeline;
   import dragonBones.objects.TransformTimeline;
   
   public final class AnimationState
   {
      
      private static var _pool:Vector.<AnimationState> = new Vector.<AnimationState>();
       
      
      public var displayControl:Boolean;
      
      public var additiveBlending:Boolean;
      
      public var autoFadeOut:Boolean;
      
      public var fadeOutTime:Number;
      
      public var weight:Number;
      
      public var autoTween:Boolean;
      
      public var lastFrameAutoTween:Boolean;
      
      var _layer:int;
      
      var _group:String;
      
      private var _armature:Armature;
      
      private var _timelineStateList:Vector.<TimelineState>;
      
      private var _slotTimelineStateList:Vector.<SlotTimelineState>;
      
      private var _boneMasks:Vector.<String>;
      
      private var _isPlaying:Boolean;
      
      private var _time:Number;
      
      private var _currentFrameIndex:int;
      
      private var _currentFramePosition:int;
      
      private var _currentFrameDuration:int;
      
      private var _pausePlayheadInFade:Boolean;
      
      private var _isFadeOut:Boolean;
      
      private var _fadeTotalWeight:Number;
      
      private var _fadeWeight:Number;
      
      private var _fadeCurrentTime:Number;
      
      private var _fadeBeginTime:Number;
      
      private var _name:String;
      
      private var _clip:AnimationData;
      
      private var _isComplete:Boolean;
      
      private var _currentPlayTimes:int;
      
      private var _totalTime:int;
      
      private var _currentTime:int;
      
      private var _lastTime:int;
      
      private var _fadeState:int;
      
      private var _fadeTotalTime:Number;
      
      private var _timeScale:Number;
      
      private var _playTimes:int;
      
      public function AnimationState()
      {
         super();
         _timelineStateList = new Vector.<TimelineState>();
         _slotTimelineStateList = new Vector.<SlotTimelineState>();
         _boneMasks = new Vector.<String>();
      }
      
      static function borrowObject() : AnimationState
      {
         if(_pool.length == 0)
         {
            return new AnimationState();
         }
         return _pool.pop();
      }
      
      static function returnObject(param1:AnimationState) : void
      {
         param1.clear();
         if(_pool.indexOf(param1) < 0)
         {
            _pool[_pool.length] = param1;
         }
      }
      
      static function clear() : void
      {
         var _loc1_:int = _pool.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _pool[_loc1_].clear();
         }
         _pool.length = 0;
         TimelineState.clear();
      }
      
      private function clear() : void
      {
         resetTimelineStateList();
         _boneMasks.length = 0;
         _armature = null;
         _clip = null;
      }
      
      function resetTimelineStateList() : void
      {
         var _loc1_:int = _timelineStateList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            TimelineState.returnObject(_timelineStateList[_loc1_]);
         }
         _timelineStateList.length = 0;
         _loc1_ = _slotTimelineStateList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            SlotTimelineState.returnObject(_slotTimelineStateList[_loc1_]);
         }
         _slotTimelineStateList.length = 0;
      }
      
      public function containsBoneMask(param1:String) : Boolean
      {
         return _boneMasks.length == 0 || _boneMasks.indexOf(param1) >= 0;
      }
      
      public function addBoneMask(param1:String, param2:Boolean = true) : AnimationState
      {
         var _loc3_:* = null;
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         addBoneToBoneMask(param1);
         if(param2)
         {
            _loc3_ = _armature.getBone(param1);
            if(_loc3_)
            {
               _loc5_ = _armature.getBones(false);
               _loc6_ = _loc5_.length;
               while(true)
               {
                  _loc6_--;
                  if(!_loc6_)
                  {
                     break;
                  }
                  _loc4_ = _loc5_[_loc6_];
                  if(_loc3_.contains(_loc4_))
                  {
                     addBoneToBoneMask(_loc4_.name);
                  }
               }
            }
         }
         updateTimelineStates();
         return this;
      }
      
      public function removeBoneMask(param1:String, param2:Boolean = true) : AnimationState
      {
         var _loc3_:* = null;
         var _loc5_:* = undefined;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         removeBoneFromBoneMask(param1);
         if(param2)
         {
            _loc3_ = _armature.getBone(param1);
            if(_loc3_)
            {
               _loc5_ = _armature.getBones(false);
               _loc6_ = _loc5_.length;
               while(true)
               {
                  _loc6_--;
                  if(!_loc6_)
                  {
                     break;
                  }
                  _loc4_ = _loc5_[_loc6_];
                  if(_loc3_.contains(_loc4_))
                  {
                     removeBoneFromBoneMask(_loc4_.name);
                  }
               }
            }
         }
         updateTimelineStates();
         return this;
      }
      
      public function removeAllMixingTransform() : AnimationState
      {
         _boneMasks.length = 0;
         updateTimelineStates();
         return this;
      }
      
      private function addBoneToBoneMask(param1:String) : void
      {
         if(_clip.getTimeline(param1) && _boneMasks.indexOf(param1) < 0)
         {
            _boneMasks.push(param1);
         }
      }
      
      private function removeBoneFromBoneMask(param1:String) : void
      {
         var _loc2_:int = _boneMasks.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _boneMasks.splice(_loc2_,1);
         }
      }
      
      function updateTimelineStates() : void
      {
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc6_:int = _timelineStateList.length;
         while(true)
         {
            _loc6_--;
            if(!_loc6_)
            {
               break;
            }
            _loc5_ = _timelineStateList[_loc6_];
            if(!_armature.getBone(_loc5_.name))
            {
               removeTimelineState(_loc5_);
            }
         }
         _loc6_ = _slotTimelineStateList.length;
         while(true)
         {
            _loc6_--;
            if(!_loc6_)
            {
               break;
            }
            _loc4_ = _slotTimelineStateList[_loc6_];
            if(!_armature.getSlot(_loc4_.name))
            {
               removeSlotTimelineState(_loc4_);
            }
         }
         if(_boneMasks.length > 0)
         {
            _loc6_ = _timelineStateList.length;
            while(true)
            {
               _loc6_--;
               if(!_loc6_)
               {
                  break;
               }
               _loc5_ = _timelineStateList[_loc6_];
               if(_boneMasks.indexOf(_loc5_.name) < 0)
               {
                  removeTimelineState(_loc5_);
               }
            }
            var _loc8_:int = 0;
            var _loc7_:* = _boneMasks;
            for each(var _loc2_ in _boneMasks)
            {
               addTimelineState(_loc2_);
            }
         }
         else
         {
            var _loc10_:int = 0;
            var _loc9_:* = _clip.timelineList;
            for each(var _loc3_ in _clip.timelineList)
            {
               addTimelineState(_loc3_.name);
            }
         }
         var _loc12_:int = 0;
         var _loc11_:* = _clip.slotTimelineList;
         for each(var _loc1_ in _clip.slotTimelineList)
         {
            addSlotTimelineState(_loc1_.name);
         }
      }
      
      private function addTimelineState(param1:String) : void
      {
         var _loc4_:* = null;
         var _loc2_:Bone = _armature.getBone(param1);
         if(_loc2_)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _timelineStateList;
            for each(var _loc3_ in _timelineStateList)
            {
               if(_loc3_.name == param1)
               {
                  return;
               }
            }
            _loc4_ = TimelineState.borrowObject();
            _loc4_.fadeIn(_loc2_,this,_clip.getTimeline(param1));
            _timelineStateList.push(_loc4_);
         }
      }
      
      private function removeTimelineState(param1:TimelineState) : void
      {
         var _loc2_:int = _timelineStateList.indexOf(param1);
         _timelineStateList.splice(_loc2_,1);
         TimelineState.returnObject(param1);
      }
      
      private function addSlotTimelineState(param1:String) : void
      {
         var _loc3_:* = null;
         var _loc4_:Slot = _armature.getSlot(param1);
         if(_loc4_ && _loc4_.displayList.length > 0)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _slotTimelineStateList;
            for each(var _loc2_ in _slotTimelineStateList)
            {
               if(_loc2_.name == param1)
               {
                  return;
               }
            }
            _loc3_ = SlotTimelineState.borrowObject();
            _loc3_.fadeIn(_loc4_,this,_clip.getSlotTimeline(param1));
            _slotTimelineStateList.push(_loc3_);
         }
      }
      
      private function removeSlotTimelineState(param1:SlotTimelineState) : void
      {
         var _loc2_:int = _slotTimelineStateList.indexOf(param1);
         _slotTimelineStateList.splice(_loc2_,1);
         SlotTimelineState.returnObject(param1);
      }
      
      public function play() : AnimationState
      {
         _isPlaying = true;
         return this;
      }
      
      public function stop() : AnimationState
      {
         _isPlaying = false;
         return this;
      }
      
      function fadeIn(param1:Armature, param2:AnimationData, param3:Number, param4:Number, param5:Number, param6:Boolean) : AnimationState
      {
         _armature = param1;
         _clip = param2;
         _pausePlayheadInFade = param6;
         _name = _clip.name;
         _totalTime = _clip.duration;
         autoTween = _clip.autoTween;
         setTimeScale(param4);
         setPlayTimes(param5);
         _isComplete = false;
         _currentFrameIndex = -1;
         _currentPlayTimes = -1;
         if(Math.round(_totalTime * _clip.frameRate * 0.001) < 2 || param4 == Infinity)
         {
            _currentTime = _totalTime;
         }
         else
         {
            _currentTime = -1;
         }
         _time = 0;
         _boneMasks.length = 0;
         _isFadeOut = false;
         _fadeWeight = 0;
         _fadeTotalWeight = 1;
         _fadeState = -1;
         _fadeCurrentTime = 0;
         _fadeBeginTime = _fadeCurrentTime;
         _fadeTotalTime = param3 * _timeScale;
         _isPlaying = true;
         displayControl = true;
         lastFrameAutoTween = true;
         additiveBlending = false;
         weight = 1;
         fadeOutTime = param3;
         updateTimelineStates();
         return this;
      }
      
      public function fadeOut(param1:Number, param2:Boolean) : AnimationState
      {
         if(!_armature)
         {
            return null;
         }
         if(isNaN(param1) || param1 < 0)
         {
            param1 = 0;
         }
         _pausePlayheadInFade = param2;
         if(_isFadeOut)
         {
            if(param1 > _fadeTotalTime / _timeScale - (_fadeCurrentTime - _fadeBeginTime))
            {
               return this;
            }
         }
         else
         {
            var _loc5_:int = 0;
            var _loc4_:* = _timelineStateList;
            for each(var _loc3_ in _timelineStateList)
            {
               _loc3_.fadeOut();
            }
         }
         _isFadeOut = true;
         _fadeTotalWeight = _fadeWeight;
         _fadeState = -1;
         _fadeBeginTime = _fadeCurrentTime;
         _fadeTotalTime = _fadeTotalWeight >= 0?param1 * _timeScale:0;
         displayControl = false;
         return this;
      }
      
      function advanceTime(param1:Number) : Boolean
      {
         param1 = param1 * _timeScale;
         advanceFadeTime(param1);
         if(_fadeWeight)
         {
            advanceTimelinesTime(param1);
         }
         return _isFadeOut && _fadeState == 1;
      }
      
      private function advanceFadeTime(param1:Number) : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc4_:Boolean = false;
         var _loc5_:Boolean = false;
         if(_fadeBeginTime >= 0)
         {
            _loc2_ = _fadeState;
            _fadeCurrentTime = _fadeCurrentTime + (param1 < 0?-param1:Number(param1));
            if(_fadeCurrentTime >= _fadeBeginTime + _fadeTotalTime)
            {
               if(_fadeWeight == 1 || _fadeWeight == 0)
               {
                  _loc2_ = 1;
                  if(_pausePlayheadInFade)
                  {
                     _pausePlayheadInFade = false;
                     _currentTime = -1;
                  }
               }
               _fadeWeight = !!_isFadeOut?0:1;
            }
            else if(_fadeCurrentTime >= _fadeBeginTime)
            {
               _loc2_ = 0;
               _fadeWeight = (_fadeCurrentTime - _fadeBeginTime) / _fadeTotalTime * _fadeTotalWeight;
               if(_isFadeOut)
               {
                  _fadeWeight = _fadeTotalWeight - _fadeWeight;
               }
            }
            else
            {
               _loc2_ = -1;
               _fadeWeight = !!_isFadeOut?1:0;
            }
            if(_fadeState != _loc2_)
            {
               if(_fadeState == -1)
               {
                  _loc4_ = true;
               }
               if(_loc2_ == 1)
               {
                  _loc5_ = true;
               }
               _fadeState = _loc2_;
            }
         }
         if(_loc4_)
         {
            if(_isFadeOut)
            {
               if(_armature.hasEventListener("fadeOut"))
               {
                  _loc3_ = new AnimationEvent("fadeOut");
                  _loc3_.animationState = this;
                  _armature._eventList.push(_loc3_);
               }
            }
            else
            {
               hideBones();
               if(_armature.hasEventListener("fadeIn"))
               {
                  _loc3_ = new AnimationEvent("fadeIn");
                  _loc3_.animationState = this;
                  _armature._eventList.push(_loc3_);
               }
            }
         }
         if(_loc5_)
         {
            if(_isFadeOut)
            {
               if(_armature.hasEventListener("fadeOutComplete"))
               {
                  _loc3_ = new AnimationEvent("fadeOutComplete");
                  _loc3_.animationState = this;
                  _armature._eventList.push(_loc3_);
               }
            }
            else if(_armature.hasEventListener("fadeInComplete"))
            {
               _loc3_ = new AnimationEvent("fadeInComplete");
               _loc3_.animationState = this;
               _armature._eventList.push(_loc3_);
            }
         }
      }
      
      private function advanceTimelinesTime(param1:Number) : void
      {
         var _loc8_:int = 0;
         var _loc7_:* = null;
         if(_isPlaying && !_pausePlayheadInFade)
         {
            _time = _time + param1;
         }
         var _loc10_:Boolean = false;
         var _loc12_:Boolean = false;
         var _loc6_:Boolean = false;
         var _loc5_:Boolean = false;
         var _loc11_:int = 0;
         var _loc4_:* = int(_time * 1000);
         if(_playTimes == 0)
         {
            _loc5_ = false;
            _loc11_ = Math.ceil(Math.abs(_loc4_) / _totalTime) || 1;
            _loc4_ = int(_loc4_ - int(_loc4_ / _totalTime) * _totalTime);
            if(_loc4_ < 0)
            {
               _loc4_ = int(_loc4_ + _totalTime);
            }
         }
         else
         {
            _loc8_ = _playTimes * _totalTime;
            if(_loc4_ >= _loc8_)
            {
               _loc4_ = _loc8_;
               _loc5_ = true;
            }
            else if(_loc4_ <= -_loc8_)
            {
               _loc4_ = int(-_loc8_);
               _loc5_ = true;
            }
            else
            {
               _loc5_ = false;
            }
            if(_loc4_ < 0)
            {
               _loc4_ = int(_loc4_ + _loc8_);
            }
            _loc11_ = Math.ceil(_loc4_ / _totalTime) || 1;
            _loc4_ = int(_loc4_ - int(_loc4_ / _totalTime) * _totalTime);
            if(_loc5_)
            {
               _loc4_ = int(_totalTime);
            }
         }
         _isComplete = _loc5_;
         var _loc3_:Number = _time * 1000 / _totalTime;
         var _loc14_:int = 0;
         var _loc13_:* = _timelineStateList;
         for each(var _loc9_ in _timelineStateList)
         {
            _loc9_.update(_loc3_);
            _isComplete = _loc9_._isComplete && _isComplete;
         }
         var _loc16_:int = 0;
         var _loc15_:* = _slotTimelineStateList;
         for each(var _loc2_ in _slotTimelineStateList)
         {
            _loc2_.update(_loc3_);
            _isComplete = _loc2_._isComplete && _isComplete;
         }
         if(_currentTime != _loc4_)
         {
            if(_currentPlayTimes != _loc11_)
            {
               if(_currentPlayTimes > 0 && _loc11_ > 1)
               {
                  _loc6_ = true;
               }
               _currentPlayTimes = _loc11_;
            }
            if(_currentTime < 0)
            {
               _loc10_ = true;
            }
            if(_isComplete)
            {
               _loc12_ = true;
            }
            _lastTime = _currentTime;
            _currentTime = _loc4_;
            updateMainTimeline(_loc5_);
         }
         if(_loc10_)
         {
            if(_armature.hasEventListener("start"))
            {
               _loc7_ = new AnimationEvent("start");
               _loc7_.animationState = this;
               _armature._eventList.push(_loc7_);
            }
         }
         if(_loc12_)
         {
            if(_armature.hasEventListener("complete"))
            {
               _loc7_ = new AnimationEvent("complete");
               _loc7_.animationState = this;
               _armature._eventList.push(_loc7_);
            }
            if(autoFadeOut)
            {
               fadeOut(fadeOutTime,true);
            }
         }
         else if(_loc6_)
         {
            if(_armature.hasEventListener("loopComplete"))
            {
               _loc7_ = new AnimationEvent("loopComplete");
               _loc7_.animationState = this;
               _armature._eventList.push(_loc7_);
            }
         }
      }
      
      private function updateMainTimeline(param1:Boolean) : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Vector.<Frame> = _clip.frameList;
         if(_loc4_.length > 0)
         {
            _loc6_ = 0;
            _loc3_ = _clip.frameList.length;
            while(_loc6_ < _loc3_)
            {
               if(_currentFrameIndex < 0)
               {
                  _currentFrameIndex = 0;
               }
               else if(_currentTime < _currentFramePosition || _currentTime >= _currentFramePosition + _currentFrameDuration || _currentTime < _lastTime)
               {
                  _lastTime = _currentTime;
                  _currentFrameIndex = Number(_currentFrameIndex) + 1;
                  if(_currentFrameIndex >= _loc4_.length)
                  {
                     if(param1)
                     {
                        _currentFrameIndex = Number(_currentFrameIndex) - 1;
                        break;
                     }
                     _currentFrameIndex = 0;
                  }
               }
               else
               {
                  break;
               }
               _loc5_ = _loc4_[_currentFrameIndex];
               if(_loc2_)
               {
                  _armature.arriveAtFrame(_loc2_,null,this,true);
               }
               _currentFrameDuration = _loc5_.duration;
               _currentFramePosition = _loc5_.position;
               _loc2_ = _loc5_;
               _loc6_++;
            }
            if(_loc5_)
            {
               _armature.arriveAtFrame(_loc5_,null,this,false);
            }
         }
      }
      
      private function hideBones() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _clip.hideTimelineNameMap;
         for each(var _loc1_ in _clip.hideTimelineNameMap)
         {
            _loc2_ = _armature.getBone(_loc1_);
            if(_loc2_)
            {
               _loc2_.hideSlots();
            }
         }
      }
      
      public function setAdditiveBlending(param1:Boolean) : AnimationState
      {
         additiveBlending = param1;
         return this;
      }
      
      public function setAutoFadeOut(param1:Boolean, param2:Number = -1) : AnimationState
      {
         autoFadeOut = param1;
         if(param2 >= 0)
         {
            this.fadeOutTime = param2 * _timeScale;
         }
         return this;
      }
      
      public function setWeight(param1:Number) : AnimationState
      {
         if(isNaN(param1) || param1 < 0)
         {
            param1 = 1;
         }
         weight = param1;
         return this;
      }
      
      public function setFrameTween(param1:Boolean, param2:Boolean) : AnimationState
      {
         this.autoTween = param1;
         this.lastFrameAutoTween = param2;
         return this;
      }
      
      public function setCurrentTime(param1:Number) : AnimationState
      {
         if(param1 < 0 || isNaN(param1))
         {
            param1 = 0;
         }
         _time = param1;
         _currentTime = _time * 1000;
         return this;
      }
      
      public function setTimeScale(param1:Number) : AnimationState
      {
         if(isNaN(param1) || param1 == Infinity)
         {
            param1 = 1;
         }
         _timeScale = param1;
         return this;
      }
      
      public function setPlayTimes(param1:int) : AnimationState
      {
         if(Math.round(_totalTime * 0.001 * _clip.frameRate) < 2)
         {
            _playTimes = param1 < 0?-1:1;
         }
         else
         {
            _playTimes = param1 < 0?-param1:param1;
         }
         autoFadeOut = param1 < 0?true:false;
         return this;
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function get layer() : int
      {
         return _layer;
      }
      
      public function get group() : String
      {
         return _group;
      }
      
      public function get clip() : AnimationData
      {
         return _clip;
      }
      
      public function get isComplete() : Boolean
      {
         return _isComplete;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying && !_isComplete;
      }
      
      public function get currentPlayTimes() : int
      {
         return _currentPlayTimes < 0?0:_currentPlayTimes;
      }
      
      public function get totalTime() : Number
      {
         return _totalTime * 0.001;
      }
      
      public function get currentTime() : Number
      {
         return _currentTime < 0?0:Number(_currentTime * 0.001);
      }
      
      public function get fadeWeight() : Number
      {
         return _fadeWeight;
      }
      
      public function get fadeState() : int
      {
         return _fadeState;
      }
      
      public function get fadeTotalTime() : Number
      {
         return _fadeTotalTime;
      }
      
      public function get timeScale() : Number
      {
         return _timeScale;
      }
      
      public function get playTimes() : int
      {
         return _playTimes;
      }
   }
}
