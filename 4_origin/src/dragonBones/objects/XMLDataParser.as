package dragonBones.objects
{
   import dragonBones.§core:dragonBones_internal§.parseAnimationData;
   import dragonBones.textures.TextureData;
   import dragonBones.utils.DBDataUtil;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class XMLDataParser
   {
      
      private static var tempDragonBonesData:DragonBonesData;
       
      
      public function XMLDataParser()
      {
         super();
      }
      
      public static function parseTextureAtlasData(param1:XML, param2:Number = 1) : Object
      {
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc8_:* = false;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc10_:Object = {};
         _loc10_.__name = param1["name"];
         var _loc12_:int = 0;
         var _loc11_:* = param1["SubTexture"];
         for each(var _loc9_ in param1["SubTexture"])
         {
            _loc4_ = _loc9_["name"];
            _loc5_ = new Rectangle();
            _loc5_.x = int(_loc9_["x"]) / param2;
            _loc5_.y = int(_loc9_["y"]) / param2;
            _loc5_.width = int(_loc9_["width"]) / param2;
            _loc5_.height = int(_loc9_["height"]) / param2;
            _loc8_ = _loc9_["rotated"] == "true";
            _loc6_ = int(_loc9_["frameWidth"]) / param2;
            _loc7_ = int(_loc9_["frameHeight"]) / param2;
            if(_loc6_ > 0 && _loc7_ > 0)
            {
               _loc3_ = new Rectangle();
               _loc3_.x = int(_loc9_["frameX"]) / param2;
               _loc3_.y = int(_loc9_["frameY"]) / param2;
               _loc3_.width = _loc6_;
               _loc3_.height = _loc7_;
            }
            else
            {
               _loc3_ = null;
            }
            _loc10_[_loc4_] = new TextureData(_loc5_,_loc3_,_loc8_);
         }
         return _loc10_;
      }
      
      public static function parseDragonBonesData(param1:XML) : DragonBonesData
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         var _loc5_:String = param1["version"];
         var _loc6_:* = _loc5_;
         if("2.3" !== _loc6_)
         {
            if("3.0" !== _loc6_)
            {
               if("4.0" !== _loc6_)
               {
                  throw new Error("Nonsupport version!");
               }
               var _loc4_:uint = int(param1["frameRate"]);
               var _loc3_:DragonBonesData = new DragonBonesData();
               _loc3_.name = param1["name"];
               _loc3_.isGlobalData = param1["isGlobal"] == "0"?false:true;
               tempDragonBonesData = _loc3_;
               var _loc8_:int = 0;
               var _loc7_:* = param1["armature"];
               for each(var _loc2_ in param1["armature"])
               {
                  _loc3_.addArmatureData(parseArmatureData(_loc2_,_loc4_));
               }
               tempDragonBonesData = null;
               return _loc3_;
            }
         }
         return XML3DataParser.parseSkeletonData(param1);
      }
      
      private static function parseArmatureData(param1:XML, param2:uint) : ArmatureData
      {
         var _loc8_:* = null;
         var _loc6_:* = null;
         var _loc5_:ArmatureData = new ArmatureData();
         _loc5_.name = param1["name"];
         var _loc10_:int = 0;
         var _loc9_:* = param1["bone"];
         for each(var _loc7_ in param1["bone"])
         {
            _loc5_.addBoneData(parseBoneData(_loc7_));
         }
         var _loc12_:int = 0;
         var _loc11_:* = param1["slot"];
         for each(var _loc4_ in param1["slot"])
         {
            _loc5_.addSlotData(parseSlotData(_loc4_));
         }
         var _loc14_:int = 0;
         var _loc13_:* = param1["skin"];
         for each(var _loc3_ in param1["skin"])
         {
            _loc5_.addSkinData(parseSkinData(_loc3_));
         }
         if(tempDragonBonesData.isGlobalData)
         {
            DBDataUtil.transformArmatureData(_loc5_);
         }
         _loc5_.sortBoneDataList();
         var _loc16_:int = 0;
         var _loc15_:* = param1["animation"];
         for each(_loc8_ in param1["animation"])
         {
            _loc6_ = parseAnimationData(_loc8_,param2);
            DBDataUtil.addHideTimeline(_loc6_,_loc5_);
            DBDataUtil.transformAnimationData(_loc6_,_loc5_,tempDragonBonesData.isGlobalData);
            _loc5_.addAnimationData(_loc6_);
         }
         return _loc5_;
      }
      
      private static function parseBoneData(param1:XML) : BoneData
      {
         var _loc2_:BoneData = new BoneData();
         _loc2_.name = param1["name"];
         _loc2_.parent = param1["parent"];
         _loc2_.length = Number(param1["length"]);
         _loc2_.inheritRotation = getBoolean(param1,"inheritRotation",true);
         _loc2_.inheritScale = getBoolean(param1,"inheritScale",true);
         parseTransform(param1["transform"][0],_loc2_.transform);
         if(tempDragonBonesData.isGlobalData)
         {
            _loc2_.global.copy(_loc2_.transform);
         }
         return _loc2_;
      }
      
      private static function parseSkinData(param1:XML) : SkinData
      {
         var _loc3_:SkinData = new SkinData();
         _loc3_.name = param1["name"];
         var _loc5_:int = 0;
         var _loc4_:* = param1["slot"];
         for each(var _loc2_ in param1["slot"])
         {
            _loc3_.addSlotData(parseSlotDisplayData(_loc2_));
         }
         return _loc3_;
      }
      
      private static function parseSlotDisplayData(param1:XML) : SlotData
      {
         var _loc2_:SlotData = new SlotData();
         _loc2_.name = param1["name"];
         var _loc5_:int = 0;
         var _loc4_:* = param1["display"];
         for each(var _loc3_ in param1["display"])
         {
            _loc2_.addDisplayData(parseDisplayData(_loc3_));
         }
         return _loc2_;
      }
      
      private static function parseSlotData(param1:XML) : SlotData
      {
         var _loc2_:SlotData = new SlotData();
         _loc2_.name = param1["name"];
         _loc2_.parent = param1["parent"];
         _loc2_.zOrder = getNumber(param1,"z",0) || 0;
         _loc2_.blendMode = param1["blendMode"];
         _loc2_.displayIndex = param1["displayIndex"];
         return _loc2_;
      }
      
      private static function parseDisplayData(param1:XML) : DisplayData
      {
         var _loc2_:DisplayData = new DisplayData();
         _loc2_.name = param1["name"];
         _loc2_.type = param1["type"];
         parseTransform(param1["transform"][0],_loc2_.transform,_loc2_.pivot);
         _loc2_.pivot.x = NaN;
         _loc2_.pivot.y = NaN;
         if(tempDragonBonesData != null)
         {
            tempDragonBonesData.addDisplayData(_loc2_);
         }
         return _loc2_;
      }
      
      static function parseAnimationData(param1:XML, param2:uint) : AnimationData
      {
         var _loc4_:* = null;
         var _loc8_:* = null;
         var _loc3_:* = null;
         var _loc10_:AnimationData = new AnimationData();
         _loc10_.name = param1["name"];
         _loc10_.frameRate = param2;
         _loc10_.duration = Math.round((int(param1["duration"]) || 1) * 1000 / param2);
         _loc10_.playTimes = int(getNumber(param1,"playTimes",1));
         _loc10_.fadeTime = getNumber(param1,"fadeInTime",0) || 0;
         _loc10_.scale = getNumber(param1,"scale",1) || 0;
         _loc10_.tweenEasing = getNumber(param1,"tweenEasing",NaN);
         _loc10_.autoTween = getBoolean(param1,"autoTween",true);
         var _loc12_:int = 0;
         var _loc11_:* = param1["frame"];
         for each(var _loc6_ in param1["frame"])
         {
            _loc4_ = parseTransformFrame(_loc6_,param2);
            _loc10_.addFrame(_loc4_);
         }
         parseTimeline(param1,_loc10_);
         var _loc9_:int = _loc10_.duration;
         var _loc14_:int = 0;
         var _loc13_:* = param1["bone"];
         for each(var _loc5_ in param1["bone"])
         {
            _loc8_ = parseTransformTimeline(_loc5_,_loc10_.duration,param2);
            if(_loc8_.frameList.length > 0)
            {
               _loc9_ = Math.min(_loc9_,_loc8_.frameList[_loc8_.frameList.length - 1].duration);
               _loc10_.addTimeline(_loc8_);
            }
         }
         var _loc16_:int = 0;
         var _loc15_:* = param1["slot"];
         for each(var _loc7_ in param1["slot"])
         {
            _loc3_ = parseSlotTimeline(_loc7_,_loc10_.duration,param2);
            if(_loc3_.frameList.length > 0)
            {
               _loc9_ = Math.min(_loc9_,_loc3_.frameList[_loc3_.frameList.length - 1].duration);
               _loc10_.addSlotTimeline(_loc3_);
            }
         }
         if(_loc10_.frameList.length > 0)
         {
            _loc9_ = Math.min(_loc9_,_loc10_.frameList[_loc10_.frameList.length - 1].duration);
         }
         _loc10_.lastFrameDuration = _loc9_;
         return _loc10_;
      }
      
      private static function parseTransformTimeline(param1:XML, param2:int, param3:uint) : TransformTimeline
      {
         var _loc4_:* = null;
         var _loc6_:TransformTimeline = new TransformTimeline();
         _loc6_.name = param1["name"];
         _loc6_.scale = getNumber(param1,"scale",1) || 0;
         _loc6_.offset = getNumber(param1,"offset",0) || 0;
         _loc6_.originPivot.x = getNumber(param1,"pX",0) || 0;
         _loc6_.originPivot.y = getNumber(param1,"pY",0) || 0;
         _loc6_.duration = param2;
         var _loc8_:int = 0;
         var _loc7_:* = param1["frame"];
         for each(var _loc5_ in param1["frame"])
         {
            _loc4_ = parseTransformFrame(_loc5_,param3);
            _loc6_.addFrame(_loc4_);
         }
         parseTimeline(param1,_loc6_);
         return _loc6_;
      }
      
      private static function parseSlotTimeline(param1:XML, param2:int, param3:uint) : SlotTimeline
      {
         var _loc4_:* = null;
         var _loc6_:SlotTimeline = new SlotTimeline();
         _loc6_.name = param1["name"];
         _loc6_.scale = getNumber(param1,"scale",1) || 0;
         _loc6_.offset = getNumber(param1,"offset",0) || 0;
         _loc6_.duration = param2;
         var _loc8_:int = 0;
         var _loc7_:* = param1["frame"];
         for each(var _loc5_ in param1["frame"])
         {
            _loc4_ = parseSlotFrame(_loc5_,param3);
            _loc6_.addFrame(_loc4_);
         }
         parseTimeline(param1,_loc6_);
         return _loc6_;
      }
      
      private static function parseMainFrame(param1:XML, param2:uint) : Frame
      {
         var _loc3_:Frame = new Frame();
         parseFrame(param1,_loc3_,param2);
         return _loc3_;
      }
      
      private static function parseSlotFrame(param1:XML, param2:uint) : SlotFrame
      {
         var _loc3_:SlotFrame = new SlotFrame();
         parseFrame(param1,_loc3_,param2);
         _loc3_.visible = !getBoolean(param1,"hide",false);
         _loc3_.tweenEasing = getNumber(param1,"tweenEasing",10);
         _loc3_.displayIndex = int(getNumber(param1,"displayIndex",0));
         _loc3_.zOrder = getNumber(param1,"z",!!tempDragonBonesData.isGlobalData?NaN:0);
         var _loc4_:XML = param1["color"][0];
         if(_loc4_)
         {
            _loc3_.color = new ColorTransform();
            parseColorTransform(_loc4_,_loc3_.color);
         }
         return _loc3_;
      }
      
      private static function parseTransformFrame(param1:XML, param2:uint) : TransformFrame
      {
         var _loc3_:TransformFrame = new TransformFrame();
         parseFrame(param1,_loc3_,param2);
         _loc3_.visible = !getBoolean(param1,"hide",false);
         _loc3_.tweenEasing = getNumber(param1,"tweenEasing",10);
         _loc3_.tweenRotate = int(getNumber(param1,"tweenRotate",0));
         _loc3_.tweenScale = getBoolean(param1,"tweenScale",true);
         parseTransform(param1["transform"][0],_loc3_.transform,_loc3_.pivot);
         if(tempDragonBonesData.isGlobalData)
         {
            _loc3_.global.copy(_loc3_.transform);
         }
         _loc3_.scaleOffset.x = getNumber(param1,"scXOffset",0) || 0;
         _loc3_.scaleOffset.y = getNumber(param1,"scYOffset",0) || 0;
         return _loc3_;
      }
      
      private static function parseTimeline(param1:XML, param2:Timeline) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = param2.frameList;
         for each(_loc4_ in param2.frameList)
         {
            _loc4_.position = _loc3_;
            _loc3_ = _loc3_ + _loc4_.duration;
         }
         if(_loc4_)
         {
            _loc4_.duration = param2.duration - _loc4_.position;
         }
      }
      
      private static function parseFrame(param1:XML, param2:Frame, param3:uint) : void
      {
         param2.duration = Math.round(int(param1["duration"]) * 1000 / param3);
         param2.action = param1["action"];
         param2.event = param1["event"];
         param2.sound = param1["sound"];
      }
      
      private static function parseTransform(param1:XML, param2:DBTransform, param3:Point = null) : void
      {
         if(param1)
         {
            if(param2)
            {
               param2.x = getNumber(param1,"x",0) || 0;
               param2.y = getNumber(param1,"y",0) || 0;
               param2.skewX = getNumber(param1,"skX",0) * 0.0174532925199433 || 0;
               param2.skewY = getNumber(param1,"skY",0) * 0.0174532925199433 || 0;
               param2.scaleX = getNumber(param1,"scX",1) || 0;
               param2.scaleY = getNumber(param1,"scY",1) || 0;
            }
            if(param3)
            {
               param3.x = getNumber(param1,"pX",0) || 0;
               param3.y = getNumber(param1,"pY",0) || 0;
            }
         }
      }
      
      private static function parseColorTransform(param1:XML, param2:ColorTransform) : void
      {
         if(param1)
         {
            if(param2)
            {
               param2.alphaOffset = int(param1["aO"]);
               param2.redOffset = int(param1["rO"]);
               param2.greenOffset = int(param1["gO"]);
               param2.blueOffset = int(param1["bO"]);
               param2.alphaMultiplier = (int(getNumber(param1,"aM",100) || 0)) * 0.01;
               param2.redMultiplier = (int(getNumber(param1,"rM",100) || 0)) * 0.01;
               param2.greenMultiplier = (int(getNumber(param1,"gM",100) || 0)) * 0.01;
               param2.blueMultiplier = (int(getNumber(param1,"bM",100) || 0)) * 0.01;
            }
         }
      }
      
      private static function getBoolean(param1:XML, param2:String, param3:Boolean) : Boolean
      {
         if(param1 && param1[param2].length() > 0)
         {
            var _loc4_:String = param1[param2];
            if("0" !== _loc4_)
            {
               if("NaN" !== _loc4_)
               {
                  if("" !== _loc4_)
                  {
                     if("false" !== _loc4_)
                     {
                        if("null" !== _loc4_)
                        {
                           if("undefined" !== _loc4_)
                           {
                              if("1" !== _loc4_)
                              {
                                 if("true" !== _loc4_)
                                 {
                                 }
                                 addr30:
                                 return true;
                              }
                              §§goto(addr30);
                           }
                        }
                        addr25:
                        return false;
                     }
                     addr24:
                     §§goto(addr25);
                  }
                  addr23:
                  §§goto(addr24);
               }
               addr22:
               §§goto(addr23);
            }
            §§goto(addr22);
         }
         else
         {
            return param3;
         }
      }
      
      private static function getNumber(param1:XML, param2:String, param3:Number) : Number
      {
         if(param1 && param1[param2].length() > 0)
         {
            var _loc4_:String = param1[param2];
            if("NaN" !== _loc4_)
            {
               if("" !== _loc4_)
               {
                  if("false" !== _loc4_)
                  {
                     if("null" !== _loc4_)
                     {
                        if("undefined" !== _loc4_)
                        {
                           return Number(param1[param2]);
                        }
                     }
                     addr24:
                     return NaN;
                  }
                  addr23:
                  §§goto(addr24);
               }
               addr22:
               §§goto(addr23);
            }
            §§goto(addr22);
         }
         else
         {
            return param3;
         }
      }
   }
}
