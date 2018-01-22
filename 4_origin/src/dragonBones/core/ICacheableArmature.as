package dragonBones.core
{
   public interface ICacheableArmature extends IArmature
   {
       
      
      function get enableCache() : Boolean;
      
      function set enableCache(param1:Boolean) : void;
      
      function get enableEventDispatch() : Boolean;
      
      function set enableEventDispatch(param1:Boolean) : void;
      
      function getSlotDic() : Object;
   }
}
