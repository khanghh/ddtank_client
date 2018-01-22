package dragonBones.animation
{
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.§core:dragonBones_internal§._animationState;
   import dragonBones.§core:dragonBones_internal§._blendEnabled;
   import dragonBones.§core:dragonBones_internal§._isComplete;
   import dragonBones.§core:dragonBones_internal§._weight;
   import dragonBones.objects.CurveData;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SlotFrame;
   import dragonBones.objects.SlotTimeline;
   import dragonBones.utils.MathUtil;
   import flash.geom.ColorTransform;
   
   public final class SlotTimelineState
   {
      
      private static const HALF_PI:Number = 1.5707963267948966;
      
      private static const DOUBLE_PI:Number = 6.283185307179586;
      
      private static var _pool:Vector.<SlotTimelineState> = new Vector.<SlotTimelineState>();
       
      
      public var name:String;
      
      var _weight:Number;
      
      var _blendEnabled:Boolean;
      
      var _isComplete:Boolean;
      
      var _animationState:AnimationState;
      
      private var _totalTime:int;
      
      private var _currentTime:int;
      
      private var _currentFrameIndex:int;
      
      private var _currentFramePosition:int;
      
      private var _currentFrameDuration:int;
      
      private var _tweenEasing:Number;
      
      private var _tweenCurve:CurveData;
      
      private var _tweenColor:Boolean;
      
      private var _rawAnimationScale:Number;
      
      private var _updateMode:int;
      
      private var _armature:Armature;
      
      private var _animation:Animation;
      
      private var _slot:Slot;
      
      private var _timelineData:SlotTimeline;
      
      private var _durationColor:ColorTransform;
      
      public function SlotTimelineState()
      {
         super();
         _durationColor = new ColorTransform();
      }
      
      static function borrowObject() : SlotTimelineState
      {
         if(_pool.length == 0)
         {
            return new SlotTimelineState();
         }
         return _pool.pop();
      }
      
      static function returnObject(param1:SlotTimelineState) : void
      {
         if(_pool.indexOf(param1) < 0)
         {
            _pool[_pool.length] = param1;
         }
         param1.clear();
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
      }
      
      private function clear() : void
      {
         _slot = null;
         _armature = null;
         _animation = null;
         _animationState = null;
         _timelineData = null;
      }
      
      function fadeIn(param1:Slot, param2:AnimationState, param3:SlotTimeline) : void
      {
         _slot = param1;
         _armature = _slot.armature;
         _animation = _armature.animation;
         _animationState = param2;
         _timelineData = param3;
         name = param3.name;
         _totalTime = _timelineData.duration;
         _rawAnimationScale = _animationState.clip.scale;
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
      
      function update(param1:Number) : void
      {
         if(_updateMode == -1)
         {
            updateMultipleFrame(param1);
         }
         else if(_updateMode == 1)
         {
            _updateMode = 0;
            updateSingleFrame();
         }
      }
      
      private function updateMultipleFrame(param1:Number) : void
      {
         var _loc4_:int = 0;
         var _loc8_:* = undefined;
         var _loc3_:* = null;
         var _loc9_:* = null;
         var _loc10_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         param1 = param1 / _timelineData.scale;
         param1 = param1 + _timelineData.offset;
         var _loc2_:* = int(_totalTime * param1);
         var _loc7_:int = _animationState.playTimes;
         if(_loc7_ == 0)
         {
            _isComplete = false;
            _loc6_ = Math.ceil(Math.abs(_loc2_) / _totalTime) || 1;
            _loc2_ = int(_loc2_ - int(_loc2_ / _totalTime) * _totalTime);
            if(_loc2_ < 0)
            {
               _loc2_ = int(_loc2_ + _totalTime);
            }
         }
         else
         {
            _loc4_ = _loc7_ * _totalTime;
            if(_loc2_ >= _loc4_)
            {
               _loc2_ = _loc4_;
               _isComplete = true;
            }
            else if(_loc2_ <= -_loc4_)
            {
               _loc2_ = int(-_loc4_);
               _isComplete = true;
            }
            else
            {
               _isComplete = false;
            }
            if(_loc2_ < 0)
            {
               _loc2_ = int(_loc2_ + _loc4_);
            }
            _loc6_ = Math.ceil(_loc2_ / _totalTime) || 1;
            if(_isComplete)
            {
               _loc2_ = int(_totalTime);
            }
            else
            {
               _loc2_ = int(_loc2_ - int(_loc2_ / _totalTime) * _totalTime);
            }
         }
         if(_currentTime != _loc2_)
         {
            _currentTime = _loc2_;
            _loc8_ = _timelineData.frameList;
            _loc10_ = 0;
            _loc5_ = _timelineData.frameList.length;
            while(_loc10_ < _loc5_)
            {
               if(_currentFrameIndex < 0)
               {
                  _currentFrameIndex = 0;
               }
               else if(_currentTime < _currentFramePosition || _currentTime >= _currentFramePosition + _currentFrameDuration)
               {
                  _currentFrameIndex = Number(_currentFrameIndex) + 1;
                  if(_currentFrameIndex >= _loc8_.length)
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
               _loc9_ = _loc8_[_currentFrameIndex] as SlotFrame;
               if(_loc3_)
               {
                  _slot.arriveAtFrame(_loc3_,this,_animationState,true);
               }
               _currentFrameDuration = _loc9_.duration;
               _currentFramePosition = _loc9_.position;
               _loc3_ = _loc9_;
               _loc10_++;
            }
            if(_loc9_)
            {
               _slot.arriveAtFrame(_loc9_,this,_animationState,false);
               _blendEnabled = _loc9_.displayIndex >= 0;
               if(_blendEnabled)
               {
                  updateToNextFrame(_loc6_);
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
      
      private function updateToNextFrame(param1:int) : void
      {
         var _loc5_:int = _currentFrameIndex + 1;
         if(_loc5_ >= _timelineData.frameList.length)
         {
            _loc5_ = 0;
         }
         var _loc4_:SlotFrame = _timelineData.frameList[_currentFrameIndex] as SlotFrame;
         var _loc2_:SlotFrame = _timelineData.frameList[_loc5_] as SlotFrame;
         var _loc3_:Boolean = false;
         if(_loc5_ == 0 && (!_animationState.lastFrameAutoTween || _animationState.playTimes && _animationState.currentPlayTimes >= _animationState.playTimes && ((_currentFramePosition + _currentFrameDuration) / _totalTime + param1 - _timelineData.offset) * _timelineData.scale > 0.999999))
         {
            _tweenEasing = NaN;
            _loc3_ = false;
         }
         else if(_loc4_.displayIndex < 0 || _loc2_.displayIndex < 0)
         {
            _tweenEasing = NaN;
            _loc3_ = false;
         }
         else if(_animationState.autoTween)
         {
            _tweenEasing = _animationState.clip.tweenEasing;
            if(isNaN(_tweenEasing))
            {
               _tweenEasing = _loc4_.tweenEasing;
               _tweenCurve = _loc4_.curve;
               if(isNaN(_tweenEasing) && _tweenCurve == null)
               {
                  _loc3_ = false;
               }
               else
               {
                  if(_tweenEasing == 10)
                  {
                     _tweenEasing = 0;
                  }
                  _loc3_ = true;
               }
            }
            else
            {
               _loc3_ = true;
            }
         }
         else
         {
            _tweenEasing = _loc4_.tweenEasing;
            _tweenCurve = _loc4_.curve;
            if((isNaN(_tweenEasing) || _tweenEasing == 10) && _tweenCurve == null)
            {
               _tweenEasing = NaN;
               _loc3_ = false;
            }
            else
            {
               _loc3_ = true;
            }
         }
         if(_loc3_)
         {
            if(_loc4_.color && _loc2_.color)
            {
               _durationColor.alphaOffset = _loc2_.color.alphaOffset - _loc4_.color.alphaOffset;
               _durationColor.redOffset = _loc2_.color.redOffset - _loc4_.color.redOffset;
               _durationColor.greenOffset = _loc2_.color.greenOffset - _loc4_.color.greenOffset;
               _durationColor.blueOffset = _loc2_.color.blueOffset - _loc4_.color.blueOffset;
               _durationColor.alphaMultiplier = _loc2_.color.alphaMultiplier - _loc4_.color.alphaMultiplier;
               _durationColor.redMultiplier = _loc2_.color.redMultiplier - _loc4_.color.redMultiplier;
               _durationColor.greenMultiplier = _loc2_.color.greenMultiplier - _loc4_.color.greenMultiplier;
               _durationColor.blueMultiplier = _loc2_.color.blueMultiplier - _loc4_.color.blueMultiplier;
               if(_durationColor.alphaOffset || Number(_durationColor.redOffset) || Number(_durationColor.greenOffset) || Number(_durationColor.blueOffset) || Number(_durationColor.alphaMultiplier) || Number(_durationColor.redMultiplier) || Number(_durationColor.greenMultiplier) || Number(_durationColor.blueMultiplier))
               {
                  _tweenColor = true;
               }
               else
               {
                  _tweenColor = false;
               }
            }
            else if(_loc4_.color)
            {
               _tweenColor = true;
               _durationColor.alphaOffset = -_loc4_.color.alphaOffset;
               _durationColor.redOffset = -_loc4_.color.redOffset;
               _durationColor.greenOffset = -_loc4_.color.greenOffset;
               _durationColor.blueOffset = -_loc4_.color.blueOffset;
               _durationColor.alphaMultiplier = 1 - _loc4_.color.alphaMultiplier;
               _durationColor.redMultiplier = 1 - _loc4_.color.redMultiplier;
               _durationColor.greenMultiplier = 1 - _loc4_.color.greenMultiplier;
               _durationColor.blueMultiplier = 1 - _loc4_.color.blueMultiplier;
            }
            else if(_loc2_.color)
            {
               _tweenColor = true;
               _durationColor.alphaOffset = _loc2_.color.alphaOffset;
               _durationColor.redOffset = _loc2_.color.redOffset;
               _durationColor.greenOffset = _loc2_.color.greenOffset;
               _durationColor.blueOffset = _loc2_.color.blueOffset;
               _durationColor.alphaMultiplier = _loc2_.color.alphaMultiplier - 1;
               _durationColor.redMultiplier = _loc2_.color.redMultiplier - 1;
               _durationColor.greenMultiplier = _loc2_.color.greenMultiplier - 1;
               _durationColor.blueMultiplier = _loc2_.color.blueMultiplier - 1;
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
         if(!_tweenColor && _animationState.displayControl)
         {
            if(_loc4_.color)
            {
               _slot.updateDisplayColor(_loc4_.color.alphaOffset,_loc4_.color.redOffset,_loc4_.color.greenOffset,_loc4_.color.blueOffset,_loc4_.color.alphaMultiplier,_loc4_.color.redMultiplier,_loc4_.color.greenMultiplier,_loc4_.color.blueMultiplier,true);
            }
            else if(_slot._isColorChanged)
            {
               _slot.updateDisplayColor(0,0,0,0,1,1,1,1,false);
            }
         }
      }
      
      private function updateTween() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:SlotFrame = _timelineData.frameList[_currentFrameIndex] as SlotFrame;
         if(_tweenColor && _animationState.displayControl)
         {
            _loc1_ = (_currentTime - _currentFramePosition) / _currentFrameDuration;
            if(_tweenCurve != null)
            {
               _loc1_ = _tweenCurve.getValueByProgress(_loc1_);
            }
            if(_tweenEasing)
            {
               _loc1_ = MathUtil.getEaseValue(_loc1_,_tweenEasing);
            }
            if(_loc2_.color)
            {
               _slot.updateDisplayColor(_loc2_.color.alphaOffset + _durationColor.alphaOffset * _loc1_,_loc2_.color.redOffset + _durationColor.redOffset * _loc1_,_loc2_.color.greenOffset + _durationColor.greenOffset * _loc1_,_loc2_.color.blueOffset + _durationColor.blueOffset * _loc1_,_loc2_.color.alphaMultiplier + _durationColor.alphaMultiplier * _loc1_,_loc2_.color.redMultiplier + _durationColor.redMultiplier * _loc1_,_loc2_.color.greenMultiplier + _durationColor.greenMultiplier * _loc1_,_loc2_.color.blueMultiplier + _durationColor.blueMultiplier * _loc1_,true);
            }
            else
            {
               _slot.updateDisplayColor(_durationColor.alphaOffset * _loc1_,_durationColor.redOffset * _loc1_,_durationColor.greenOffset * _loc1_,_durationColor.blueOffset * _loc1_,1 + _durationColor.alphaMultiplier * _loc1_,1 + _durationColor.redMultiplier * _loc1_,1 + _durationColor.greenMultiplier * _loc1_,1 + _durationColor.blueMultiplier * _loc1_,true);
            }
         }
      }
      
      private function updateSingleFrame() : void
      {
         var _loc1_:SlotFrame = _timelineData.frameList[0] as SlotFrame;
         _slot.arriveAtFrame(_loc1_,this,_animationState,false);
         _isComplete = true;
         _tweenEasing = NaN;
         _tweenColor = false;
         _blendEnabled = _loc1_.displayIndex >= 0;
         if(_blendEnabled)
         {
            if(_animationState.displayControl)
            {
               if(_loc1_.color)
               {
                  _slot.updateDisplayColor(_loc1_.color.alphaOffset,_loc1_.color.redOffset,_loc1_.color.greenOffset,_loc1_.color.blueOffset,_loc1_.color.alphaMultiplier,_loc1_.color.redMultiplier,_loc1_.color.greenMultiplier,_loc1_.color.blueMultiplier,true);
               }
               else if(_slot._isColorChanged)
               {
                  _slot.updateDisplayColor(0,0,0,0,1,1,1,1,false);
               }
            }
         }
      }
   }
}
