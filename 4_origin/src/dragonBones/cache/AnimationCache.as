package dragonBones.cache
{
   import dragonBones.objects.AnimationData;
   import dragonBones.objects.ArmatureData;
   import dragonBones.objects.SlotData;
   import dragonBones.objects.TransformTimeline;
   
   public class AnimationCache
   {
       
      
      public var name:String;
      
      public var slotTimelineCacheList:Vector.<SlotTimelineCache>;
      
      public var slotTimelineCacheDic:Object;
      
      public var frameNum:int = 0;
      
      public function AnimationCache()
      {
         slotTimelineCacheList = new Vector.<SlotTimelineCache>();
         slotTimelineCacheDic = {};
         super();
      }
      
      public static function initWithAnimationData(animationData:AnimationData, armatureData:ArmatureData) : AnimationCache
      {
         var boneName:* = null;
         var boneData:* = null;
         var slotData:* = null;
         var slotTimelineCache:* = null;
         var slotName:* = null;
         var i:int = 0;
         var length:int = 0;
         var j:int = 0;
         var jlen:int = 0;
         var output:AnimationCache = new AnimationCache();
         output.name = animationData.name;
         var boneTimelineList:Vector.<TransformTimeline> = animationData.timelineList;
         for(i = 0,length = boneTimelineList.length; i < length; )
         {
            boneName = boneTimelineList[i].name;
            for(j = 0,jlen = armatureData.slotDataList.length; j < jlen; )
            {
               slotData = armatureData.slotDataList[j];
               slotName = slotData.name;
               if(slotData.parent == boneName)
               {
                  if(output.slotTimelineCacheDic[slotName] == null)
                  {
                     slotTimelineCache = new SlotTimelineCache();
                     slotTimelineCache.name = slotName;
                     output.slotTimelineCacheList.push(slotTimelineCache);
                     output.slotTimelineCacheDic[slotName] = slotTimelineCache;
                  }
               }
               j++;
            }
            i++;
         }
         return output;
      }
      
      public function initSlotTimelineCacheDic(slotCacheGeneratorDic:Object, slotFrameCacheDic:Object) : void
      {
         var name:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = slotTimelineCacheDic;
         for each(var slotTimelineCache in slotTimelineCacheDic)
         {
            name = slotTimelineCache.name;
            slotTimelineCache.cacheGenerator = slotCacheGeneratorDic[name];
            slotTimelineCache.currentFrameCache = slotFrameCacheDic[name];
         }
      }
      
      public function bindCacheUserSlotDic(slotDic:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = slotDic;
         for(var name in slotDic)
         {
            (slotTimelineCacheDic[name] as SlotTimelineCache).bindCacheUser(slotDic[name]);
         }
      }
      
      public function addFrame() : void
      {
         var slotTimelineCache:* = null;
         var i:int = 0;
         var length:int = 0;
         frameNum = Number(frameNum) + 1;
         for(i = 0,length = slotTimelineCacheList.length; i < length; )
         {
            slotTimelineCache = slotTimelineCacheList[i];
            slotTimelineCache.addFrame();
            i++;
         }
      }
      
      public function update(progress:Number) : void
      {
         var slotTimelineCache:* = null;
         var i:int = 0;
         var length:int = 0;
         var frameIndex:int = progress * (frameNum - 1);
         for(i = 0,length = slotTimelineCacheList.length; i < length; )
         {
            slotTimelineCache = slotTimelineCacheList[i];
            slotTimelineCache.update(frameIndex);
            i++;
         }
      }
   }
}
