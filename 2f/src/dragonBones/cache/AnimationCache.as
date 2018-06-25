package dragonBones.cache{   import dragonBones.objects.AnimationData;   import dragonBones.objects.ArmatureData;   import dragonBones.objects.SlotData;   import dragonBones.objects.TransformTimeline;      public class AnimationCache   {                   public var name:String;            public var slotTimelineCacheList:Vector.<SlotTimelineCache>;            public var slotTimelineCacheDic:Object;            public var frameNum:int = 0;            public function AnimationCache() { super(); }
            public static function initWithAnimationData(animationData:AnimationData, armatureData:ArmatureData) : AnimationCache { return null; }
            public function initSlotTimelineCacheDic(slotCacheGeneratorDic:Object, slotFrameCacheDic:Object) : void { }
            public function bindCacheUserSlotDic(slotDic:Object) : void { }
            public function addFrame() : void { }
            public function update(progress:Number) : void { }
   }}