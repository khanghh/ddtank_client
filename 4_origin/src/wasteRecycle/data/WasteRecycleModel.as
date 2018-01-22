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
      
      public function set data(param1:DictionaryData) : void
      {
         _data = param1;
      }
      
      public function set trophyList(param1:Vector.<InventoryItemInfo>) : void
      {
         _trophyList = param1;
      }
      
      public function get trophyList() : Vector.<InventoryItemInfo>
      {
         return _trophyList;
      }
   }
}
