package dragonBones.fast.animation
{
   import dragonBones.§core:dragonBones_internal§._animationState;
   import dragonBones.§core:dragonBones_internal§._isComplete;
   import dragonBones.§core:dragonBones_internal§._transform;
   import dragonBones.fast.FastBone;
   import dragonBones.objects.CurveData;
   import dragonBones.objects.DBTransform;
   import dragonBones.objects.Frame;
   import dragonBones.objects.TransformFrame;
   import dragonBones.objects.TransformTimeline;
   import dragonBones.utils.MathUtil;
   import dragonBones.utils.TransformUtil;
   import flash.geom.Point;
   
   public class FastBoneTimelineState
   {
      
      private static var _pool:Vector.<FastBoneTimelineState> = new Vector.<FastBoneTimelineState>();
       
      
      public var name:String;
      
      private var _totalTime:int;
      
      private var _currentTime:int;
      
      private var _lastTime:int;
      
      private var _currentFrameIndex:int;
      
      private var _currentFramePosition:int;
      
      private var _currentFrameDuration:int;
      
      private var _bone:FastBone;
      
      private var _timelineData:TransformTimeline;
      
      private var _durationTransform:DBTransform;
      
      private var _tweenTransform:Boolean;
      
      private var _tweenEasing:Number;
      
      private var _tweenCurve:CurveData;
      
      private var _updateMode:int;
      
      private var _transformToFadein:DBTransform;
      
      var _animationState:FastAnimationState;
      
      var _isComplete:Boolean;
      
      var _transform:DBTransform;
      
      public function FastBoneTimelineState()
      {
         super();
         _transform = new DBTransform();
         _durationTransform = new DBTransform();
         _transformToFadein = new DBTransform();
      }
      
      static function borrowObject() : FastBoneTimelineState
      {
         if(_pool.length == 0)
         {
            return new FastBoneTimelineState();
         }
         return _pool.pop();
      }
      
      static function returnObject(param1:FastBoneTimelineState) : void
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
         if(_bone)
         {
            _bone._timelineState = null;
            _bone = null;
         }
         _animationState = null;
         _timelineData = null;
      }
      
      function fadeIn(param1:FastBone, param2:FastAnimationState, param3:TransformTimeline) : void
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         _bone = param1;
         _animationState = param2;
         _timelineData = param3;
         name = param3.name;
         _totalTime = _timelineData.duration;
         _isComplete = false;
         _tweenTransform = false;
         _currentFrameIndex = -1;
         _currentTime = -1;
         _tweenEasing = NaN;
         switch(int(_timelineData.frameList.length))
         {
            case 0:
               _updateMode = 0;
               break;
            case 1:
               _updateMode = 1;
         }
         if(param2._fadeTotalTime > 0)
         {
            if(_bone._timelineState)
            {
               _transformToFadein.copy(_bone._timelineState._transform);
            }
            else
            {
               _transformToFadein = new DBTransform();
            }
            _loc5_ = _timelineData.frameList[0] as TransformFrame;
            _durationTransform.copy(_loc5_.transform);
            _durationTransform.minus(this._transformToFadein);
         }
         _bone._timelineState = this;
      }
      
      function updateFade(param1:Number) : void
      {
         _transform.x = _transformToFadein.x + _durationTransform.x * param1;
         _transform.y = _transformToFadein.y + _durationTransform.y * param1;
         _transform.scaleX = _transformToFadein.scaleX * (1 + (_durationTransform.scaleX - 1) * param1);
         _transform.scaleY = _transformToFadein.scaleX * (1 + (_durationTransform.scaleY - 1) * param1);
         _transform.rotation = _transformToFadein.rotation + _durationTransform.rotation * param1;
         _bone.invalidUpdate();
      }
      
      function update(param1:Number) : void
      {
         if(_updateMode == 1)
         {
            _updateMode = 0;
            updateSingleFrame();
         }
         else if(_updateMode == -1)
         {
            updateMultipleFrame(param1);
         }
      }
      
      private function updateSingleFrame() : void
      {
         var _loc1_:TransformFrame = _timelineData.frameList[0] as TransformFrame;
         _bone.arriveAtFrame(_loc1_,_animationState);
         _isComplete = true;
         _tweenEasing = NaN;
         _tweenTransform = false;
         _transform.copy(_loc1_.transform);
         _bone.invalidUpdate();
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
            _lastTime = _currentTime;
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
               else if(_currentTime < _currentFramePosition || _currentTime >= _currentFramePosition + _currentFrameDuration || _currentTime < _lastTime)
               {
                  _currentFrameIndex = Number(_currentFrameIndex) + 1;
                  _lastTime = _currentTime;
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
               _loc9_ = _loc8_[_currentFrameIndex] as TransformFrame;
               if(_loc3_)
               {
                  _bone.arriveAtFrame(_loc3_,_animationState);
               }
               _currentFrameDuration = _loc9_.duration;
               _currentFramePosition = _loc9_.position;
               _loc3_ = _loc9_;
               _loc10_++;
            }
            if(_loc9_)
            {
               _bone.arriveAtFrame(_loc9_,_animationState);
               updateToNextFrame(_loc6_);
            }
            if(_tweenTransform)
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
         var _loc4_:TransformFrame = _timelineData.frameList[_currentFrameIndex] as TransformFrame;
         var _loc2_:TransformFrame = _timelineData.frameList[_loc5_] as TransformFrame;
         var _loc3_:Boolean = false;
         if(_loc5_ == 0 && (_animationState.playTimes && _animationState.currentPlayTimes >= _animationState.playTimes && ((_currentFramePosition + _currentFrameDuration) / _totalTime + param1 - _timelineData.offset) * _timelineData.scale > 0.999999))
         {
            _tweenEasing = NaN;
            _loc3_ = false;
         }
         else if(_animationState.autoTween)
         {
            _tweenEasing = _animationState.animationData.tweenEasing;
            if(isNaN(_tweenEasing))
            {
               _tweenEasing = _loc4_.tweenEasing;
               _tweenCurve = _loc4_.curve;
               if(isNaN(_tweenEasing))
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
            if(isNaN(_tweenEasing) || _tweenEasing == 10)
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
            _durationTransform.x = _loc2_.transform.x - _loc4_.transform.x;
            _durationTransform.y = _loc2_.transform.y - _loc4_.transform.y;
            _durationTransform.skewX = _loc2_.transform.skewX - _loc4_.transform.skewX;
            _durationTransform.skewY = _loc2_.transform.skewY - _loc4_.transform.skewY;
            _durationTransform.scaleX = _loc2_.transform.scaleX - _loc4_.transform.scaleX + _loc2_.scaleOffset.x;
            _durationTransform.scaleY = _loc2_.transform.scaleY - _loc4_.transform.scaleY + _loc2_.scaleOffset.y;
            _durationTransform.normalizeRotation();
            if(_loc5_ == 0)
            {
               _durationTransform.skewX = TransformUtil.formatRadian(_durationTransform.skewX);
               _durationTransform.skewY = TransformUtil.formatRadian(_durationTransform.skewY);
            }
            if(_durationTransform.x || Number(_durationTransform.y) || Number(_durationTransform.skewX) || Number(_durationTransform.skewY) || _durationTransform.scaleX != 1 || _durationTransform.scaleY != 1)
            {
               _tweenTransform = true;
            }
            else
            {
               _tweenTransform = false;
            }
         }
         else
         {
            _tweenTransform = false;
         }
         if(!_tweenTransform)
         {
            _transform.copy(_loc4_.transform);
            _bone.invalidUpdate();
         }
      }
      
      private function updateTween() : void
      {
         var _loc1_:Number = (_currentTime - _currentFramePosition) / _currentFrameDuration;
         if(_tweenCurve)
         {
            _loc1_ = _tweenCurve.getValueByProgress(_loc1_);
         }
         if(_tweenEasing)
         {
            _loc1_ = MathUtil.getEaseValue(_loc1_,_tweenEasing);
         }
         var _loc3_:TransformFrame = _timelineData.frameList[_currentFrameIndex] as TransformFrame;
         var _loc4_:DBTransform = _loc3_.transform;
         var _loc2_:Point = _loc3_.pivot;
         _transform.x = _loc4_.x + _durationTransform.x * _loc1_;
         _transform.y = _loc4_.y + _durationTransform.y * _loc1_;
         _transform.skewX = _loc4_.skewX + _durationTransform.skewX * _loc1_;
         _transform.skewY = _loc4_.skewY + _durationTransform.skewY * _loc1_;
         _transform.scaleX = _loc4_.scaleX + _durationTransform.scaleX * _loc1_;
         _transform.scaleY = _loc4_.scaleY + _durationTransform.scaleY * _loc1_;
         _bone.invalidUpdate();
      }
   }
}
