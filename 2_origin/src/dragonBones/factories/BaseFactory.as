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
       
      
      public function BaseFactory(self:BaseFactory)
      {
         super(this);
         if(self != this)
         {
            throw new IllegalOperationError("Abstract class can not be instantiated!");
         }
      }
      
      public function dispose(disposeData:Boolean = true) : void
      {
         throw new Error("骨架 纹理资源都在DDTAssetManager里面。根据模块动态删除了.");
      }
      
      public function getSkeletonData(name:String) : DragonBonesData
      {
         return dragonBonesDataDic[name];
      }
      
      public function addSkeletonData(data:DragonBonesData, name:String = null) : void
      {
         throw new Error("添加Skieleton请在DDTAssetManager里面添加");
      }
      
      public function removeSkeletonData(name:String) : void
      {
      }
      
      public function getTextureAtlas(name:String) : Object
      {
         return textureAtlasDic[name];
      }
      
      public function addTextureAtlas(textureAtlas:Object, name:String = null) : void
      {
         throw new Error("添加纹理请在DDTAssetManager里面添加");
      }
      
      public function removeTextureAtlas(name:String) : void
      {
      }
      
      public function getTextureDisplay(textureName:String, textureAtlasName:String = null, pivotX:Number = NaN, pivotY:Number = NaN) : Object
      {
         var targetTextureAtlas:* = null;
         var data:* = null;
         var displayData:* = null;
         if(textureAtlasName)
         {
            targetTextureAtlas = textureAtlasDic[textureAtlasName];
         }
         else
         {
            var _loc9_:int = 0;
            var _loc8_:* = textureAtlasDic;
            for(textureAtlasName in textureAtlasDic)
            {
               targetTextureAtlas = textureAtlasDic[textureAtlasName];
               if(targetTextureAtlas.getRegion(textureName))
               {
                  break;
               }
               targetTextureAtlas = null;
            }
         }
         if(!targetTextureAtlas)
         {
            return null;
         }
         if(isNaN(pivotX) || isNaN(pivotY))
         {
            data = dragonBonesDataDic[textureAtlasName];
            data = !!data?data:findFirstDragonBonesData();
            if(data)
            {
               displayData = data.getDisplayDataByName(textureName);
               if(displayData)
               {
                  pivotX = displayData.pivot.x;
                  pivotY = displayData.pivot.y;
               }
            }
         }
         return generateDisplay(targetTextureAtlas,textureName,pivotX,pivotY);
      }
      
      public function buildArmature(armatureName:String, fromDragonBonesDataName:String = null, fromTextureAtlasName:String = null, skinName:String = null) : Armature
      {
         var buildArmatureDataPackage:BuildArmatureDataPackage = new BuildArmatureDataPackage();
         if(fillBuildArmatureDataPackageArmatureInfo(armatureName,fromDragonBonesDataName,buildArmatureDataPackage))
         {
            fillBuildArmatureDataPackageTextureInfo(fromTextureAtlasName,buildArmatureDataPackage);
         }
         var dragonBonesData:DragonBonesData = buildArmatureDataPackage.dragonBonesData;
         var armatureData:ArmatureData = buildArmatureDataPackage.armatureData;
         var textureAtlas:Object = buildArmatureDataPackage.textureAtlas;
         if(!armatureData || !textureAtlas)
         {
            return null;
         }
         return buildArmatureUsingArmatureDataFromTextureAtlas(dragonBonesData,armatureData,textureAtlas,skinName);
      }
      
      public function buildFastArmature(armatureName:String, fromDragonBonesDataName:String = null, fromTextureAtlasName:String = null, skinName:String = null) : FastArmature
      {
         var buildArmatureDataPackage:BuildArmatureDataPackage = new BuildArmatureDataPackage();
         if(fillBuildArmatureDataPackageArmatureInfo(armatureName,fromDragonBonesDataName,buildArmatureDataPackage))
         {
            fillBuildArmatureDataPackageTextureInfo(fromTextureAtlasName,buildArmatureDataPackage);
         }
         var dragonBonesData:DragonBonesData = buildArmatureDataPackage.dragonBonesData;
         var armatureData:ArmatureData = buildArmatureDataPackage.armatureData;
         var textureAtlas:Object = buildArmatureDataPackage.textureAtlas;
         if(!armatureData || !textureAtlas)
         {
            return null;
         }
         return buildFastArmatureUsingArmatureDataFromTextureAtlas(dragonBonesData,armatureData,textureAtlas,skinName);
      }
      
      protected function buildArmatureUsingArmatureDataFromTextureAtlas(dragonBonesData:DragonBonesData, armatureData:ArmatureData, textureAtlas:Object, skinName:String = null) : Armature
      {
         var outputArmature:Armature = generateArmature();
         outputArmature.name = armatureData.name;
         outputArmature.__dragonBonesData = dragonBonesData;
         outputArmature._armatureData = armatureData;
         outputArmature.animation.animationDataList = armatureData.animationDataList;
         buildBones(outputArmature);
         buildSlots(outputArmature,skinName,textureAtlas);
         outputArmature.advanceTime(0);
         return outputArmature;
      }
      
      protected function buildFastArmatureUsingArmatureDataFromTextureAtlas(dragonBonesData:DragonBonesData, armatureData:ArmatureData, textureAtlas:Object, skinName:String = null) : FastArmature
      {
         var outputArmature:FastArmature = generateFastArmature();
         outputArmature.name = armatureData.name;
         outputArmature.__dragonBonesData = dragonBonesData;
         outputArmature._armatureData = armatureData;
         outputArmature.animation.animationDataList = armatureData.animationDataList;
         buildFastBones(outputArmature);
         buildFastSlots(outputArmature,skinName,textureAtlas);
         outputArmature.advanceTime(0);
         return outputArmature;
      }
      
      public function copyAnimationsToArmature(toArmature:Armature, fromArmatreName:String, fromDragonBonesDataName:String = null, ifRemoveOriginalAnimationList:Boolean = true) : Boolean
      {
         var fromSlotData:* = null;
         var fromDisplayData:* = null;
         var toSlot:* = null;
         var toSlotDisplayList:* = null;
         var toSlotDisplayListLength:* = 0;
         var toDisplayObject:* = null;
         var toChildArmature:* = null;
         var i:int = 0;
         var buildArmatureDataPackage:BuildArmatureDataPackage = new BuildArmatureDataPackage();
         if(!fillBuildArmatureDataPackageArmatureInfo(fromArmatreName,fromDragonBonesDataName,buildArmatureDataPackage))
         {
            return false;
         }
         var fromArmatureData:ArmatureData = buildArmatureDataPackage.armatureData;
         toArmature.animation.animationDataList = fromArmatureData.animationDataList;
         var fromSkinData:SkinData = fromArmatureData.getSkinData("");
         var toSlotList:Vector.<Slot> = toArmature.getSlots(false);
         var _loc18_:int = 0;
         var _loc17_:* = toSlotList;
         for each(toSlot in toSlotList)
         {
            toSlotDisplayList = toSlot.displayList;
            toSlotDisplayListLength = uint(toSlotDisplayList.length);
            for(i = 0; i < toSlotDisplayListLength; )
            {
               toDisplayObject = toSlotDisplayList[i];
               if(toDisplayObject is Armature)
               {
                  toChildArmature = toDisplayObject as Armature;
                  fromSlotData = fromSkinData.getSlotData(toSlot.name);
                  fromDisplayData = fromSlotData.displayDataList[i];
                  if(fromDisplayData.type == "armature")
                  {
                     copyAnimationsToArmature(toChildArmature,fromDisplayData.name,buildArmatureDataPackage.dragonBonesDataName,ifRemoveOriginalAnimationList);
                  }
               }
               i++;
            }
         }
         return true;
      }
      
      private function fillBuildArmatureDataPackageArmatureInfo(armatureName:String, dragonBonesDataName:String, outputBuildArmatureDataPackage:BuildArmatureDataPackage) : Boolean
      {
         if(dragonBonesDataName)
         {
            outputBuildArmatureDataPackage.dragonBonesDataName = dragonBonesDataName;
            outputBuildArmatureDataPackage.dragonBonesData = dragonBonesDataDic[dragonBonesDataName];
            outputBuildArmatureDataPackage.armatureData = outputBuildArmatureDataPackage.dragonBonesData.getArmatureDataByName(armatureName);
            return true;
         }
         var _loc5_:int = 0;
         var _loc4_:* = dragonBonesDataDic;
         for(dragonBonesDataName in dragonBonesDataDic)
         {
            outputBuildArmatureDataPackage.dragonBonesData = dragonBonesDataDic[dragonBonesDataName];
            outputBuildArmatureDataPackage.armatureData = outputBuildArmatureDataPackage.dragonBonesData.getArmatureDataByName(armatureName);
            if(outputBuildArmatureDataPackage.armatureData)
            {
               outputBuildArmatureDataPackage.dragonBonesDataName = dragonBonesDataName;
               return true;
            }
         }
         return false;
      }
      
      private function fillBuildArmatureDataPackageTextureInfo(fromTextureAtlasName:String, outputBuildArmatureDataPackage:BuildArmatureDataPackage) : void
      {
         outputBuildArmatureDataPackage.textureAtlas = textureAtlasDic[!!fromTextureAtlasName?fromTextureAtlasName:outputBuildArmatureDataPackage.dragonBonesDataName];
      }
      
      protected function findFirstDragonBonesData() : DragonBonesData
      {
         var _loc3_:int = 0;
         var _loc2_:* = dragonBonesDataDic;
         for each(var outputDragonBonesData in dragonBonesDataDic)
         {
            if(outputDragonBonesData)
            {
               return outputDragonBonesData;
            }
         }
         return null;
      }
      
      protected function findFirstTextureAtlas() : Object
      {
         var _loc3_:int = 0;
         var _loc2_:* = textureAtlasDic;
         for each(var outputTextureAtlas in textureAtlasDic)
         {
            if(outputTextureAtlas)
            {
               return outputTextureAtlas;
            }
         }
         return null;
      }
      
      protected function buildBones(armature:Armature) : void
      {
         var boneData:* = null;
         var bone:* = null;
         var parent:* = null;
         var i:int = 0;
         var boneDataList:Vector.<BoneData> = armature.armatureData.boneDataList;
         for(i = 0; i < boneDataList.length; )
         {
            boneData = boneDataList[i];
            bone = Bone.initWithBoneData(boneData);
            parent = boneData.parent;
            if(parent && armature.armatureData.getBoneData(parent) == null)
            {
               parent = null;
            }
            armature.addBone(bone,parent,true);
            i++;
         }
         armature.updateAnimationAfterBoneListChanged();
      }
      
      protected function buildFastBones(armature:FastArmature) : void
      {
         var boneData:* = null;
         var bone:* = null;
         var i:int = 0;
         var boneDataList:Vector.<BoneData> = armature.armatureData.boneDataList;
         for(i = 0; i < boneDataList.length; )
         {
            boneData = boneDataList[i];
            bone = FastBone.initWithBoneData(boneData);
            armature.addBone(bone,boneData.parent);
            i++;
         }
      }
      
      protected function buildFastSlots(armature:FastArmature, skinName:String, textureAtlas:Object) : void
      {
         var slotData:* = null;
         var slot:* = null;
         var i:int = 0;
         var l:int = 0;
         var displayData:* = null;
         var childArmature:* = null;
         var skinData:SkinData = armature.armatureData.getSkinData(skinName);
         if(!skinData)
         {
            return;
         }
         armature.armatureData.setSkinData(skinName);
         var displayList:Array = [];
         var slotDataList:Vector.<SlotData> = armature.armatureData.slotDataList;
         for(i = 0; i < slotDataList.length; )
         {
            displayList.length = 0;
            slotData = slotDataList[i];
            slot = generateFastSlot();
            slot.initWithSlotData(slotData);
            l = slotData.displayDataList.length;
            while(true)
            {
               l--;
               if(!l)
               {
                  break;
               }
               displayData = slotData.displayDataList[l];
               var _loc14_:* = displayData.type;
               if("armature" !== _loc14_)
               {
                  if("image" !== _loc14_)
                  {
                  }
                  displayList[l] = generateDisplay(textureAtlas,displayData.name,displayData.pivot.x,displayData.pivot.y);
               }
               else
               {
                  childArmature = buildFastArmatureUsingArmatureDataFromTextureAtlas(armature.__dragonBonesData,armature.__dragonBonesData.getArmatureDataByName(displayData.name),textureAtlas,skinName);
                  displayList[l] = childArmature;
                  slot.hasChildArmature = true;
               }
            }
            var _loc17_:int = 0;
            var _loc16_:* = displayList;
            for each(var displayObject in displayList)
            {
               if(displayObject)
               {
                  if(displayObject is FastArmature)
                  {
                     displayObject = (displayObject as FastArmature).display;
                  }
                  if(displayObject.hasOwnProperty("name"))
                  {
                     try
                     {
                        displayObject["name"] = slot.name;
                     }
                     catch(err:Error)
                     {
                        continue;
                     }
                  }
               }
            }
            slot.initDisplayList(displayList.concat());
            armature.addSlot(slot,slotData.parent);
            slot.changeDisplayIndex(slotData.displayIndex);
            i++;
         }
      }
      
      protected function buildSlots(armature:Armature, skinName:String, textureAtlas:Object) : void
      {
         var slotData:* = null;
         var slot:* = null;
         var bone:* = null;
         var i:int = 0;
         var l:int = 0;
         var displayData:* = null;
         var childArmature:* = null;
         var skinData:SkinData = armature.armatureData.getSkinData(skinName);
         if(!skinData)
         {
            return;
         }
         armature.armatureData.setSkinData(skinName);
         var displayList:Array = [];
         var slotDataList:Vector.<SlotData> = armature.armatureData.slotDataList;
         var skinListObject:Object = {};
         for(i = 0; i < slotDataList.length; )
         {
            displayList.length = 0;
            slotData = slotDataList[i];
            bone = armature.getBone(slotData.parent);
            if(bone)
            {
               slot = generateSlot();
               slot.initWithSlotData(slotData);
               bone.addSlot(slot);
               l = slotData.displayDataList.length;
               while(true)
               {
                  l--;
                  if(!l)
                  {
                     break;
                  }
                  displayData = slotData.displayDataList[l];
                  var _loc16_:* = displayData.type;
                  if("armature" !== _loc16_)
                  {
                     if("image" !== _loc16_)
                     {
                     }
                     displayList[l] = generateDisplay(textureAtlas,displayData.name,displayData.pivot.x,displayData.pivot.y);
                  }
                  else
                  {
                     childArmature = buildArmatureUsingArmatureDataFromTextureAtlas(armature.__dragonBonesData,armature.__dragonBonesData.getArmatureDataByName(displayData.name),textureAtlas,skinName);
                     displayList[l] = childArmature;
                  }
               }
               var _loc19_:int = 0;
               var _loc18_:* = displayList;
               for each(var displayObject in displayList)
               {
                  if(displayObject && displayObject is Armature)
                  {
                     displayObject = (displayObject as Armature).display;
                  }
                  if(displayObject && displayObject.hasOwnProperty("name"))
                  {
                     try
                     {
                        displayObject["name"] = slot.name;
                     }
                     catch(err:Error)
                     {
                        continue;
                     }
                  }
               }
               skinListObject[slotData.name] = displayList.concat();
               slot.displayList = displayList;
               slot.changeDisplay(slotData.displayIndex);
            }
            i++;
         }
         armature.addSkinList(skinName,skinListObject);
      }
      
      public function addSkinToArmature(armature:Armature, skinName:String, textureAtlasName:String) : void
      {
         var slotData:* = null;
         var slot:* = null;
         var bone:* = null;
         var displayDataList:* = undefined;
         var i:int = 0;
         var l:int = 0;
         var displayData:* = null;
         var childArmature:* = null;
         var textureAtlas:Object = textureAtlasDic[textureAtlasName];
         var skinData:SkinData = armature.armatureData.getSkinData(skinName);
         if(!skinData || !textureAtlas)
         {
            return;
         }
         var displayList:Array = [];
         var slotDataList:Vector.<SlotData> = armature.armatureData.slotDataList;
         var skinListData:Object = {};
         for(i = 0; i < slotDataList.length; )
         {
            displayList.length = 0;
            slotData = slotDataList[i];
            bone = armature.getBone(slotData.parent);
            if(bone)
            {
               l = 0;
               if(i >= skinData.slotDataList.length)
               {
                  l = 0;
               }
               else
               {
                  displayDataList = skinData.slotDataList[i].displayDataList;
                  l = displayDataList.length;
               }
               while(true)
               {
                  l--;
                  if(!l)
                  {
                     break;
                  }
                  displayData = displayDataList[l];
                  var _loc18_:* = displayData.type;
                  if("armature" !== _loc18_)
                  {
                     if("image" !== _loc18_)
                     {
                     }
                     displayList[l] = generateDisplay(textureAtlas,displayData.name,displayData.pivot.x,displayData.pivot.y);
                  }
                  else
                  {
                     childArmature = buildArmatureUsingArmatureDataFromTextureAtlas(armature.__dragonBonesData,armature.__dragonBonesData.getArmatureDataByName(displayData.name),textureAtlas,skinName);
                     displayList[l] = childArmature;
                  }
               }
               var _loc21_:int = 0;
               var _loc20_:* = displayList;
               for each(var displayObject in displayList)
               {
                  if(displayObject is Armature)
                  {
                     displayObject = (displayObject as Armature).display;
                  }
                  if(displayObject.hasOwnProperty("name"))
                  {
                     try
                     {
                        displayObject["name"] = slot.name;
                     }
                     catch(err:Error)
                     {
                        continue;
                     }
                  }
               }
               skinListData[slotData.name] = displayList.concat();
            }
            i++;
         }
         armature.addSkinList(skinName,skinListData);
      }
      
      public function parseData(bytes:ByteArray, dataName:String = null) : void
      {
         throw new Error("屏蔽了parseData()不要用这个!!");
      }
      
      protected function parseCompleteHandler(event:Event) : void
      {
         var decompressedData:DecompressedData = event.target as DecompressedData;
         decompressedData.removeEventListener("complete",parseCompleteHandler);
         var textureAtlas:Object = generateTextureAtlas(decompressedData.textureAtlas,decompressedData.textureAtlasData);
         addTextureAtlas(textureAtlas,decompressedData.name);
         decompressedData.dispose();
         this.dispatchEvent(new Event("complete"));
      }
      
      protected function generateTextureAtlas(content:Object, textureAtlasRawData:Object) : ITextureAtlas
      {
         return null;
      }
      
      protected function generateArmature() : Armature
      {
         return null;
      }
      
      protected function generateFastArmature() : FastArmature
      {
         return null;
      }
      
      protected function generateSlot() : Slot
      {
         return null;
      }
      
      protected function generateFastSlot() : FastSlot
      {
         return null;
      }
      
      protected function generateDisplay(textureAtlas:Object, fullName:String, pivotX:Number, pivotY:Number) : Object
      {
         return null;
      }
      
      protected function get textureAtlasDic() : Dictionary
      {
         return null;
      }
      
      protected function get dragonBonesDataDic() : Dictionary
      {
         return DDTAssetManager.instance.dragonBonesDataDic;
      }
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
   
   function BuildArmatureDataPackage()
   {
      super();
   }
}
