package cardCollectAward.data
{
   public class ItemInfo
   {
       
      
      private var _name:String;
      
      public function ItemInfo()
      {
         super();
      }
      
      public function get name() : String
      {
         return _name;
      }
      
      public function set name(param1:String) : void
      {
         _name = param1;
      }
   }
}
