package dragonBones.cache{   import dragonBones.core.ISlotCacheGenerator;   import dragonBones.utils.ColorTransformUtil;      public class SlotTimelineCache extends TimelineCache   {                   public var cacheGenerator:ISlotCacheGenerator;            public function SlotTimelineCache() { super(); }
            override public function addFrame() : void { }
   }}