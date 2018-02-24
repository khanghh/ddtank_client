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
      
      public function AnimationCache(){super();}
      
      public static function initWithAnimationData(param1:AnimationData, param2:ArmatureData) : AnimationCache{return null;}
      
      public function initSlotTimelineCacheDic(param1:Object, param2:Object) : void{}
      
      public function bindCacheUserSlotDic(param1:Object) : void{}
      
      public function addFrame() : void{}
      
      public function update(param1:Number) : void{}
   }
}
