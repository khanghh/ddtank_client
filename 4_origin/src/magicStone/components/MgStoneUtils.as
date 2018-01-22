package magicStone.components
{
   public class MgStoneUtils
   {
      
      public static const BAG_START:int = 32;
      
      public static const BAG_END:int = 143;
      
      public static const PAGE_COUNT:int = 56;
       
      
      public function MgStoneUtils()
      {
         super();
      }
      
      public static function getPlace(param1:int) : int
      {
         var _loc2_:Array = [0,4,6,15,7,8,9,10,31];
         return _loc2_[param1];
      }
   }
}
