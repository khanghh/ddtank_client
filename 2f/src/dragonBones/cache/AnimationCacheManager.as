package dragonBones.cache{   import dragonBones.core.IAnimationState;   import dragonBones.core.ICacheUser;   import dragonBones.core.ICacheableArmature;   import dragonBones.objects.AnimationData;   import dragonBones.objects.ArmatureData;      public class AnimationCacheManager   {                   public var cacheGeneratorArmature:ICacheableArmature;            public var armatureData:ArmatureData;            public var frameRate:Number;            public var animationCacheDic:Object;            public var slotFrameCacheDic:Object;            public function AnimationCacheManager() { super(); }
            public static function initWithArmatureData(armatureData:ArmatureData, frameRate:Number = 0) : AnimationCacheManager { return null; }
            public function initAllAnimationCache() : void { }
            public function initAnimationCache(animationName:String) : void { }
            public function bindCacheUserArmatures(armatures:Array) : void { }
            public function bindCacheUserArmature(armature:ICacheableArmature) : void { }
            public function setCacheGeneratorArmature(armature:ICacheableArmature) : void { }
            public function generateAllAnimationCache(loop:Boolean) : void { }
            public function generateAnimationCache(animationName:String, loop:Boolean) : void { }
            public function resetCacheGeneratorArmature() : void { }
            public function getAnimationCache(animationName:String) : AnimationCache { return null; }
   }}