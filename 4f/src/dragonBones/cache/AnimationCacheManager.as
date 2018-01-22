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
      
      public function AnimationCacheManager(){super();}
      
      public static function initWithArmatureData(param1:ArmatureData, param2:Number = 0) : AnimationCacheManager{return null;}
      
      public function initAllAnimationCache() : void{}
      
      public function initAnimationCache(param1:String) : void{}
      
      public function bindCacheUserArmatures(param1:Array) : void{}
      
      public function bindCacheUserArmature(param1:ICacheableArmature) : void{}
      
      public function setCacheGeneratorArmature(param1:ICacheableArmature) : void{}
      
      public function generateAllAnimationCache(param1:Boolean) : void{}
      
      public function generateAnimationCache(param1:String, param2:Boolean) : void{}
      
      public function resetCacheGeneratorArmature() : void{}
      
      public function getAnimationCache(param1:String) : AnimationCache{return null;}
   }
}
