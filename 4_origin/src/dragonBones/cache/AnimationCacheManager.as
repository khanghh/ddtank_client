package dragonBones.cache
{
   import dragonBones.core.IAnimationState;
   import dragonBones.core.ICacheUser;
   import dragonBones.core.ICacheableArmature;
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.ArmatureData;
   
   public class AnimationCacheManager
   {
       
      
      public var cacheGeneratorArmature:ICacheableArmature;
      
      public var armatureData:ArmatureData;
      
      public var frameRate:Number;
      
      public var animationCacheDic:Object;
      
      public var slotFrameCacheDic:Object;
      
      public function AnimationCacheManager()
      {
         animationCacheDic = {};
         slotFrameCacheDic = {};
         super();
      }
      
      public static function initWithArmatureData(armatureData:ArmatureData, frameRate:Number = 0) : AnimationCacheManager
      {
         var animationData:* = null;
         var output:AnimationCacheManager = new AnimationCacheManager();
         output.armatureData = armatureData;
         if(frameRate <= 0)
         {
            animationData = armatureData.animationDataList[0];
            if(animationData)
            {
               output.frameRate = animationData.frameRate;
            }
         }
         else
         {
            output.frameRate = frameRate;
         }
         return output;
      }
      
      public function initAllAnimationCache() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = armatureData.animationDataList;
         for each(var animationData in armatureData.animationDataList)
         {
            animationCacheDic[animationData.name] = AnimationCache.initWithAnimationData(animationData,armatureData);
         }
      }
      
      public function initAnimationCache(animationName:String) : void
      {
         animationCacheDic[animationName] = AnimationCache.initWithAnimationData(armatureData.getAnimationData(animationName),armatureData);
      }
      
      public function bindCacheUserArmatures(armatures:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = armatures;
         for each(var armature in armatures)
         {
            bindCacheUserArmature(armature);
         }
      }
      
      public function bindCacheUserArmature(armature:ICacheableArmature) : void
      {
         var cacheUser:* = null;
         armature.getAnimation().animationCacheManager = this;
         var slotDic:Object = armature.getSlotDic();
         var _loc5_:int = 0;
         var _loc4_:* = slotDic;
         for each(cacheUser in slotDic)
         {
            cacheUser.frameCache = slotFrameCacheDic[cacheUser.name];
         }
      }
      
      public function setCacheGeneratorArmature(armature:ICacheableArmature) : void
      {
         var cacheUser:* = null;
         cacheGeneratorArmature = armature;
         var slotDic:Object = armature.getSlotDic();
         var _loc6_:int = 0;
         var _loc5_:* = armature.getSlotDic();
         for each(cacheUser in armature.getSlotDic())
         {
            slotFrameCacheDic[cacheUser.name] = new SlotFrameCache();
         }
         var _loc8_:int = 0;
         var _loc7_:* = animationCacheDic;
         for each(var animationCache in animationCacheDic)
         {
            animationCache.initSlotTimelineCacheDic(slotDic,slotFrameCacheDic);
         }
      }
      
      public function generateAllAnimationCache(loop:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = animationCacheDic;
         for each(var animationCache in animationCacheDic)
         {
            generateAnimationCache(animationCache.name,loop);
         }
      }
      
      public function generateAnimationCache(animationName:String, loop:Boolean) : void
      {
         var lastProgress:Number = NaN;
         var temp:Boolean = cacheGeneratorArmature.enableCache;
         cacheGeneratorArmature.enableCache = false;
         var animationCache:AnimationCache = animationCacheDic[animationName];
         if(!animationCache)
         {
            return;
         }
         var animationState:IAnimationState = cacheGeneratorArmature.getAnimation().animationState;
         var passTime:Number = 1 / frameRate;
         if(loop)
         {
            cacheGeneratorArmature.getAnimation().gotoAndPlay(animationName,0,-1,0);
         }
         else
         {
            cacheGeneratorArmature.getAnimation().gotoAndPlay(animationName,0,-1,1);
         }
         var tempEnableEventDispatch:Boolean = cacheGeneratorArmature.enableEventDispatch;
         cacheGeneratorArmature.enableEventDispatch = false;
         do
         {
            lastProgress = animationState.progress;
            cacheGeneratorArmature.advanceTime(passTime);
            animationCache.addFrame();
         }
         while(animationState.progress >= lastProgress && animationState.progress < 1);
         
         cacheGeneratorArmature.enableEventDispatch = tempEnableEventDispatch;
         resetCacheGeneratorArmature();
         cacheGeneratorArmature.enableCache = temp;
      }
      
      public function resetCacheGeneratorArmature() : void
      {
         cacheGeneratorArmature.resetAnimation();
      }
      
      public function getAnimationCache(animationName:String) : AnimationCache
      {
         return animationCacheDic[animationName];
      }
   }
}
