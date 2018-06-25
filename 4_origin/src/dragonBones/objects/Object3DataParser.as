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
      
      public static function parseSkeletonData(rawData:Object, ifSkipAnimationData:Boolean = false, outputAnimationDictionary:Dictionary = null) : DragonBonesData
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
         data.name = rawData["name"];
         tempDragonBonesData = data;
         var isGlobalData:Boolean = rawData["isGlobal"] == "0"?false:true;
         var _loc11_:int = 0;
         var _loc10_:* = rawData["armature"];
         for each(var armatureObject in rawData["armature"])
         {
            data.addArmatureData(parseArmatureData(armatureObject,data,frameRate,isGlobalData,ifSkipAnimationData,outputAnimationDictionary));
         }
         return data;
      }
      
      private static function parseArmatureData(armatureObject:Object, data:DragonBonesData, frameRate:uint, isGlobalData:Boolean, ifSkipAnimationData:Boolean, outputAnimationDictionary:Dictionary) : ArmatureData
      {
         var animationObject:* = null;
         var index:int = 0;
         var armatureData:ArmatureData = new ArmatureData();
         armatureData.name = armatureObject["name"];
         var _loc15_:int = 0;
         var _loc14_:* = armatureObject["bone"];
         for each(var boneObject in armatureObject["bone"])
         {
            armatureData.addBoneData(parseBoneData(boneObject,isGlobalData));
         }
         var _loc19_:int = 0;
         var _loc18_:* = armatureObject["skin"];
         for each(var skinObj in armatureObject["skin"])
         {
            var _loc17_:int = 0;
            var _loc16_:* = skinObj["slot"];
            for each(var slotObj in skinObj["slot"])
            {
               armatureData.addSlotData(parseSlotData(slotObj));
            }
         }
         var _loc21_:int = 0;
         var _loc20_:* = armatureObject["skin"];
         for each(var skinObject in armatureObject["skin"])
         {
            armatureData.addSkinData(parseSkinData(skinObject,data));
         }
         armatureData.sortBoneDataList();
         if(isGlobalData)
         {
            DBDataUtil.transformArmatureData(armatureData);
         }
         if(ifSkipAnimationData)
         {
            if(outputAnimationDictionary != null)
            {
               outputAnimationDictionary[armatureData.name] = new Dictionary();
            }
            index = 0;
            var _loc23_:int = 0;
            var _loc22_:* = armatureObject["animation"];
            for each(animationObject in armatureObject["animation"])
            {
               if(index == 0)
               {
                  armatureData.addAnimationData(parseAnimationData(animationObject,armatureData,frameRate,isGlobalData));
               }
               else if(outputAnimationDictionary != null)
               {
                  outputAnimationDictionary[armatureData.name][animationObject["name"]] = animationObject;
               }
               index++;
            }
         }
         else
         {
            var _loc25_:int = 0;
            var _loc24_:* = armatureObject["animation"];
            for each(animationObject in armatureObject["animation"])
            {
               armatureData.addAnimationData(parseAnimationData(animationObject,armatureData,frameRate,isGlobalData));
            }
         }
         return armatureData;
      }
      
      private static function parseBoneData(boneObject:Object, isGlobalData:Boolean) : BoneData
      {
         var boneData:BoneData = new BoneData();
         boneData.name = boneObject["name"];
         boneData.parent = boneObject["parent"];
         boneData.length = Number(boneObject["length"]);
         boneData.inheritRotation = getBoolean(boneObject,"inheritRotation",true);
         boneData.inheritScale = getBoolean(boneObject,"inheritScale",true);
         parseTransform(boneObject["transform"],boneData.transform);
         if(isGlobalData)
         {
            boneData.global.copy(boneData.transform);
         }
         return boneData;
      }
      
      private static function parseRectangleData(rectangleObject:Object) : RectangleData
      {
         var rectangleData:RectangleData = new RectangleData();
         rectangleData.name = rectangleObject["name"];
         rectangleData.width = Number(rectangleObject["width"]);
         rectangleData.height = Number(rectangleObject["height"]);
         parseTransform(rectangleObject["transform"],rectangleData.transform,rectangleData.pivot);
         return rectangleData;
      }
      
      private static function parseEllipseData(ellipseObject:Object) : EllipseData
      {
         var ellipseData:EllipseData = new EllipseData();
         ellipseData.name = ellipseObject["name"];
         ellipseData.width = Number(ellipseObject["width"]);
         ellipseData.height = Number(ellipseObject["height"]);
         parseTransform(ellipseObject["transform"],ellipseData.transform,ellipseData.pivot);
         return ellipseData;
      }
      
      private static function parseSlotData(slotObject:Object) : SlotData
      {
         var slotData:SlotData = new SlotData();
         slotData.name = slotObject["name"];
         slotData.parent = slotObject["parent"];
         slotData.zOrder = getNumber(slotObject,"z",0) || 0;
         slotData.blendMode = slotObject["blendMode"];
         slotData.displayIndex = 0;
         return slotData;
      }
      
      private static function parseSkinData(skinObject:Object, data:DragonBonesData) : SkinData
      {
         var skinData:SkinData = new SkinData();
         skinData.name = skinObject["name"];
         var _loc6_:int = 0;
         var _loc5_:* = skinObject["slot"];
         for each(var slotObject in skinObject["slot"])
         {
            skinData.addSlotData(parseSkinSlotData(slotObject,data));
         }
         return skinData;
      }
      
      private static function parseSkinSlotData(slotObject:Object, data:DragonBonesData) : SlotData
      {
         var slotData:SlotData = new SlotData();
         slotData.name = slotObject["name"];
         slotData.parent = slotObject["parent"];
         slotData.zOrder = getNumber(slotObject,"z",0) || 0;
         slotData.blendMode = slotObject["blendMode"];
         var _loc6_:int = 0;
         var _loc5_:* = slotObject["display"];
         for each(var displayObject in slotObject["display"])
         {
            slotData.addDisplayData(parseDisplayData(displayObject,data));
         }
         return slotData;
      }
      
      private static function parseDisplayData(displayObject:Object, data:DragonBonesData) : DisplayData
      {
         var displayData:DisplayData = new DisplayData();
         displayData.name = displayObject["name"];
         displayData.type = displayObject["type"];
         parseTransform(displayObject["transform"],displayData.transform,displayData.pivot);
         if(tempDragonBonesData)
         {
            tempDragonBonesData.addDisplayData(displayData);
         }
         return displayData;
      }
      
      static function parseAnimationData(animationObject:Object, armatureData:ArmatureData, frameRate:uint, isGlobalData:Boolean) : AnimationData
      {
         var frame:* = null;
         var timeline:* = null;
         var slotTimeline:* = null;
         var displayIndexChange:Boolean = false;
         var slotFrame:* = null;
         var i:int = 0;
         var len:int = 0;
         var curFrame:* = null;
         var curSlotFrame:* = null;
         var nextSlotFrame:* = null;
         var j:int = 0;
         var jlen:int = 0;
         var animationData:AnimationData = new AnimationData();
         animationData.name = animationObject["name"];
         animationData.frameRate = frameRate;
         animationData.duration = Math.round((Number(animationObject["duration"]) || 1) * 1000 / frameRate);
         animationData.playTimes = int(getNumber(animationObject,"loop",1));
         animationData.fadeTime = getNumber(animationObject,"fadeInTime",0) || 0;
         animationData.scale = getNumber(animationObject,"scale",1) || 0;
         animationData.tweenEasing = getNumber(animationObject,"tweenEasing",NaN);
         animationData.autoTween = getBoolean(animationObject,"autoTween",true);
         var _loc25_:* = 0;
         var _loc24_:* = animationObject["frame"];
         for each(var frameObject in animationObject["frame"])
         {
            frame = parseTransformFrame(frameObject,frameRate,isGlobalData);
            animationData.addFrame(frame);
         }
         parseTimeline(animationObject,animationData);
         var displayIndexChangeSlotTimelines:Vector.<SlotTimeline> = new Vector.<SlotTimeline>();
         var displayIndexChangeTimelines:Vector.<TransformTimeline> = new Vector.<TransformTimeline>();
         var lastFrameDuration:int = animationData.duration;
         var _loc27_:* = 0;
         var _loc26_:* = animationObject["timeline"];
         for each(var timelineObject in animationObject["timeline"])
         {
            timeline = parseTransformTimeline(timelineObject,animationData.duration,frameRate,isGlobalData);
            lastFrameDuration = Math.min(lastFrameDuration,timeline.frameList[timeline.frameList.length - 1].duration);
            animationData.addTimeline(timeline);
            slotTimeline = parseSlotTimeline(timelineObject,animationData.duration,frameRate,isGlobalData);
            if(slotTimeline.frameList.length > 0)
            {
               lastFrameDuration = Math.min(lastFrameDuration,slotTimeline.frameList[slotTimeline.frameList.length - 1].duration);
               animationData.addSlotTimeline(slotTimeline);
               if(animationData.autoTween)
               {
                  for(i = 0,len = slotTimeline.frameList.length; i < len; )
                  {
                     slotFrame = slotTimeline.frameList[i] as SlotFrame;
                     if(slotFrame && slotFrame.displayIndex < 0)
                     {
                        displayIndexChange = true;
                        break;
                     }
                     i++;
                  }
                  if(displayIndexChange)
                  {
                     displayIndexChangeSlotTimelines.push(slotTimeline);
                     displayIndexChangeTimelines.push(timeline);
                  }
               }
            }
         }
         len = displayIndexChangeSlotTimelines.length;
         var animationTween:Number = animationData.tweenEasing;
         if(len > 0)
         {
            for(i = 0; i < len; )
            {
               slotTimeline = displayIndexChangeSlotTimelines[i];
               timeline = displayIndexChangeTimelines[i];
               for(j = 0,jlen = slotTimeline.frameList.length; j < jlen; )
               {
                  curSlotFrame = slotTimeline.frameList[j] as SlotFrame;
                  curFrame = timeline.frameList[j] as TransformFrame;
                  nextSlotFrame = j == jlen - 1?slotTimeline.frameList[0] as SlotFrame:slotTimeline.frameList[j + 1] as SlotFrame;
                  if(curSlotFrame.displayIndex < 0 || nextSlotFrame.displayIndex < 0)
                  {
                     _loc25_ = NaN;
                     curSlotFrame.tweenEasing = _loc25_;
                     curFrame.tweenEasing = _loc25_;
                  }
                  else if(animationTween == 10)
                  {
                     _loc24_ = 0;
                     curSlotFrame.tweenEasing = _loc24_;
                     curFrame.tweenEasing = _loc24_;
                  }
                  else if(!isNaN(animationTween))
                  {
                     _loc27_ = animationTween;
                     curSlotFrame.tweenEasing = _loc27_;
                     curFrame.tweenEasing = _loc27_;
                  }
                  else if(curFrame.tweenEasing == 10)
                  {
                     curFrame.tweenEasing = 0;
                  }
                  j++;
               }
               i++;
            }
            animationData.autoTween = false;
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
      
      private static function parseSlotTimeline(timelineObject:Object, duration:int, frameRate:uint, isGlobalData:Boolean) : SlotTimeline
      {
         var frame:* = null;
         var timeline:SlotTimeline = new SlotTimeline();
         timeline.name = timelineObject["name"];
         timeline.scale = getNumber(timelineObject,"scale",1) || 0;
         timeline.offset = getNumber(timelineObject,"offset",0) || 0;
         timeline.duration = duration;
         var _loc9_:int = 0;
         var _loc8_:* = timelineObject["frame"];
         for each(var frameObject in timelineObject["frame"])
         {
            frame = parseSlotFrame(frameObject,frameRate,isGlobalData);
            timeline.addFrame(frame);
         }
         parseTimeline(timelineObject,timeline);
         return timeline;
      }
      
      private static function parseSlotFrame(frameObject:Object, frameRate:uint, isGlobalData:Boolean) : SlotFrame
      {
         var frame:SlotFrame = new SlotFrame();
         parseFrame(frameObject,frame,frameRate);
         frame.visible = !getBoolean(frameObject,"hide",false);
         frame.tweenEasing = getNumber(frameObject,"tweenEasing",10);
         frame.displayIndex = int(getNumber(frameObject,"displayIndex",0));
         frame.zOrder = getNumber(frameObject,"z",!!isGlobalData?NaN:0);
         var colorTransformObject:Object = frameObject["colorTransform"];
         if(colorTransformObject)
         {
            frame.color = new ColorTransform();
            parseColorTransform(colorTransformObject,frame.color);
         }
         return frame;
      }
      
      private static function parseTransformTimeline(timelineObject:Object, duration:int, frameRate:uint, isGlobalData:Boolean) : TransformTimeline
      {
         var frame:* = null;
         var timeline:TransformTimeline = new TransformTimeline();
         timeline.name = timelineObject["name"];
         timeline.scale = getNumber(timelineObject,"scale",1) || 0;
         timeline.offset = getNumber(timelineObject,"offset",0) || 0;
         timeline.originPivot.x = getNumber(timelineObject,"pX",0) || 0;
         timeline.originPivot.y = getNumber(timelineObject,"pY",0) || 0;
         timeline.duration = duration;
         var _loc9_:int = 0;
         var _loc8_:* = timelineObject["frame"];
         for each(var frameObject in timelineObject["frame"])
         {
            frame = parseTransformFrame(frameObject,frameRate,isGlobalData);
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
      
      private static function parseTransformFrame(frameObject:Object, frameRate:uint, isGlobalData:Boolean) : TransformFrame
      {
         var frame:TransformFrame = new TransformFrame();
         parseFrame(frameObject,frame,frameRate);
         frame.visible = !getBoolean(frameObject,"hide",false);
         frame.tweenEasing = getNumber(frameObject,"tweenEasing",10);
         frame.tweenRotate = int(getNumber(frameObject,"tweenRotate",0));
         frame.tweenScale = getBoolean(frameObject,"tweenScale",true);
         parseTransform(frameObject["transform"],frame.transform,frame.pivot);
         if(isGlobalData)
         {
            frame.global.copy(frame.transform);
         }
         frame.scaleOffset.x = getNumber(frameObject,"scXOffset",0) || 0;
         frame.scaleOffset.y = getNumber(frameObject,"scYOffset",0) || 0;
         return frame;
      }
      
      private static function parseTimeline(timelineObject:Object, timeline:Timeline) : void
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
      
      private static function parseFrame(frameObject:Object, frame:Frame, frameRate:uint) : void
      {
         frame.duration = Math.round((Number(frameObject["duration"]) || 1) * 1000 / frameRate);
         frame.action = frameObject["action"];
         frame.event = frameObject["event"];
         frame.sound = frameObject["sound"];
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
