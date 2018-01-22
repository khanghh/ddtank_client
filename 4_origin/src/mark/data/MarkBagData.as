package mark.data
{
   import flash.utils.Dictionary;
   
   public class MarkBagData
   {
       
      
      private var _type:int;
      
      public var chips:Dictionary;
      
      public function MarkBagData()
      {
         chips = new Dictionary();
         super();
      }
      
      public function set type(param1:int) : void
      {
         _type = param1;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get chipCnt() : int
      {
         var _loc1_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = chips;
         for each(var _loc2_ in chips)
         {
            _loc1_++;
         }
         return _loc1_;
      }
   }
}
