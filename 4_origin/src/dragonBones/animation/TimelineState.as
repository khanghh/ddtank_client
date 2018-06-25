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
      
      static function returnObject(timeline:TimelineState) : void
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
      
      function fadeIn(bone:Bone, animationState:AnimationState, timelineData:TransformTimeline) : void
      {
         _bone = bone;
         _armature = _bone.armature;
         _animation = _armature.animation;
         _animationState = animationState;
         _timelineData = timelineData;
         _originTransform = _timelineData.originTransform;
         _originPivot = _timelineData.originPivot;
         name = timelineData.name;
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
            _lastTime = _currentTime;
            _currentTime = currentTime;
            frameList = _timelineData.frameList;
            for(i = 0,l = _timelineData.frameList.length; i < l; )
            {
               if(_currentFrameIndex < 0)
               {
                  _currentFrameIndex = 0;
               }
               else if(_currentTime < _currentFramePosition || _currentTime >= _currentFramePosition + _currentFrameDuration || _currentTime < _lastTime)
               {
                  _currentFrameIndex = Number(_currentFrameIndex) + 1;
                  _lastTime = _currentTime;
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
               currentFrame = frameList[_currentFrameIndex] as TransformFrame;
               if(prevFrame)
               {
                  _bone.arriveAtFrame(prevFrame,this,_animationState,true);
               }
               _currentFrameDuration = currentFrame.duration;
               _currentFramePosition = currentFrame.position;
               prevFrame = currentFrame;
               i++;
            }
            if(currentFrame)
            {
               _bone.arriveAtFrame(currentFrame,this,_animationState,false);
               _blendEnabled = !isNaN(currentFrame.tweenEasing);
               if(_blendEnabled)
               {
                  updateToNextFrame(currentPlayTimes);
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
      
      private function updateToNextFrame(currentPlayTimes:int) : void
      {
         var nextFrameIndex:int = _currentFrameIndex + 1;
         if(nextFrameIndex >= _timelineData.frameList.length)
         {
            nextFrameIndex = 0;
         }
         var currentFrame:TransformFrame = _timelineData.frameList[_currentFrameIndex] as TransformFrame;
         var nextFrame:TransformFrame = _timelineData.frameList[nextFrameIndex] as TransformFrame;
         var tweenEnabled:Boolean = false;
         if(nextFrameIndex == 0 && (!_animationState.lastFrameAutoTween || _animationState.playTimes && _animationState.currentPlayTimes >= _animationState.playTimes && ((_currentFramePosition + _currentFrameDuration) / _totalTime + currentPlayTimes - _timelineData.offset) * _timelineData.scale > 0.999999))
         {
            _tweenEasing = NaN;
            tweenEnabled = false;
         }
         else if(_animationState.autoTween)
         {
            _tweenEasing = _animationState.clip.tweenEasing;
            if(isNaN(_tweenEasing))
            {
               _tweenEasing = currentFrame.tweenEasing;
               _tweenCurve = currentFrame.curve;
               if(isNaN(_tweenEasing) && _tweenCurve == null)
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
            if((isNaN(_tweenEasing) || _tweenEasing == 10) && _tweenCurve == null)
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
            _durationTransform.x = nextFrame.transform.x - currentFrame.transform.x;
            _durationTransform.y = nextFrame.transform.y - currentFrame.transform.y;
            _durationTransform.skewX = nextFrame.transform.skewX - currentFrame.transform.skewX;
            _durationTransform.skewY = nextFrame.transform.skewY - currentFrame.transform.skewY;
            _durationTransform.scaleX = nextFrame.transform.scaleX - currentFrame.transform.scaleX + nextFrame.scaleOffset.x;
            _durationTransform.scaleY = nextFrame.transform.scaleY - currentFrame.transform.scaleY + nextFrame.scaleOffset.y;
            _durationTransform.normalizeRotation();
            if(nextFrameIndex == 0)
            {
               _durationTransform.skewX = TransformUtil.formatRadian(_durationTransform.skewX);
               _durationTransform.skewY = TransformUtil.formatRadian(_durationTransform.skewY);
            }
            _durationPivot.x = nextFrame.pivot.x - currentFrame.pivot.x;
            _durationPivot.y = nextFrame.pivot.y - currentFrame.pivot.y;
            if(_durationTransform.x || Number(_durationTransform.y) || Number(_durationTransform.skewX) || Number(_durationTransform.skewY) || Number(_durationTransform.scaleX) || Number(_durationTransform.scaleY) || Number(_durationPivot.x) || Number(_durationPivot.y))
            {
               _tweenTransform = true;
               _tweenScale = currentFrame.tweenScale;
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
               _transform.x = currentFrame.transform.x;
               _transform.y = currentFrame.transform.y;
               _transform.skewX = currentFrame.transform.skewX;
               _transform.skewY = currentFrame.transform.skewY;
               _transform.scaleX = currentFrame.transform.scaleX;
               _transform.scaleY = currentFrame.transform.scaleY;
               _pivot.x = currentFrame.pivot.x;
               _pivot.y = currentFrame.pivot.y;
            }
            else
            {
               _transform.x = _originTransform.x + currentFrame.transform.x;
               _transform.y = _originTransform.y + currentFrame.transform.y;
               _transform.skewX = _originTransform.skewX + currentFrame.transform.skewX;
               _transform.skewY = _originTransform.skewY + currentFrame.transform.skewY;
               _transform.scaleX = _originTransform.scaleX * currentFrame.transform.scaleX;
               _transform.scaleY = _originTransform.scaleY * currentFrame.transform.scaleY;
               _pivot.x = _originPivot.x + currentFrame.pivot.x;
               _pivot.y = _originPivot.y + currentFrame.pivot.y;
            }
            _bone.invalidUpdate();
         }
         else if(!_tweenScale)
         {
            if(_animationState.additiveBlending)
            {
               _transform.scaleX = currentFrame.transform.scaleX;
               _transform.scaleY = currentFrame.transform.scaleY;
            }
            else
            {
               _transform.scaleX = _originTransform.scaleX * currentFrame.transform.scaleX;
               _transform.scaleY = _originTransform.scaleY * currentFrame.transform.scaleY;
            }
         }
      }
      
      private function updateTween() : void
      {
         var progress:Number = NaN;
         var currentTransform:* = null;
         var currentPivot:* = null;
         var currentFrame:TransformFrame = _timelineData.frameList[_currentFrameIndex] as TransformFrame;
         if(_tweenTransform)
         {
            progress = (_currentTime - _currentFramePosition) / _currentFrameDuration;
            if(_tweenCurve != null)
            {
               progress = _tweenCurve.getValueByProgress(progress);
            }
            else if(_tweenEasing)
            {
               progress = MathUtil.getEaseValue(progress,_tweenEasing);
            }
            currentTransform = currentFrame.transform;
            currentPivot = currentFrame.pivot;
            if(_animationState.additiveBlending)
            {
               _transform.x = currentTransform.x + _durationTransform.x * progress;
               _transform.y = currentTransform.y + _durationTransform.y * progress;
               _transform.skewX = currentTransform.skewX + _durationTransform.skewX * progress;
               _transform.skewY = currentTransform.skewY + _durationTransform.skewY * progress;
               if(_tweenScale)
               {
                  _transform.scaleX = currentTransform.scaleX + _durationTransform.scaleX * progress;
                  _transform.scaleY = currentTransform.scaleY + _durationTransform.scaleY * progress;
               }
               _pivot.x = currentPivot.x + _durationPivot.x * progress;
               _pivot.y = currentPivot.y + _durationPivot.y * progress;
            }
            else
            {
               _transform.x = _originTransform.x + currentTransform.x + _durationTransform.x * progress;
               _transform.y = _originTransform.y + currentTransform.y + _durationTransform.y * progress;
               _transform.skewX = _originTransform.skewX + currentTransform.skewX + _durationTransform.skewX * progress;
               _transform.skewY = _originTransform.skewY + currentTransform.skewY + _durationTransform.skewY * progress;
               if(_tweenScale)
               {
                  _transform.scaleX = _originTransform.scaleX * currentTransform.scaleX + _durationTransform.scaleX * progress;
                  _transform.scaleY = _originTransform.scaleY * currentTransform.scaleY + _durationTransform.scaleY * progress;
               }
               _pivot.x = _originPivot.x + currentPivot.x + _durationPivot.x * progress;
               _pivot.y = _originPivot.y + currentPivot.y + _durationPivot.y * progress;
            }
            _bone.invalidUpdate();
         }
      }
      
      private function updateSingleFrame() : void
      {
         var currentFrame:TransformFrame = _timelineData.frameList[0] as TransformFrame;
         _bone.arriveAtFrame(currentFrame,this,_animationState,false);
         _isComplete = true;
         _tweenEasing = NaN;
         _tweenTransform = false;
         _tweenScale = false;
         _blendEnabled = true;
         if(_animationState.additiveBlending)
         {
            _transform.x = currentFrame.transform.x;
            _transform.y = currentFrame.transform.y;
            _transform.skewX = currentFrame.transform.skewX;
            _transform.skewY = currentFrame.transform.skewY;
            _transform.scaleX = currentFrame.transform.scaleX;
            _transform.scaleY = currentFrame.transform.scaleY;
            _pivot.x = currentFrame.pivot.x;
            _pivot.y = currentFrame.pivot.y;
         }
         else
         {
            _transform.x = _originTransform.x + currentFrame.transform.x;
            _transform.y = _originTransform.y + currentFrame.transform.y;
            _transform.skewX = _originTransform.skewX + currentFrame.transform.skewX;
            _transform.skewY = _originTransform.skewY + currentFrame.transform.skewY;
            _transform.scaleX = _originTransform.scaleX * currentFrame.transform.scaleX;
            _transform.scaleY = _originTransform.scaleY * currentFrame.transform.scaleY;
            _pivot.x = _originPivot.x + currentFrame.pivot.x;
            _pivot.y = _originPivot.y + currentFrame.pivot.y;
         }
         _bone.invalidUpdate();
      }
   }
}
