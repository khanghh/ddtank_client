package dragonBones{   import dragonBones.animation.AnimationState;   import dragonBones.animation.TimelineState;   import dragonBones.core.DBObject;   import dragonBones.events.FrameEvent;   import dragonBones.events.SoundEvent;   import dragonBones.events.SoundEventManager;   import dragonBones.objects.BoneData;   import dragonBones.objects.DBTransform;   import dragonBones.objects.Frame;   import dragonBones.utils.TransformUtil;   import flash.geom.Matrix;   import flash.geom.Point;      public class Bone extends DBObject   {            private static const _soundManager:SoundEventManager = SoundEventManager.getInstance();                   public var applyOffsetTranslationToChild:Boolean = true;            public var applyOffsetRotationToChild:Boolean = true;            public var applyOffsetScaleToChild:Boolean = false;            public var displayController:String;            protected var _boneList:Vector.<Bone>;            protected var _slotList:Vector.<Slot>;            protected var _timelineStateList:Vector.<TimelineState>;            var _tween:DBTransform;            var _tweenPivot:Point;            var _needUpdate:int;            var _globalTransformForChild:DBTransform;            var _globalTransformMatrixForChild:Matrix;            private var _tempGlobalTransformForChild:DBTransform;            private var _tempGlobalTransformMatrixForChild:Matrix;            public function Bone() { super(); }
            public static function initWithBoneData(boneData:BoneData) : Bone { return null; }
            override public function dispose() : void { }
            public function contains(child:DBObject) : Boolean { return false; }
            public function addChildBone(childBone:Bone, updateLater:Boolean = false) : void { }
            public function removeChildBone(childBone:Bone, updateLater:Boolean = false) : void { }
            public function addSlot(childSlot:Slot) : void { }
            public function removeSlot(childSlot:Slot) : void { }
            override protected function setArmature(value:Armature) : void { }
            public function getBones(returnCopy:Boolean = true) : Vector.<Bone> { return null; }
            public function getSlots(returnCopy:Boolean = true) : Vector.<Slot> { return null; }
            public function invalidUpdate() : void { }
            override protected function calculateRelativeParentTransform() : void { }
            protected function update(needUpdate:Boolean = false) : void { }
            protected function hideSlots() : void { }
            protected function arriveAtFrame(frame:Frame, timelineState:TimelineState, animationState:AnimationState, isCross:Boolean) : void { }
            protected function addState(timelineState:TimelineState) : void { }
            protected function removeState(timelineState:TimelineState) : void { }
            protected function removeAllStates() : void { }
            private function blendingTimeline() : void { }
            private function sortState(state1:TimelineState, state2:TimelineState) : int { return 0; }
            public function get childArmature() : Armature { return null; }
            public function get display() : Object { return null; }
            public function set display(value:Object) : void { }
            public function get node() : DBTransform { return null; }
            override public function set visible(value:Boolean) : void { }
            public function get slot() : Slot { return null; }
   }}