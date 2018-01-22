package dragonBones.fast.animation
{
   import dragonBones.cache.AnimationCacheManager;
   import dragonBones.core.IArmature;
   import dragonBones.fast.FastArmature;
   import dragonBones.fast.FastSlot;
   import dragonBones.objects.AnimationData;
   
   public class FastAnimation
   {
       
      
      public var animationList:Vector.<String>;
      
      public var animationState:FastAnimationState;
      
      public var animationCacheManager:AnimationCacheManager;
      
      private var _armature:FastArmature;
      
      private var _animationDataList:Vector.<AnimationData>;
      
      private var _animationDataObj:Object;
      
      private var _isPlaying:Boolean;
      
      private var _timeScale:Number;
      
      public function FastAnimation(param1:FastArmature)
      {
         animationState = new FastAnimationState();
         super();
         _armature = param1;
         animationState._armature = param1;
         animationList = new Vector.<String>();
         _animationDataObj = {};
         _isPlaying = false;
         _timeScale = 1;
      }
      
      public function dispose() : void
      {
         if(!_armature)
         {
            return;
         }
         _armature = null;
         _animationDataList = null;
         animationList = null;
         animationState = null;
      }
      
      public function gotoAndPlay(param1:String, param2:Number = -1, param3:Number = -1, param4:Number = NaN) : FastAnimationState
      {
         var _loc8_:Number = NaN;
         var _loc6_:* = null;
         var _loc5_:* = null;
         if(!_animationDataList)
         {
            return null;
         }
         var _loc7_:AnimationData = _animationDataObj[param1];
         if(!_loc7_)
         {
            return null;
         }
         _isPlaying = true;
         param2 = param2 < 0?_loc7_.fadeTime < 0?0.3:Number(_loc7_.fadeTime):Number(param2);
         if(param3 < 0)
         {
            _loc8_ = _loc7_.scale < 0?1:Number(_loc7_.scale);
         }
         else
         {
            _loc8_ = param3 * 1000 / _loc7_.duration;
         }
         param4 = !!isNaN(param4)?_loc7_.playTimes:param4;
         animationState.fadeIn(_loc7_,param4,1 / _loc8_,param2);
         if(_armature.enableCache && animationCacheManager)
         {
            animationState.animationCache = animationCacheManager.getAnimationCache(param1);
         }
         var _loc9_:int = _armature.slotHasChildArmatureList.length;
         while(true)
         {
            _loc9_--;
            if(!_loc9_)
            {
               break;
            }
            _loc6_ = _armature.slotHasChildArmatureList[_loc9_];
            _loc5_ = _loc6_.childArmature as IArmature;
            if(_loc5_)
            {
               _loc5_.getAnimation().gotoAndPlay(param1);
            }
         }
         return animationState;
      }
      
      public function gotoAndStop(param1:String, param2:Number, param3:Number = -1, param4:Number = 0, param5:Number = -1) : FastAnimationState
      {
         if(!animationState.name != param1)
         {
            gotoAndPlay(param1,param4,param5);
         }
         if(param3 >= 0)
         {
            animationState.setCurrentTime(animationState.totalTime * param3);
         }
         else
         {
            animationState.setCurrentTime(param2);
         }
         animationState.stop();
         return animationState;
      }
      
      public function play() : void
      {
         if(!_animationDataList)
         {
            return;
         }
         if(!animationState.name)
         {
            gotoAndPlay(_animationDataList[0].name);
         }
         else if(!_isPlaying)
         {
            _isPlaying = true;
         }
         else
         {
            gotoAndPlay(animationState.name);
         }
      }
      
      public function stop() : void
      {
         _isPlaying = false;
      }
      
      function advanceTime(param1:Number) : void
      {
         if(!_isPlaying)
         {
            return;
         }
         animationState.advanceTime(param1 * _timeScale);
      }
      
      public function hasAnimation(param1:String) : Boolean
      {
         return _animationDataObj[param1] != null;
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
         animationList.length = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _animationDataList;
         for each(var _loc2_ in _animationDataList)
         {
            animationList.push(_loc2_.name);
            _animationDataObj[_loc2_.name] = _loc2_;
         }
      }
      
      public function get movementList() : Vector.<String>
      {
         return animationList;
      }
      
      public function get movementID() : String
      {
         return lastAnimationName;
      }
      
      public function get isPlaying() : Boolean
      {
         return _isPlaying && !isComplete;
      }
      
      public function get isComplete() : Boolean
      {
         return animationState.isComplete;
      }
      
      public function get lastAnimationState() : FastAnimationState
      {
         return animationState;
      }
      
      public function get lastAnimationName() : String
      {
         return !!animationState?animationState.name:null;
      }
   }
}
