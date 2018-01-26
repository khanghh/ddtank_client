package dragonBones.core
{
   import dragonBones.cache.FrameCache;
   
   public interface ICacheUser
   {
       
      
      function get name() : String;
      
      function set frameCache(param1:FrameCache) : void;
   }
}
