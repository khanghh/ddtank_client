package dragonBones.fast{   import dragonBones.cache.AnimationCacheManager;   import dragonBones.cache.SlotFrameCache;   import dragonBones.core.IArmature;   import dragonBones.core.ICacheableArmature;   import dragonBones.events.FrameEvent;   import dragonBones.fast.animation.FastAnimation;   import dragonBones.fast.animation.FastAnimationState;   import dragonBones.objects.ArmatureData;   import dragonBones.objects.DragonBonesData;   import dragonBones.objects.Frame;   import flash.events.Event;   import flash.events.EventDispatcher;      [Event(name="complete",type="dragonBones.events.AnimationEvent")]   [Event(name="loopComplete",type="dragonBones.events.AnimationEvent")]   [Event(name="animationFrameEvent",type="dragonBones.events.FrameEvent")]   [Event(name="boneFrameEvent",type="dragonBones.events.FrameEvent")]   public class FastArmature extends EventDispatcher implements ICacheableArmature   {                   public var name:String;            public var userData:Object;            private var _enableCache:Boolean;            public var isCacheManagerExclusive:Boolean = false;            protected var _animation:FastAnimation;            protected var _display:Object;            public var boneList:Vector.<FastBone>;            var _boneDic:Object;            public var slotList:Vector.<FastSlot>;            var _slotDic:Object;            public var slotHasChildArmatureList:Vector.<FastSlot>;            protected var _enableEventDispatch:Boolean = true;            var __dragonBonesData:DragonBonesData;            var _armatureData:ArmatureData;            var _slotsZOrderChanged:Boolean;            private var _eventList:Array;            private var _delayDispose:Boolean;            private var _lockDispose:Boolean;            private var useCache:Boolean = true;            public function FastArmature(display:Object) { super(null); }
            public function dispose() : void { }
            public function advanceTime(passedTime:Number) : void { }
            public function enableAnimationCache(frameRate:int, animationList:Array = null, loop:Boolean = true) : AnimationCacheManager { return null; }
            public function getBone(boneName:String) : FastBone { return null; }
            public function getSlot(slotName:String) : FastSlot { return null; }
            public function getBoneByDisplay(display:Object) : FastBone { return null; }
            public function getSlotByDisplay(displayObj:Object) : FastSlot { return null; }
            public function getSlots(returnCopy:Boolean = true) : Vector.<FastSlot> { return null; }
            protected function _updateBonesByCache() : void { }
            protected function addBone(bone:FastBone, parentName:String = null) : void { }
            protected function addSlot(slot:FastSlot, parentBoneName:String) : void { }
            protected function updateSlotsZOrder() : void { }
            private function sortBoneList() : void { }
            protected function arriveAtFrame(frame:Frame, animationState:FastAnimationState) : void { }
            public function invalidUpdate(boneName:String = null) : void { }
            public function resetAnimation() : void { }
            private function sortSlot(slot1:FastSlot, slot2:FastSlot) : int { return 0; }
            public function getAnimation() : Object { return null; }
            public function get armatureData() : ArmatureData { return null; }
            public function get animation() : FastAnimation { return null; }
            public function get display() : Object { return null; }
            public function get enableCache() : Boolean { return false; }
            public function set enableCache(value:Boolean) : void { }
            public function get enableEventDispatch() : Boolean { return false; }
            public function set enableEventDispatch(value:Boolean) : void { }
            public function getSlotDic() : Object { return null; }
            protected function addEvent(event:Event) : void { }
   }}