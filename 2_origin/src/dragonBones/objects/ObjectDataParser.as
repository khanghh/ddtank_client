package dragonBones.objects
{
   import dragonBones.§core:dragonBones_internal§.parseAnimationData;
   import dragonBones.textures.TextureData;
   import dragonBones.utils.DBDataUtil;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public final class ObjectDataParser
   {
      
      private static var tempDragonBonesData:DragonBonesData;
       
      
      public function ObjectDataParser()
      {
         super();
      }
      
      public static function parseTextureAtlasData(param1:Object, param2:Number = 1) : Object
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc6_:* = null;
         var _loc9_:* = false;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:Object = {};
         _loc10_.__name = param1["name"];
         var _loc12_:int = 0;
         var _loc11_:* = param1["SubTexture"];
         for each(var _loc3_ in param1["SubTexture"])
         {
            _loc5_ = _loc3_["name"];
            _loc6_ = new Rectangle();
            _loc6_.x = int(_loc3_["x"]) / param2;
            _loc6_.y = int(_loc3_["y"]) / param2;
            _loc6_.width = int(_loc3_["width"]) / param2;
            _loc6_.height = int(_loc3_["height"]) / param2;
            _loc9_ = _loc3_["rotated"] == "true";
            _loc7_ = int(_loc3_["frameWidth"]) / param2;
            _loc8_ = int(_loc3_["frameHeight"]) / param2;
            if(_loc7_ > 0 && _loc8_ > 0)
            {
               _loc4_ = new Rectangle();
               _loc4_.x = int(_loc3_["frameX"]) / param2;
               _loc4_.y = int(_loc3_["frameY"]) / param2;
               _loc4_.width = _loc7_;
               _loc4_.height = _loc8_;
            }
            else
            {
               _loc4_ = null;
            }
            _loc10_[_loc5_] = new TextureData(_loc6_,_loc4_,_loc9_);
         }
         return _loc10_;
      }
      
      public static function parseDragonBonesData(param1:Object) : DragonBonesData
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
         return Object3DataParser.parseSkeletonData(param1);
      }
      
      private static function parseArmatureData(param1:Object, param2:uint) : ArmatureData
      {
         var _loc7_:* = null;
         var _loc6_:ArmatureData = new ArmatureData();
         _loc6_.name = param1["name"];
         var _loc10_:int = 0;
         var _loc9_:* = param1["bone"];
         for each(var _loc5_ in param1["bone"])
         {
            _loc6_.addBoneData(parseBoneData(_loc5_));
         }
         var _loc12_:int = 0;
         var _loc11_:* = param1["slot"];
         for each(var _loc8_ in param1["slot"])
         {
            _loc6_.addSlotData(parseSlotData(_loc8_));
         }
         var _loc14_:int = 0;
         var _loc13_:* = param1["skin"];
         for each(var _loc4_ in param1["skin"])
         {
            _loc6_.addSkinData(parseSkinData(_loc4_));
         }
         if(tempDragonBonesData.isGlobalData)
         {
            DBDataUtil.transformArmatureData(_loc6_);
         }
         _loc6_.sortBoneDataList();
         var _loc16_:int = 0;
         var _loc15_:* = param1["animation"];
         for each(var _loc3_ in param1["animation"])
         {
            _loc7_ = parseAnimationData(_loc3_,param2);
            DBDataUtil.addHideTimeline(_loc7_,_loc6_);
            DBDataUtil.transformAnimationData(_loc7_,_loc6_,tempDragonBonesData.isGlobalData);
            _loc6_.addAnimationData(_loc7_);
         }
         return _loc6_;
      }
      
      private static function parseBoneData(param1:Object) : BoneData
      {
         var _loc2_:BoneData = new BoneData();
         _loc2_.name = param1["name"];
         _loc2_.parent = param1["parent"];
         _loc2_.length = Number(param1["length"]);
         _loc2_.inheritRotation = getBoolean(param1,"inheritRotation",true);
         _loc2_.inheritScale = getBoolean(param1,"inheritScale",true);
         parseTransform(param1["transform"],_loc2_.transform);
         if(tempDragonBonesData.isGlobalData)
         {
            _loc2_.global.copy(_loc2_.transform);
         }
         return _loc2_;
      }
      
      private static function parseSkinData(param1:Object) : SkinData
      {
         var _loc2_:SkinData = new SkinData();
         _loc2_.name = param1["name"];
         var _loc5_:int = 0;
         var _loc4_:* = param1["slot"];
         for each(var _loc3_ in param1["slot"])
         {
            _loc2_.addSlotData(parseSlotDisplayData(_loc3_));
         }
         return _loc2_;
      }
      
      private static function parseSlotDisplayData(param1:Object) : SlotData
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
      
      private static function parseSlotData(param1:Object) : SlotData
      {
         var _loc2_:SlotData = new SlotData();
         _loc2_.name = param1["name"];
         _loc2_.parent = param1["parent"];
         _loc2_.zOrder = getNumber(param1,"z",0) || 0;
         _loc2_.blendMode = param1["blendMode"];
         _loc2_.displayIndex = param1["displayIndex"];
         return _loc2_;
      }
      
      private static function parseDisplayData(param1:Object) : DisplayData
      {
         var _loc2_:DisplayData = new DisplayData();
         _loc2_.name = param1["name"];
         _loc2_.type = param1["type"];
         parseTransform(param1["transform"],_loc2_.transform,_loc2_.pivot);
         _loc2_.pivot.x = NaN;
         _loc2_.pivot.y = NaN;
         if(tempDragonBonesData != null)
         {
            tempDragonBonesData.addDisplayData(_loc2_);
         }
         return _loc2_;
      }
      
      static function parseAnimationData(param1:Object, param2:uint) : AnimationData
      {
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         var _loc10_:AnimationData = new AnimationData();
         _loc10_.name = param1["name"];
         _loc10_.frameRate = param2;
         _loc10_.duration = Math.round((Number(param1["duration"]) || 1) * 1000 / param2);
         _loc10_.playTimes = int(getNumber(param1,"playTimes",1));
         _loc10_.fadeTime = getNumber(param1,"fadeInTime",0) || 0;
         _loc10_.scale = getNumber(param1,"scale",1) || 0;
         _loc10_.tweenEasing = getNumber(param1,"tweenEasing",NaN);
         _loc10_.autoTween = getBoolean(param1,"autoTween",true);
         var _loc12_:int = 0;
         var _loc11_:* = param1["frame"];
         for each(var _loc7_ in param1["frame"])
         {
            _loc4_ = parseTransformFrame(_loc7_,param2);
            _loc10_.addFrame(_loc4_);
         }
         parseTimeline(param1,_loc10_);
         var _loc6_:int = _loc10_.duration;
         var _loc14_:int = 0;
         var _loc13_:* = param1["bone"];
         for each(var _loc8_ in param1["bone"])
         {
            _loc5_ = parseTransformTimeline(_loc8_,_loc10_.duration,param2);
            if(_loc5_.frameList.length > 0)
            {
               _loc6_ = Math.min(_loc6_,_loc5_.frameList[_loc5_.frameList.length - 1].duration);
               _loc10_.addTimeline(_loc5_);
            }
         }
         var _loc16_:int = 0;
         var _loc15_:* = param1["slot"];
         for each(var _loc9_ in param1["slot"])
         {
            _loc3_ = parseSlotTimeline(_loc9_,_loc10_.duration,param2);
            if(_loc3_.frameList.length > 0)
            {
               _loc6_ = Math.min(_loc6_,_loc3_.frameList[_loc3_.frameList.length - 1].duration);
               _loc10_.addSlotTimeline(_loc3_);
            }
         }
         if(_loc10_.frameList.length > 0)
         {
            _loc6_ = Math.min(_loc6_,_loc10_.frameList[_loc10_.frameList.length - 1].duration);
         }
         _loc10_.lastFrameDuration = _loc6_;
         return _loc10_;
      }
      
      private static function parseTransformTimeline(param1:Object, param2:int, param3:uint) : TransformTimeline
      {
         var _loc5_:* = null;
         var _loc4_:TransformTimeline = new TransformTimeline();
         _loc4_.name = param1["name"];
         _loc4_.scale = getNumber(param1,"scale",1) || 0;
         _loc4_.offset = getNumber(param1,"offset",0) || 0;
         _loc4_.originPivot.x = getNumber(param1,"pX",0) || 0;
         _loc4_.originPivot.y = getNumber(param1,"pY",0) || 0;
         _loc4_.duration = param2;
         var _loc8_:int = 0;
         var _loc7_:* = param1["frame"];
         for each(var _loc6_ in param1["frame"])
         {
            _loc5_ = parseTransformFrame(_loc6_,param3);
            _loc4_.addFrame(_loc5_);
         }
         parseTimeline(param1,_loc4_);
         return _loc4_;
      }
      
      private static function parseSlotTimeline(param1:Object, param2:int, param3:uint) : SlotTimeline
      {
         var _loc4_:* = null;
         var _loc5_:SlotTimeline = new SlotTimeline();
         _loc5_.name = param1["name"];
         _loc5_.scale = getNumber(param1,"scale",1) || 0;
         _loc5_.offset = getNumber(param1,"offset",0) || 0;
         _loc5_.duration = param2;
         var _loc8_:int = 0;
         var _loc7_:* = param1["frame"];
         for each(var _loc6_ in param1["frame"])
         {
            _loc4_ = parseSlotFrame(_loc6_,param3);
            _loc5_.addFrame(_loc4_);
         }
         parseTimeline(param1,_loc5_);
         return _loc5_;
      }
      
      private static function parseMainFrame(param1:Object, param2:uint) : Frame
      {
         var _loc3_:Frame = new Frame();
         parseFrame(param1,_loc3_,param2);
         return _loc3_;
      }
      
      private static function parseTransformFrame(param1:Object, param2:uint) : TransformFrame
      {
         var _loc3_:TransformFrame = new TransformFrame();
         parseFrame(param1,_loc3_,param2);
         _loc3_.visible = !getBoolean(param1,"hide",false);
         _loc3_.tweenEasing = getNumber(param1,"tweenEasing",10);
         _loc3_.tweenRotate = int(getNumber(param1,"tweenRotate",0));
         _loc3_.tweenScale = getBoolean(param1,"tweenScale",true);
         parseTransform(param1["transform"],_loc3_.transform,_loc3_.pivot);
         if(tempDragonBonesData.isGlobalData)
         {
            _loc3_.global.copy(_loc3_.transform);
         }
         _loc3_.scaleOffset.x = getNumber(param1,"scXOffset",0) || 0;
         _loc3_.scaleOffset.y = getNumber(param1,"scYOffset",0) || 0;
         return _loc3_;
      }
      
      private static function parseSlotFrame(param1:Object, param2:uint) : SlotFrame
      {
         var _loc3_:SlotFrame = new SlotFrame();
         parseFrame(param1,_loc3_,param2);
         _loc3_.visible = !getBoolean(param1,"hide",false);
         _loc3_.tweenEasing = getNumber(param1,"tweenEasing",10);
         _loc3_.displayIndex = int(getNumber(param1,"displayIndex",0));
         _loc3_.zOrder = getNumber(param1,"z",!!tempDragonBonesData.isGlobalData?NaN:0);
         var _loc4_:Object = param1["color"];
         if(_loc4_)
         {
            _loc3_.color = new ColorTransform();
            parseColorTransform(_loc4_,_loc3_.color);
         }
         return _loc3_;
      }
      
      private static function parseTimeline(param1:Object, param2:Timeline) : void
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
      
      private static function parseFrame(param1:Object, param2:Frame, param3:uint) : void
      {
         param2.duration = Math.round(param1["duration"] * 1000 / param3);
         param2.action = param1["action"];
         param2.event = param1["event"];
         param2.sound = param1["sound"];
         if(param1["curve"] != null && param1["curve"].length == 4)
         {
            param2.curve = new CurveData();
            param2.curve.pointList = [new Point(param1["curve"][0],param1["curve"][1]),new Point(param1["curve"][2],param1["curve"][3])];
         }
      }
      
      private static function parseTransform(param1:Object, param2:DBTransform, param3:Point = null) : void
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
      
      private static function parseColorTransform(param1:Object, param2:ColorTransform) : void
      {
         if(param1)
         {
            if(param2)
            {
               param2.alphaOffset = int(param1["aO"]);
               param2.redOffset = int(param1["rO"]);
               param2.greenOffset = int(param1["gO"]);
               param2.blueOffset = int(param1["bO"]);
               param2.alphaMultiplier = int(getNumber(param1,"aM",100)) * 0.01;
               param2.redMultiplier = int(getNumber(param1,"rM",100)) * 0.01;
               param2.greenMultiplier = int(getNumber(param1,"gM",100)) * 0.01;
               param2.blueMultiplier = int(getNumber(param1,"bM",100)) * 0.01;
            }
         }
      }
      
      private static function getBoolean(param1:Object, param2:String, param3:Boolean) : Boolean
      {
         if(param1 && param2 in param1)
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
                                 addr27:
                                 return true;
                              }
                              §§goto(addr27);
                           }
                        }
                        addr22:
                        return false;
                     }
                     addr21:
                     §§goto(addr22);
                  }
                  addr20:
                  §§goto(addr21);
               }
               addr19:
               §§goto(addr20);
            }
            §§goto(addr19);
         }
         else
         {
            return param3;
         }
      }
      
      private static function getNumber(param1:Object, param2:String, param3:Number) : Number
      {
         if(param1 && param2 in param1)
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
                     addr21:
                     return NaN;
                  }
                  addr20:
                  §§goto(addr21);
               }
               addr19:
               §§goto(addr20);
            }
            §§goto(addr19);
         }
         else
         {
            return param3;
         }
      }
   }
}
