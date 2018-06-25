package dragonBones.cache{   import flash.geom.ColorTransform;      public class SlotFrameCache extends FrameCache   {                   public var colorTransform:ColorTransform;            public var displayIndex:int = -1;            public function SlotFrameCache() { super(); }
            override public function copy(frameCache:FrameCache) : void { }
            override public function clear() : void { }
   }}