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
         var i:int = 0;
         var total:int = 0;
         for(i = 0; i < StockMgr.inst.model.mytocks.length; )
         {
            total = total + (StockMgr.inst.model.stocks[StockMgr.inst.model.mytocks[i]] as StockData).totalCost;
            i++;
         }
         return total;
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
