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
      
      static function returnObject(animationState:AnimationState) : void
      {
         animationState.clear();
         if(_pool.indexOf(animationState) < 0)
         {
            _pool[_pool.length] = animationState;
         }
      }
      
      static function clear() : void
      {
         var i:int = _pool.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _pool[i].clear();
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
         var i:int = _timelineStateList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            TimelineState.returnObject(_timelineStateList[i]);
         }
         _timelineStateList.length = 0;
         i = _slotTimelineStateList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            SlotTimelineState.returnObject(_slotTimelineStateList[i]);
         }
         _slotTimelineStateList.length = 0;
      }
      
      public function containsBoneMask(boneName:String) : Boolean
      {
         return _boneMasks.length == 0 || _boneMasks.indexOf(boneName) >= 0;
      }
      
      public function addBoneMask(boneName:String, ifInvolveChildBones:Boolean = true) : AnimationState
      {
         var currentBone:* = null;
         var boneList:* = undefined;
         var i:int = 0;
         var tempBone:* = null;
         addBoneToBoneMask(boneName);
         if(ifInvolveChildBones)
         {
            currentBone = _armature.getBone(boneName);
            if(currentBone)
            {
               boneList = _armature.getBones(false);
               i = boneList.length;
               while(true)
               {
                  i--;
                  if(!i)
                  {
                     break;
                  }
                  tempBone = boneList[i];
                  if(currentBone.contains(tempBone))
                  {
                     addBoneToBoneMask(tempBone.name);
                  }
               }
            }
         }
         updateTimelineStates();
         return this;
      }
      
      public function removeBoneMask(boneName:String, ifInvolveChildBones:Boolean = true) : AnimationState
      {
         var currentBone:* = null;
         var boneList:* = undefined;
         var i:int = 0;
         var tempBone:* = null;
         removeBoneFromBoneMask(boneName);
         if(ifInvolveChildBones)
         {
            currentBone = _armature.getBone(boneName);
            if(currentBone)
            {
               boneList = _armature.getBones(false);
               i = boneList.length;
               while(true)
               {
                  i--;
                  if(!i)
                  {
                     break;
                  }
                  tempBone = boneList[i];
                  if(currentBone.contains(tempBone))
                  {
                     removeBoneFromBoneMask(tempBone.name);
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
      
      private function addBoneToBoneMask(boneName:String) : void
      {
         if(_clip.getTimeline(boneName) && _boneMasks.indexOf(boneName) < 0)
         {
            _boneMasks.push(boneName);
         }
      }
      
      private function removeBoneFromBoneMask(boneName:String) : void
      {
         var index:int = _boneMasks.indexOf(boneName);
         if(index >= 0)
         {
            _boneMasks.splice(index,1);
         }
      }
      
      function updateTimelineStates() : void
      {
         var timelineState:* = null;
         var slotTimelineState:* = null;
         var i:int = _timelineStateList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            timelineState = _timelineStateList[i];
            if(!_armature.getBone(timelineState.name))
            {
               removeTimelineState(timelineState);
            }
         }
         i = _slotTimelineStateList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            slotTimelineState = _slotTimelineStateList[i];
            if(!_armature.getSlot(slotTimelineState.name))
            {
               removeSlotTimelineState(slotTimelineState);
            }
         }
         if(_boneMasks.length > 0)
         {
            i = _timelineStateList.length;
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               timelineState = _timelineStateList[i];
               if(_boneMasks.indexOf(timelineState.name) < 0)
               {
                  removeTimelineState(timelineState);
               }
            }
            var _loc8_:int = 0;
            var _loc7_:* = _boneMasks;
            for each(var timelineName in _boneMasks)
            {
               addTimelineState(timelineName);
            }
         }
         else
         {
            var _loc10_:int = 0;
            var _loc9_:* = _clip.timelineList;
            for each(var timeline in _clip.timelineList)
            {
               addTimelineState(timeline.name);
            }
         }
         var _loc12_:int = 0;
         var _loc11_:* = _clip.slotTimelineList;
         for each(var slotTimeline in _clip.slotTimelineList)
         {
            addSlotTimelineState(slotTimeline.name);
         }
      }
      
      private function addTimelineState(timelineName:String) : void
      {
         var timelineState:* = null;
         var bone:Bone = _armature.getBone(timelineName);
         if(bone)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _timelineStateList;
            for each(var eachState in _timelineStateList)
            {
               if(eachState.name == timelineName)
               {
                  return;
               }
            }
            timelineState = TimelineState.borrowObject();
            timelineState.fadeIn(bone,this,_clip.getTimeline(timelineName));
            _timelineStateList.push(timelineState);
         }
      }
      
      private function removeTimelineState(timelineState:TimelineState) : void
      {
         var index:int = _timelineStateList.indexOf(timelineState);
         _timelineStateList.splice(index,1);
         TimelineState.returnObject(timelineState);
      }
      
      private function addSlotTimelineState(timelineName:String) : void
      {
         var timelineState:* = null;
         var slot:Slot = _armature.getSlot(timelineName);
         if(slot && slot.displayList.length > 0)
         {
            var _loc6_:int = 0;
            var _loc5_:* = _slotTimelineStateList;
            for each(var eachState in _slotTimelineStateList)
            {
               if(eachState.name == timelineName)
               {
                  return;
               }
            }
            timelineState = SlotTimelineState.borrowObject();
            timelineState.fadeIn(slot,this,_clip.getSlotTimeline(timelineName));
            _slotTimelineStateList.push(timelineState);
         }
      }
      
      private function removeSlotTimelineState(timelineState:SlotTimelineState) : void
      {
         var index:int = _slotTimelineStateList.indexOf(timelineState);
         _slotTimelineStateList.splice(index,1);
         SlotTimelineState.returnObject(timelineState);
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
      
      function fadeIn(armature:Armature, clip:AnimationData, fadeTotalTime:Number, timeScale:Number, playTimes:Number, pausePlayhead:Boolean) : AnimationState
      {
         _armature = armature;
         _clip = clip;
         _pausePlayheadInFade = pausePlayhead;
         _name = _clip.name;
         _totalTime = _clip.duration;
         autoTween = _clip.autoTween;
         setTimeScale(timeScale);
         setPlayTimes(playTimes);
         _isComplete = false;
         _currentFrameIndex = -1;
         _currentPlayTimes = -1;
         if(Math.round(_totalTime * _clip.frameRate * 0.001) < 2 || timeScale == Infinity)
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
         _fadeTotalTime = fadeTotalTime * _timeScale;
         _isPlaying = true;
         displayControl = true;
         lastFrameAutoTween = true;
         additiveBlending = false;
         weight = 1;
         fadeOutTime = fadeTotalTime;
         updateTimelineStates();
         return this;
      }
      
      public function fadeOut(fadeTotalTime:Number, pausePlayhead:Boolean) : AnimationState
      {
         if(!_armature)
         {
            return null;
         }
         if(isNaN(fadeTotalTime) || fadeTotalTime < 0)
         {
            fadeTotalTime = 0;
         }
         _pausePlayheadInFade = pausePlayhead;
         if(_isFadeOut)
         {
            if(fadeTotalTime > _fadeTotalTime / _timeScale - (_fadeCurrentTime - _fadeBeginTime))
            {
               return this;
            }
         }
         else
         {
            var _loc5_:int = 0;
            var _loc4_:* = _timelineStateList;
            for each(var timelineState in _timelineStateList)
            {
               timelineState.fadeOut();
            }
         }
         _isFadeOut = true;
         _fadeTotalWeight = _fadeWeight;
         _fadeState = -1;
         _fadeBeginTime = _fadeCurrentTime;
         _fadeTotalTime = _fadeTotalWeight >= 0?fadeTotalTime * _timeScale:0;
         displayControl = false;
         return this;
      }
      
      function advanceTime(passedTime:Number) : Boolean
      {
         passedTime = passedTime * _timeScale;
         advanceFadeTime(passedTime);
         if(_fadeWeight)
         {
            advanceTimelinesTime(passedTime);
         }
         return _isFadeOut && _fadeState == 1;
      }
      
      private function advanceFadeTime(passedTime:Number) : void
      {
         var fadeState:int = 0;
         var event:* = null;
         var fadeStartFlg:Boolean = false;
         var fadeCompleteFlg:Boolean = false;
         if(_fadeBeginTime >= 0)
         {
            fadeState = _fadeState;
            _fadeCurrentTime = _fadeCurrentTime + (passedTime < 0?-passedTime:Number(passedTime));
            if(_fadeCurrentTime >= _fadeBeginTime + _fadeTotalTime)
            {
               if(_fadeWeight == 1 || _fadeWeight == 0)
               {
                  fadeState = 1;
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
               fadeState = 0;
               _fadeWeight = (_fadeCurrentTime - _fadeBeginTime) / _fadeTotalTime * _fadeTotalWeight;
               if(_isFadeOut)
               {
                  _fadeWeight = _fadeTotalWeight - _fadeWeight;
               }
            }
            else
            {
               fadeState = -1;
               _fadeWeight = !!_isFadeOut?1:0;
            }
            if(_fadeState != fadeState)
            {
               if(_fadeState == -1)
               {
                  fadeStartFlg = true;
               }
               if(fadeState == 1)
               {
                  fadeCompleteFlg = true;
               }
               _fadeState = fadeState;
            }
         }
         if(fadeStartFlg)
         {
            if(_isFadeOut)
            {
               if(_armature.hasEventListener("fadeOut"))
               {
                  event = new AnimationEvent("fadeOut");
                  event.animationState = this;
                  _armature._eventList.push(event);
               }
            }
            else
            {
               hideBones();
               if(_armature.hasEventListener("fadeIn"))
               {
                  event = new AnimationEvent("fadeIn");
                  event.animationState = this;
                  _armature._eventList.push(event);
               }
            }
         }
         if(fadeCompleteFlg)
         {
            if(_isFadeOut)
            {
               if(_armature.hasEventListener("fadeOutComplete"))
               {
                  event = new AnimationEvent("fadeOutComplete");
                  event.animationState = this;
                  _armature._eventList.push(event);
               }
            }
            else if(_armature.hasEventListener("fadeInComplete"))
            {
               event = new AnimationEvent("fadeInComplete");
               event.animationState = this;
               _armature._eventList.push(event);
            }
         }
      }
      
      private function advanceTimelinesTime(passedTime:Number) : void
      {
         var totalTimes:int = 0;
         var event:* = null;
         if(_isPlaying && !_pausePlayheadInFade)
         {
            _time = _time + passedTime;
         }
         var startFlg:Boolean = false;
         var completeFlg:Boolean = false;
         var loopCompleteFlg:Boolean = false;
         var isThisComplete:Boolean = false;
         var currentPlayTimes:int = 0;
         var currentTime:* = int(_time * 1000);
         if(_playTimes == 0)
         {
            isThisComplete = false;
            currentPlayTimes = Math.ceil(Math.abs(currentTime) / _totalTime) || 1;
            currentTime = int(currentTime - int(currentTime / _totalTime) * _totalTime);
            if(currentTime < 0)
            {
               currentTime = int(currentTime + _totalTime);
            }
         }
         else
         {
            totalTimes = _playTimes * _totalTime;
            if(currentTime >= totalTimes)
            {
               currentTime = totalTimes;
               isThisComplete = true;
            }
            else if(currentTime <= -totalTimes)
            {
               currentTime = int(-totalTimes);
               isThisComplete = true;
            }
            else
            {
               isThisComplete = false;
            }
            if(currentTime < 0)
            {
               currentTime = int(currentTime + totalTimes);
            }
            currentPlayTimes = Math.ceil(currentTime / _totalTime) || 1;
            currentTime = int(currentTime - int(currentTime / _totalTime) * _totalTime);
            if(isThisComplete)
            {
               currentTime = int(_totalTime);
            }
         }
         _isComplete = isThisComplete;
         var progress:Number = _time * 1000 / _totalTime;
         var _loc14_:int = 0;
         var _loc13_:* = _timelineStateList;
         for each(var timeline in _timelineStateList)
         {
            timeline.update(progress);
            _isComplete = timeline._isComplete && _isComplete;
         }
         var _loc16_:int = 0;
         var _loc15_:* = _slotTimelineStateList;
         for each(var slotTimeline in _slotTimelineStateList)
         {
            slotTimeline.update(progress);
            _isComplete = slotTimeline._isComplete && _isComplete;
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
            if(_currentTime < 0)
            {
               startFlg = true;
            }
            if(_isComplete)
            {
               completeFlg = true;
            }
            _lastTime = _currentTime;
            _currentTime = currentTime;
            updateMainTimeline(isThisComplete);
         }
         if(startFlg)
         {
            if(_armature.hasEventListener("start"))
            {
               event = new AnimationEvent("start");
               event.animationState = this;
               _armature._eventList.push(event);
            }
         }
         if(completeFlg)
         {
            if(_armature.hasEventListener("complete"))
            {
               event = new AnimationEvent("complete");
               event.animationState = this;
               _armature._eventList.push(event);
            }
            if(autoFadeOut)
            {
               fadeOut(fadeOutTime,true);
            }
         }
         else if(loopCompleteFlg)
         {
            if(_armature.hasEventListener("loopComplete"))
            {
               event = new AnimationEvent("loopComplete");
               event.animationState = this;
               _armature._eventList.push(event);
            }
         }
      }
      
      private function updateMainTimeline(isThisComplete:Boolean) : void
      {
         var prevFrame:* = null;
         var currentFrame:* = null;
         var i:int = 0;
         var l:int = 0;
         var frameList:Vector.<Frame> = _clip.frameList;
         if(frameList.length > 0)
         {
            for(i = 0,l = _clip.frameList.length; i < l; )
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
                  _armature.arriveAtFrame(prevFrame,null,this,true);
               }
               _currentFrameDuration = currentFrame.duration;
               _currentFramePosition = currentFrame.position;
               prevFrame = currentFrame;
               i++;
            }
            if(currentFrame)
            {
               _armature.arriveAtFrame(currentFrame,null,this,false);
            }
         }
      }
      
      private function hideBones() : void
      {
         var bone:* = null;
         var _loc4_:int = 0;
         var _loc3_:* = _clip.hideTimelineNameMap;
         for each(var timelineName in _clip.hideTimelineNameMap)
         {
            bone = _armature.getBone(timelineName);
            if(bone)
            {
               bone.hideSlots();
            }
         }
      }
      
      public function setAdditiveBlending(value:Boolean) : AnimationState
      {
         additiveBlending = value;
         return this;
      }
      
      public function setAutoFadeOut(value:Boolean, fadeOutTime:Number = -1) : AnimationState
      {
         autoFadeOut = value;
         if(fadeOutTime >= 0)
         {
            this.fadeOutTime = fadeOutTime * _timeScale;
         }
         return this;
      }
      
      public function setWeight(value:Number) : AnimationState
      {
         if(isNaN(value) || value < 0)
         {
            value = 1;
         }
         weight = value;
         return this;
      }
      
      public function setFrameTween(autoTween:Boolean, lastFrameAutoTween:Boolean) : AnimationState
      {
         this.autoTween = autoTween;
         this.lastFrameAutoTween = lastFrameAutoTween;
         return this;
      }
      
      public function setCurrentTime(value:Number) : AnimationState
      {
         if(value < 0 || isNaN(value))
         {
            value = 0;
         }
         _time = value;
         _currentTime = _time * 1000;
         return this;
      }
      
      public function setTimeScale(value:Number) : AnimationState
      {
         if(isNaN(value) || value == Infinity)
         {
            value = 1;
         }
         _timeScale = value;
         return this;
      }
      
      public function setPlayTimes(value:int) : AnimationState
      {
         if(Math.round(_totalTime * 0.001 * _clip.frameRate) < 2)
         {
            _playTimes = value < 0?-1:1;
         }
         else
         {
            _playTimes = value < 0?-value:value;
         }
         autoFadeOut = value < 0?true:false;
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
