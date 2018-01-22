package dragonBones.cache
{
   import dragonBones.core.ICacheUser;
   
   public class TimelineCache
   {
       
      
      public var name:String;
      
      public var frameCacheList:Vector.<FrameCache>;
      
      public var currentFrameCache:FrameCache;
      
      public function TimelineCache()
      {
         frameCacheList = new Vector.<FrameCache>();
         super();
      }
      
      public function addFrame() : void
      {
      }
      
      public function update(param1:int) : void
      {
         currentFrameCache.copy(frameCacheList[param1]);
      }
      
      public function bindCacheUser(param1:ICacheUser) : void
      {
         param1.frameCache = currentFrameCache;
      }
   }
}
