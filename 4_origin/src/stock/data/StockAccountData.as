package stock.data
{
   import stock.StockMgr;
   
   public final class StockAccountData
   {
       
      
      public var totalValue:int = 0;
      
      public var validLoan:int = 0;
      
      public var fund:int = 0;
      
      public var historyList:Vector.<StockNewsData>;
      
      public function StockAccountData()
      {
         historyList = new Vector.<StockNewsData>();
         super();
      }
      
      public function get totalBenefit() : int
      {
         return totalValue - totalCost;
      }
      
      public function get totalCost() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < StockMgr.inst.model.mytocks.length)
         {
            _loc1_ = _loc1_ + (StockMgr.inst.model.stocks[StockMgr.inst.model.mytocks[_loc2_]] as StockData).totalCost;
            _loc2_++;
         }
         return _loc1_;
      }
      
      public function get validAsset() : int
      {
         return fund + validLoan;
      }
      
      public function get totalAssets() : int
      {
         return fund + validLoan + totalValue;
      }
   }
}
