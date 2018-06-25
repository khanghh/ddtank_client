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
      
      public function addItem(info:ItemInfo) : void
      {
         if(_item != null)
         {
            _item.push(info);
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
      
      public function set title(value:String) : void
      {
         _title = value;
      }
   }
}
