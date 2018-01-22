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
      
      override public function copy(param1:FrameCache) : void
      {
         super.copy(param1);
         colorTransform = (param1 as SlotFrameCache).colorTransform;
         displayIndex = (param1 as SlotFrameCache).displayIndex;
      }
      
      override public function clear() : void
      {
         super.clear();
         colorTransform = null;
         displayIndex = -1;
      }
   }
}
