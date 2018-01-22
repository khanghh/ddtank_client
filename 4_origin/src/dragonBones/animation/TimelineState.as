package dragonBones.animation
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.§core:dragonBones_internal§._animationState;
   import dragonBones.§core:dragonBones_internal§._blendEnabled;
   import dragonBones.§core:dragonBones_internal§._isComplete;
   import dragonBones.§core:dragonBones_internal§._pivot;
   import dragonBones.§core:dragonBones_internal§._transform;
   import dragonBones.§core:dragonBones_internal§._weight;
   import dragonBones.objects.CurveData;
   import dragonBones.objects.DBTransform;
   import dragonBones.objects.Frame;
   import dragonBones.objects.TransformFrame;
   import dragonBones.objects.TransformTimeline;
   import dragonBones.utils.MathUtil;
   import dragonBones.utils.TransformUtil;
   import flash.geom.Point;
   
   public final class TimelineState
   {
      
      private static const HALF_PI:Number = 1.5707963267948966;
      
      private static const DOUBLE_PI:Number = 6.283185307179586;
      
      private static var _pool:Vector.<TimelineState> = new Vector.<TimelineState>();
       
      
      public var name:String;
      
      var _weight:Number;
      
      var _transform:DBTransform;
      
      var _pivot:Point;
      
      var _blendEnabled:Boolean;
      
      var _isComplete:Boolean;
      
      var _animationState:AnimationState;
      
      private var _totalTime:int;
      
      private var _currentTime:int;
      
      private var _lastTime:int;
      
      private var _currentFrameIndex:int;
      
      private var _currentFramePosition:int;
      
      private var _currentFrameDuration:int;
      
      private var _tweenEasing:Number;
      
      private var _tweenCurve:CurveData;
      
      private var _tweenTransform:Boolean;
      
      private var _tweenScale:Boolean;
      
      private var _rawAnimationScale:Number;
      
      private var _updateMode:int;
      
      private var _armature:Armature;
      
      private var _animation:Animation;
      
      private var _bone:Bone;
      
      private var _timelineData:TransformTimeline;
      
      private var _originTransform:DBTransform;
      
      private var _originPivot:Point;
      
      private var _durationTransform:DBTransform;
      
      private var _durationPivot:Point;
      
      public function TimelineState()
      {
         super();
         _transform = new DBTransform();
         _pivot = new Point();
         _durationTransform = new DBTransform();
         _durationPivot = new Point();
      }
      
      static function borrowObject() : TimelineState
      {
         if(_pool.length == 0)
         {
            return new TimelineState();
         }
         return _pool.pop();
      }
      
      static function returnObject(param1:TimelineState) : void
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
            _bone.removeState(this);
            _bone = null;
         }
         _armature = null;
         _animation = null;
         _animationState = null;
         _timelineData = null;
         _originTransform = null;
         _originPivot = null;
      }
      
      function fadeIn(param1:Bone, param2:AnimationState, param3:TransformTimeline) : void
      {
         _bone = param1;
         _armature = _bone.armature;
         _animation = _armature.animation;
         _animationState = param2;
         _timelineData = param3;
         _originTransform = _timelineData.originTransform;
         _originPivot = _timelineData.originPivot;
         name = param3.name;
         _totalTime = _timelineData.duration;
         _rawAnimationScale = _animationState.clip.scale;
         _isComplete = false;
         _blendEnabled = false;
         _tweenTransform = false;
         _tweenScale = false;
         _currentFrameIndex = -1;
         _currentTime = -1;
         _tweenEasing = NaN;
         _weight = 1;
         _transform.x = 0;
         _transform.y = 0;
         _transform.scaleX = 1;
         _transform.scaleY = 1;
         _transform.skewX = 0;
         _transform.skewY = 0;
         _pivot.x = 0;
         _pivot.y = 0;
         _durationTransform.x = 0;
         _durationTransform.y = 0;
         _durationTransform.scaleX = 1;
         _durationTransform.scaleY = 1;
         _durationTransform.skewX = 0;
         _durationTransform.skewY = 0;
         _durationPivot.x = 0;
         _durationPivot.y = 0;
         switch(int(_timelineData.frameList.length))
         {
            case 0:
               _updateMode = 0;
               break;
            case 1:
               _updateMode = 1;
         }
         _bone.addState(this);
      }
      
      function fadeOut() : void
      {
         _transform.skewX = TransformUtil.formatRadian(_transform.skewX);
         _transform.skewY = TransformUtil.formatRadian(_transform.skewY);
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
                  _bone.arriveAtFrame(_loc3_,this,_animationState,true);
               }
               _currentFrameDuration = _loc9_.duration;
               _currentFramePosition = _loc9_.position;
               _loc3_ = _loc9_;
               _loc10_++;
            }
            if(_loc9_)
            {
               _bone.arriveAtFrame(_loc9_,this,_animationState,false);
               _blendEnabled = !isNaN(_loc9_.tweenEasing);
               if(_blendEnabled)
               {
                  updateToNextFrame(_loc6_);
               }
               else
               {
                  _tweenEasing = NaN;
                  _tweenTransform = false;
                  _tweenScale = false;
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
         var _loc4_:TransformFrame = _timelineData.frameList[_currentFrameIndex] as TransformFrame;
         var _loc2_:TransformFrame = _timelineData.frameList[_loc5_] as TransformFrame;
         var _loc3_:Boolean = false;
         if(_loc5_ == 0 && (!_animationState.lastFrameAutoTween || _animationState.playTimes && _animationState.currentPlayTimes >= _animationState.playTimes && ((_currentFramePosition + _currentFrameDuration) / _totalTime + param1 - _timelineData.offset) * _timelineData.scale > 0.999999))
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
            _durationPivot.x = _loc2_.pivot.x - _loc4_.pivot.x;
            _durationPivot.y = _loc2_.pivot.y - _loc4_.pivot.y;
            if(_durationTransform.x || Number(_durationTransform.y) || Number(_durationTransform.skewX) || Number(_durationTransform.skewY) || Number(_durationTransform.scaleX) || Number(_durationTransform.scaleY) || Number(_durationPivot.x) || Number(_durationPivot.y))
            {
               _tweenTransform = true;
               _tweenScale = _loc4_.tweenScale;
            }
            else
            {
               _tweenTransform = false;
               _tweenScale = false;
            }
         }
         else
         {
            _tweenTransform = false;
            _tweenScale = false;
         }
         if(!_tweenTransform)
         {
            if(_animationState.additiveBlending)
            {
               _transform.x = _loc4_.transform.x;
               _transform.y = _loc4_.transform.y;
               _transform.skewX = _loc4_.transform.skewX;
               _transform.skewY = _loc4_.transform.skewY;
               _transform.scaleX = _loc4_.transform.scaleX;
               _transform.scaleY = _loc4_.transform.scaleY;
               _pivot.x = _loc4_.pivot.x;
               _pivot.y = _loc4_.pivot.y;
            }
            else
            {
               _transform.x = _originTransform.x + _loc4_.transform.x;
               _transform.y = _originTransform.y + _loc4_.transform.y;
               _transform.skewX = _originTransform.skewX + _loc4_.transform.skewX;
               _transform.skewY = _originTransform.skewY + _loc4_.transform.skewY;
               _transform.scaleX = _originTransform.scaleX * _loc4_.transform.scaleX;
               _transform.scaleY = _originTransform.scaleY * _loc4_.transform.scaleY;
               _pivot.x = _originPivot.x + _loc4_.pivot.x;
               _pivot.y = _originPivot.y + _loc4_.pivot.y;
            }
            _bone.invalidUpdate();
         }
         else if(!_tweenScale)
         {
            if(_animationState.additiveBlending)
            {
               _transform.scaleX = _loc4_.transform.scaleX;
               _transform.scaleY = _loc4_.transform.scaleY;
            }
            else
            {
               _transform.scaleX = _originTransform.scaleX * _loc4_.transform.scaleX;
               _transform.scaleY = _originTransform.scaleY * _loc4_.transform.scaleY;
            }
         }
      }
      
      private function updateTween() : void
      {
         var _loc1_:Number = NaN;
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:TransformFrame = _timelineData.frameList[_currentFrameIndex] as TransformFrame;
         if(_tweenTransform)
         {
            _loc1_ = (_currentTime - _currentFramePosition) / _currentFrameDuration;
            if(_tweenCurve != null)
            {
               _loc1_ = _tweenCurve.getValueByProgress(_loc1_);
            }
            else if(_tweenEasing)
            {
               _loc1_ = MathUtil.getEaseValue(_loc1_,_tweenEasing);
            }
            _loc4_ = _loc3_.transform;
            _loc2_ = _loc3_.pivot;
            if(_animationState.additiveBlending)
            {
               _transform.x = _loc4_.x + _durationTransform.x * _loc1_;
               _transform.y = _loc4_.y + _durationTransform.y * _loc1_;
               _transform.skewX = _loc4_.skewX + _durationTransform.skewX * _loc1_;
               _transform.skewY = _loc4_.skewY + _durationTransform.skewY * _loc1_;
               if(_tweenScale)
               {
                  _transform.scaleX = _loc4_.scaleX + _durationTransform.scaleX * _loc1_;
                  _transform.scaleY = _loc4_.scaleY + _durationTransform.scaleY * _loc1_;
               }
               _pivot.x = _loc2_.x + _durationPivot.x * _loc1_;
               _pivot.y = _loc2_.y + _durationPivot.y * _loc1_;
            }
            else
            {
               _transform.x = _originTransform.x + _loc4_.x + _durationTransform.x * _loc1_;
               _transform.y = _originTransform.y + _loc4_.y + _durationTransform.y * _loc1_;
               _transform.skewX = _originTransform.skewX + _loc4_.skewX + _durationTransform.skewX * _loc1_;
               _transform.skewY = _originTransform.skewY + _loc4_.skewY + _durationTransform.skewY * _loc1_;
               if(_tweenScale)
               {
                  _transform.scaleX = _originTransform.scaleX * _loc4_.scaleX + _durationTransform.scaleX * _loc1_;
                  _transform.scaleY = _originTransform.scaleY * _loc4_.scaleY + _durationTransform.scaleY * _loc1_;
               }
               _pivot.x = _originPivot.x + _loc2_.x + _durationPivot.x * _loc1_;
               _pivot.y = _originPivot.y + _loc2_.y + _durationPivot.y * _loc1_;
            }
            _bone.invalidUpdate();
         }
      }
      
      private function updateSingleFrame() : void
      {
         var _loc1_:TransformFrame = _timelineData.frameList[0] as TransformFrame;
         _bone.arriveAtFrame(_loc1_,this,_animationState,false);
         _isComplete = true;
         _tweenEasing = NaN;
         _tweenTransform = false;
         _tweenScale = false;
         _blendEnabled = true;
         if(_animationState.additiveBlending)
         {
            _transform.x = _loc1_.transform.x;
            _transform.y = _loc1_.transform.y;
            _transform.skewX = _loc1_.transform.skewX;
            _transform.skewY = _loc1_.transform.skewY;
            _transform.scaleX = _loc1_.transform.scaleX;
            _transform.scaleY = _loc1_.transform.scaleY;
            _pivot.x = _loc1_.pivot.x;
            _pivot.y = _loc1_.pivot.y;
         }
         else
         {
            _transform.x = _originTransform.x + _loc1_.transform.x;
            _transform.y = _originTransform.y + _loc1_.transform.y;
            _transform.skewX = _originTransform.skewX + _loc1_.transform.skewX;
            _transform.skewY = _originTransform.skewY + _loc1_.transform.skewY;
            _transform.scaleX = _originTransform.scaleX * _loc1_.transform.scaleX;
            _transform.scaleY = _originTransform.scaleY * _loc1_.transform.scaleY;
            _pivot.x = _originPivot.x + _loc1_.pivot.x;
            _pivot.y = _originPivot.y + _loc1_.pivot.y;
         }
         _bone.invalidUpdate();
      }
   }
}
