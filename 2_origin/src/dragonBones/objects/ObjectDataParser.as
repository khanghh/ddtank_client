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
      
      public static function parseTextureAtlasData(rawData:Object, scale:Number = 1) : Object
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
         for each(var subTextureObject in rawData["SubTexture"])
         {
            subTextureName = subTextureObject["name"];
            subTextureRegion = new Rectangle();
            subTextureRegion.x = int(subTextureObject["x"]) / scale;
            subTextureRegion.y = int(subTextureObject["y"]) / scale;
            subTextureRegion.width = int(subTextureObject["width"]) / scale;
            subTextureRegion.height = int(subTextureObject["height"]) / scale;
            rotated = subTextureObject["rotated"] == "true";
            frameWidth = int(subTextureObject["frameWidth"]) / scale;
            frameHeight = int(subTextureObject["frameHeight"]) / scale;
            if(frameWidth > 0 && frameHeight > 0)
            {
               subTextureFrame = new Rectangle();
               subTextureFrame.x = int(subTextureObject["frameX"]) / scale;
               subTextureFrame.y = int(subTextureObject["frameY"]) / scale;
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
      
      public static function parseDragonBonesData(rawDataToParse:Object) : DragonBonesData
      {
         if(!rawDataToParse)
         {
            throw new ArgumentError();
         }
         var version:String = rawDataToParse["version"];
         var _loc6_:* = version;
         if("2.3" !== _loc6_)
         {
            if("3.0" !== _loc6_)
            {
               if("4.0" !== _loc6_)
               {
                  throw new Error("Nonsupport version!");
               }
               var frameRate:uint = int(rawDataToParse["frameRate"]);
               var outputDragonBonesData:DragonBonesData = new DragonBonesData();
               outputDragonBonesData.name = rawDataToParse["name"];
               outputDragonBonesData.isGlobalData = rawDataToParse["isGlobal"] == "0"?false:true;
               tempDragonBonesData = outputDragonBonesData;
               var _loc8_:int = 0;
               var _loc7_:* = rawDataToParse["armature"];
               for each(var armatureObject in rawDataToParse["armature"])
               {
                  outputDragonBonesData.addArmatureData(parseArmatureData(armatureObject,frameRate));
               }
               tempDragonBonesData = null;
               return outputDragonBonesData;
            }
         }
         return Object3DataParser.parseSkeletonData(rawDataToParse);
      }
      
      private static function parseArmatureData(armatureDataToParse:Object, frameRate:uint) : ArmatureData
      {
         var animationData:* = null;
         var outputArmatureData:ArmatureData = new ArmatureData();
         outputArmatureData.name = armatureDataToParse["name"];
         var _loc10_:int = 0;
         var _loc9_:* = armatureDataToParse["bone"];
         for each(var boneObject in armatureDataToParse["bone"])
         {
            outputArmatureData.addBoneData(parseBoneData(boneObject));
         }
         var _loc12_:int = 0;
         var _loc11_:* = armatureDataToParse["slot"];
         for each(var slotObject in armatureDataToParse["slot"])
         {
            outputArmatureData.addSlotData(parseSlotData(slotObject));
         }
         var _loc14_:int = 0;
         var _loc13_:* = armatureDataToParse["skin"];
         for each(var skinObject in armatureDataToParse["skin"])
         {
            outputArmatureData.addSkinData(parseSkinData(skinObject));
         }
         if(tempDragonBonesData.isGlobalData)
         {
            DBDataUtil.transformArmatureData(outputArmatureData);
         }
         outputArmatureData.sortBoneDataList();
         var _loc16_:int = 0;
         var _loc15_:* = armatureDataToParse["animation"];
         for each(var animationObject in armatureDataToParse["animation"])
         {
            animationData = parseAnimationData(animationObject,frameRate);
            DBDataUtil.addHideTimeline(animationData,outputArmatureData);
            DBDataUtil.transformAnimationData(animationData,outputArmatureData,tempDragonBonesData.isGlobalData);
            outputArmatureData.addAnimationData(animationData);
         }
         return outputArmatureData;
      }
      
      private static function parseBoneData(boneObject:Object) : BoneData
      {
         var boneData:BoneData = new BoneData();
         boneData.name = boneObject["name"];
         boneData.parent = boneObject["parent"];
         boneData.length = Number(boneObject["length"]);
         boneData.inheritRotation = getBoolean(boneObject,"inheritRotation",true);
         boneData.inheritScale = getBoolean(boneObject,"inheritScale",true);
         parseTransform(boneObject["transform"],boneData.transform);
         if(tempDragonBonesData.isGlobalData)
         {
            boneData.global.copy(boneData.transform);
         }
         return boneData;
      }
      
      private static function parseSkinData(skinObject:Object) : SkinData
      {
         var skinData:SkinData = new SkinData();
         skinData.name = skinObject["name"];
         var _loc5_:int = 0;
         var _loc4_:* = skinObject["slot"];
         for each(var slotObject in skinObject["slot"])
         {
            skinData.addSlotData(parseSlotDisplayData(slotObject));
         }
         return skinData;
      }
      
      private static function parseSlotDisplayData(slotObject:Object) : SlotData
      {
         var slotData:SlotData = new SlotData();
         slotData.name = slotObject["name"];
         var _loc5_:int = 0;
         var _loc4_:* = slotObject["display"];
         for each(var displayObject in slotObject["display"])
         {
            slotData.addDisplayData(parseDisplayData(displayObject));
         }
         return slotData;
      }
      
      private static function parseSlotData(slotObject:Object) : SlotData
      {
         var slotData:SlotData = new SlotData();
         slotData.name = slotObject["name"];
         slotData.parent = slotObject["parent"];
         slotData.zOrder = getNumber(slotObject,"z",0) || 0;
         slotData.blendMode = slotObject["blendMode"];
         slotData.displayIndex = slotObject["displayIndex"];
         return slotData;
      }
      
      private static function parseDisplayData(displayObject:Object) : DisplayData
      {
         var displayData:DisplayData = new DisplayData();
         displayData.name = displayObject["name"];
         displayData.type = displayObject["type"];
         parseTransform(displayObject["transform"],displayData.transform,displayData.pivot);
         displayData.pivot.x = NaN;
         displayData.pivot.y = NaN;
         if(tempDragonBonesData != null)
         {
            tempDragonBonesData.addDisplayData(displayData);
         }
         return displayData;
      }
      
      static function parseAnimationData(animationObject:Object, frameRate:uint) : AnimationData
      {
         var frame:* = null;
         var timeline:* = null;
         var slotTimeline:* = null;
         var animationData:AnimationData = new AnimationData();
         animationData.name = animationObject["name"];
         animationData.frameRate = frameRate;
         animationData.duration = Math.round((Number(animationObject["duration"]) || 1) * 1000 / frameRate);
         animationData.playTimes = int(getNumber(animationObject,"playTimes",1));
         animationData.fadeTime = getNumber(animationObject,"fadeInTime",0) || 0;
         animationData.scale = getNumber(animationObject,"scale",1) || 0;
         animationData.tweenEasing = getNumber(animationObject,"tweenEasing",NaN);
         animationData.autoTween = getBoolean(animationObject,"autoTween",true);
         var _loc12_:int = 0;
         var _loc11_:* = animationObject["frame"];
         for each(var frameObject in animationObject["frame"])
         {
            frame = parseTransformFrame(frameObject,frameRate);
            animationData.addFrame(frame);
         }
         parseTimeline(animationObject,animationData);
         var lastFrameDuration:int = animationData.duration;
         var _loc14_:int = 0;
         var _loc13_:* = animationObject["bone"];
         for each(var timelineObject in animationObject["bone"])
         {
            timeline = parseTransformTimeline(timelineObject,animationData.duration,frameRate);
            if(timeline.frameList.length > 0)
            {
               lastFrameDuration = Math.min(lastFrameDuration,timeline.frameList[timeline.frameList.length - 1].duration);
               animationData.addTimeline(timeline);
            }
         }
         var _loc16_:int = 0;
         var _loc15_:* = animationObject["slot"];
         for each(var slotTimelineObject in animationObject["slot"])
         {
            slotTimeline = parseSlotTimeline(slotTimelineObject,animationData.duration,frameRate);
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
      
      private static function parseTransformTimeline(timelineObject:Object, duration:int, frameRate:uint) : TransformTimeline
      {
         var frame:* = null;
         var outputTimeline:TransformTimeline = new TransformTimeline();
         outputTimeline.name = timelineObject["name"];
         outputTimeline.scale = getNumber(timelineObject,"scale",1) || 0;
         outputTimeline.offset = getNumber(timelineObject,"offset",0) || 0;
         outputTimeline.originPivot.x = getNumber(timelineObject,"pX",0) || 0;
         outputTimeline.originPivot.y = getNumber(timelineObject,"pY",0) || 0;
         outputTimeline.duration = duration;
         var _loc8_:int = 0;
         var _loc7_:* = timelineObject["frame"];
         for each(var frameObject in timelineObject["frame"])
         {
            frame = parseTransformFrame(frameObject,frameRate);
            outputTimeline.addFrame(frame);
         }
         parseTimeline(timelineObject,outputTimeline);
         return outputTimeline;
      }
      
      private static function parseSlotTimeline(timelineObject:Object, duration:int, frameRate:uint) : SlotTimeline
      {
         var frame:* = null;
         var timeline:SlotTimeline = new SlotTimeline();
         timeline.name = timelineObject["name"];
         timeline.scale = getNumber(timelineObject,"scale",1) || 0;
         timeline.offset = getNumber(timelineObject,"offset",0) || 0;
         timeline.duration = duration;
         var _loc8_:int = 0;
         var _loc7_:* = timelineObject["frame"];
         for each(var frameObject in timelineObject["frame"])
         {
            frame = parseSlotFrame(frameObject,frameRate);
            timeline.addFrame(frame);
         }
         parseTimeline(timelineObject,timeline);
         return timeline;
      }
      
      private static function parseMainFrame(frameObject:Object, frameRate:uint) : Frame
      {
         var frame:Frame = new Frame();
         parseFrame(frameObject,frame,frameRate);
         return frame;
      }
      
      private static function parseTransformFrame(frameObject:Object, frameRate:uint) : TransformFrame
      {
         var outputFrame:TransformFrame = new TransformFrame();
         parseFrame(frameObject,outputFrame,frameRate);
         outputFrame.visible = !getBoolean(frameObject,"hide",false);
         outputFrame.tweenEasing = getNumber(frameObject,"tweenEasing",10);
         outputFrame.tweenRotate = int(getNumber(frameObject,"tweenRotate",0));
         outputFrame.tweenScale = getBoolean(frameObject,"tweenScale",true);
         parseTransform(frameObject["transform"],outputFrame.transform,outputFrame.pivot);
         if(tempDragonBonesData.isGlobalData)
         {
            outputFrame.global.copy(outputFrame.transform);
         }
         outputFrame.scaleOffset.x = getNumber(frameObject,"scXOffset",0) || 0;
         outputFrame.scaleOffset.y = getNumber(frameObject,"scYOffset",0) || 0;
         return outputFrame;
      }
      
      private static function parseSlotFrame(frameObject:Object, frameRate:uint) : SlotFrame
      {
         var frame:SlotFrame = new SlotFrame();
         parseFrame(frameObject,frame,frameRate);
         frame.visible = !getBoolean(frameObject,"hide",false);
         frame.tweenEasing = getNumber(frameObject,"tweenEasing",10);
         frame.displayIndex = int(getNumber(frameObject,"displayIndex",0));
         frame.zOrder = getNumber(frameObject,"z",!!tempDragonBonesData.isGlobalData?NaN:0);
         var colorTransformObject:Object = frameObject["color"];
         if(colorTransformObject)
         {
            frame.color = new ColorTransform();
            parseColorTransform(colorTransformObject,frame.color);
         }
         return frame;
      }
      
      private static function parseTimeline(timelineObject:Object, outputTimeline:Timeline) : void
      {
         var frame:* = null;
         var position:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = outputTimeline.frameList;
         for each(frame in outputTimeline.frameList)
         {
            frame.position = position;
            position = position + frame.duration;
         }
         if(frame)
         {
            frame.duration = outputTimeline.duration - frame.position;
         }
      }
      
      private static function parseFrame(frameObject:Object, outputFrame:Frame, frameRate:uint) : void
      {
         outputFrame.duration = Math.round(frameObject["duration"] * 1000 / frameRate);
         outputFrame.action = frameObject["action"];
         outputFrame.event = frameObject["event"];
         outputFrame.sound = frameObject["sound"];
         if(frameObject["curve"] != null && frameObject["curve"].length == 4)
         {
            outputFrame.curve = new CurveData();
            outputFrame.curve.pointList = [new Point(frameObject["curve"][0],frameObject["curve"][1]),new Point(frameObject["curve"][2],frameObject["curve"][3])];
         }
      }
      
      private static function parseTransform(transformObject:Object, transform:DBTransform, pivot:Point = null) : void
      {
         if(transformObject)
         {
            if(transform)
            {
               transform.x = getNumber(transformObject,"x",0) || 0;
               transform.y = getNumber(transformObject,"y",0) || 0;
               transform.skewX = getNumber(transformObject,"skX",0) * 0.0174532925199433 || 0;
               transform.skewY = getNumber(transformObject,"skY",0) * 0.0174532925199433 || 0;
               transform.scaleX = getNumber(transformObject,"scX",1) || 0;
               transform.scaleY = getNumber(transformObject,"scY",1) || 0;
            }
            if(pivot)
            {
               pivot.x = getNumber(transformObject,"pX",0) || 0;
               pivot.y = getNumber(transformObject,"pY",0) || 0;
            }
         }
      }
      
      private static function parseColorTransform(colorTransformObject:Object, colorTransform:ColorTransform) : void
      {
         if(colorTransformObject)
         {
            if(colorTransform)
            {
               colorTransform.alphaOffset = int(colorTransformObject["aO"]);
               colorTransform.redOffset = int(colorTransformObject["rO"]);
               colorTransform.greenOffset = int(colorTransformObject["gO"]);
               colorTransform.blueOffset = int(colorTransformObject["bO"]);
               colorTransform.alphaMultiplier = int(getNumber(colorTransformObject,"aM",100)) * 0.01;
               colorTransform.redMultiplier = int(getNumber(colorTransformObject,"rM",100)) * 0.01;
               colorTransform.greenMultiplier = int(getNumber(colorTransformObject,"gM",100)) * 0.01;
               colorTransform.blueMultiplier = int(getNumber(colorTransformObject,"bM",100)) * 0.01;
            }
         }
      }
      
      private static function getBoolean(data:Object, key:String, defaultValue:Boolean) : Boolean
      {
         if(data && key in data)
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
                                 addr36:
                                 return true;
                              }
                              §§goto(addr36);
                           }
                        }
                        addr30:
                        return false;
                     }
                     addr29:
                     §§goto(addr30);
                  }
                  addr28:
                  §§goto(addr29);
               }
               addr27:
               §§goto(addr28);
            }
            §§goto(addr27);
         }
         else
         {
            return defaultValue;
         }
      }
      
      private static function getNumber(data:Object, key:String, defaultValue:Number) : Number
      {
         if(data && key in data)
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
                     addr29:
                     return NaN;
                  }
                  addr28:
                  §§goto(addr29);
               }
               addr27:
               §§goto(addr28);
            }
            §§goto(addr27);
         }
         else
         {
            return defaultValue;
         }
      }
   }
}
