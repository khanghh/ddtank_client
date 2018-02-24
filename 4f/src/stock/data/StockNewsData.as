package stock.data
{
   import ddt.manager.LanguageMgr;
   import stock.StockMgr;
   
   public class StockNewsData extends StockNewsTemplateData
   {
       
      
      public var stockID:int = 0;
      
      public var time:Number = 0.0;
      
      public var dealType:int = 0;
      
      public var singleCost:int = 0;
      
      public var dealCnt:int = 0;
      
      private var _type:int = 0;
      
      public function StockNewsData(param1:int){super();}
      
      public function get content() : String{return null;}
   }
}
