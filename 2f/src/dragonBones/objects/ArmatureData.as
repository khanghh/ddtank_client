package dragonBones.objects{   public final class ArmatureData   {                   public var name:String;            private var _boneDataList:Vector.<BoneData>;            private var _skinDataList:Vector.<SkinData>;            private var _slotDataList:Vector.<SlotData>;            private var _animationDataList:Vector.<AnimationData>;            public function ArmatureData() { super(); }
            public function setSkinData(skinName:String) : void { }
            public function dispose() : void { }
            public function getBoneData(boneName:String) : BoneData { return null; }
            public function getSlotData(slotName:String) : SlotData { return null; }
            public function getSkinData(skinName:String) : SkinData { return null; }
            public function getAnimationData(animationName:String) : AnimationData { return null; }
            public function addBoneData(boneData:BoneData) : void { }
            public function addSlotData(slotData:SlotData) : void { }
            public function addSkinData(skinData:SkinData) : void { }
            public function addAnimationData(animationData:AnimationData) : void { }
            public function sortBoneDataList() : void { }
            public function get boneDataList() : Vector.<BoneData> { return null; }
            public function get skinDataList() : Vector.<SkinData> { return null; }
            public function get animationDataList() : Vector.<AnimationData> { return null; }
            public function get slotDataList() : Vector.<SlotData> { return null; }
   }}