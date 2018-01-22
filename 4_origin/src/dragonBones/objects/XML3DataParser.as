package dragonBones.objects
{
   import dragonBones.§core:dragonBones_internal§.parseAnimationData;
   import dragonBones.utils.DBDataUtil;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public final class XML3DataParser
   {
      
      private static var tempDragonBonesData:DragonBonesData;
       
      
      public function XML3DataParser()
      {
         super();
      }
      
      public static function parseSkeletonData(param1:XML, param2:Boolean = false, param3:Dictionary = null) : DragonBonesData
      {
         if(!param1)
         {
            throw new ArgumentError();
         }
         var _loc8_:String = param1["version"];
         var _loc9_:* = _loc8_;
         if("2.3" !== _loc9_)
         {
            if("3.0" !== _loc9_)
            {
               throw new Error("Nonsupport version!");
            }
         }
         var _loc7_:uint = int(param1["frameRate"]);
         var _loc6_:DragonBonesData = new DragonBonesData();
         tempDragonBonesData = _loc6_;
         _loc6_.name = param1["name"];
         var _loc5_:Boolean = param1["isGlobal"] == "0"?false:true;
         var _loc11_:int = 0;
         var _loc10_:* = param1["armature"];
         for each(var _loc4_ in param1["armature"])
         {
            _loc6_.addArmatureData(parseArmatureData(_loc4_,_loc6_,_loc7_,_loc5_,param2,param3));
         }
         return _loc6_;
      }
      
      private static function parseArmatureData(param1:XML, param2:DragonBonesData, param3:uint, param4:Boolean, param5:Boolean, param6:Dictionary) : ArmatureData
      {
         var _loc11_:* = null;
         var _loc12_:ArmatureData = new ArmatureData();
         _loc12_.name = param1["name"];
         var _loc14_:int = 0;
         var _loc13_:* = param1["bone"];
         for each(var _loc10_ in param1["bone"])
         {
            _loc12_.addBoneData(parseBoneData(_loc10_,param4));
         }
         var _loc18_:int = 0;
         var _loc17_:* = param1["skin"];
         for each(var _loc9_ in param1["skin"])
         {
            var _loc16_:int = 0;
            var _loc15_:* = _loc9_["slot"];
            for each(var _loc8_ in _loc9_["slot"])
            {
               _loc12_.addSlotData(parseSlotData(_loc8_));
            }
         }
         var _loc20_:int = 0;
         var _loc19_:* = param1["skin"];
         for each(var _loc7_ in param1["skin"])
         {
            _loc12_.addSkinData(parseSkinData(_loc7_,param2));
         }
         if(param4)
         {
            DBDataUtil.transformArmatureData(_loc12_);
         }
         _loc12_.sortBoneDataList();
         if(!param5)
         {
            var _loc22_:int = 0;
            var _loc21_:* = param1["animation"];
            for each(_loc11_ in param1["animation"])
            {
               _loc12_.addAnimationData(parseAnimationData(_loc11_,_loc12_,param3,param4));
            }
         }
         return _loc12_;
      }
      
      private static function parseBoneData(param1:XML, param2:Boolean) : BoneData
      {
         var _loc3_:BoneData = new BoneData();
         _loc3_.name = param1["name"];
         _loc3_.parent = param1["parent"];
         _loc3_.length = Number(param1["length"]);
         _loc3_.inheritRotation = getBoolean(param1,"inheritRotation",true);
         _loc3_.inheritScale = getBoolean(param1,"inheritScale",true);
         parseTransform(param1["transform"][0],_loc3_.transform);
         if(param2)
         {
            _loc3_.global.copy(_loc3_.transform);
         }
         return _loc3_;
      }
      
      private static function parseRectangleData(param1:XML) : RectangleData
      {
         var _loc2_:RectangleData = new RectangleData();
         _loc2_.name = param1["name"];
         _loc2_.width = Number(param1["width"]);
         _loc2_.height = Number(param1["height"]);
         parseTransform(param1["transform"][0],_loc2_.transform,_loc2_.pivot);
         return _loc2_;
      }
      
      private static function parseEllipseData(param1:XML) : EllipseData
      {
         var _loc2_:EllipseData = new EllipseData();
         _loc2_.name = param1["name"];
         _loc2_.width = Number(param1["width"]);
         _loc2_.height = Number(param1["height"]);
         parseTransform(param1["transform"][0],_loc2_.transform,_loc2_.pivot);
         return _loc2_;
      }
      
      private static function parseSlotData(param1:XML) : SlotData
      {
         var _loc2_:SlotData = new SlotData();
         _loc2_.name = param1["name"];
         _loc2_.parent = param1["parent"];
         _loc2_.zOrder = getNumber(param1,"z",0) || 0;
         _loc2_.blendMode = param1["blendMode"];
         _loc2_.displayIndex = 0;
         return _loc2_;
      }
      
      private static function parseSkinData(param1:XML, param2:DragonBonesData) : SkinData
      {
         var _loc4_:SkinData = new SkinData();
         _loc4_.name = param1["name"];
         var _loc6_:int = 0;
         var _loc5_:* = param1["slot"];
         for each(var _loc3_ in param1["slot"])
         {
            _loc4_.addSlotData(parseSkinSlotData(_loc3_,param2));
         }
         return _loc4_;
      }
      
      private static function parseSkinSlotData(param1:XML, param2:DragonBonesData) : SlotData
      {
         var _loc3_:SlotData = new SlotData();
         _loc3_.name = param1["name"];
         _loc3_.parent = param1["parent"];
         _loc3_.zOrder = getNumber(param1,"z",0) || 0;
         _loc3_.blendMode = param1["blendMode"];
         var _loc6_:int = 0;
         var _loc5_:* = param1["display"];
         for each(var _loc4_ in param1["display"])
         {
            _loc3_.addDisplayData(parseDisplayData(_loc4_,param2));
         }
         return _loc3_;
      }
      
      private static function parseDisplayData(param1:XML, param2:DragonBonesData) : DisplayData
      {
         var _loc3_:DisplayData = new DisplayData();
         _loc3_.name = param1["name"];
         _loc3_.type = param1["type"];
         _loc3_.pivot = new Point();
         parseTransform(param1["transform"][0],_loc3_.transform,_loc3_.pivot);
         if(tempDragonBonesData)
         {
            tempDragonBonesData.addDisplayData(_loc3_);
         }
         return _loc3_;
      }
      
      static function parseAnimationData(param1:XML, param2:ArmatureData, param3:uint, param4:Boolean) : AnimationData
      {
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc5_:* = null;
         var _loc11_:AnimationData = new AnimationData();
         _loc11_.name = param1["name"];
         _loc11_.frameRate = param3;
         _loc11_.duration = Math.round((int(param1["duration"]) || 1) * 1000 / param3);
         _loc11_.playTimes = int(getNumber(param1,"loop",1));
         _loc11_.fadeTime = getNumber(param1,"fadeInTime",0) || 0;
         _loc11_.scale = getNumber(param1,"scale",1) || 0;
         _loc11_.tweenEasing = getNumber(param1,"tweenEasing",NaN);
         _loc11_.autoTween = getBoolean(param1,"autoTween",true);
         var _loc13_:int = 0;
         var _loc12_:* = param1["frame"];
         for each(var _loc8_ in param1["frame"])
         {
            _loc6_ = parseTransformFrame(_loc8_,param3,param4);
            _loc11_.addFrame(_loc6_);
         }
         parseTimeline(param1,_loc11_);
         var _loc10_:int = _loc11_.duration;
         var _loc15_:int = 0;
         var _loc14_:* = param1["timeline"];
         for each(var _loc7_ in param1["timeline"])
         {
            _loc9_ = parseTransformTimeline(_loc7_,_loc11_.duration,param3,param4);
            _loc10_ = Math.min(_loc10_,_loc9_.frameList[_loc9_.frameList.length - 1].duration);
            _loc11_.addTimeline(_loc9_);
            _loc5_ = parseSlotTimeline(_loc7_,_loc11_.duration,param3,param4);
            if(_loc5_.frameList.length > 0)
            {
               _loc10_ = Math.min(_loc10_,_loc5_.frameList[_loc5_.frameList.length - 1].duration);
               _loc11_.addSlotTimeline(_loc5_);
            }
         }
         if(_loc11_.frameList.length > 0)
         {
            _loc10_ = Math.min(_loc10_,_loc11_.frameList[_loc11_.frameList.length - 1].duration);
         }
         _loc11_.lastFrameDuration = _loc10_;
         DBDataUtil.addHideTimeline(_loc11_,param2);
         DBDataUtil.transformAnimationData(_loc11_,param2,param4);
         return _loc11_;
      }
      
      private static function parseSlotTimeline(param1:XML, param2:int, param3:uint, param4:Boolean) : SlotTimeline
      {
         var _loc5_:* = null;
         var _loc7_:SlotTimeline = new SlotTimeline();
         _loc7_.name = param1["name"];
         _loc7_.scale = getNumber(param1,"scale",1) || 0;
         _loc7_.offset = getNumber(param1,"offset",0) || 0;
         _loc7_.duration = param2;
         var _loc9_:int = 0;
         var _loc8_:* = param1["frame"];
         for each(var _loc6_ in param1["frame"])
         {
            _loc5_ = parseSlotFrame(_loc6_,param3,param4);
            _loc7_.addFrame(_loc5_);
         }
         parseTimeline(param1,_loc7_);
         return _loc7_;
      }
      
      private static function parseSlotFrame(param1:XML, param2:uint, param3:Boolean) : SlotFrame
      {
         var _loc4_:SlotFrame = new SlotFrame();
         parseFrame(param1,_loc4_,param2);
         _loc4_.visible = !getBoolean(param1,"hide",false);
         _loc4_.tweenEasing = getNumber(param1,"tweenEasing",10);
         _loc4_.displayIndex = int(getNumber(param1,"displayIndex",0));
         _loc4_.zOrder = getNumber(param1,"z",!!param3?NaN:0);
         var _loc5_:XML = param1["colorTransform"][0];
         if(_loc5_)
         {
            _loc4_.color = new ColorTransform();
            parseColorTransform(_loc5_,_loc4_.color);
         }
         return _loc4_;
      }
      
      private static function parseTransformTimeline(param1:XML, param2:int, param3:uint, param4:Boolean) : TransformTimeline
      {
         var _loc5_:* = null;
         var _loc7_:TransformTimeline = new TransformTimeline();
         _loc7_.name = param1["name"];
         _loc7_.scale = getNumber(param1,"scale",1) || 0;
         _loc7_.offset = getNumber(param1,"offset",0) || 0;
         _loc7_.originPivot.x = getNumber(param1,"pX",0) || 0;
         _loc7_.originPivot.y = getNumber(param1,"pY",0) || 0;
         _loc7_.duration = param2;
         var _loc9_:int = 0;
         var _loc8_:* = param1["frame"];
         for each(var _loc6_ in param1["frame"])
         {
            _loc5_ = parseTransformFrame(_loc6_,param3,param4);
            _loc7_.addFrame(_loc5_);
         }
         parseTimeline(param1,_loc7_);
         return _loc7_;
      }
      
      private static function parseMainFrame(param1:XML, param2:uint) : Frame
      {
         var _loc3_:Frame = new Frame();
         parseFrame(param1,_loc3_,param2);
         return _loc3_;
      }
      
      private static function parseTransformFrame(param1:XML, param2:uint, param3:Boolean) : TransformFrame
      {
         var _loc4_:TransformFrame = new TransformFrame();
         parseFrame(param1,_loc4_,param2);
         _loc4_.visible = !getBoolean(param1,"hide",false);
         _loc4_.tweenEasing = getNumber(param1,"tweenEasing",10);
         _loc4_.tweenRotate = int(getNumber(param1,"tweenRotate",0));
         _loc4_.tweenScale = getBoolean(param1,"tweenScale",true);
         parseTransform(param1["transform"][0],_loc4_.transform,_loc4_.pivot);
         if(param3)
         {
            _loc4_.global.copy(_loc4_.transform);
         }
         _loc4_.scaleOffset.x = getNumber(param1,"scXOffset",0) || 0;
         _loc4_.scaleOffset.y = getNumber(param1,"scYOffset",0) || 0;
         return _loc4_;
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
         param2.duration = Math.round((int(param1["duration"]) || 1) * 1000 / param3);
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
               param2.alphaMultiplier = (int(getNumber(param1,"aM",100) || 100)) * 0.01;
               param2.redMultiplier = (int(getNumber(param1,"rM",100) || 100)) * 0.01;
               param2.greenMultiplier = (int(getNumber(param1,"gM",100) || 100)) * 0.01;
               param2.blueMultiplier = (int(getNumber(param1,"bM",100) || 100)) * 0.01;
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
