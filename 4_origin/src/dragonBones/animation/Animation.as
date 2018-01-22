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
      
      public function Animation(param1:Armature)
      {
         super();
         _armature = param1;
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
         var _loc1_:* = null;
         var _loc2_:int = _animationStateList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            _loc1_ = _animationStateList[_loc2_];
            _loc1_.resetTimelineStateList();
            AnimationState.returnObject(_loc1_);
         }
         _animationStateList.length = 0;
      }
      
      public function gotoAndPlay(param1:String, param2:Number = -1, param3:Number = -1, param4:Number = NaN, param5:int = 0, param6:String = null, param7:String = "sameLayerAndGroup", param8:Boolean = true, param9:Boolean = true) : AnimationState
      {
         var _loc11_:* = null;
         var _loc12_:Number = NaN;
         var _loc10_:* = null;
         var _loc15_:* = null;
         if(!_animationDataList)
         {
            return null;
         }
         var _loc13_:int = _animationDataList.length;
         while(true)
         {
            _loc13_--;
            if(_loc13_)
            {
               if(_animationDataList[_loc13_].name == param1)
               {
                  _loc11_ = _animationDataList[_loc13_];
                  break;
               }
               continue;
            }
            break;
         }
         if(!_loc11_)
         {
            return null;
         }
         _isPlaying = true;
         _isFading = true;
         param2 = param2 < 0?_loc11_.fadeTime < 0?0.3:Number(_loc11_.fadeTime):Number(param2);
         if(param3 < 0)
         {
            _loc12_ = _loc11_.scale < 0?1:Number(_loc11_.scale);
         }
         else
         {
            _loc12_ = param3 * 1000 / _loc11_.duration;
         }
         param4 = !!isNaN(param4)?_loc11_.playTimes:param4;
         var _loc16_:* = param7;
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
                     _loc13_ = _animationStateList.length;
                     while(true)
                     {
                        _loc13_--;
                        if(!_loc13_)
                        {
                           break;
                        }
                        _loc10_ = _animationStateList[_loc13_];
                        if(_loc10_.layer == param5 && _loc10_.group == param6)
                        {
                           _loc10_.fadeOut(param2,param8);
                        }
                     }
                  }
                  else
                  {
                     _loc13_ = _animationStateList.length;
                     while(true)
                     {
                        _loc13_--;
                        if(!_loc13_)
                        {
                           break;
                        }
                        _loc10_ = _animationStateList[_loc13_];
                        _loc10_.fadeOut(param2,param8);
                     }
                  }
               }
               else
               {
                  _loc13_ = _animationStateList.length;
                  while(true)
                  {
                     _loc13_--;
                     if(!_loc13_)
                     {
                        break;
                     }
                     _loc10_ = _animationStateList[_loc13_];
                     if(_loc10_.group == param6)
                     {
                        _loc10_.fadeOut(param2,param8);
                     }
                  }
               }
            }
            else
            {
               _loc13_ = _animationStateList.length;
               while(true)
               {
                  _loc13_--;
                  if(!_loc13_)
                  {
                     break;
                  }
                  _loc10_ = _animationStateList[_loc13_];
                  if(_loc10_.layer == param5)
                  {
                     _loc10_.fadeOut(param2,param8);
                  }
               }
            }
         }
         _lastAnimationState = AnimationState.borrowObject();
         _lastAnimationState._layer = param5;
         _lastAnimationState._group = param6;
         _lastAnimationState.autoTween = tweenEnabled;
         _lastAnimationState.fadeIn(_armature,_loc11_,param2,1 / _loc12_,param4,param9);
         addState(_lastAnimationState);
         var _loc14_:Vector.<Slot> = _armature.getSlots(false);
         _loc13_ = _loc14_.length;
         while(true)
         {
            _loc13_--;
            if(!_loc13_)
            {
               break;
            }
            _loc15_ = _loc14_[_loc13_];
            if(_loc15_.childArmature)
            {
               _loc15_.childArmature.animation.gotoAndPlay(param1,param2);
            }
         }
         return _lastAnimationState;
      }
      
      public function gotoAndStop(param1:String, param2:Number, param3:Number = -1, param4:Number = 0, param5:Number = -1, param6:int = 0, param7:String = null, param8:String = "all") : AnimationState
      {
         var _loc9_:AnimationState = getState(param1,param6);
         if(!_loc9_)
         {
            _loc9_ = gotoAndPlay(param1,param4,param5,NaN,param6,param7,param8);
         }
         if(param3 >= 0)
         {
            _loc9_.setCurrentTime(_loc9_.totalTime * param3);
         }
         else
         {
            _loc9_.setCurrentTime(param2);
         }
         _loc9_.stop();
         return _loc9_;
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
      
      public function getState(param1:String, param2:int = 0) : AnimationState
      {
         var _loc3_:* = null;
         var _loc4_:int = _animationStateList.length;
         while(true)
         {
            _loc4_--;
            if(!_loc4_)
            {
               break;
            }
            _loc3_ = _animationStateList[_loc4_];
            if(_loc3_.name == param1 && _loc3_.layer == param2)
            {
               return _loc3_;
            }
         }
         return null;
      }
      
      public function hasAnimation(param1:String) : Boolean
      {
         var _loc2_:int = _animationDataList.length;
         while(true)
         {
            _loc2_--;
            if(!_loc2_)
            {
               break;
            }
            if(_animationDataList[_loc2_].name == param1)
            {
               return true;
            }
         }
         return false;
      }
      
      function advanceTime(param1:Number) : void
      {
         var _loc2_:* = null;
         if(!_isPlaying)
         {
            return;
         }
         var _loc3_:Boolean = false;
         param1 = param1 * _timeScale;
         var _loc4_:int = _animationStateList.length;
         while(true)
         {
            _loc4_--;
            if(!_loc4_)
            {
               break;
            }
            _loc2_ = _animationStateList[_loc4_];
            if(_loc2_.advanceTime(param1))
            {
               removeState(_loc2_);
            }
            else if(_loc2_.fadeState != 1)
            {
               _loc3_ = true;
            }
         }
         _isFading = _loc3_;
      }
      
      function updateAnimationStates() : void
      {
         var _loc1_:int = _animationStateList.length;
         while(true)
         {
            _loc1_--;
            if(!_loc1_)
            {
               break;
            }
            _animationStateList[_loc1_].updateTimelineStates();
         }
      }
      
      private function addState(param1:AnimationState) : void
      {
         if(_animationStateList.indexOf(param1) < 0)
         {
            _animationStateList.unshift(param1);
            _animationStateCount = _animationStateList.length;
         }
      }
      
      private function removeState(param1:AnimationState) : void
      {
         var _loc2_:int = _animationStateList.indexOf(param1);
         if(_loc2_ >= 0)
         {
            _animationStateList.splice(_loc2_,1);
            AnimationState.returnObject(param1);
            if(_lastAnimationState == param1)
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
         var _loc1_:int = 0;
         if(_lastAnimationState)
         {
            if(!_lastAnimationState.isComplete)
            {
               return false;
            }
            _loc1_ = _animationStateList.length;
            while(true)
            {
               _loc1_--;
               if(!_loc1_)
               {
                  break;
               }
               if(!_animationStateList[_loc1_].isComplete)
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
      
      public function set timeScale(param1:Number) : void
      {
         if(isNaN(param1) || param1 < 0)
         {
            param1 = 1;
         }
         _timeScale = param1;
      }
      
      public function get animationDataList() : Vector.<AnimationData>
      {
         return _animationDataList;
      }
      
      public function set animationDataList(param1:Vector.<AnimationData>) : void
      {
         _animationDataList = param1;
         _animationList.length = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _animationDataList;
         for each(var _loc2_ in _animationDataList)
         {
            _animationList[_animationList.length] = _loc2_.name;
         }
      }
   }
}
