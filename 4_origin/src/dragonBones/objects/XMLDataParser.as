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
      
      public static function parseTextureAtlasData(rawData:XML, scale:Number = 1) : Object
      {
         var subTextureFrame:* = null;
         var subTextureName:* = null;
         var subTextureRegion:* = null;
         var rotated:* = false;
         var frameWidth:Number = NaN;
         var frameHeight:Number = NaN;
         var textureAtlasData:Object = {};
         textureAtlasData.__name = rawData["name"];
         var _loc12_:int = 0;
         var _loc11_:* = rawData["SubTexture"];
         for each(var subTextureXML in rawData["SubTexture"])
         {
            subTextureName = subTextureXML["name"];
            subTextureRegion = new Rectangle();
            subTextureRegion.x = int(subTextureXML["x"]) / scale;
            subTextureRegion.y = int(subTextureXML["y"]) / scale;
            subTextureRegion.width = int(subTextureXML["width"]) / scale;
            subTextureRegion.height = int(subTextureXML["height"]) / scale;
            rotated = subTextureXML["rotated"] == "true";
            frameWidth = int(subTextureXML["frameWidth"]) / scale;
            frameHeight = int(subTextureXML["frameHeight"]) / scale;
            if(frameWidth > 0 && frameHeight > 0)
            {
               subTextureFrame = new Rectangle();
               subTextureFrame.x = int(subTextureXML["frameX"]) / scale;
               subTextureFrame.y = int(subTextureXML["frameY"]) / scale;
               subTextureFrame.width = frameWidth;
               subTextureFrame.height = frameHeight;
            }
            else
            {
               subTextureFrame = null;
            }
            textureAtlasData[subTextureName] = new TextureData(subTextureRegion,subTextureFrame,rotated);
         }
         return textureAtlasData;
      }
      
      public static function parseDragonBonesData(rawData:XML) : DragonBonesData
      {
         if(!rawData)
         {
            throw new ArgumentError();
         }
         var version:String = rawData["version"];
         var _loc6_:* = version;
         if("2.3" !== _loc6_)
         {
            if("3.0" !== _loc6_)
            {
               if("4.0" !== _loc6_)
               {
                  throw new Error("Nonsupport version!");
               }
               var frameRate:uint = int(rawData["frameRate"]);
               var outputDragonBonesData:DragonBonesData = new DragonBonesData();
               outputDragonBonesData.name = rawData["name"];
               outputDragonBonesData.isGlobalData = rawData["isGlobal"] == "0"?false:true;
               tempDragonBonesData = outputDragonBonesData;
               var _loc8_:int = 0;
               var _loc7_:* = rawData["armature"];
               for each(var armatureXML in rawData["armature"])
               {
                  outputDragonBonesData.addArmatureData(parseArmatureData(armatureXML,frameRate));
               }
               tempDragonBonesData = null;
               return outputDragonBonesData;
            }
         }
         return XML3DataParser.parseSkeletonData(rawData);
      }
      
      private static function parseArmatureData(armatureXML:XML, frameRate:uint) : ArmatureData
      {
         var animationXML:* = null;
         var animationData:* = null;
         var outputArmatureData:ArmatureData = new ArmatureData();
         outputArmatureData.name = armatureXML["name"];
         var _loc10_:int = 0;
         var _loc9_:* = armatureXML["bone"];
         for each(var boneXML in armatureXML["bone"])
         {
            outputArmatureData.addBoneData(parseBoneData(boneXML));
         }
         var _loc12_:int = 0;
         var _loc11_:* = armatureXML["slot"];
         for each(var slotXML in armatureXML["slot"])
         {
            outputArmatureData.addSlotData(parseSlotData(slotXML));
         }
         var _loc14_:int = 0;
         var _loc13_:* = armatureXML["skin"];
         for each(var skinXML in armatureXML["skin"])
         {
            outputArmatureData.addSkinData(parseSkinData(skinXML));
         }
         if(tempDragonBonesData.isGlobalData)
         {
            DBDataUtil.transformArmatureData(outputArmatureData);
         }
         outputArmatureData.sortBoneDataList();
         var _loc16_:int = 0;
         var _loc15_:* = armatureXML["animation"];
         for each(animationXML in armatureXML["animation"])
         {
            animationData = parseAnimationData(animationXML,frameRate);
            DBDataUtil.addHideTimeline(animationData,outputArmatureData);
            DBDataUtil.transformAnimationData(animationData,outputArmatureData,tempDragonBonesData.isGlobalData);
            outputArmatureData.addAnimationData(animationData);
         }
         return outputArmatureData;
      }
      
      private static function parseBoneData(boneXML:XML) : BoneData
      {
         var boneData:BoneData = new BoneData();
         boneData.name = boneXML["name"];
         boneData.parent = boneXML["parent"];
         boneData.length = Number(boneXML["length"]);
         boneData.inheritRotation = getBoolean(boneXML,"inheritRotation",true);
         boneData.inheritScale = getBoolean(boneXML,"inheritScale",true);
         parseTransform(boneXML["transform"][0],boneData.transform);
         if(tempDragonBonesData.isGlobalData)
         {
            boneData.global.copy(boneData.transform);
         }
         return boneData;
      }
      
      private static function parseSkinData(skinXML:XML) : SkinData
      {
         var skinData:SkinData = new SkinData();
         skinData.name = skinXML["name"];
         var _loc5_:int = 0;
         var _loc4_:* = skinXML["slot"];
         for each(var slotXML in skinXML["slot"])
         {
            skinData.addSlotData(parseSlotDisplayData(slotXML));
         }
         return skinData;
      }
      
      private static function parseSlotDisplayData(slotXML:XML) : SlotData
      {
         var slotData:SlotData = new SlotData();
         slotData.name = slotXML["name"];
         var _loc5_:int = 0;
         var _loc4_:* = slotXML["display"];
         for each(var displayXML in slotXML["display"])
         {
            slotData.addDisplayData(parseDisplayData(displayXML));
         }
         return slotData;
      }
      
      private static function parseSlotData(slotXML:XML) : SlotData
      {
         var slotData:SlotData = new SlotData();
         slotData.name = slotXML["name"];
         slotData.parent = slotXML["parent"];
         slotData.zOrder = getNumber(slotXML,"z",0) || 0;
         slotData.blendMode = slotXML["blendMode"];
         slotData.displayIndex = slotXML["displayIndex"];
         return slotData;
      }
      
      private static function parseDisplayData(displayXML:XML) : DisplayData
      {
         var displayData:DisplayData = new DisplayData();
         displayData.name = displayXML["name"];
         displayData.type = displayXML["type"];
         parseTransform(displayXML["transform"][0],displayData.transform,displayData.pivot);
         displayData.pivot.x = NaN;
         displayData.pivot.y = NaN;
         if(tempDragonBonesData != null)
         {
            tempDragonBonesData.addDisplayData(displayData);
         }
         return displayData;
      }
      
      static function parseAnimationData(animationXML:XML, frameRate:uint) : AnimationData
      {
         var frame:* = null;
         var timeline:* = null;
         var slotTimeline:* = null;
         var animationData:AnimationData = new AnimationData();
         animationData.name = animationXML["name"];
         animationData.frameRate = frameRate;
         animationData.duration = Math.round((int(animationXML["duration"]) || 1) * 1000 / frameRate);
         animationData.playTimes = int(getNumber(animationXML,"playTimes",1));
         animationData.fadeTime = getNumber(animationXML,"fadeInTime",0) || 0;
         animationData.scale = getNumber(animationXML,"scale",1) || 0;
         animationData.tweenEasing = getNumber(animationXML,"tweenEasing",NaN);
         animationData.autoTween = getBoolean(animationXML,"autoTween",true);
         var _loc12_:int = 0;
         var _loc11_:* = animationXML["frame"];
         for each(var frameXML in animationXML["frame"])
         {
            frame = parseTransformFrame(frameXML,frameRate);
            animationData.addFrame(frame);
         }
         parseTimeline(animationXML,animationData);
         var lastFrameDuration:int = animationData.duration;
         var _loc14_:int = 0;
         var _loc13_:* = animationXML["bone"];
         for each(var timelineXML in animationXML["bone"])
         {
            timeline = parseTransformTimeline(timelineXML,animationData.duration,frameRate);
            if(timeline.frameList.length > 0)
            {
               lastFrameDuration = Math.min(lastFrameDuration,timeline.frameList[timeline.frameList.length - 1].duration);
               animationData.addTimeline(timeline);
            }
         }
         var _loc16_:int = 0;
         var _loc15_:* = animationXML["slot"];
         for each(var slotTimelineXML in animationXML["slot"])
         {
            slotTimeline = parseSlotTimeline(slotTimelineXML,animationData.duration,frameRate);
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
         return animationData;
      }
      
      private static function parseTransformTimeline(timelineXML:XML, duration:int, frameRate:uint) : TransformTimeline
      {
         var frame:* = null;
         var timeline:TransformTimeline = new TransformTimeline();
         timeline.name = timelineXML["name"];
         timeline.scale = getNumber(timelineXML,"scale",1) || 0;
         timeline.offset = getNumber(timelineXML,"offset",0) || 0;
         timeline.originPivot.x = getNumber(timelineXML,"pX",0) || 0;
         timeline.originPivot.y = getNumber(timelineXML,"pY",0) || 0;
         timeline.duration = duration;
         var _loc8_:int = 0;
         var _loc7_:* = timelineXML["frame"];
         for each(var frameXML in timelineXML["frame"])
         {
            frame = parseTransformFrame(frameXML,frameRate);
            timeline.addFrame(frame);
         }
         parseTimeline(timelineXML,timeline);
         return timeline;
      }
      
      private static function parseSlotTimeline(timelineXML:XML, duration:int, frameRate:uint) : SlotTimeline
      {
         var frame:* = null;
         var timeline:SlotTimeline = new SlotTimeline();
         timeline.name = timelineXML["name"];
         timeline.scale = getNumber(timelineXML,"scale",1) || 0;
         timeline.offset = getNumber(timelineXML,"offset",0) || 0;
         timeline.duration = duration;
         var _loc8_:int = 0;
         var _loc7_:* = timelineXML["frame"];
         for each(var frameXML in timelineXML["frame"])
         {
            frame = parseSlotFrame(frameXML,frameRate);
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
      
      private static function parseSlotFrame(frameXML:XML, frameRate:uint) : SlotFrame
      {
         var frame:SlotFrame = new SlotFrame();
         parseFrame(frameXML,frame,frameRate);
         frame.visible = !getBoolean(frameXML,"hide",false);
         frame.tweenEasing = getNumber(frameXML,"tweenEasing",10);
         frame.displayIndex = int(getNumber(frameXML,"displayIndex",0));
         frame.zOrder = getNumber(frameXML,"z",!!tempDragonBonesData.isGlobalData?NaN:0);
         var colorTransformXML:XML = frameXML["color"][0];
         if(colorTransformXML)
         {
            frame.color = new ColorTransform();
            parseColorTransform(colorTransformXML,frame.color);
         }
         return frame;
      }
      
      private static function parseTransformFrame(frameXML:XML, frameRate:uint) : TransformFrame
      {
         var frame:TransformFrame = new TransformFrame();
         parseFrame(frameXML,frame,frameRate);
         frame.visible = !getBoolean(frameXML,"hide",false);
         frame.tweenEasing = getNumber(frameXML,"tweenEasing",10);
         frame.tweenRotate = int(getNumber(frameXML,"tweenRotate",0));
         frame.tweenScale = getBoolean(frameXML,"tweenScale",true);
         parseTransform(frameXML["transform"][0],frame.transform,frame.pivot);
         if(tempDragonBonesData.isGlobalData)
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
         frame.duration = Math.round(int(frameXML["duration"]) * 1000 / frameRate);
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
               colorTransform.alphaMultiplier = (int(getNumber(colorTransformXML,"aM",100) || 0)) * 0.01;
               colorTransform.redMultiplier = (int(getNumber(colorTransformXML,"rM",100) || 0)) * 0.01;
               colorTransform.greenMultiplier = (int(getNumber(colorTransformXML,"gM",100) || 0)) * 0.01;
               colorTransform.blueMultiplier = (int(getNumber(colorTransformXML,"bM",100) || 0)) * 0.01;
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
