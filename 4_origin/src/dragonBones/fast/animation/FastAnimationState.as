package dragonBones.fast.animation
{
   import dragonBones.cache.AnimationCache;
   import dragonBones.core.IAnimationState;
   import dragonBones.§core:dragonBones_internal§._armature;
   import dragonBones.§core:dragonBones_internal§._fadeTotalTime;
   import dragonBones.§core:dragonBones_internal§.resetTimelineStateList;
   import dragonBones.§core:dragonBones_internal§.updateTimelineStateList;
   import dragonBones.events.AnimationEvent;
   import dragonBones.fast.FastArmature;
   import dragonBones.fast.FastBone;
   import dragonBones.fast.FastSlot;
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SlotTimeline;
   import dragonBones.objects.TransformTimeline;
   
   public class FastAnimationState implements IAnimationState
   {
       
      
      public var animationCache:AnimationCache;
      
      public var autoTween:Boolean;
      
      private var _progress:Number;
      
      var _armature:FastArmature;
      
      private var _boneTimelineStateList:Vector.<FastBoneTimelineState>;
      
      private var _slotTimelineStateList:Vector.<FastSlotTimelineState>;
      
      public var animationData:AnimationData;
      
      public var name:String;
      
      private var _time:Number;
      
      private var _currentFrameIndex:int;
      
      private var _currentFramePosition:int;
      
      private var _currentFrameDuration:int;
      
      private var _currentPlayTimes:int;
      
      private var _totalTime:int;
      
      private var _currentTime:int;
      
      private var _lastTime:int;
      
      private var _isComplete:Boolean;
      
      private var _isPlaying:Boolean;
      
      private var _timeScale:Number;
      
      private var _playTimes:int;
      
      private var _fading:Boolean = false;
      
      private var _listenCompleteEvent:Boolean;
      
      private var _listenLoopCompleteEvent:Boolean;
      
      var _fadeTotalTime:Number;
      
      public function FastAnimationState()
      {
         _boneTimelineStateList = new Vector.<FastBoneTimelineState>();
         _slotTimelineStateList = new Vector.<FastSlotTimelineState>();
         super();
      }
      
      public function dispose() : void
      {
         resetTimelineStateList();
         _armature = null;
      }
      
      public function play() : FastAnimationState
      {
         _isPlaying = true;
         return this;
      }
      
      public function stop() : FastAnimationState
      {
         _isPlaying = false;
         return this;
      }
      
      public function setCurrentTime(param1:Number) : FastAnimationState
      {
         if(param1 < 0 || isNaN(param1))
         {
            param1 = 0;
         }
         _time = param1;
         _currentTime = _time * 1000;
         return this;
      }
      
      function resetTimelineStateList() : void
      {
         var _loc1_:int = _boneTimelineStateList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            FastBoneTimelineState.returnObject(_boneTimelineStateList[_loc1_]);
         }
         _boneTimelineStateList.length = 0;
         _loc1_ = _slotTimelineStateList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            FastSlotTimelineState.returnObject(_slotTimelineStateList[_loc1_]);
         }
         _slotTimelineStateList.length = 0;
         name = null;
      }
      
      function fadeIn(param1:AnimationData, param2:Number, param3:Number, param4:Number) : void
      {
         animationData = param1;
         name = animationData.name;
         _totalTime = animationData.duration;
         autoTween = param1.autoTween;
         setTimeScale(param3);
         setPlayTimes(param2);
         _isComplete = false;
         _currentFrameIndex = -1;
         _currentPlayTimes = -1;
         if(Math.round(_totalTime * animationData.frameRate * 0.001) < 2)
         {
            _currentTime = _totalTime;
         }
         else
         {
            _currentTime = -1;
         }
         _fadeTotalTime = param4 * _timeScale;
         _fading = _fadeTotalTime > 0;
         _isPlaying = true;
         _listenCompleteEvent = _armature.hasEventListener("complete");
         if(this._armature.enableCache && animationCache && _fading && _boneTimelineStateList)
         {
            updateTransformTimeline(progress);
         }
         _time = 0;
         _progress = 0;
         updateTimelineStateList();
         hideBones();
      }
      
      function updateTimelineStateList() : void
      {
         var _loc2_:* = null;
         var _loc4_:* = null;
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         resetTimelineStateList();
         var _loc9_:int = 0;
         var _loc8_:* = animationData.timelineList;
         for each(var _loc3_ in animationData.timelineList)
         {
            _loc2_ = _loc3_.name;
            _loc4_ = _armature.getBone(_loc2_);
            if(_loc4_)
            {
               _loc7_ = FastBoneTimelineState.borrowObject();
               _loc7_.fadeIn(_loc4_,this,_loc3_);
               _boneTimelineStateList.push(_loc7_);
            }
         }
         var _loc11_:int = 0;
         var _loc10_:* = animationData.slotTimelineList;
         for each(var _loc1_ in animationData.slotTimelineList)
         {
            _loc2_ = _loc1_.name;
            _loc6_ = _armature.getSlot(_loc2_);
            if(_loc6_ && _loc6_.displayList.length > 0)
            {
               _loc5_ = FastSlotTimelineState.borrowObject();
               _loc5_.fadeIn(_loc6_,this,_loc1_);
               _slotTimelineStateList.push(_loc5_);
            }
         }
      }
      
      function advanceTime(param1:Number) : void
      {
         param1 = param1 * _timeScale;
         if(_fading)
         {
            _time = _time + param1;
            _progress = _time / _fadeTotalTime;
            if(progress >= 1)
            {
               _progress = 0;
               _time = 0;
               _fading = false;
            }
         }
         if(_fading)
         {
            var _loc5_:int = 0;
            var _loc4_:* = _boneTimelineStateList;
            for each(var _loc3_ in _boneTimelineStateList)
            {
               _loc3_.updateFade(progress);
            }
            var _loc7_:int = 0;
            var _loc6_:* = _slotTimelineStateList;
            for each(var _loc2_ in _slotTimelineStateList)
            {
               _loc2_.updateFade(progress);
            }
         }
         else
         {
            advanceTimelinesTime(param1);
         }
      }
      
      private function advanceTimelinesTime(param1:Number) : void
      {
         var _loc5_:* = null;
         _time = _time + param1;
         var _loc4_:Boolean = false;
         var _loc7_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc6_:int = 0;
         var _loc2_:int = _time * 1000;
         if(_playTimes == 0 || _loc2_ < _playTimes * _totalTime)
         {
            _loc3_ = false;
            _progress = _loc2_ / _totalTime;
            _loc6_ = Math.ceil(progress) || 1;
            _progress = _progress - Math.floor(progress);
            _loc2_ = _loc2_ % _totalTime;
         }
         else
         {
            _loc6_ = _playTimes;
            _loc2_ = _totalTime;
            _loc3_ = true;
            _progress = 1;
         }
         _isComplete = _loc3_;
         if(this.isUseCache())
         {
            animationCache.update(progress);
         }
         else
         {
            updateTransformTimeline(progress);
         }
         if(_currentTime != _loc2_)
         {
            if(_currentPlayTimes != _loc6_)
            {
               if(_currentPlayTimes > 0 && _loc6_ > 1)
               {
                  _loc4_ = true;
               }
               _currentPlayTimes = _loc6_;
            }
            if(_isComplete)
            {
               _loc7_ = true;
            }
            _lastTime = _currentTime;
            _currentTime = _loc2_;
            updateMainTimeline(_loc3_);
         }
         if(_loc7_)
         {
            if(_armature.hasEventListener("complete"))
            {
               _loc5_ = new AnimationEvent("complete");
               _loc5_.animationState = this;
               _armature.addEvent(_loc5_);
            }
         }
         else if(_loc4_)
         {
            if(_armature.hasEventListener("loopComplete"))
            {
               _loc5_ = new AnimationEvent("loopComplete");
               _loc5_.animationState = this;
               _armature.addEvent(_loc5_);
            }
         }
      }
      
      private function updateTransformTimeline(param1:Number) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc4_:int = _boneTimelineStateList.length;
         if(_isComplete)
         {
            while(true)
            {
               _loc4_--;
               if(!_loc4_)
               {
                  break;
               }
               _loc3_ = _boneTimelineStateList[_loc4_];
               _loc3_.update(param1);
               _isComplete = _loc3_._isComplete && _isComplete;
            }
            _loc4_ = _slotTimelineStateList.length;
            while(true)
            {
               _loc4_--;
               if(!_loc4_)
               {
                  break;
               }
               _loc2_ = _slotTimelineStateList[_loc4_];
               _loc2_.update(param1);
               _isComplete = _loc2_._isComplete && _isComplete;
            }
         }
         else
         {
            while(true)
            {
               _loc4_--;
               if(!_loc4_)
               {
                  break;
               }
               _loc3_ = _boneTimelineStateList[_loc4_];
               _loc3_.update(param1);
            }
            _loc4_ = _slotTimelineStateList.length;
            while(true)
            {
               _loc4_--;
               if(!_loc4_)
               {
                  break;
               }
               _loc2_ = _slotTimelineStateList[_loc4_];
               _loc2_.update(param1);
            }
         }
      }
      
      private function updateMainTimeline(param1:Boolean) : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc6_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:Vector.<Frame> = animationData.frameList;
         if(_loc4_.length > 0)
         {
            _loc6_ = 0;
            _loc3_ = animationData.frameList.length;
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
                  _armature.arriveAtFrame(_loc2_,this);
               }
               _currentFrameDuration = _loc5_.duration;
               _currentFramePosition = _loc5_.position;
               _loc2_ = _loc5_;
               _loc6_++;
            }
            if(_loc5_)
            {
               _armature.arriveAtFrame(_loc5_,this);
            }
         }
      }
      
      private function hideBones() : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = animationData.hideTimelineNameMap;
         for each(var _loc1_ in animationData.hideTimelineNameMap)
         {
            _loc2_ = _armature.getSlot(_loc1_);
            if(_loc2_)
            {
               _loc2_.hideSlots();
            }
         }
      }
      
      public function setTimeScale(param1:Number) : FastAnimationState
      {
         if(isNaN(param1) || param1 == Infinity)
         {
            param1 = 1;
         }
         _timeScale = param1;
         return this;
      }
      
      public function setPlayTimes(param1:int) : FastAnimationState
      {
         if(Math.round(_totalTime * 0.001 * animationData.frameRate) < 2)
         {
            _playTimes = 1;
         }
         else
         {
            _playTimes = param1;
         }
         return this;
      }
      
      public function get playTimes() : int
      {
         return _playTimes;
      }
      
      public function get currentPlayTimes() : int
      {
         return _currentPlayTimes < 0?0:_currentPlayTimes;
      }
      
      public function get isComplete() : Boolean
      {
         return _isComplete;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying && !_isComplete;
      }
      
      public function get totalTime() : Number
      {
         return _totalTime * 0.001;
      }
      
      public function get currentTime() : Number
      {
         return _currentTime < 0?0:Number(_currentTime * 0.001);
      }
      
      public function isUseCache() : Boolean
      {
         return _armature.enableCache && animationCache && !_fading;
      }
      
      public function get progress() : Number
      {
         return _progress;
      }
   }
}
