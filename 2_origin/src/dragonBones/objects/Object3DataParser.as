package dragonBones.objects
{
   import dragonBones.§core:dragonBones_internal§.parseAnimationData;
   import dragonBones.utils.DBDataUtil;
   import flash.geom.ColorTransform;
   import flash.geom.Point;
   import flash.utils.Dictionary;
   
   public final class Object3DataParser
   {
      
      private static var tempDragonBonesData:DragonBonesData;
       
      
      public function Object3DataParser()
      {
         super();
      }
      
      public static function parseSkeletonData(param1:Object, param2:Boolean = false, param3:Dictionary = null) : DragonBonesData
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
         _loc6_.name = param1["name"];
         tempDragonBonesData = _loc6_;
         var _loc5_:Boolean = param1["isGlobal"] == "0"?false:true;
         var _loc11_:int = 0;
         var _loc10_:* = param1["armature"];
         for each(var _loc4_ in param1["armature"])
         {
            _loc6_.addArmatureData(parseArmatureData(_loc4_,_loc6_,_loc7_,_loc5_,param2,param3));
         }
         return _loc6_;
      }
      
      private static function parseArmatureData(param1:Object, param2:DragonBonesData, param3:uint, param4:Boolean, param5:Boolean, param6:Dictionary) : ArmatureData
      {
         var _loc8_:* = null;
         var _loc9_:int = 0;
         var _loc13_:ArmatureData = new ArmatureData();
         _loc13_.name = param1["name"];
         var _loc15_:int = 0;
         var _loc14_:* = param1["bone"];
         for each(var _loc10_ in param1["bone"])
         {
            _loc13_.addBoneData(parseBoneData(_loc10_,param4));
         }
         var _loc19_:int = 0;
         var _loc18_:* = param1["skin"];
         for each(var _loc12_ in param1["skin"])
         {
            var _loc17_:int = 0;
            var _loc16_:* = _loc12_["slot"];
            for each(var _loc11_ in _loc12_["slot"])
            {
               _loc13_.addSlotData(parseSlotData(_loc11_));
            }
         }
         var _loc21_:int = 0;
         var _loc20_:* = param1["skin"];
         for each(var _loc7_ in param1["skin"])
         {
            _loc13_.addSkinData(parseSkinData(_loc7_,param2));
         }
         _loc13_.sortBoneDataList();
         if(param4)
         {
            DBDataUtil.transformArmatureData(_loc13_);
         }
         if(param5)
         {
            if(param6 != null)
            {
               param6[_loc13_.name] = new Dictionary();
            }
            _loc9_ = 0;
            var _loc23_:int = 0;
            var _loc22_:* = param1["animation"];
            for each(_loc8_ in param1["animation"])
            {
               if(_loc9_ == 0)
               {
                  _loc13_.addAnimationData(parseAnimationData(_loc8_,_loc13_,param3,param4));
               }
               else if(param6 != null)
               {
                  param6[_loc13_.name][_loc8_["name"]] = _loc8_;
               }
               _loc9_++;
            }
         }
         else
         {
            var _loc25_:int = 0;
            var _loc24_:* = param1["animation"];
            for each(_loc8_ in param1["animation"])
            {
               _loc13_.addAnimationData(parseAnimationData(_loc8_,_loc13_,param3,param4));
            }
         }
         return _loc13_;
      }
      
      private static function parseBoneData(param1:Object, param2:Boolean) : BoneData
      {
         var _loc3_:BoneData = new BoneData();
         _loc3_.name = param1["name"];
         _loc3_.parent = param1["parent"];
         _loc3_.length = Number(param1["length"]);
         _loc3_.inheritRotation = getBoolean(param1,"inheritRotation",true);
         _loc3_.inheritScale = getBoolean(param1,"inheritScale",true);
         parseTransform(param1["transform"],_loc3_.transform);
         if(param2)
         {
            _loc3_.global.copy(_loc3_.transform);
         }
         return _loc3_;
      }
      
      private static function parseRectangleData(param1:Object) : RectangleData
      {
         var _loc2_:RectangleData = new RectangleData();
         _loc2_.name = param1["name"];
         _loc2_.width = Number(param1["width"]);
         _loc2_.height = Number(param1["height"]);
         parseTransform(param1["transform"],_loc2_.transform,_loc2_.pivot);
         return _loc2_;
      }
      
      private static function parseEllipseData(param1:Object) : EllipseData
      {
         var _loc2_:EllipseData = new EllipseData();
         _loc2_.name = param1["name"];
         _loc2_.width = Number(param1["width"]);
         _loc2_.height = Number(param1["height"]);
         parseTransform(param1["transform"],_loc2_.transform,_loc2_.pivot);
         return _loc2_;
      }
      
      private static function parseSlotData(param1:Object) : SlotData
      {
         var _loc2_:SlotData = new SlotData();
         _loc2_.name = param1["name"];
         _loc2_.parent = param1["parent"];
         _loc2_.zOrder = getNumber(param1,"z",0) || 0;
         _loc2_.blendMode = param1["blendMode"];
         _loc2_.displayIndex = 0;
         return _loc2_;
      }
      
      private static function parseSkinData(param1:Object, param2:DragonBonesData) : SkinData
      {
         var _loc3_:SkinData = new SkinData();
         _loc3_.name = param1["name"];
         var _loc6_:int = 0;
         var _loc5_:* = param1["slot"];
         for each(var _loc4_ in param1["slot"])
         {
            _loc3_.addSlotData(parseSkinSlotData(_loc4_,param2));
         }
         return _loc3_;
      }
      
      private static function parseSkinSlotData(param1:Object, param2:DragonBonesData) : SlotData
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
      
      private static function parseDisplayData(param1:Object, param2:DragonBonesData) : DisplayData
      {
         var _loc3_:DisplayData = new DisplayData();
         _loc3_.name = param1["name"];
         _loc3_.type = param1["type"];
         parseTransform(param1["transform"],_loc3_.transform,_loc3_.pivot);
         if(tempDragonBonesData)
         {
            tempDragonBonesData.addDisplayData(_loc3_);
         }
         return _loc3_;
      }
      
      static function parseAnimationData(param1:Object, param2:ArmatureData, param3:uint, param4:Boolean) : AnimationData
      {
         var _loc17_:* = null;
         var _loc7_:* = null;
         var _loc16_:* = null;
         var _loc19_:Boolean = false;
         var _loc13_:* = null;
         var _loc15_:int = 0;
         var _loc11_:int = 0;
         var _loc5_:* = null;
         var _loc21_:* = null;
         var _loc22_:* = null;
         var _loc12_:int = 0;
         var _loc18_:int = 0;
         var _loc14_:AnimationData = new AnimationData();
         _loc14_.name = param1["name"];
         _loc14_.frameRate = param3;
         _loc14_.duration = Math.round((Number(param1["duration"]) || 1) * 1000 / param3);
         _loc14_.playTimes = int(getNumber(param1,"loop",1));
         _loc14_.fadeTime = getNumber(param1,"fadeInTime",0) || 0;
         _loc14_.scale = getNumber(param1,"scale",1) || 0;
         _loc14_.tweenEasing = getNumber(param1,"tweenEasing",NaN);
         _loc14_.autoTween = getBoolean(param1,"autoTween",true);
         var _loc25_:* = 0;
         var _loc24_:* = param1["frame"];
         for each(var _loc20_ in param1["frame"])
         {
            _loc17_ = parseTransformFrame(_loc20_,param3,param4);
            _loc14_.addFrame(_loc17_);
         }
         parseTimeline(param1,_loc14_);
         var _loc6_:Vector.<SlotTimeline> = new Vector.<SlotTimeline>();
         var _loc23_:Vector.<TransformTimeline> = new Vector.<TransformTimeline>();
         var _loc8_:int = _loc14_.duration;
         var _loc27_:* = 0;
         var _loc26_:* = param1["timeline"];
         for each(var _loc9_ in param1["timeline"])
         {
            _loc7_ = parseTransformTimeline(_loc9_,_loc14_.duration,param3,param4);
            _loc8_ = Math.min(_loc8_,_loc7_.frameList[_loc7_.frameList.length - 1].duration);
            _loc14_.addTimeline(_loc7_);
            _loc16_ = parseSlotTimeline(_loc9_,_loc14_.duration,param3,param4);
            if(_loc16_.frameList.length > 0)
            {
               _loc8_ = Math.min(_loc8_,_loc16_.frameList[_loc16_.frameList.length - 1].duration);
               _loc14_.addSlotTimeline(_loc16_);
               if(_loc14_.autoTween)
               {
                  _loc15_ = 0;
                  _loc11_ = _loc16_.frameList.length;
                  while(_loc15_ < _loc11_)
                  {
                     _loc13_ = _loc16_.frameList[_loc15_] as SlotFrame;
                     if(_loc13_ && _loc13_.displayIndex < 0)
                     {
                        _loc19_ = true;
                        break;
                     }
                     _loc15_++;
                  }
                  if(_loc19_)
                  {
                     _loc6_.push(_loc16_);
                     _loc23_.push(_loc7_);
                  }
               }
            }
         }
         _loc11_ = _loc6_.length;
         var _loc10_:Number = _loc14_.tweenEasing;
         if(_loc11_ > 0)
         {
            _loc15_ = 0;
            while(_loc15_ < _loc11_)
            {
               _loc16_ = _loc6_[_loc15_];
               _loc7_ = _loc23_[_loc15_];
               _loc12_ = 0;
               _loc18_ = _loc16_.frameList.length;
               while(_loc12_ < _loc18_)
               {
                  _loc21_ = _loc16_.frameList[_loc12_] as SlotFrame;
                  _loc5_ = _loc7_.frameList[_loc12_] as TransformFrame;
                  _loc22_ = _loc12_ == _loc18_ - 1?_loc16_.frameList[0] as SlotFrame:_loc16_.frameList[_loc12_ + 1] as SlotFrame;
                  if(_loc21_.displayIndex < 0 || _loc22_.displayIndex < 0)
                  {
                     _loc25_ = NaN;
                     _loc21_.tweenEasing = _loc25_;
                     _loc5_.tweenEasing = _loc25_;
                  }
                  else if(_loc10_ == 10)
                  {
                     _loc24_ = 0;
                     _loc21_.tweenEasing = _loc24_;
                     _loc5_.tweenEasing = _loc24_;
                  }
                  else if(!isNaN(_loc10_))
                  {
                     _loc27_ = _loc10_;
                     _loc21_.tweenEasing = _loc27_;
                     _loc5_.tweenEasing = _loc27_;
                  }
                  else if(_loc5_.tweenEasing == 10)
                  {
                     _loc5_.tweenEasing = 0;
                  }
                  _loc12_++;
               }
               _loc15_++;
            }
            _loc14_.autoTween = false;
         }
         if(_loc14_.frameList.length > 0)
         {
            _loc8_ = Math.min(_loc8_,_loc14_.frameList[_loc14_.frameList.length - 1].duration);
         }
         _loc14_.lastFrameDuration = _loc8_;
         DBDataUtil.addHideTimeline(_loc14_,param2);
         DBDataUtil.transformAnimationData(_loc14_,param2,param4);
         return _loc14_;
      }
      
      private static function parseSlotTimeline(param1:Object, param2:int, param3:uint, param4:Boolean) : SlotTimeline
      {
         var _loc5_:* = null;
         var _loc6_:SlotTimeline = new SlotTimeline();
         _loc6_.name = param1["name"];
         _loc6_.scale = getNumber(param1,"scale",1) || 0;
         _loc6_.offset = getNumber(param1,"offset",0) || 0;
         _loc6_.duration = param2;
         var _loc9_:int = 0;
         var _loc8_:* = param1["frame"];
         for each(var _loc7_ in param1["frame"])
         {
            _loc5_ = parseSlotFrame(_loc7_,param3,param4);
            _loc6_.addFrame(_loc5_);
         }
         parseTimeline(param1,_loc6_);
         return _loc6_;
      }
      
      private static function parseSlotFrame(param1:Object, param2:uint, param3:Boolean) : SlotFrame
      {
         var _loc4_:SlotFrame = new SlotFrame();
         parseFrame(param1,_loc4_,param2);
         _loc4_.visible = !getBoolean(param1,"hide",false);
         _loc4_.tweenEasing = getNumber(param1,"tweenEasing",10);
         _loc4_.displayIndex = int(getNumber(param1,"displayIndex",0));
         _loc4_.zOrder = getNumber(param1,"z",!!param3?NaN:0);
         var _loc5_:Object = param1["colorTransform"];
         if(_loc5_)
         {
            _loc4_.color = new ColorTransform();
            parseColorTransform(_loc5_,_loc4_.color);
         }
         return _loc4_;
      }
      
      private static function parseTransformTimeline(param1:Object, param2:int, param3:uint, param4:Boolean) : TransformTimeline
      {
         var _loc5_:* = null;
         var _loc6_:TransformTimeline = new TransformTimeline();
         _loc6_.name = param1["name"];
         _loc6_.scale = getNumber(param1,"scale",1) || 0;
         _loc6_.offset = getNumber(param1,"offset",0) || 0;
         _loc6_.originPivot.x = getNumber(param1,"pX",0) || 0;
         _loc6_.originPivot.y = getNumber(param1,"pY",0) || 0;
         _loc6_.duration = param2;
         var _loc9_:int = 0;
         var _loc8_:* = param1["frame"];
         for each(var _loc7_ in param1["frame"])
         {
            _loc5_ = parseTransformFrame(_loc7_,param3,param4);
            _loc6_.addFrame(_loc5_);
         }
         parseTimeline(param1,_loc6_);
         return _loc6_;
      }
      
      private static function parseMainFrame(param1:Object, param2:uint) : Frame
      {
         var _loc3_:Frame = new Frame();
         parseFrame(param1,_loc3_,param2);
         return _loc3_;
      }
      
      private static function parseTransformFrame(param1:Object, param2:uint, param3:Boolean) : TransformFrame
      {
         var _loc4_:TransformFrame = new TransformFrame();
         parseFrame(param1,_loc4_,param2);
         _loc4_.visible = !getBoolean(param1,"hide",false);
         _loc4_.tweenEasing = getNumber(param1,"tweenEasing",10);
         _loc4_.tweenRotate = int(getNumber(param1,"tweenRotate",0));
         _loc4_.tweenScale = getBoolean(param1,"tweenScale",true);
         parseTransform(param1["transform"],_loc4_.transform,_loc4_.pivot);
         if(param3)
         {
            _loc4_.global.copy(_loc4_.transform);
         }
         _loc4_.scaleOffset.x = getNumber(param1,"scXOffset",0) || 0;
         _loc4_.scaleOffset.y = getNumber(param1,"scYOffset",0) || 0;
         return _loc4_;
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
         param2.duration = Math.round((Number(param1["duration"]) || 1) * 1000 / param3);
         param2.action = param1["action"];
         param2.event = param1["event"];
         param2.sound = param1["sound"];
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
