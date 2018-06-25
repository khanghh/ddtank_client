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
      
      public static function parseSkeletonData(rawData:XML, ifSkipAnimationData:Boolean = false, outputAnimationDictionary:Dictionary = null) : DragonBonesData
      {
         if(!rawData)
         {
            throw new ArgumentError();
         }
         var version:String = rawData["version"];
         var _loc9_:* = version;
         if("2.3" !== _loc9_)
         {
            if("3.0" !== _loc9_)
            {
               throw new Error("Nonsupport version!");
            }
         }
         var frameRate:uint = int(rawData["frameRate"]);
         var data:DragonBonesData = new DragonBonesData();
         tempDragonBonesData = data;
         data.name = rawData["name"];
         var isGlobalData:Boolean = rawData["isGlobal"] == "0"?false:true;
         var _loc11_:int = 0;
         var _loc10_:* = rawData["armature"];
         for each(var armatureXML in rawData["armature"])
         {
            data.addArmatureData(parseArmatureData(armatureXML,data,frameRate,isGlobalData,ifSkipAnimationData,outputAnimationDictionary));
         }
         return data;
      }
      
      private static function parseArmatureData(armatureXML:XML, data:DragonBonesData, frameRate:uint, isGlobalData:Boolean, ifSkipAnimationData:Boolean, outputAnimationDictionary:Dictionary) : ArmatureData
      {
         var animationXML:* = null;
         var armatureData:ArmatureData = new ArmatureData();
         armatureData.name = armatureXML["name"];
         var _loc14_:int = 0;
         var _loc13_:* = armatureXML["bone"];
         for each(var boneXML in armatureXML["bone"])
         {
            armatureData.addBoneData(parseBoneData(boneXML,isGlobalData));
         }
         var _loc18_:int = 0;
         var _loc17_:* = armatureXML["skin"];
         for each(var skinXml in armatureXML["skin"])
         {
            var _loc16_:int = 0;
            var _loc15_:* = skinXml["slot"];
            for each(var slotXML in skinXml["slot"])
            {
               armatureData.addSlotData(parseSlotData(slotXML));
            }
         }
         var _loc20_:int = 0;
         var _loc19_:* = armatureXML["skin"];
         for each(var skinXML in armatureXML["skin"])
         {
            armatureData.addSkinData(parseSkinData(skinXML,data));
         }
         if(isGlobalData)
         {
            DBDataUtil.transformArmatureData(armatureData);
         }
         armatureData.sortBoneDataList();
         if(!ifSkipAnimationData)
         {
            var _loc22_:int = 0;
            var _loc21_:* = armatureXML["animation"];
            for each(animationXML in armatureXML["animation"])
            {
               armatureData.addAnimationData(parseAnimationData(animationXML,armatureData,frameRate,isGlobalData));
            }
         }
         return armatureData;
      }
      
      private static function parseBoneData(boneXML:XML, isGlobalData:Boolean) : BoneData
      {
         var boneData:BoneData = new BoneData();
         boneData.name = boneXML["name"];
         boneData.parent = boneXML["parent"];
         boneData.length = Number(boneXML["length"]);
         boneData.inheritRotation = getBoolean(boneXML,"inheritRotation",true);
         boneData.inheritScale = getBoolean(boneXML,"inheritScale",true);
         parseTransform(boneXML["transform"][0],boneData.transform);
         if(isGlobalData)
         {
            boneData.global.copy(boneData.transform);
         }
         return boneData;
      }
      
      private static function parseRectangleData(rectangleXML:XML) : RectangleData
      {
         var rectangleData:RectangleData = new RectangleData();
         rectangleData.name = rectangleXML["name"];
         rectangleData.width = Number(rectangleXML["width"]);
         rectangleData.height = Number(rectangleXML["height"]);
         parseTransform(rectangleXML["transform"][0],rectangleData.transform,rectangleData.pivot);
         return rectangleData;
      }
      
      private static function parseEllipseData(ellipseXML:XML) : EllipseData
      {
         var ellipseData:EllipseData = new EllipseData();
         ellipseData.name = ellipseXML["name"];
         ellipseData.width = Number(ellipseXML["width"]);
         ellipseData.height = Number(ellipseXML["height"]);
         parseTransform(ellipseXML["transform"][0],ellipseData.transform,ellipseData.pivot);
         return ellipseData;
      }
      
      private static function parseSlotData(slotXML:XML) : SlotData
      {
         var slotData:SlotData = new SlotData();
         slotData.name = slotXML["name"];
         slotData.parent = slotXML["parent"];
         slotData.zOrder = getNumber(slotXML,"z",0) || 0;
         slotData.blendMode = slotXML["blendMode"];
         slotData.displayIndex = 0;
         return slotData;
      }
      
      private static function parseSkinData(skinXML:XML, data:DragonBonesData) : SkinData
      {
         var skinData:SkinData = new SkinData();
         skinData.name = skinXML["name"];
         var _loc6_:int = 0;
         var _loc5_:* = skinXML["slot"];
         for each(var slotXML in skinXML["slot"])
         {
            skinData.addSlotData(parseSkinSlotData(slotXML,data));
         }
         return skinData;
      }
      
      private static function parseSkinSlotData(slotXML:XML, data:DragonBonesData) : SlotData
      {
         var slotData:SlotData = new SlotData();
         slotData.name = slotXML["name"];
         slotData.parent = slotXML["parent"];
         slotData.zOrder = getNumber(slotXML,"z",0) || 0;
         slotData.blendMode = slotXML["blendMode"];
         var _loc6_:int = 0;
         var _loc5_:* = slotXML["display"];
         for each(var displayXML in slotXML["display"])
         {
            slotData.addDisplayData(parseDisplayData(displayXML,data));
         }
         return slotData;
      }
      
      private static function parseDisplayData(displayXML:XML, data:DragonBonesData) : DisplayData
      {
         var displayData:DisplayData = new DisplayData();
         displayData.name = displayXML["name"];
         displayData.type = displayXML["type"];
         displayData.pivot = new Point();
         parseTransform(displayXML["transform"][0],displayData.transform,displayData.pivot);
         if(tempDragonBonesData)
         {
            tempDragonBonesData.addDisplayData(displayData);
         }
         return displayData;
      }
      
      static function parseAnimationData(animationXML:XML, armatureData:ArmatureData, frameRate:uint, isGlobalData:Boolean) : AnimationData
      {
         var frame:* = null;
         var timeline:* = null;
         var slotTimeline:* = null;
         var animationData:AnimationData = new AnimationData();
         animationData.name = animationXML["name"];
         animationData.frameRate = frameRate;
         animationData.duration = Math.round((int(animationXML["duration"]) || 1) * 1000 / frameRate);
         animationData.playTimes = int(getNumber(animationXML,"loop",1));
         animationData.fadeTime = getNumber(animationXML,"fadeInTime",0) || 0;
         animationData.scale = getNumber(animationXML,"scale",1) || 0;
         animationData.tweenEasing = getNumber(animationXML,"tweenEasing",NaN);
         animationData.autoTween = getBoolean(animationXML,"autoTween",true);
         var _loc13_:int = 0;
         var _loc12_:* = animationXML["frame"];
         for each(var frameXML in animationXML["frame"])
         {
            frame = parseTransformFrame(frameXML,frameRate,isGlobalData);
            animationData.addFrame(frame);
         }
         parseTimeline(animationXML,animationData);
         var lastFrameDuration:int = animationData.duration;
         var _loc15_:int = 0;
         var _loc14_:* = animationXML["timeline"];
         for each(var timelineXML in animationXML["timeline"])
         {
            timeline = parseTransformTimeline(timelineXML,animationData.duration,frameRate,isGlobalData);
            lastFrameDuration = Math.min(lastFrameDuration,timeline.frameList[timeline.frameList.length - 1].duration);
            animationData.addTimeline(timeline);
            slotTimeline = parseSlotTimeline(timelineXML,animationData.duration,frameRate,isGlobalData);
            if(slotTimeline.frameList.length > 0)
            {
               lastFrameDuration = Math.min(lastFrameDuration,slotTimeline.frameList[slotTimeline.frameList.length - 1].duration);
               animationData.addSlotTimeline(slotTimeline);
            }
         }
         if(animationData.frameList.length > 0)
         {
            lastFrameDuration = Math.min(lastFrameDuration,animationData.frameList[animationData.frameList.length - 1].duration);
         }
         animationData.lastFrameDuration = lastFrameDuration;
         DBDataUtil.addHideTimeline(animationData,armatureData);
         DBDataUtil.transformAnimationData(animationData,armatureData,isGlobalData);
         return animationData;
      }
      
      private static function parseSlotTimeline(timelineXML:XML, duration:int, frameRate:uint, isGlobalData:Boolean) : SlotTimeline
      {
         var frame:* = null;
         var timeline:SlotTimeline = new SlotTimeline();
         timeline.name = timelineXML["name"];
         timeline.scale = getNumber(timelineXML,"scale",1) || 0;
         timeline.offset = getNumber(timelineXML,"offset",0) || 0;
         timeline.duration = duration;
         var _loc9_:int = 0;
         var _loc8_:* = timelineXML["frame"];
         for each(var frameXML in timelineXML["frame"])
         {
            frame = parseSlotFrame(frameXML,frameRate,isGlobalData);
            timeline.addFrame(frame);
         }
         parseTimeline(timelineXML,timeline);
         return timeline;
      }
      
      private static function parseSlotFrame(frameXML:XML, frameRate:uint, isGlobalData:Boolean) : SlotFrame
      {
         var frame:SlotFrame = new SlotFrame();
         parseFrame(frameXML,frame,frameRate);
         frame.visible = !getBoolean(frameXML,"hide",false);
         frame.tweenEasing = getNumber(frameXML,"tweenEasing",10);
         frame.displayIndex = int(getNumber(frameXML,"displayIndex",0));
         frame.zOrder = getNumber(frameXML,"z",!!isGlobalData?NaN:0);
         var colorTransformXML:XML = frameXML["colorTransform"][0];
         if(colorTransformXML)
         {
            frame.color = new ColorTransform();
            parseColorTransform(colorTransformXML,frame.color);
         }
         return frame;
      }
      
      private static function parseTransformTimeline(timelineXML:XML, duration:int, frameRate:uint, isGlobalData:Boolean) : TransformTimeline
      {
         var frame:* = null;
         var timeline:TransformTimeline = new TransformTimeline();
         timeline.name = timelineXML["name"];
         timeline.scale = getNumber(timelineXML,"scale",1) || 0;
         timeline.offset = getNumber(timelineXML,"offset",0) || 0;
         timeline.originPivot.x = getNumber(timelineXML,"pX",0) || 0;
         timeline.originPivot.y = getNumber(timelineXML,"pY",0) || 0;
         timeline.duration = duration;
         var _loc9_:int = 0;
         var _loc8_:* = timelineXML["frame"];
         for each(var frameXML in timelineXML["frame"])
         {
            frame = parseTransformFrame(frameXML,frameRate,isGlobalData);
            timeline.addFrame(frame);
         }
         parseTimeline(timelineXML,timeline);
         return timeline;
      }
      
      private static function parseMainFrame(frameXML:XML, frameRate:uint) : Frame
      {
         var frame:Frame = new Frame();
         parseFrame(frameXML,frame,frameRate);
         return frame;
      }
      
      private static function parseTransformFrame(frameXML:XML, frameRate:uint, isGlobalData:Boolean) : TransformFrame
      {
         var frame:TransformFrame = new TransformFrame();
         parseFrame(frameXML,frame,frameRate);
         frame.visible = !getBoolean(frameXML,"hide",false);
         frame.tweenEasing = getNumber(frameXML,"tweenEasing",10);
         frame.tweenRotate = int(getNumber(frameXML,"tweenRotate",0));
         frame.tweenScale = getBoolean(frameXML,"tweenScale",true);
         parseTransform(frameXML["transform"][0],frame.transform,frame.pivot);
         if(isGlobalData)
         {
            frame.global.copy(frame.transform);
         }
         frame.scaleOffset.x = getNumber(frameXML,"scXOffset",0) || 0;
         frame.scaleOffset.y = getNumber(frameXML,"scYOffset",0) || 0;
         return frame;
      }
      
      private static function parseTimeline(timelineXML:XML, timeline:Timeline) : void
      {
         var frame:* = null;
         var position:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = timeline.frameList;
         for each(frame in timeline.frameList)
         {
            frame.position = position;
            position = position + frame.duration;
         }
         if(frame)
         {
            frame.duration = timeline.duration - frame.position;
         }
      }
      
      private static function parseFrame(frameXML:XML, frame:Frame, frameRate:uint) : void
      {
         frame.duration = Math.round((int(frameXML["duration"]) || 1) * 1000 / frameRate);
         frame.action = frameXML["action"];
         frame.event = frameXML["event"];
         frame.sound = frameXML["sound"];
      }
      
      private static function parseTransform(transformXML:XML, transform:DBTransform, pivot:Point = null) : void
      {
         if(transformXML)
         {
            if(transform)
            {
               transform.x = getNumber(transformXML,"x",0) || 0;
               transform.y = getNumber(transformXML,"y",0) || 0;
               transform.skewX = getNumber(transformXML,"skX",0) * 0.0174532925199433 || 0;
               transform.skewY = getNumber(transformXML,"skY",0) * 0.0174532925199433 || 0;
               transform.scaleX = getNumber(transformXML,"scX",1) || 0;
               transform.scaleY = getNumber(transformXML,"scY",1) || 0;
            }
            if(pivot)
            {
               pivot.x = getNumber(transformXML,"pX",0) || 0;
               pivot.y = getNumber(transformXML,"pY",0) || 0;
            }
         }
      }
      
      private static function parseColorTransform(colorTransformXML:XML, colorTransform:ColorTransform) : void
      {
         if(colorTransformXML)
         {
            if(colorTransform)
            {
               colorTransform.alphaOffset = int(colorTransformXML["aO"]);
               colorTransform.redOffset = int(colorTransformXML["rO"]);
               colorTransform.greenOffset = int(colorTransformXML["gO"]);
               colorTransform.blueOffset = int(colorTransformXML["bO"]);
               colorTransform.alphaMultiplier = (int(getNumber(colorTransformXML,"aM",100) || 100)) * 0.01;
               colorTransform.redMultiplier = (int(getNumber(colorTransformXML,"rM",100) || 100)) * 0.01;
               colorTransform.greenMultiplier = (int(getNumber(colorTransformXML,"gM",100) || 100)) * 0.01;
               colorTransform.blueMultiplier = (int(getNumber(colorTransformXML,"bM",100) || 100)) * 0.01;
            }
         }
      }
      
      private static function getBoolean(data:XML, key:String, defaultValue:Boolean) : Boolean
      {
         if(data && data[key].length() > 0)
         {
            var _loc4_:String = data[key];
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
                                 addr39:
                                 return true;
                              }
                              §§goto(addr39);
                           }
                        }
                        addr33:
                        return false;
                     }
                     addr32:
                     §§goto(addr33);
                  }
                  addr31:
                  §§goto(addr32);
               }
               addr30:
               §§goto(addr31);
            }
            §§goto(addr30);
         }
         else
         {
            return defaultValue;
         }
      }
      
      private static function getNumber(data:XML, key:String, defaultValue:Number) : Number
      {
         if(data && data[key].length() > 0)
         {
            var _loc4_:String = data[key];
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
                           return Number(data[key]);
                        }
                     }
                     addr32:
                     return NaN;
                  }
                  addr31:
                  §§goto(addr32);
               }
               addr30:
               §§goto(addr31);
            }
            §§goto(addr30);
         }
         else
         {
            return defaultValue;
         }
      }
   }
}
