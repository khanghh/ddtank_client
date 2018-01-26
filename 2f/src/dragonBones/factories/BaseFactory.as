package dragonBones.factories
{
   import dragonBones.Armature;
   import dragonBones.Bone;
   import dragonBones.Slot;
   import dragonBones.fast.FastArmature;
   import dragonBones.fast.FastBone;
   import dragonBones.fast.FastSlot;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.BoneData;
   import dragonBones.objects.DataParser;
   import dragonBones.objects.DataSerializer;
   import dragonBones.objects.DecompressedData;
   import dragonBones.objects.DisplayData;
   import dragonBones.objects.DragonBonesData;
   import dragonBones.objects.SkinData;
   import dragonBones.objects.SlotData;
   import dragonBones.textures.ITextureAtlas;
   import flash.errors.IllegalOperationError;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.geom.Matrix;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import road7th.DDTAssetManager;
   
   public class BaseFactory extends EventDispatcher
   {
      
      protected static const _helpMatrix:Matrix = new Matrix();
       
      
      public function BaseFactory(param1:BaseFactory){super(null);}
      
      public function dispose(param1:Boolean = true) : void{}
      
      public function getSkeletonData(param1:String) : DragonBonesData{return null;}
      
      public function addSkeletonData(param1:DragonBonesData, param2:String = null) : void{}
      
      public function removeSkeletonData(param1:String) : void{}
      
      public function getTextureAtlas(param1:String) : Object{return null;}
      
      public function addTextureAtlas(param1:Object, param2:String = null) : void{}
      
      public function removeTextureAtlas(param1:String) : void{}
      
      public function getTextureDisplay(param1:String, param2:String = null, param3:Number = NaN, param4:Number = NaN) : Object{return null;}
      
      public function buildArmature(param1:String, param2:String = null, param3:String = null, param4:String = null) : Armature{return null;}
      
      public function buildFastArmature(param1:String, param2:String = null, param3:String = null, param4:String = null) : FastArmature{return null;}
      
      protected function buildArmatureUsingArmatureDataFromTextureAtlas(param1:DragonBonesData, param2:ArmatureData, param3:Object, param4:String = null) : Armature{return null;}
      
      protected function buildFastArmatureUsingArmatureDataFromTextureAtlas(param1:DragonBonesData, param2:ArmatureData, param3:Object, param4:String = null) : FastArmature{return null;}
      
      public function copyAnimationsToArmature(param1:Armature, param2:String, param3:String = null, param4:Boolean = true) : Boolean{return false;}
      
      private function fillBuildArmatureDataPackageArmatureInfo(param1:String, param2:String, param3:BuildArmatureDataPackage) : Boolean{return false;}
      
      private function fillBuildArmatureDataPackageTextureInfo(param1:String, param2:BuildArmatureDataPackage) : void{}
      
      protected function findFirstDragonBonesData() : DragonBonesData{return null;}
      
      protected function findFirstTextureAtlas() : Object{return null;}
      
      protected function buildBones(param1:Armature) : void{}
      
      protected function buildFastBones(param1:FastArmature) : void{}
      
      protected function buildFastSlots(param1:FastArmature, param2:String, param3:Object) : void{}
      
      protected function buildSlots(param1:Armature, param2:String, param3:Object) : void{}
      
      public function addSkinToArmature(param1:Armature, param2:String, param3:String) : void{}
      
      public function parseData(param1:ByteArray, param2:String = null) : void{}
      
      protected function parseCompleteHandler(param1:Event) : void{}
      
      protected function generateTextureAtlas(param1:Object, param2:Object) : ITextureAtlas{return null;}
      
      protected function generateArmature() : Armature{return null;}
      
      protected function generateFastArmature() : FastArmature{return null;}
      
      protected function generateSlot() : Slot{return null;}
      
      protected function generateFastSlot() : FastSlot{return null;}
      
      protected function generateDisplay(param1:Object, param2:String, param3:Number, param4:Number) : Object{return null;}
      
      protected function get textureAtlasDic() : Dictionary{return null;}
      
      protected function get dragonBonesDataDic() : Dictionary{return null;}
   }
}

import dragonBones.objects.ArmatureData;
import dragonBones.objects.DragonBonesData;

class BuildArmatureDataPackage
{
    
   
   public var dragonBonesDataName:String;
   
   public var dragonBonesData:DragonBonesData;
   
   public var armatureData:ArmatureData;
   
   public var textureAtlas:Object;
   
   function BuildArmatureDataPackage(){super();}
}
