package stock.data
{
   import stock.StockMgr;
   
   public final class StockData extends StockTemplateData
   {
       
      
      public var price:int = 0;
      
      public var sellTotalValue:int = 0;
      
      public var buyTotalValue:int = 0;
      
      public var holdNum:int = 0;
      
      public var validNum:int = 0;
      
      public var dealNum:int = 0;
      
      public var changeValue:int = 0;
      
      public var originPrice:int = 0;
      
      public var centerPrice:int = 0;
      
      public var dayCenterPrice:int = 0;
      
      public var maxBuyNum:int = 0;
      
      public var diffValue:int = 0;
      
      public var notices:Vector.<StockNewsData>;
      
      public var dailyPoints:Vector.<StockPointData>;
      
      public var hourPoints:Vector.<StockPointData>;
      
      public function StockData(param1:int)
      {
         notices = new Vector.<StockNewsData>();
         dailyPoints = new Vector.<StockPointData>();
         hourPoints = new Vector.<StockPointData>();
         super();
         StockID = param1;
         parseStock();
      }
      
      private function parseStock() : void
      {
         var _loc1_:StockTemplateData = StockMgr.inst.model.cfgStocks[StockID];
         if(_loc1_)
         {
            StockName = _loc1_.StockName;
         }
      }
      
      public function get cost() : int
      {
         return totalCost / holdNum;
      }
      
      public function get totalCost() : int
      {
         return buyTotalValue - sellTotalValue;
      }
      
      public function get floatBenefit() : int
      {
         return (price - cost) * holdNum;
      }
      
      public function get benefitRate() : Number
      {
         return floatBenefit / buyTotalValue;
      }
   }
}
