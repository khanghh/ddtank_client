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
      
      public static function initWithArmatureData(param1:ArmatureData, param2:Number = 0) : AnimationCacheManager
      {
         var _loc3_:* = null;
         var _loc4_:AnimationCacheManager = new AnimationCacheManager();
         _loc4_.armatureData = param1;
         if(param2 <= 0)
         {
            _loc3_ = param1.animationDataList[0];
            if(_loc3_)
            {
               _loc4_.frameRate = _loc3_.frameRate;
            }
         }
         else
         {
            _loc4_.frameRate = param2;
         }
         return _loc4_;
      }
      
      public function initAllAnimationCache() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = armatureData.animationDataList;
         for each(var _loc1_ in armatureData.animationDataList)
         {
            animationCacheDic[_loc1_.name] = AnimationCache.initWithAnimationData(_loc1_,armatureData);
         }
      }
      
      public function initAnimationCache(param1:String) : void
      {
         animationCacheDic[param1] = AnimationCache.initWithAnimationData(armatureData.getAnimationData(param1),armatureData);
      }
      
      public function bindCacheUserArmatures(param1:Array) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for each(var _loc2_ in param1)
         {
            bindCacheUserArmature(_loc2_);
         }
      }
      
      public function bindCacheUserArmature(param1:ICacheableArmature) : void
      {
         var _loc2_:* = null;
         param1.getAnimation().animationCacheManager = this;
         var _loc3_:Object = param1.getSlotDic();
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(_loc2_ in _loc3_)
         {
            _loc2_.frameCache = slotFrameCacheDic[_loc2_.name];
         }
      }
      
      public function setCacheGeneratorArmature(param1:ICacheableArmature) : void
      {
         var _loc3_:* = null;
         cacheGeneratorArmature = param1;
         var _loc4_:Object = param1.getSlotDic();
         var _loc6_:int = 0;
         var _loc5_:* = param1.getSlotDic();
         for each(_loc3_ in param1.getSlotDic())
         {
            slotFrameCacheDic[_loc3_.name] = new SlotFrameCache();
         }
         var _loc8_:int = 0;
         var _loc7_:* = animationCacheDic;
         for each(var _loc2_ in animationCacheDic)
         {
            _loc2_.initSlotTimelineCacheDic(_loc4_,slotFrameCacheDic);
         }
      }
      
      public function generateAllAnimationCache(param1:Boolean) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = animationCacheDic;
         for each(var _loc2_ in animationCacheDic)
         {
            generateAnimationCache(_loc2_.name,param1);
         }
      }
      
      public function generateAnimationCache(param1:String, param2:Boolean) : void
      {
         var _loc8_:Number = NaN;
         var _loc7_:Boolean = cacheGeneratorArmature.enableCache;
         cacheGeneratorArmature.enableCache = false;
         var _loc5_:AnimationCache = animationCacheDic[param1];
         if(!_loc5_)
         {
            return;
         }
         var _loc4_:IAnimationState = cacheGeneratorArmature.getAnimation().animationState;
         var _loc6_:Number = 1 / frameRate;
         if(param2)
         {
            cacheGeneratorArmature.getAnimation().gotoAndPlay(param1,0,-1,0);
         }
         else
         {
            cacheGeneratorArmature.getAnimation().gotoAndPlay(param1,0,-1,1);
         }
         var _loc3_:Boolean = cacheGeneratorArmature.enableEventDispatch;
         cacheGeneratorArmature.enableEventDispatch = false;
         do
         {
            _loc8_ = _loc4_.progress;
            cacheGeneratorArmature.advanceTime(_loc6_);
            _loc5_.addFrame();
         }
         while(_loc4_.progress >= _loc8_ && _loc4_.progress < 1);
         
         cacheGeneratorArmature.enableEventDispatch = _loc3_;
         resetCacheGeneratorArmature();
         cacheGeneratorArmature.enableCache = _loc7_;
      }
      
      public function resetCacheGeneratorArmature() : void
      {
         cacheGeneratorArmature.resetAnimation();
      }
      
      public function getAnimationCache(param1:String) : AnimationCache
      {
         return animationCacheDic[param1];
      }
   }
}
