package dragonBones.fast{   import dragonBones.events.FrameEvent;   import dragonBones.fast.animation.FastAnimationState;   import dragonBones.fast.animation.FastBoneTimelineState;   import dragonBones.objects.BoneData;   import dragonBones.objects.Frame;      public class FastBone extends FastDBObject   {                   public var slotList:Vector.<FastSlot>;            public var boneList:Vector.<FastBone>;            var _timelineState:FastBoneTimelineState;            var _needUpdate:int;            public function FastBone() { super(); }
            public static function initWithBoneData(boneData:BoneData) : FastBone { return null; }
            public function getBones(returnCopy:Boolean = true) : Vector.<FastBone> { return null; }
            public function getSlots(returnCopy:Boolean = true) : Vector.<FastSlot> { return null; }
            override public function dispose() : void { }
            public function invalidUpdate() : void { }
            override protected function calculateRelativeParentTransform() : void { }
            override protected function updateByCache() : void { }
            protected function update(needUpdate:Boolean = false) : void { }
            protected function arriveAtFrame(frame:Frame, animationState:FastAnimationState) : void { }
            public function get childArmature() : Object { return null; }
            public function get display() : Object { return null; }
            public function set display(value:Object) : void { }
            override public function set visible(value:Boolean) : void { }
            public function get slot() : FastSlot { return null; }
   }}