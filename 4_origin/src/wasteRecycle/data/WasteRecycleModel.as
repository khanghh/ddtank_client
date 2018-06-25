package wasteRecycle.data
{
   import ddt.data.goods.InventoryItemInfo;
   import road7th.data.DictionaryData;
   
   public class WasteRecycleModel
   {
       
      
      public var lotteryScore:int;
      
      public var lotteryLimitScore:int;
      
      public var lotteryDonateScore:int;
      
      private var _data:DictionaryData;
      
      private var _trophyList:Vector.<InventoryItemInfo>;
      
      public function WasteRecycleModel()
      {
         super();
      }
      
      public function get data() : DictionaryData
      {
         return _data;
      }
      
      public function set data(value:DictionaryData) : void
      {
         _data = value;
      }
      
      public function set trophyList(value:Vector.<InventoryItemInfo>) : void
      {
         _trophyList = value;
      }
      
      public function get trophyList() : Vector.<InventoryItemInfo>
      {
         return _trophyList;
      }
   }
}
