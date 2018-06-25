package dragonBones.utils
{
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.BoneData;
   import dragonBones.objects.DBTransform;
   import dragonBones.objects.Frame;
   import dragonBones.objects.SkinData;
   import dragonBones.objects.SlotData;
   import dragonBones.objects.SlotFrame;
   import dragonBones.objects.SlotTimeline;
   import dragonBones.objects.TransformFrame;
   import dragonBones.objects.TransformTimeline;
   import flash.geom.Matrix;
   import flash.geom.Point;
   
   public final class DBDataUtil
   {
       
      
      public function DBDataUtil()
      {
         super();
      }
      
      public static function transformArmatureData(armatureData:ArmatureData) : void
      {
         var boneData:* = null;
         var parentBoneData:* = null;
         var boneDataList:Vector.<BoneData> = armatureData.boneDataList;
         var i:int = boneDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            boneData = boneDataList[i];
            if(boneData.parent)
            {
               parentBoneData = armatureData.getBoneData(boneData.parent);
               if(parentBoneData)
               {
                  boneData.transform.copy(boneData.global);
                  boneData.transform.divParent(parentBoneData.global);
               }
            }
         }
      }
      
      public static function transformArmatureDataAnimations(armatureData:ArmatureData) : void
      {
         var animationDataList:Vector.<AnimationData> = armatureData.animationDataList;
         var i:int = animationDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            transformAnimationData(animationDataList[i],armatureData,false);
         }
      }
      
      public static function transformRelativeAnimationData(animationData:AnimationData, armatureData:ArmatureData) : void
      {
      }
      
      public static function transformAnimationData(animationData:AnimationData, armatureData:ArmatureData, isGlobalData:Boolean) : void
      {
         var slotDataList:* = undefined;
         var i:int = 0;
         var boneData:* = null;
         var timeline:* = null;
         var slotTimeline:* = null;
         var slotData:* = null;
         var frameList:* = undefined;
         var slotFrameList:* = undefined;
         var originTransform:* = null;
         var originPivot:* = null;
         var prevFrame:* = null;
         var frameListLength:* = 0;
         var j:int = 0;
         var frame:* = null;
         var dLX:Number = NaN;
         var slotFrame:* = null;
         if(!isGlobalData)
         {
            transformRelativeAnimationData(animationData,armatureData);
            return;
         }
         var skinData:SkinData = armatureData.getSkinData(null);
         var boneDataList:Vector.<BoneData> = armatureData.boneDataList;
         if(skinData)
         {
            slotDataList = armatureData.slotDataList;
         }
         i = 0;
         while(i < boneDataList.length)
         {
            boneData = boneDataList[i];
            timeline = animationData.getTimeline(boneData.name);
            slotTimeline = animationData.getSlotTimeline(boneData.name);
            if(!(!timeline && !slotTimeline))
            {
               slotData = null;
               if(slotDataList)
               {
                  var _loc23_:int = 0;
                  var _loc22_:* = slotDataList;
                  for each(slotData in slotDataList)
                  {
                     if(slotData.parent != boneData.name)
                     {
                        continue;
                     }
                     break;
                  }
               }
               frameList = timeline.frameList;
               if(slotTimeline)
               {
                  slotFrameList = slotTimeline.frameList;
               }
               originTransform = null;
               originPivot = null;
               prevFrame = null;
               frameListLength = uint(frameList.length);
               for(j = 0; j < frameListLength; )
               {
                  frame = frameList[j] as TransformFrame;
                  setFrameTransform(animationData,armatureData,boneData,frame);
                  frame.transform.x = frame.transform.x - boneData.transform.x;
                  frame.transform.y = frame.transform.y - boneData.transform.y;
                  frame.transform.skewX = frame.transform.skewX - boneData.transform.skewX;
                  frame.transform.skewY = frame.transform.skewY - boneData.transform.skewY;
                  frame.transform.scaleX = frame.transform.scaleX / boneData.transform.scaleX;
                  frame.transform.scaleY = frame.transform.scaleY / boneData.transform.scaleY;
                  if(prevFrame)
                  {
                     dLX = frame.transform.skewX - prevFrame.transform.skewX;
                     if(prevFrame.tweenRotate)
                     {
                        if(prevFrame.tweenRotate > 0)
                        {
                           if(dLX < 0)
                           {
                              frame.transform.skewX = frame.transform.skewX + 3.14159265358979 * 2;
                              frame.transform.skewY = frame.transform.skewY + 3.14159265358979 * 2;
                           }
                           if(prevFrame.tweenRotate > 1)
                           {
                              frame.transform.skewX = frame.transform.skewX + 3.14159265358979 * 2 * (prevFrame.tweenRotate - 1);
                              frame.transform.skewY = frame.transform.skewY + 3.14159265358979 * 2 * (prevFrame.tweenRotate - 1);
                           }
                        }
                        else
                        {
                           if(dLX > 0)
                           {
                              frame.transform.skewX = frame.transform.skewX - 3.14159265358979 * 2;
                              frame.transform.skewY = frame.transform.skewY - 3.14159265358979 * 2;
                           }
                           if(prevFrame.tweenRotate < 1)
                           {
                              frame.transform.skewX = frame.transform.skewX + 3.14159265358979 * 2 * (prevFrame.tweenRotate + 1);
                              frame.transform.skewY = frame.transform.skewY + 3.14159265358979 * 2 * (prevFrame.tweenRotate + 1);
                           }
                        }
                     }
                     else
                     {
                        frame.transform.skewX = prevFrame.transform.skewX + TransformUtil.formatRadian(frame.transform.skewX - prevFrame.transform.skewX);
                        frame.transform.skewY = prevFrame.transform.skewY + TransformUtil.formatRadian(frame.transform.skewY - prevFrame.transform.skewY);
                     }
                  }
                  prevFrame = frame;
                  j++;
               }
               if(slotTimeline && slotFrameList)
               {
                  frameListLength = uint(slotFrameList.length);
                  for(j = 0; j < frameListLength; )
                  {
                     slotFrame = slotFrameList[j] as SlotFrame;
                     if(!slotTimeline.transformed)
                     {
                        if(slotData)
                        {
                           slotFrame.zOrder = slotFrame.zOrder - slotData.zOrder;
                        }
                     }
                     j++;
                  }
                  slotTimeline.transformed = true;
               }
               timeline.transformed = true;
            }
            i++;
         }
      }
      
      private static function setFrameTransform(animationData:AnimationData, armatureData:ArmatureData, boneData:BoneData, frame:TransformFrame) : void
      {
         var parentTimeline:* = null;
         var parentTimelineList:* = undefined;
         var parentDataList:* = undefined;
         var i:int = 0;
         var globalTransform:* = null;
         var globalTransformMatrix:* = null;
         var currentTransform:* = null;
         var currentTransformMatrix:* = null;
         frame.transform.copy(frame.global);
         var parentData:BoneData = armatureData.getBoneData(boneData.parent);
         if(parentData)
         {
            parentTimeline = animationData.getTimeline(parentData.name);
            if(parentTimeline)
            {
               parentTimelineList = new Vector.<TransformTimeline>();
               parentDataList = new Vector.<BoneData>();
               while(parentTimeline)
               {
                  parentTimelineList.push(parentTimeline);
                  parentDataList.push(parentData);
                  parentData = armatureData.getBoneData(parentData.parent);
                  if(parentData)
                  {
                     parentTimeline = animationData.getTimeline(parentData.name);
                  }
                  else
                  {
                     parentTimeline = null;
                  }
               }
               i = parentTimelineList.length;
               globalTransformMatrix = new Matrix();
               currentTransform = new DBTransform();
               currentTransformMatrix = new Matrix();
               while(true)
               {
                  i--;
                  if(!i)
                  {
                     break;
                  }
                  parentTimeline = parentTimelineList[i];
                  parentData = parentDataList[i];
                  getTimelineTransform(parentTimeline,frame.position,currentTransform,!globalTransform);
                  if(!globalTransform)
                  {
                     globalTransform = new DBTransform();
                     globalTransform.copy(currentTransform);
                  }
                  else
                  {
                     currentTransform.x = currentTransform.x + (parentTimeline.originTransform.x + parentData.transform.x);
                     currentTransform.y = currentTransform.y + (parentTimeline.originTransform.y + parentData.transform.y);
                     currentTransform.skewX = currentTransform.skewX + (parentTimeline.originTransform.skewX + parentData.transform.skewX);
                     currentTransform.skewY = currentTransform.skewY + (parentTimeline.originTransform.skewY + parentData.transform.skewY);
                     currentTransform.scaleX = currentTransform.scaleX * (parentTimeline.originTransform.scaleX * parentData.transform.scaleX);
                     currentTransform.scaleY = currentTransform.scaleY * (parentTimeline.originTransform.scaleY * parentData.transform.scaleY);
                     TransformUtil.transformToMatrix(currentTransform,currentTransformMatrix);
                     currentTransformMatrix.concat(globalTransformMatrix);
                     TransformUtil.matrixToTransform(currentTransformMatrix,globalTransform,currentTransform.scaleX * globalTransform.scaleX >= 0,currentTransform.scaleY * globalTransform.scaleY >= 0);
                  }
                  TransformUtil.transformToMatrix(globalTransform,globalTransformMatrix);
               }
               frame.transform.divParent(globalTransform);
            }
         }
      }
      
      private static function getTimelineTransform(timeline:TransformTimeline, position:int, retult:DBTransform, isGlobal:Boolean) : void
      {
         var currentFrame:* = null;
         var tweenEasing:Number = NaN;
         var progress:Number = NaN;
         var nextFrame:* = null;
         var currentTransform:* = null;
         var nextTransform:* = null;
         var frameList:Vector.<Frame> = timeline.frameList;
         var i:int = frameList.length;
         while(true)
         {
            i--;
            if(i)
            {
               currentFrame = frameList[i] as TransformFrame;
               if(currentFrame.position <= position && currentFrame.position + currentFrame.duration > position)
               {
                  if(i == frameList.length - 1 || position == currentFrame.position)
                  {
                     retult.copy(!!isGlobal?currentFrame.global:currentFrame.transform);
                  }
                  else
                  {
                     tweenEasing = currentFrame.tweenEasing;
                     progress = (position - currentFrame.position) / currentFrame.duration;
                     if(tweenEasing && tweenEasing != 10)
                     {
                        progress = MathUtil.getEaseValue(progress,tweenEasing);
                     }
                     nextFrame = frameList[i + 1] as TransformFrame;
                     currentTransform = !!isGlobal?currentFrame.global:currentFrame.transform;
                     nextTransform = !!isGlobal?nextFrame.global:nextFrame.transform;
                     retult.x = currentTransform.x + (nextTransform.x - currentTransform.x) * progress;
                     retult.y = currentTransform.y + (nextTransform.y - currentTransform.y) * progress;
                     retult.skewX = TransformUtil.formatRadian(currentTransform.skewX + (nextTransform.skewX - currentTransform.skewX) * progress);
                     retult.skewY = TransformUtil.formatRadian(currentTransform.skewY + (nextTransform.skewY - currentTransform.skewY) * progress);
                     retult.scaleX = currentTransform.scaleX + (nextTransform.scaleX - currentTransform.scaleX) * progress;
                     retult.scaleY = currentTransform.scaleY + (nextTransform.scaleY - currentTransform.scaleY) * progress;
                  }
                  break;
               }
               continue;
            }
            break;
         }
      }
      
      public static function addHideTimeline(animationData:AnimationData, armatureData:ArmatureData) : void
      {
         var boneData:* = null;
         var boneName:* = null;
         var boneDataList:Vector.<BoneData> = armatureData.boneDataList;
         var i:int = boneDataList.length;
         while(true)
         {
            i--;
            if(!i)
            {
               break;
            }
            boneData = boneDataList[i];
            boneName = boneData.name;
            if(!animationData.getTimeline(boneName))
            {
               if(animationData.hideTimelineNameMap.indexOf(boneName) < 0)
               {
                  animationData.hideTimelineNameMap.fixed = false;
                  animationData.hideTimelineNameMap.push(boneName);
                  animationData.hideTimelineNameMap.fixed = true;
               }
            }
         }
      }
   }
}
