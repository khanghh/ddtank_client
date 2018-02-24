package stock.data
{
   import stock.StockMgr;
   
   public final class StockAccountData
   {
       
      
      public var totalValue:int = 0;
      
      public var validLoan:int = 0;
      
      public var fund:int = 0;
      
      public var historyList:Vector.<StockNewsData>;
      
      public function StockAccountData(){super();}
      
      public function get totalBenefit() : int{return 0;}
      
      public function get totalCost() : int{return 0;}
      
      public function get validAsset() : int{return 0;}
      
      public function get totalAssets() : int{return 0;}
   }
}
