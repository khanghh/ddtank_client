package cardCollectAward.data
{
   public class AwardItem
   {
       
      
      private var _title:String;
      
      private var _item:Vector.<ItemInfo>;
      
      public function AwardItem()
      {
         super();
         _item = new Vector.<ItemInfo>();
      }
      
      public function addItem(param1:ItemInfo) : void
      {
         if(_item != null)
         {
            _item.push(param1);
         }
      }
      
      public function get item() : Vector.<ItemInfo>
      {
         return _item;
      }
      
      public function get title() : String
      {
         return _title;
      }
      
      public function set title(param1:String) : void
      {
         _title = param1;
      }
   }
}
