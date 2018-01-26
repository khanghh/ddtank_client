package dragonBones.objects
{
   public final class ArmatureData
   {
       
      
      public var name:String;
      
      private var _boneDataList:Vector.<BoneData>;
      
      private var _skinDataList:Vector.<SkinData>;
      
      private var _slotDataList:Vector.<SlotData>;
      
      private var _animationDataList:Vector.<AnimationData>;
      
      public function ArmatureData(){super();}
      
      public function setSkinData(param1:String) : void{}
      
      public function dispose() : void{}
      
      public function getBoneData(param1:String) : BoneData{return null;}
      
      public function getSlotData(param1:String) : SlotData{return null;}
      
      public function getSkinData(param1:String) : SkinData{return null;}
      
      public function getAnimationData(param1:String) : AnimationData{return null;}
      
      public function addBoneData(param1:BoneData) : void{}
      
      public function addSlotData(param1:SlotData) : void{}
      
      public function addSkinData(param1:SkinData) : void{}
      
      public function addAnimationData(param1:AnimationData) : void{}
      
      public function sortBoneDataList() : void{}
      
      public function get boneDataList() : Vector.<BoneData>{return null;}
      
      public function get skinDataList() : Vector.<SkinData>{return null;}
      
      public function get animationDataList() : Vector.<AnimationData>{return null;}
      
      public function get slotDataList() : Vector.<SlotData>{return null;}
   }
}
