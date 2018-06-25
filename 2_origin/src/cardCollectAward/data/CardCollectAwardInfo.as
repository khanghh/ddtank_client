package cardCollectAward.data
{
   import road7th.data.DictionaryData;
   
   public class CardCollectAwardInfo
   {
       
      
      private var _title:String;
      
      private var _desc:String;
      
      private var _minLv:int;
      
      private var _quertions:String;
      
      private var _beginTime:Date;
      
      private var _endTime:Date;
      
      private var _qq:String;
      
      private var _phone:String;
      
      private var _awardData:DictionaryData;
      
      public function CardCollectAwardInfo()
      {
         super();
         _awardData = new DictionaryData();
      }
      
      public function get awardData() : DictionaryData
      {
         return _awardData;
      }
      
      public function get phone() : String
      {
         return _phone;
      }
      
      public function set phone(value:String) : void
      {
         _phone = value;
      }
      
      public function get qq() : String
      {
         return _qq;
      }
      
      public function set qq(value:String) : void
      {
         _qq = value;
      }
      
      public function get endTime() : Date
      {
         return _endTime;
      }
      
      public function set endTime(value:Date) : void
      {
         _endTime = value;
      }
      
      public function get beginTime() : Date
      {
         return _beginTime;
      }
      
      public function set beginTime(value:Date) : void
      {
         _beginTime = value;
      }
      
      public function get quertions() : String
      {
         return _quertions;
      }
      
      public function set quertions(value:String) : void
      {
         var allItem:* = null;
         var items:* = null;
         var awardItem:* = null;
         var itemInfo:* = null;
         var i:int = 0;
         var item:* = null;
         _quertions = value;
         if(_quertions != null)
         {
            allItem = _quertions.split("|");
            items = [];
            for(i = 0; i < allItem.length; )
            {
               items = (allItem[i] as String).split(",");
               if(_awardData != null && items[0] != null)
               {
                  awardItem = new AwardItem();
                  awardItem.title = items[0];
                  if(items[1] != null)
                  {
                     item = (items[1] as String).split(";");
                     while(item != null && item.length > 0)
                     {
                        itemInfo = new ItemInfo();
                        itemInfo.name = String(item.shift());
                        awardItem.addItem(itemInfo);
                     }
                  }
                  _awardData[i] = awardItem;
               }
               i++;
            }
         }
      }
      
      public function getQuertionByIndex(index:int) : AwardItem
      {
         if(_awardData != null && _awardData.hasKey(index))
         {
            return _awardData[index];
         }
         return null;
      }
      
      public function get minLv() : int
      {
         return _minLv;
      }
      
      public function set minLv(value:int) : void
      {
         _minLv = value;
      }
      
      public function get desc() : String
      {
         return _desc;
      }
      
      public function set desc(value:String) : void
      {
         _desc = value;
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
