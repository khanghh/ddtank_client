package dragonBones.fast.animation
{
   import dragonBones.§core:dragonBones_internal§._animationState;
   import dragonBones.§core:dragonBones_internal§._blendEnabled;
   import dragonBones.§core:dragonBones_internal§._isComplete;
   import dragonBones.§core:dragonBones_internal§._weight;
   import dragonBones.fast.FastArmature;
   import dragonBones.fast.FastSlot;
   import dragonBones.objects.CurveData;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SlotFrame;
   import dragonBones.objects.SlotTimeline;
   import dragonBones.utils.ColorTransformUtil;
   import dragonBones.utils.MathUtil;
   import flash.geom.ColorTransform;
   
   public final class FastSlotTimelineState
   {
      
      private static const HALF_PI:Number = 1.5707963267948966;
      
      private static const DOUBLE_PI:Number = 6.283185307179586;
      
      private static var _pool:Vector.<FastSlotTimelineState> = new Vector.<FastSlotTimelineState>();
       
      
      public var name:String;
      
      var _weight:Number;
      
      var _blendEnabled:Boolean;
      
      var _isComplete:Boolean;
      
      var _animationState:FastAnimationState;
      
      private var _totalTime:int;
      
      private var _currentTime:int;
      
      private var _currentFrameIndex:int;
      
      private var _currentFramePosition:int;
      
      private var _currentFrameDuration:int;
      
      private var _tweenEasing:Number;
      
      private var _tweenCurve:CurveData;
      
      private var _tweenColor:Boolean;
      
      private var _colorChanged:Boolean;
      
      private var _updateMode:int;
      
      private var _armature:FastArmature;
      
      private var _animation:FastAnimation;
      
      private var _slot:FastSlot;
      
      private var _timelineData:SlotTimeline;
      
      private var _durationColor:ColorTransform;
      
      public function FastSlotTimelineState()
      {
         super();
         _durationColor = new ColorTransform();
      }
      
      static function borrowObject() : FastSlotTimelineState
      {
         if(_pool.length == 0)
         {
            return new FastSlotTimelineState();
         }
         return _pool.pop();
      }
      
      static function returnObject(timeline:FastSlotTimelineState) : void
      {
         if(_pool.indexOf(timeline) < 0)
         {
            _pool[_pool.length] = timeline;
         }
         timeline.clear();
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
      }
      
      private function clear() : void
      {
         _slot = null;
         _armature = null;
         _animation = null;
         _animationState = null;
         _timelineData = null;
      }
      
      function fadeIn(slot:FastSlot, animationState:FastAnimationState, timelineData:SlotTimeline) : void
      {
         _slot = slot;
         _armature = _slot.armature;
         _animation = _armature.animation as FastAnimation;
         _animationState = animationState;
         _timelineData = timelineData;
         name = timelineData.name;
         _totalTime = _timelineData.duration;
         _isComplete = false;
         _blendEnabled = false;
         _tweenColor = false;
         _currentFrameIndex = -1;
         _currentTime = -1;
         _tweenEasing = NaN;
         _weight = 1;
         switch(int(_timelineData.frameList.length))
         {
            case 0:
               _updateMode = 0;
               break;
            case 1:
               _updateMode = 1;
         }
      }
      
      function updateFade(progress:Number) : void
      {
      }
      
      function update(progress:Number) : void
      {
         if(_updateMode == -1)
         {
            updateMultipleFrame(progress);
         }
         else if(_updateMode == 1)
         {
            _updateMode = 0;
            updateSingleFrame();
         }
      }
      
      private function updateMultipleFrame(progress:Number) : void
      {
         var totalTimes:int = 0;
         var frameList:* = undefined;
         var prevFrame:* = null;
         var currentFrame:* = null;
         var i:int = 0;
         var l:int = 0;
         var currentPlayTimes:int = 0;
         progress = progress / _timelineData.scale;
         progress = progress + _timelineData.offset;
         var currentTime:* = int(_totalTime * progress);
         var playTimes:int = _animationState.playTimes;
         if(playTimes == 0)
         {
            _isComplete = false;
            currentPlayTimes = Math.ceil(Math.abs(currentTime) / _totalTime) || 1;
            currentTime = int(currentTime - int(currentTime / _totalTime) * _totalTime);
            if(currentTime < 0)
            {
               currentTime = int(currentTime + _totalTime);
            }
         }
         else
         {
            totalTimes = playTimes * _totalTime;
            if(currentTime >= totalTimes)
            {
               currentTime = totalTimes;
               _isComplete = true;
            }
            else if(currentTime <= -totalTimes)
            {
               currentTime = int(-totalTimes);
               _isComplete = true;
            }
            else
            {
               _isComplete = false;
            }
            if(currentTime < 0)
            {
               currentTime = int(currentTime + totalTimes);
            }
            currentPlayTimes = Math.ceil(currentTime / _totalTime) || 1;
            if(_isComplete)
            {
               currentTime = int(_totalTime);
            }
            else
            {
               currentTime = int(currentTime - int(currentTime / _totalTime) * _totalTime);
            }
         }
         if(_currentTime != currentTime)
         {
            _currentTime = currentTime;
            frameList = _timelineData.frameList;
            for(i = 0,l = _timelineData.frameList.length; i < l; )
            {
               if(_currentFrameIndex < 0)
               {
                  _currentFrameIndex = 0;
               }
               else if(_currentTime < _currentFramePosition || _currentTime >= _currentFramePosition + _currentFrameDuration)
               {
                  _currentFrameIndex = Number(_currentFrameIndex) + 1;
                  if(_currentFrameIndex >= frameList.length)
                  {
                     if(_isComplete)
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
               currentFrame = frameList[_currentFrameIndex] as SlotFrame;
               if(prevFrame)
               {
                  _slot.arriveAtFrame(prevFrame,_animationState);
               }
               _currentFrameDuration = currentFrame.duration;
               _currentFramePosition = currentFrame.position;
               prevFrame = currentFrame;
               i++;
            }
            if(currentFrame)
            {
               _slot.arriveAtFrame(currentFrame,_animationState);
               _blendEnabled = currentFrame.displayIndex >= 0;
               if(_blendEnabled)
               {
                  updateToNextFrame(currentPlayTimes);
               }
               else
               {
                  _tweenEasing = NaN;
                  _tweenColor = false;
               }
            }
            if(_blendEnabled)
            {
               updateTween();
            }
         }
      }
      
      private function updateToNextFrame(currentPlayTimes:int) : void
      {
         var targetColor:* = null;
         var colorChanged:Boolean = false;
         var nextFrameIndex:int = _currentFrameIndex + 1;
         if(nextFrameIndex >= _timelineData.frameList.length)
         {
            nextFrameIndex = 0;
         }
         var currentFrame:SlotFrame = _timelineData.frameList[_currentFrameIndex] as SlotFrame;
         var nextFrame:SlotFrame = _timelineData.frameList[nextFrameIndex] as SlotFrame;
         var tweenEnabled:Boolean = false;
         if(nextFrameIndex == 0 && (_animationState.playTimes && _animationState.currentPlayTimes >= _animationState.playTimes && ((_currentFramePosition + _currentFrameDuration) / _totalTime + currentPlayTimes - _timelineData.offset) * _timelineData.scale > 0.999999))
         {
            _tweenEasing = NaN;
            tweenEnabled = false;
         }
         else if(currentFrame.displayIndex < 0 || nextFrame.displayIndex < 0)
         {
            _tweenEasing = NaN;
            tweenEnabled = false;
         }
         else if(_animationState.autoTween)
         {
            _tweenEasing = _animationState.animationData.tweenEasing;
            if(isNaN(_tweenEasing))
            {
               _tweenEasing = currentFrame.tweenEasing;
               _tweenCurve = currentFrame.curve;
               if(isNaN(_tweenEasing))
               {
                  tweenEnabled = false;
               }
               else
               {
                  if(_tweenEasing == 10)
                  {
                     _tweenEasing = 0;
                  }
                  tweenEnabled = true;
               }
            }
            else
            {
               tweenEnabled = true;
            }
         }
         else
         {
            _tweenEasing = currentFrame.tweenEasing;
            _tweenCurve = currentFrame.curve;
            if(isNaN(_tweenEasing) || _tweenEasing == 10)
            {
               _tweenEasing = NaN;
               tweenEnabled = false;
            }
            else
            {
               tweenEnabled = true;
            }
         }
         if(tweenEnabled)
         {
            if(currentFrame.color || nextFrame.color)
            {
               ColorTransformUtil.minus(nextFrame.color || ColorTransformUtil.originalColor,currentFrame.color || ColorTransformUtil.originalColor,_durationColor);
               _tweenColor = _durationColor.alphaOffset || Number(_durationColor.redOffset) || Number(_durationColor.greenOffset) || Number(_durationColor.blueOffset) || Number(_durationColor.alphaMultiplier) || Number(_durationColor.redMultiplier) || Number(_durationColor.greenMultiplier) || Number(_durationColor.blueMultiplier);
            }
            else
            {
               _tweenColor = false;
            }
         }
         else
         {
            _tweenColor = false;
         }
         if(!_tweenColor)
         {
            if(currentFrame.colorChanged)
            {
               targetColor = currentFrame.color;
               colorChanged = true;
            }
            else
            {
               targetColor = ColorTransformUtil.originalColor;
               colorChanged = false;
            }
            if(_slot._isColorChanged || colorChanged)
            {
               if(!ColorTransformUtil.isEqual(_slot._colorTransform,targetColor))
               {
                  _slot.updateDisplayColor(targetColor.alphaOffset,targetColor.redOffset,targetColor.greenOffset,targetColor.blueOffset,targetColor.alphaMultiplier,targetColor.redMultiplier,targetColor.greenMultiplier,targetColor.blueMultiplier,colorChanged);
               }
            }
         }
      }
      
      private function updateTween() : void
      {
         var progress:Number = NaN;
         var currentFrame:SlotFrame = _timelineData.frameList[_currentFrameIndex] as SlotFrame;
         if(_tweenColor)
         {
            progress = (_currentTime - _currentFramePosition) / _currentFrameDuration;
            if(_tweenCurve != null)
            {
               progress = _tweenCurve.getValueByProgress(progress);
            }
            if(_tweenEasing)
            {
               progress = MathUtil.getEaseValue(progress,_tweenEasing);
            }
            if(currentFrame.color)
            {
               _slot.updateDisplayColor(currentFrame.color.alphaOffset + _durationColor.alphaOffset * progress,currentFrame.color.redOffset + _durationColor.redOffset * progress,currentFrame.color.greenOffset + _durationColor.greenOffset * progress,currentFrame.color.blueOffset + _durationColor.blueOffset * progress,currentFrame.color.alphaMultiplier + _durationColor.alphaMultiplier * progress,currentFrame.color.redMultiplier + _durationColor.redMultiplier * progress,currentFrame.color.greenMultiplier + _durationColor.greenMultiplier * progress,currentFrame.color.blueMultiplier + _durationColor.blueMultiplier * progress,true);
            }
            else
            {
               _slot.updateDisplayColor(_durationColor.alphaOffset * progress,_durationColor.redOffset * progress,_durationColor.greenOffset * progress,_durationColor.blueOffset * progress,_durationColor.alphaMultiplier * progress + 1,_durationColor.redMultiplier * progress + 1,_durationColor.greenMultiplier * progress + 1,_durationColor.blueMultiplier * progress + 1,true);
            }
         }
      }
      
      private function updateSingleFrame() : void
      {
         var targetColor:* = null;
         var colorChanged:Boolean = false;
         var currentFrame:SlotFrame = _timelineData.frameList[0] as SlotFrame;
         _slot.arriveAtFrame(currentFrame,_animationState);
         _isComplete = true;
         _tweenEasing = NaN;
         _tweenColor = false;
         _blendEnabled = currentFrame.displayIndex >= 0;
         if(_blendEnabled)
         {
            if(currentFrame.colorChanged)
            {
               targetColor = currentFrame.color;
               colorChanged = true;
            }
            else
            {
               targetColor = ColorTransformUtil.originalColor;
               colorChanged = false;
            }
            if(_slot._isColorChanged || colorChanged)
            {
               if(!ColorTransformUtil.isEqual(_slot._colorTransform,targetColor))
               {
                  _slot.updateDisplayColor(targetColor.alphaOffset,targetColor.redOffset,targetColor.greenOffset,targetColor.blueOffset,targetColor.alphaMultiplier,targetColor.redMultiplier,targetColor.greenMultiplier,targetColor.blueMultiplier,colorChanged);
               }
            }
         }
      }
   }
}
