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
      
      public function FastAnimation(armature:FastArmature)
      {
         animationState = new FastAnimationState();
         super();
         _armature = armature;
         animationState._armature = armature;
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
      
      public function gotoAndPlay(animationName:String, fadeInTime:Number = -1, duration:Number = -1, playTimes:Number = NaN) : FastAnimationState
      {
         var durationScale:Number = NaN;
         var slot:* = null;
         var childArmature:* = null;
         if(!_animationDataList)
         {
            return null;
         }
         var animationData:AnimationData = _animationDataObj[animationName];
         if(!animationData)
         {
            return null;
         }
         _isPlaying = true;
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
         animationState.fadeIn(animationData,playTimes,1 / durationScale,fadeInTime);
         if(_armature.enableCache && animationCacheManager)
         {
            animationState.animationCache = animationCacheManager.getAnimationCache(animationName);
         }
         var i:int = _armature.slotHasChildArmatureList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            slot = _armature.slotHasChildArmatureList[i];
            childArmature = slot.childArmature as IArmature;
            if(childArmature)
            {
               childArmature.getAnimation().gotoAndPlay(animationName);
            }
         }
         return animationState;
      }
      
      public function gotoAndStop(animationName:String, time:Number, normalizedTime:Number = -1, fadeInTime:Number = 0, duration:Number = -1) : FastAnimationState
      {
         if(!animationState.name != animationName)
         {
            gotoAndPlay(animationName,fadeInTime,duration);
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
      
      function advanceTime(passedTime:Number) : void
      {
         if(!_isPlaying)
         {
            return;
         }
         animationState.advanceTime(passedTime * _timeScale);
      }
      
      public function hasAnimation(animationName:String) : Boolean
      {
         return _animationDataObj[animationName] != null;
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
         animationList.length = 0;
         var _loc4_:int = 0;
         var _loc3_:* = _animationDataList;
         for each(var animationData in _animationDataList)
         {
            animationList.push(animationData.name);
            _animationDataObj[animationData.name] = animationData;
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
