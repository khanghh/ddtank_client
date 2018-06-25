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
      
      public function set type(value:int) : void
      {
         _type = value;
      }
      
      public function get type() : int
      {
         return _type;
      }
      
      public function get chipCnt() : int
      {
         var count:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = chips;
         for each(var bag in chips)
         {
            count++;
         }
         return count;
      }
   }
}
