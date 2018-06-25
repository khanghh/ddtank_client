package dragonBones{   import dragonBones.animation.Animation;   import dragonBones.animation.AnimationState;   import dragonBones.animation.TimelineState;   import dragonBones.core.IArmature;   import dragonBones.events.ArmatureEvent;   import dragonBones.events.FrameEvent;   import dragonBones.events.SoundEvent;   import dragonBones.events.SoundEventManager;   import dragonBones.objects.ArmatureData;   import dragonBones.objects.DragonBonesData;   import dragonBones.objects.Frame;   import dragonBones.objects.SkinData;   import dragonBones.objects.SlotData;   import flash.events.Event;   import flash.events.EventDispatcher;      [Event(name="zOrderUpdated",type="dragonBones.events.ArmatureEvent")]   [Event(name="fadeIn",type="dragonBones.events.AnimationEvent")]   [Event(name="fadeOut",type="dragonBones.events.AnimationEvent")]   [Event(name="start",type="dragonBones.events.AnimationEvent")]   [Event(name="complete",type="dragonBones.events.AnimationEvent")]   [Event(name="loopComplete",type="dragonBones.events.AnimationEvent")]   [Event(name="fadeInComplete",type="dragonBones.events.AnimationEvent")]   [Event(name="fadeOutComplete",type="dragonBones.events.AnimationEvent")]   [Event(name="animationFrameEvent",type="dragonBones.events.FrameEvent")]   [Event(name="boneFrameEvent",type="dragonBones.events.FrameEvent")]   public class Armature extends EventDispatcher implements IArmature   {            private static const _soundManager:SoundEventManager = SoundEventManager.getInstance();                   var __dragonBonesData:DragonBonesData;            public var name:String;            public var userData:Object;            var _slotsZOrderChanged:Boolean;            var _eventList:Vector.<Event>;            protected var _slotList:Vector.<Slot>;            protected var _boneList:Vector.<Bone>;            private var _delayDispose:Boolean;            private var _lockDispose:Boolean;            var _armatureData:ArmatureData;            protected var _display:Object;            protected var _animation:Animation;            var _skinLists:Object;            public function Armature(display:Object) { super(null); }
            public function get armatureData() : ArmatureData { return null; }
            public function get display() : Object { return null; }
            public function get animation() : Animation { return null; }
            public function dispose() : void { }
            public function invalidUpdate(boneName:String = null) : void { }
            public function advanceTime(passedTime:Number) : void { }
            public function resetAnimation() : void { }
            public function getSlots(returnCopy:Boolean = true) : Vector.<Slot> { return null; }
            public function getSlot(slotName:String) : Slot { return null; }
            public function getSlotByDisplay(displayObj:Object) : Slot { return null; }
            public function addSlot(slot:Slot, boneName:String) : void { }
            public function removeSlot(slot:Slot) : void { }
            public function removeSlotByName(slotName:String) : Slot { return null; }
            public function getBones(returnCopy:Boolean = true) : Vector.<Bone> { return null; }
            public function getBone(boneName:String) : Bone { return null; }
            public function getBoneByDisplay(display:Object) : Bone { return null; }
            public function addBone(bone:Bone, parentName:String = null, updateLater:Boolean = false) : void { }
            public function removeBone(bone:Bone, updateLater:Boolean = false) : void { }
            public function removeBoneByName(boneName:String) : Bone { return null; }
            protected function addBoneToBoneList(bone:Bone) : void { }
            protected function removeBoneFromBoneList(bone:Bone) : void { }
            protected function addSlotToSlotList(slot:Slot) : void { }
            protected function removeSlotFromSlotList(slot:Slot) : void { }
            public function updateSlotsZOrder() : void { }
            protected function updateAnimationAfterBoneListChanged(ifNeedSortBoneList:Boolean = true) : void { }
            private function sortBoneList() : void { }
            protected function arriveAtFrame(frame:Frame, timelineState:TimelineState, animationState:AnimationState, isCross:Boolean) : void { }
            private function sortSlot(slot1:Slot, slot2:Slot) : int { return 0; }
            public function addSkinList(skinName:String, list:Object) : void { }
            public function changeSkin(skinName:String) : void { }
            public function getAnimation() : Object { return null; }
   }}