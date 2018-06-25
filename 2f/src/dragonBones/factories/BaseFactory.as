package dragonBones.factories{   import dragonBones.Armature;   import dragonBones.Bone;   import dragonBones.Slot;   import dragonBones.fast.FastArmature;   import dragonBones.fast.FastBone;   import dragonBones.fast.FastSlot;   import dragonBones.objects.ArmatureData;   import dragonBones.objects.BoneData;   import dragonBones.objects.DataParser;   import dragonBones.objects.DataSerializer;   import dragonBones.objects.DecompressedData;   import dragonBones.objects.DisplayData;   import dragonBones.objects.DragonBonesData;   import dragonBones.objects.SkinData;   import dragonBones.objects.SlotData;   import dragonBones.textures.ITextureAtlas;   import flash.errors.IllegalOperationError;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.geom.Matrix;   import flash.utils.ByteArray;   import flash.utils.Dictionary;   import road7th.DDTAssetManager;      public class BaseFactory extends EventDispatcher   {            protected static const _helpMatrix:Matrix = new Matrix();                   public function BaseFactory(self:BaseFactory) { super(null); }
            public function dispose(disposeData:Boolean = true) : void { }
            public function getSkeletonData(name:String) : DragonBonesData { return null; }
            public function addSkeletonData(data:DragonBonesData, name:String = null) : void { }
            public function removeSkeletonData(name:String) : void { }
            public function getTextureAtlas(name:String) : Object { return null; }
            public function addTextureAtlas(textureAtlas:Object, name:String = null) : void { }
            public function removeTextureAtlas(name:String) : void { }
            public function getTextureDisplay(textureName:String, textureAtlasName:String = null, pivotX:Number = NaN, pivotY:Number = NaN) : Object { return null; }
            public function buildArmature(armatureName:String, fromDragonBonesDataName:String = null, fromTextureAtlasName:String = null, skinName:String = null) : Armature { return null; }
            public function buildFastArmature(armatureName:String, fromDragonBonesDataName:String = null, fromTextureAtlasName:String = null, skinName:String = null) : FastArmature { return null; }
            protected function buildArmatureUsingArmatureDataFromTextureAtlas(dragonBonesData:DragonBonesData, armatureData:ArmatureData, textureAtlas:Object, skinName:String = null) : Armature { return null; }
            protected function buildFastArmatureUsingArmatureDataFromTextureAtlas(dragonBonesData:DragonBonesData, armatureData:ArmatureData, textureAtlas:Object, skinName:String = null) : FastArmature { return null; }
            public function copyAnimationsToArmature(toArmature:Armature, fromArmatreName:String, fromDragonBonesDataName:String = null, ifRemoveOriginalAnimationList:Boolean = true) : Boolean { return false; }
            private function fillBuildArmatureDataPackageArmatureInfo(armatureName:String, dragonBonesDataName:String, outputBuildArmatureDataPackage:BuildArmatureDataPackage) : Boolean { return false; }
            private function fillBuildArmatureDataPackageTextureInfo(fromTextureAtlasName:String, outputBuildArmatureDataPackage:BuildArmatureDataPackage) : void { }
            protected function findFirstDragonBonesData() : DragonBonesData { return null; }
            protected function findFirstTextureAtlas() : Object { return null; }
            protected function buildBones(armature:Armature) : void { }
            protected function buildFastBones(armature:FastArmature) : void { }
            protected function buildFastSlots(armature:FastArmature, skinName:String, textureAtlas:Object) : void { }
            protected function buildSlots(armature:Armature, skinName:String, textureAtlas:Object) : void { }
            public function addSkinToArmature(armature:Armature, skinName:String, textureAtlasName:String) : void { }
            public function parseData(bytes:ByteArray, dataName:String = null) : void { }
            protected function parseCompleteHandler(event:Event) : void { }
            protected function generateTextureAtlas(content:Object, textureAtlasRawData:Object) : ITextureAtlas { return null; }
            protected function generateArmature() : Armature { return null; }
            protected function generateFastArmature() : FastArmature { return null; }
            protected function generateSlot() : Slot { return null; }
            protected function generateFastSlot() : FastSlot { return null; }
            protected function generateDisplay(textureAtlas:Object, fullName:String, pivotX:Number, pivotY:Number) : Object { return null; }
            protected function get textureAtlasDic() : Dictionary { return null; }
            protected function get dragonBonesDataDic() : Dictionary { return null; }
   }}import dragonBones.objects.ArmatureData;import dragonBones.objects.DragonBonesData;class BuildArmatureDataPackage{          public var dragonBonesDataName:String;      public var dragonBonesData:DragonBonesData;      public var armatureData:ArmatureData;      public var textureAtlas:Object;      function BuildArmatureDataPackage() { super(); }
}