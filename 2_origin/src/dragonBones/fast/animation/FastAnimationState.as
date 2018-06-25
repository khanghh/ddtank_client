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
      
      public function setCurrentTime(value:Number) : FastAnimationState
      {
         if(value < 0 || isNaN(value))
         {
            value = 0;
         }
         _time = value;
         _currentTime = _time * 1000;
         return this;
      }
      
      function resetTimelineStateList() : void
      {
         var i:int = _boneTimelineStateList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            FastBoneTimelineState.returnObject(_boneTimelineStateList[i]);
         }
         _boneTimelineStateList.length = 0;
         i = _slotTimelineStateList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            FastSlotTimelineState.returnObject(_slotTimelineStateList[i]);
         }
         _slotTimelineStateList.length = 0;
         name = null;
      }
      
      function fadeIn(aniData:AnimationData, playTimes:Number, timeScale:Number, fadeTotalTime:Number) : void
      {
         animationData = aniData;
         name = animationData.name;
         _totalTime = animationData.duration;
         autoTween = aniData.autoTween;
         setTimeScale(timeScale);
         setPlayTimes(playTimes);
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
         _fadeTotalTime = fadeTotalTime * _timeScale;
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
         var timelineName:* = null;
         var bone:* = null;
         var boneTimelineState:* = null;
         var slot:* = null;
         var slotTimelineState:* = null;
         resetTimelineStateList();
         var _loc9_:int = 0;
         var _loc8_:* = animationData.timelineList;
         for each(var boneTimeline in animationData.timelineList)
         {
            timelineName = boneTimeline.name;
            bone = _armature.getBone(timelineName);
            if(bone)
            {
               boneTimelineState = FastBoneTimelineState.borrowObject();
               boneTimelineState.fadeIn(bone,this,boneTimeline);
               _boneTimelineStateList.push(boneTimelineState);
            }
         }
         var _loc11_:int = 0;
         var _loc10_:* = animationData.slotTimelineList;
         for each(var slotTimeline in animationData.slotTimelineList)
         {
            timelineName = slotTimeline.name;
            slot = _armature.getSlot(timelineName);
            if(slot && slot.displayList.length > 0)
            {
               slotTimelineState = FastSlotTimelineState.borrowObject();
               slotTimelineState.fadeIn(slot,this,slotTimeline);
               _slotTimelineStateList.push(slotTimelineState);
            }
         }
      }
      
      function advanceTime(passedTime:Number) : void
      {
         passedTime = passedTime * _timeScale;
         if(_fading)
         {
            _time = _time + passedTime;
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
            for each(var timeline in _boneTimelineStateList)
            {
               timeline.updateFade(progress);
            }
            var _loc7_:int = 0;
            var _loc6_:* = _slotTimelineStateList;
            for each(var slotTimeline in _slotTimelineStateList)
            {
               slotTimeline.updateFade(progress);
            }
         }
         else
         {
            advanceTimelinesTime(passedTime);
         }
      }
      
      private function advanceTimelinesTime(passedTime:Number) : void
      {
         var event:* = null;
         _time = _time + passedTime;
         var loopCompleteFlg:Boolean = false;
         var completeFlg:Boolean = false;
         var isThisComplete:Boolean = false;
         var currentPlayTimes:int = 0;
         var currentTime:int = _time * 1000;
         if(_playTimes == 0 || currentTime < _playTimes * _totalTime)
         {
            isThisComplete = false;
            _progress = currentTime / _totalTime;
            currentPlayTimes = Math.ceil(progress) || 1;
            _progress = _progress - Math.floor(progress);
            currentTime = currentTime % _totalTime;
         }
         else
         {
            currentPlayTimes = _playTimes;
            currentTime = _totalTime;
            isThisComplete = true;
            _progress = 1;
         }
         _isComplete = isThisComplete;
         if(this.isUseCache())
         {
            animationCache.update(progress);
         }
         else
         {
            updateTransformTimeline(progress);
         }
         if(_currentTime != currentTime)
         {
            if(_currentPlayTimes != currentPlayTimes)
            {
               if(_currentPlayTimes > 0 && currentPlayTimes > 1)
               {
                  loopCompleteFlg = true;
               }
               _currentPlayTimes = currentPlayTimes;
            }
            if(_isComplete)
            {
               completeFlg = true;
            }
            _lastTime = _currentTime;
            _currentTime = currentTime;
            updateMainTimeline(isThisComplete);
         }
         if(completeFlg)
         {
            if(_armature.hasEventListener("complete"))
            {
               event = new AnimationEvent("complete");
               event.animationState = this;
               _armature.addEvent(event);
            }
         }
         else if(loopCompleteFlg)
         {
            if(_armature.hasEventListener("loopComplete"))
            {
               event = new AnimationEvent("loopComplete");
               event.animationState = this;
               _armature.addEvent(event);
            }
         }
      }
      
      private function updateTransformTimeline(progress:Number) : void
      {
         var boneTimeline:* = null;
         var slotTimeline:* = null;
         var i:int = _boneTimelineStateList.length;
         if(_isComplete)
         {
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               boneTimeline = _boneTimelineStateList[i];
               boneTimeline.update(progress);
               _isComplete = boneTimeline._isComplete && _isComplete;
            }
            i = _slotTimelineStateList.length;
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               slotTimeline = _slotTimelineStateList[i];
               slotTimeline.update(progress);
               _isComplete = slotTimeline._isComplete && _isComplete;
            }
         }
         else
         {
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               boneTimeline = _boneTimelineStateList[i];
               boneTimeline.update(progress);
            }
            i = _slotTimelineStateList.length;
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               slotTimeline = _slotTimelineStateList[i];
               slotTimeline.update(progress);
            }
         }
      }
      
      private function updateMainTimeline(isThisComplete:Boolean) : void
      {
         var prevFrame:* = null;
         var currentFrame:* = null;
         var i:int = 0;
         var l:int = 0;
         var frameList:Vector.<Frame> = animationData.frameList;
         if(frameList.length > 0)
         {
            for(i = 0,l = animationData.frameList.length; i < l; )
            {
               if(_currentFrameIndex < 0)
               {
                  _currentFrameIndex = 0;
               }
               else if(_currentTime < _currentFramePosition || _currentTime >= _currentFramePosition + _currentFrameDuration || _currentTime < _lastTime)
               {
                  _lastTime = _currentTime;
                  _currentFrameIndex = Number(_currentFrameIndex) + 1;
                  if(_currentFrameIndex >= frameList.length)
                  {
                     if(isThisComplete)
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
               currentFrame = frameList[_currentFrameIndex];
               if(prevFrame)
               {
                  _armature.arriveAtFrame(prevFrame,this);
               }
               _currentFrameDuration = currentFrame.duration;
               _currentFramePosition = currentFrame.position;
               prevFrame = currentFrame;
               i++;
            }
            if(currentFrame)
            {
               _armature.arriveAtFrame(currentFrame,this);
            }
         }
      }
      
      private function hideBones() : void
      {
         var slot:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = animationData.hideTimelineNameMap;
         for each(var timelineName in animationData.hideTimelineNameMap)
         {
            slot = _armature.getSlot(timelineName);
            if(slot)
            {
               slot.hideSlots();
            }
         }
      }
      
      public function setTimeScale(value:Number) : FastAnimationState
      {
         if(isNaN(value) || value == Infinity)
         {
            value = 1;
         }
         _timeScale = value;
         return this;
      }
      
      public function setPlayTimes(value:int) : FastAnimationState
      {
         if(Math.round(_totalTime * 0.001 * animationData.frameRate) < 2)
         {
            _playTimes = 1;
         }
         else
         {
            _playTimes = value;
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
