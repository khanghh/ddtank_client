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
      
      public static function initWithAnimationData(param1:AnimationData, param2:ArmatureData) : AnimationCache
      {
         var _loc4_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc9_:* = null;
         var _loc13_:* = null;
         var _loc8_:int = 0;
         var _loc11_:int = 0;
         var _loc5_:int = 0;
         var _loc10_:int = 0;
         var _loc12_:AnimationCache = new AnimationCache();
         _loc12_.name = param1.name;
         var _loc7_:Vector.<TransformTimeline> = param1.timelineList;
         _loc8_ = 0;
         _loc11_ = _loc7_.length;
         while(_loc8_ < _loc11_)
         {
            _loc4_ = _loc7_[_loc8_].name;
            _loc5_ = 0;
            _loc10_ = param2.slotDataList.length;
            while(_loc5_ < _loc10_)
            {
               _loc3_ = param2.slotDataList[_loc5_];
               _loc13_ = _loc3_.name;
               if(_loc3_.parent == _loc4_)
               {
                  if(_loc12_.slotTimelineCacheDic[_loc13_] == null)
                  {
                     _loc9_ = new SlotTimelineCache();
                     _loc9_.name = _loc13_;
                     _loc12_.slotTimelineCacheList.push(_loc9_);
                     _loc12_.slotTimelineCacheDic[_loc13_] = _loc9_;
                  }
               }
               _loc5_++;
            }
            _loc8_++;
         }
         return _loc12_;
      }
      
      public function initSlotTimelineCacheDic(param1:Object, param2:Object) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:* = slotTimelineCacheDic;
         for each(var _loc3_ in slotTimelineCacheDic)
         {
            _loc4_ = _loc3_.name;
            _loc3_.cacheGenerator = param1[_loc4_];
            _loc3_.currentFrameCache = param2[_loc4_];
         }
      }
      
      public function bindCacheUserSlotDic(param1:Object) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in param1)
         {
            (slotTimelineCacheDic[_loc2_] as SlotTimelineCache).bindCacheUser(param1[_loc2_]);
         }
      }
      
      public function addFrame() : void
      {
         var _loc1_:* = null;
         var _loc3_:int = 0;
         var _loc2_:int = 0;
         frameNum = Number(frameNum) + 1;
         _loc3_ = 0;
         _loc2_ = slotTimelineCacheList.length;
         while(_loc3_ < _loc2_)
         {
            _loc1_ = slotTimelineCacheList[_loc3_];
            _loc1_.addFrame();
            _loc3_++;
         }
      }
      
      public function update(param1:Number) : void
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = param1 * (frameNum - 1);
         _loc5_ = 0;
         _loc3_ = slotTimelineCacheList.length;
         while(_loc5_ < _loc3_)
         {
            _loc2_ = slotTimelineCacheList[_loc5_];
            _loc2_.update(_loc4_);
            _loc5_++;
         }
      }
   }
}
