package dragonBones.cache
{
   import dragonBones.core.ISlotCacheGenerator;
   import dragonBones.utils.ColorTransformUtil;
   
   public class SlotTimelineCache extends TimelineCache
   {
       
      
      public var cacheGenerator:ISlotCacheGenerator;
      
      public function SlotTimelineCache()
      {
         super();
      }
      
      override public function addFrame() : void
      {
         var _loc1_:SlotFrameCache = new SlotFrameCache();
         _loc1_.globalTransform.copy(cacheGenerator.global);
         _loc1_.globalTransformMatrix.copyFrom(cacheGenerator.globalTransformMatrix);
         if(cacheGenerator.colorChanged)
         {
            _loc1_.colorTransform = ColorTransformUtil.cloneColor(cacheGenerator.colorTransform);
         }
         _loc1_.displayIndex = cacheGenerator.displayIndex;
         frameCacheList.push(_loc1_);
      }
   }
}
