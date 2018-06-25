package dragonBones.cache
{
   import flash.geom.ColorTransform;
   
   public class SlotFrameCache extends FrameCache
   {
       
      
      public var colorTransform:ColorTransform;
      
      public var displayIndex:int = -1;
      
      public function SlotFrameCache()
      {
         super();
      }
      
      override public function copy(frameCache:FrameCache) : void
      {
         super.copy(frameCache);
         colorTransform = (frameCache as SlotFrameCache).colorTransform;
         displayIndex = (frameCache as SlotFrameCache).displayIndex;
      }
      
      override public function clear() : void
      {
         super.clear();
         colorTransform = null;
         displayIndex = -1;
      }
   }
}
