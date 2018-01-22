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
       
      
      public function BaseFactory(param1:BaseFactory)
      {
         super(this);
         if(param1 != this)
         {
            throw new IllegalOperationError("Abstract class can not be instantiated!");
         }
      }
      
      public function dispose(param1:Boolean = true) : void
      {
         throw new Error("骨架 纹理资源都在DDTAssetManager里面。根据模块动态删除了.");
      }
      
      public function getSkeletonData(param1:String) : DragonBonesData
      {
         return dragonBonesDataDic[param1];
      }
      
      public function addSkeletonData(param1:DragonBonesData, param2:String = null) : void
      {
         throw new Error("添加Skieleton请在DDTAssetManager里面添加");
      }
      
      public function removeSkeletonData(param1:String) : void
      {
      }
      
      public function getTextureAtlas(param1:String) : Object
      {
         return textureAtlasDic[param1];
      }
      
      public function addTextureAtlas(param1:Object, param2:String = null) : void
      {
         throw new Error("添加纹理请在DDTAssetManager里面添加");
      }
      
      public function removeTextureAtlas(param1:String) : void
      {
      }
      
      public function getTextureDisplay(param1:String, param2:String = null, param3:Number = NaN, param4:Number = NaN) : Object
      {
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc7_:* = null;
         if(param2)
         {
            _loc6_ = textureAtlasDic[param2];
         }
         else
         {
            var _loc9_:int = 0;
            var _loc8_:* = textureAtlasDic;
            for(param2 in textureAtlasDic)
            {
               _loc6_ = textureAtlasDic[param2];
               if(!_loc6_.getRegion(param1))
               {
                  _loc6_ = null;
                  continue;
               }
               break;
            }
         }
         if(!_loc6_)
         {
            return null;
         }
         if(isNaN(param3) || isNaN(param4))
         {
            _loc5_ = dragonBonesDataDic[param2];
            _loc5_ = !!_loc5_?_loc5_:findFirstDragonBonesData();
            if(_loc5_)
            {
               _loc7_ = _loc5_.getDisplayDataByName(param1);
               if(_loc7_)
               {
                  param3 = _loc7_.pivot.x;
                  param4 = _loc7_.pivot.y;
               }
            }
         }
         return generateDisplay(_loc6_,param1,param3,param4);
      }
      
      public function buildArmature(param1:String, param2:String = null, param3:String = null, param4:String = null) : Armature
      {
         var _loc7_:BuildArmatureDataPackage = new BuildArmatureDataPackage();
         if(fillBuildArmatureDataPackageArmatureInfo(param1,param2,_loc7_))
         {
            fillBuildArmatureDataPackageTextureInfo(param3,_loc7_);
         }
         var _loc5_:DragonBonesData = _loc7_.dragonBonesData;
         var _loc8_:ArmatureData = _loc7_.armatureData;
         var _loc6_:Object = _loc7_.textureAtlas;
         if(!_loc8_ || !_loc6_)
         {
            return null;
         }
         return buildArmatureUsingArmatureDataFromTextureAtlas(_loc5_,_loc8_,_loc6_,param4);
      }
      
      public function buildFastArmature(param1:String, param2:String = null, param3:String = null, param4:String = null) : FastArmature
      {
         var _loc7_:BuildArmatureDataPackage = new BuildArmatureDataPackage();
         if(fillBuildArmatureDataPackageArmatureInfo(param1,param2,_loc7_))
         {
            fillBuildArmatureDataPackageTextureInfo(param3,_loc7_);
         }
         var _loc5_:DragonBonesData = _loc7_.dragonBonesData;
         var _loc8_:ArmatureData = _loc7_.armatureData;
         var _loc6_:Object = _loc7_.textureAtlas;
         if(!_loc8_ || !_loc6_)
         {
            return null;
         }
         return buildFastArmatureUsingArmatureDataFromTextureAtlas(_loc5_,_loc8_,_loc6_,param4);
      }
      
      protected function buildArmatureUsingArmatureDataFromTextureAtlas(param1:DragonBonesData, param2:ArmatureData, param3:Object, param4:String = null) : Armature
      {
         var _loc5_:Armature = generateArmature();
         _loc5_.name = param2.name;
         _loc5_.__dragonBonesData = param1;
         _loc5_._armatureData = param2;
         _loc5_.animation.animationDataList = param2.animationDataList;
         buildBones(_loc5_);
         buildSlots(_loc5_,param4,param3);
         _loc5_.advanceTime(0);
         return _loc5_;
      }
      
      protected function buildFastArmatureUsingArmatureDataFromTextureAtlas(param1:DragonBonesData, param2:ArmatureData, param3:Object, param4:String = null) : FastArmature
      {
         var _loc5_:FastArmature = generateFastArmature();
         _loc5_.name = param2.name;
         _loc5_.__dragonBonesData = param1;
         _loc5_._armatureData = param2;
         _loc5_.animation.animationDataList = param2.animationDataList;
         buildFastBones(_loc5_);
         buildFastSlots(_loc5_,param4,param3);
         _loc5_.advanceTime(0);
         return _loc5_;
      }
      
      public function copyAnimationsToArmature(param1:Armature, param2:String, param3:String = null, param4:Boolean = true) : Boolean
      {
         var _loc5_:* = null;
         var _loc7_:* = null;
         var _loc14_:* = null;
         var _loc13_:* = null;
         var _loc16_:* = 0;
         var _loc6_:* = null;
         var _loc10_:* = null;
         var _loc11_:int = 0;
         var _loc12_:BuildArmatureDataPackage = new BuildArmatureDataPackage();
         if(!fillBuildArmatureDataPackageArmatureInfo(param2,param3,_loc12_))
         {
            return false;
         }
         var _loc15_:ArmatureData = _loc12_.armatureData;
         param1.animation.animationDataList = _loc15_.animationDataList;
         var _loc8_:SkinData = _loc15_.getSkinData("");
         var _loc9_:Vector.<Slot> = param1.getSlots(false);
         var _loc18_:int = 0;
         var _loc17_:* = _loc9_;
         for each(_loc14_ in _loc9_)
         {
            _loc13_ = _loc14_.displayList;
            _loc16_ = uint(_loc13_.length);
            _loc11_ = 0;
            while(_loc11_ < _loc16_)
            {
               _loc6_ = _loc13_[_loc11_];
               if(_loc6_ is Armature)
               {
                  _loc10_ = _loc6_ as Armature;
                  _loc5_ = _loc8_.getSlotData(_loc14_.name);
                  _loc7_ = _loc5_.displayDataList[_loc11_];
                  if(_loc7_.type == "armature")
                  {
                     copyAnimationsToArmature(_loc10_,_loc7_.name,_loc12_.dragonBonesDataName,param4);
                  }
               }
               _loc11_++;
            }
         }
         return true;
      }
      
      private function fillBuildArmatureDataPackageArmatureInfo(param1:String, param2:String, param3:BuildArmatureDataPackage) : Boolean
      {
         if(param2)
         {
            param3.dragonBonesDataName = param2;
            param3.dragonBonesData = dragonBonesDataDic[param2];
            param3.armatureData = param3.dragonBonesData.getArmatureDataByName(param1);
            return true;
         }
         var _loc5_:int = 0;
         var _loc4_:* = dragonBonesDataDic;
         for(param2 in dragonBonesDataDic)
         {
            param3.dragonBonesData = dragonBonesDataDic[param2];
            param3.armatureData = param3.dragonBonesData.getArmatureDataByName(param1);
            if(param3.armatureData)
            {
               param3.dragonBonesDataName = param2;
               return true;
            }
         }
         return false;
      }
      
      private function fillBuildArmatureDataPackageTextureInfo(param1:String, param2:BuildArmatureDataPackage) : void
      {
         param2.textureAtlas = textureAtlasDic[!!param1?param1:param2.dragonBonesDataName];
      }
      
      protected function findFirstDragonBonesData() : DragonBonesData
      {
         var _loc3_:int = 0;
         var _loc2_:* = dragonBonesDataDic;
         for each(var _loc1_ in dragonBonesDataDic)
         {
            if(_loc1_)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      protected function findFirstTextureAtlas() : Object
      {
         var _loc3_:int = 0;
         var _loc2_:* = textureAtlasDic;
         for each(var _loc1_ in textureAtlasDic)
         {
            if(_loc1_)
            {
               return _loc1_;
            }
         }
         return null;
      }
      
      protected function buildBones(param1:Armature) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         var _loc6_:int = 0;
         var _loc5_:Vector.<BoneData> = param1.armatureData.boneDataList;
         _loc6_ = 0;
         while(_loc6_ < _loc5_.length)
         {
            _loc4_ = _loc5_[_loc6_];
            _loc2_ = Bone.initWithBoneData(_loc4_);
            _loc3_ = _loc4_.parent;
            if(_loc3_ && param1.armatureData.getBoneData(_loc3_) == null)
            {
               _loc3_ = null;
            }
            param1.addBone(_loc2_,_loc3_,true);
            _loc6_++;
         }
         param1.updateAnimationAfterBoneListChanged();
      }
      
      protected function buildFastBones(param1:FastArmature) : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:Vector.<BoneData> = param1.armatureData.boneDataList;
         _loc5_ = 0;
         while(_loc5_ < _loc4_.length)
         {
            _loc3_ = _loc4_[_loc5_];
            _loc2_ = FastBone.initWithBoneData(_loc3_);
            param1.addBone(_loc2_,_loc3_.parent);
            _loc5_++;
         }
      }
      
      protected function buildFastSlots(param1:FastArmature, param2:String, param3:Object) : void
      {
         var _loc4_:* = null;
         var _loc12_:* = null;
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         var _loc13_:* = null;
         var _loc10_:* = null;
         var _loc11_:SkinData = param1.armatureData.getSkinData(param2);
         if(!_loc11_)
         {
            return;
         }
         param1.armatureData.setSkinData(param2);
         var _loc5_:Array = [];
         var _loc9_:Vector.<SlotData> = param1.armatureData.slotDataList;
         _loc8_ = 0;
         while(_loc8_ < _loc9_.length)
         {
            _loc5_.length = 0;
            _loc4_ = _loc9_[_loc8_];
            _loc12_ = generateFastSlot();
            _loc12_.initWithSlotData(_loc4_);
            _loc6_ = _loc4_.displayDataList.length;
            while(true)
            {
               _loc6_--;
               if(!_loc6_)
               {
                  break;
               }
               _loc13_ = _loc4_.displayDataList[_loc6_];
               var _loc14_:* = _loc13_.type;
               if("armature" !== _loc14_)
               {
                  if("image" !== _loc14_)
                  {
                  }
                  _loc5_[_loc6_] = generateDisplay(param3,_loc13_.name,_loc13_.pivot.x,_loc13_.pivot.y);
               }
               else
               {
                  _loc10_ = buildFastArmatureUsingArmatureDataFromTextureAtlas(param1.__dragonBonesData,param1.__dragonBonesData.getArmatureDataByName(_loc13_.name),param3,param2);
                  _loc5_[_loc6_] = _loc10_;
                  _loc12_.hasChildArmature = true;
               }
            }
            var _loc17_:int = 0;
            var _loc16_:* = _loc5_;
            for each(var _loc7_ in _loc5_)
            {
               if(_loc7_)
               {
                  if(_loc7_ is FastArmature)
                  {
                     _loc7_ = (_loc7_ as FastArmature).display;
                  }
                  if(_loc7_.hasOwnProperty("name"))
                  {
                     try
                     {
                        _loc7_["name"] = _loc12_.name;
                     }
                     catch(err:Error)
                     {
                        continue;
                     }
                  }
               }
            }
            _loc12_.initDisplayList(_loc5_.concat());
            param1.addSlot(_loc12_,_loc4_.parent);
            _loc12_.changeDisplayIndex(_loc4_.displayIndex);
            _loc8_++;
         }
      }
      
      protected function buildSlots(param1:Armature, param2:String, param3:Object) : void
      {
         var _loc4_:* = null;
         var _loc14_:* = null;
         var _loc10_:* = null;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc15_:* = null;
         var _loc12_:* = null;
         var _loc13_:SkinData = param1.armatureData.getSkinData(param2);
         if(!_loc13_)
         {
            return;
         }
         param1.armatureData.setSkinData(param2);
         var _loc6_:Array = [];
         var _loc11_:Vector.<SlotData> = param1.armatureData.slotDataList;
         var _loc5_:Object = {};
         _loc9_ = 0;
         while(_loc9_ < _loc11_.length)
         {
            _loc6_.length = 0;
            _loc4_ = _loc11_[_loc9_];
            _loc10_ = param1.getBone(_loc4_.parent);
            if(_loc10_)
            {
               _loc14_ = generateSlot();
               _loc14_.initWithSlotData(_loc4_);
               _loc10_.addSlot(_loc14_);
               _loc7_ = _loc4_.displayDataList.length;
               while(true)
               {
                  _loc7_--;
                  if(!_loc7_)
                  {
                     break;
                  }
                  _loc15_ = _loc4_.displayDataList[_loc7_];
                  var _loc16_:* = _loc15_.type;
                  if("armature" !== _loc16_)
                  {
                     if("image" !== _loc16_)
                     {
                     }
                     _loc6_[_loc7_] = generateDisplay(param3,_loc15_.name,_loc15_.pivot.x,_loc15_.pivot.y);
                  }
                  else
                  {
                     _loc12_ = buildArmatureUsingArmatureDataFromTextureAtlas(param1.__dragonBonesData,param1.__dragonBonesData.getArmatureDataByName(_loc15_.name),param3,param2);
                     _loc6_[_loc7_] = _loc12_;
                  }
               }
               var _loc19_:int = 0;
               var _loc18_:* = _loc6_;
               for each(var _loc8_ in _loc6_)
               {
                  if(_loc8_ && _loc8_ is Armature)
                  {
                     _loc8_ = (_loc8_ as Armature).display;
                  }
                  if(_loc8_ && _loc8_.hasOwnProperty("name"))
                  {
                     try
                     {
                        _loc8_["name"] = _loc14_.name;
                     }
                     catch(err:Error)
                     {
                        continue;
                     }
                  }
               }
               _loc5_[_loc4_.name] = _loc6_.concat();
               _loc14_.displayList = _loc6_;
               _loc14_.changeDisplay(_loc4_.displayIndex);
            }
            _loc9_++;
         }
         param1.addSkinList(param2,_loc5_);
      }
      
      public function addSkinToArmature(param1:Armature, param2:String, param3:String) : void
      {
         var _loc4_:* = null;
         var _loc17_:* = null;
         var _loc12_:* = null;
         var _loc6_:* = undefined;
         var _loc9_:int = 0;
         var _loc7_:int = 0;
         var _loc16_:* = null;
         var _loc14_:* = null;
         var _loc10_:Object = textureAtlasDic[param3];
         var _loc15_:SkinData = param1.armatureData.getSkinData(param2);
         if(!_loc15_ || !_loc10_)
         {
            return;
         }
         var _loc5_:Array = [];
         var _loc13_:Vector.<SlotData> = param1.armatureData.slotDataList;
         var _loc11_:Object = {};
         _loc9_ = 0;
         while(_loc9_ < _loc13_.length)
         {
            _loc5_.length = 0;
            _loc4_ = _loc13_[_loc9_];
            _loc12_ = param1.getBone(_loc4_.parent);
            if(_loc12_)
            {
               _loc7_ = 0;
               if(_loc9_ >= _loc15_.slotDataList.length)
               {
                  _loc7_ = 0;
               }
               else
               {
                  _loc6_ = _loc15_.slotDataList[_loc9_].displayDataList;
                  _loc7_ = _loc6_.length;
               }
               while(true)
               {
                  _loc7_--;
                  if(!_loc7_)
                  {
                     break;
                  }
                  _loc16_ = _loc6_[_loc7_];
                  var _loc18_:* = _loc16_.type;
                  if("armature" !== _loc18_)
                  {
                     if("image" !== _loc18_)
                     {
                     }
                     _loc5_[_loc7_] = generateDisplay(_loc10_,_loc16_.name,_loc16_.pivot.x,_loc16_.pivot.y);
                  }
                  else
                  {
                     _loc14_ = buildArmatureUsingArmatureDataFromTextureAtlas(param1.__dragonBonesData,param1.__dragonBonesData.getArmatureDataByName(_loc16_.name),_loc10_,param2);
                     _loc5_[_loc7_] = _loc14_;
                  }
               }
               var _loc21_:int = 0;
               var _loc20_:* = _loc5_;
               for each(var _loc8_ in _loc5_)
               {
                  if(_loc8_ is Armature)
                  {
                     _loc8_ = (_loc8_ as Armature).display;
                  }
                  if(_loc8_.hasOwnProperty("name"))
                  {
                     try
                     {
                        _loc8_["name"] = _loc17_.name;
                     }
                     catch(err:Error)
                     {
                        continue;
                     }
                  }
               }
               _loc11_[_loc4_.name] = _loc5_.concat();
            }
            _loc9_++;
         }
         param1.addSkinList(param2,_loc11_);
      }
      
      public function parseData(param1:ByteArray, param2:String = null) : void
      {
         throw new Error("屏蔽了parseData()不要用这个!!");
      }
      
      protected function parseCompleteHandler(param1:Event) : void
      {
         var _loc3_:DecompressedData = param1.target as DecompressedData;
         _loc3_.removeEventListener("complete",parseCompleteHandler);
         var _loc2_:Object = generateTextureAtlas(_loc3_.textureAtlas,_loc3_.textureAtlasData);
         addTextureAtlas(_loc2_,_loc3_.name);
         _loc3_.dispose();
         this.dispatchEvent(new Event("complete"));
      }
      
      protected function generateTextureAtlas(param1:Object, param2:Object) : ITextureAtlas
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
      
      protected function generateDisplay(param1:Object, param2:String, param3:Number, param4:Number) : Object
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
