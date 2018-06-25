package dragonBones.animation
{
   import dragonBones.Armature;
   import dragonBones.Slot;
   import dragonBones.§core:dragonBones_internal§._animationStateCount;
   import dragonBones.§core:dragonBones_internal§._isFading;
   import dragonBones.§core:dragonBones_internal§._lastAnimationState;
   import dragonBones.§core:dragonBones_internal§.resetAnimationStateList;
   import dragonBones.objects.AnimationData;
   
   public class Animation
   {
      
      public static const NONE:String = "none";
      
      public static const SAME_LAYER:String = "sameLayer";
      
      public static const SAME_GROUP:String = "sameGroup";
      
      public static const SAME_LAYER_AND_GROUP:String = "sameLayerAndGroup";
      
      public static const ALL:String = "all";
       
      
      public var tweenEnabled:Boolean;
      
      private var _armature:Armature;
      
      private var _animationStateList:Vector.<AnimationState>;
      
      private var _animationDataList:Vector.<AnimationData>;
      
      private var _animationList:Vector.<String>;
      
      private var _isPlaying:Boolean;
      
      private var _timeScale:Number;
      
      var _lastAnimationState:AnimationState;
      
      var _isFading:Boolean;
      
      var _animationStateCount:int;
      
      public function Animation(armature:Armature)
      {
         super();
         _armature = armature;
         _animationList = new Vector.<String>();
         _animationStateList = new Vector.<AnimationState>();
         _timeScale = 1;
         _isPlaying = false;
         tweenEnabled = true;
      }
      
      public function dispose() : void
      {
         if(!_armature)
         {
            return;
         }
         resetAnimationStateList();
         _animationList.length = 0;
         _armature = null;
         _animationDataList = null;
         _animationList = null;
         _animationStateList = null;
      }
      
      function resetAnimationStateList() : void
      {
         var animationState:* = null;
         var i:int = _animationStateList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            animationState = _animationStateList[i];
            animationState.resetTimelineStateList();
            AnimationState.returnObject(animationState);
         }
         _animationStateList.length = 0;
      }
      
      public function gotoAndPlay(animationName:String, fadeInTime:Number = -1, duration:Number = -1, playTimes:Number = NaN, layer:int = 0, group:String = null, fadeOutMode:String = "sameLayerAndGroup", pauseFadeOut:Boolean = true, pauseFadeIn:Boolean = true) : AnimationState
      {
         var animationData:* = null;
         var durationScale:Number = NaN;
         var animationState:* = null;
         var slot:* = null;
         if(!_animationDataList)
         {
            return null;
         }
         var i:int = _animationDataList.length;
         while(true)
         {
            i--;
            if(i)
            {
               if(_animationDataList[i].name == animationName)
               {
                  animationData = _animationDataList[i];
                  break;
               }
               continue;
            }
            break;
         }
         if(!animationData)
         {
            return null;
         }
         _isPlaying = true;
         _isFading = true;
         fadeInTime = fadeInTime < 0?animationData.fadeTime < 0?0.3:Number(animationData.fadeTime):Number(fadeInTime);
         if(duration < 0)
         {
            durationScale = animationData.scale < 0?1:Number(animationData.scale);
         }
         else
         {
            durationScale = duration * 1000 / animationData.duration;
         }
         playTimes = !!isNaN(playTimes)?animationData.playTimes:playTimes;
         var _loc16_:* = fadeOutMode;
         if("none" !== _loc16_)
         {
            if("sameLayer" !== _loc16_)
            {
               if("sameGroup" !== _loc16_)
               {
                  if("all" !== _loc16_)
                  {
                     if("sameLayerAndGroup" !== _loc16_)
                     {
                     }
                     i = _animationStateList.length;
                     while(true)
                     {
                        i--;
                        if(!i)
                        {
                           break;
                        }
                        animationState = _animationStateList[i];
                        if(animationState.layer == layer && animationState.group == group)
                        {
                           animationState.fadeOut(fadeInTime,pauseFadeOut);
                        }
                     }
                  }
                  else
                  {
                     i = _animationStateList.length;
                     while(true)
                     {
                        i--;
                        if(!i)
                        {
                           break;
                        }
                        animationState = _animationStateList[i];
                        animationState.fadeOut(fadeInTime,pauseFadeOut);
                     }
                  }
               }
               else
               {
                  i = _animationStateList.length;
                  while(true)
                  {
                     i--;
                     if(!i)
                     {
                        break;
                     }
                     animationState = _animationStateList[i];
                     if(animationState.group == group)
                     {
                        animationState.fadeOut(fadeInTime,pauseFadeOut);
                     }
                  }
               }
            }
            else
            {
               i = _animationStateList.length;
               while(true)
               {
                  i--;
                  if(!i)
                  {
                     break;
                  }
                  animationState = _animationStateList[i];
                  if(animationState.layer == layer)
                  {
                     animationState.fadeOut(fadeInTime,pauseFadeOut);
                  }
               }
            }
         }
         _lastAnimationState = AnimationState.borrowObject();
         _lastAnimationState._layer = layer;
         _lastAnimationState._group = group;
         _lastAnimationState.autoTween = tweenEnabled;
         _lastAnimationState.fadeIn(_armature,animationData,fadeInTime,1 / durationScale,playTimes,pauseFadeIn);
         addState(_lastAnimationState);
         var slotList:Vector.<Slot> = _armature.getSlots(false);
         i = slotList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            slot = slotList[i];
            if(slot.childArmature)
            {
               slot.childArmature.animation.gotoAndPlay(animationName,fadeInTime);
            }
         }
         return _lastAnimationState;
      }
      
      public function gotoAndStop(animationName:String, time:Number, normalizedTime:Number = -1, fadeInTime:Number = 0, duration:Number = -1, layer:int = 0, group:String = null, fadeOutMode:String = "all") : AnimationState
      {
         var animationState:AnimationState = getState(animationName,layer);
         if(!animationState)
         {
            animationState = gotoAndPlay(animationName,fadeInTime,duration,NaN,layer,group,fadeOutMode);
         }
         if(normalizedTime >= 0)
         {
            animationState.setCurrentTime(animationState.totalTime * normalizedTime);
         }
         else
         {
            animationState.setCurrentTime(time);
         }
         animationState.stop();
         return animationState;
      }
      
      public function play() : void
      {
         if(!_animationDataList || _animationDataList.length == 0)
         {
            return;
         }
         if(!_lastAnimationState)
         {
            gotoAndPlay(_animationDataList[0].name);
         }
         else if(!_isPlaying)
         {
            _isPlaying = true;
         }
         else
         {
            gotoAndPlay(_lastAnimationState.name);
         }
      }
      
      public function stop() : void
      {
         _isPlaying = false;
      }
      
      public function getState(name:String, layer:int = 0) : AnimationState
      {
         var animationState:* = null;
         var i:int = _animationStateList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            animationState = _animationStateList[i];
            if(animationState.name == name && animationState.layer == layer)
            {
               return animationState;
            }
         }
         return null;
      }
      
      public function hasAnimation(animationName:String) : Boolean
      {
         var i:int = _animationDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            if(_animationDataList[i].name == animationName)
            {
               return true;
            }
         }
         return false;
      }
      
      function advanceTime(passedTime:Number) : void
      {
         var animationState:* = null;
         if(!_isPlaying)
         {
            return;
         }
         var isFading:Boolean = false;
         passedTime = passedTime * _timeScale;
         var i:int = _animationStateList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            animationState = _animationStateList[i];
            if(animationState.advanceTime(passedTime))
            {
               removeState(animationState);
            }
            else if(animationState.fadeState != 1)
            {
               isFading = true;
            }
         }
         _isFading = isFading;
      }
      
      function updateAnimationStates() : void
      {
         var i:int = _animationStateList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            _animationStateList[i].updateTimelineStates();
         }
      }
      
      private function addState(animationState:AnimationState) : void
      {
         if(_animationStateList.indexOf(animationState) < 0)
         {
            _animationStateList.unshift(animationState);
            _animationStateCount = _animationStateList.length;
         }
      }
      
      private function removeState(animationState:AnimationState) : void
      {
         var index:int = _animationStateList.indexOf(animationState);
         if(index >= 0)
         {
            _animationStateList.splice(index,1);
            AnimationState.returnObject(animationState);
            if(_lastAnimationState == animationState)
            {
               if(_animationStateList.length > 0)
               {
                  _lastAnimationState = _animationStateList[0];
               }
               else
               {
                  _lastAnimationState = null;
               }
            }
            _animationStateCount = _animationStateList.length;
         }
      }
      
      public function get movementList() : Vector.<String>
      {
         return _animationList;
      }
      
      public function get movementID() : String
      {
         return lastAnimationName;
      }
      
      public function get lastAnimationState() : AnimationState
      {
         return _lastAnimationState;
      }
      
      public function get lastAnimationName() : String
      {
         return !!_lastAnimationState?_lastAnimationState.name:null;
      }
      
      public function get animationList() : Vector.<String>
      {
         return _animationList;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying && !isComplete;
      }
      
      public function get isComplete() : Boolean
      {
         var i:int = 0;
         if(_lastAnimationState)
         {
            if(!_lastAnimationState.isComplete)
            {
               return false;
            }
            i = _animationStateList.length;
            while(true)
            {
               i--;
               if(!i)
               {
                  break;
               }
               if(!_animationStateList[i].isComplete)
               {
                  return false;
               }
            }
            return true;
         }
         return true;
      }
      
      public function get timeScale() : Number
      {
         return _timeScale;
      }
      
      public function set timeScale(value:Number) : void
      {
         if(isNaN(value) || value < 0)
         {
            value = 1;
         }
         _timeScale = value;
      }
      
      public function get animationDataList() : Vector.<AnimationData>
      {
         return _animationDataList;
      }
      
      public function set animationDataList(value:Vector.<AnimationData>) : void
      {
         _animationDataList = value;
         _animationList.length = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _animationDataList;
         for each(var animationData in _animationDataList)
         {
            _animationList[_animationList.length] = animationData.name;
         }
      }
   }
}
