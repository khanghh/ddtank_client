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
      
      public function StockNewsData(type:int)
      {
         super();
         _type = type;
      }
      
      public function get content() : String
      {
         var tmp:* = null;
         var stockNotice:String = "";
         var stockName:String = StockMgr.inst.model.stocks[stockID].StockName;
         var date:Date = new Date(time);
         if(_type == 1)
         {
            tmp = StockMgr.inst.model.cfgStockNews[NewsId];
            stockNotice = tmp.NewsContent.replace("{0}",LanguageMgr.GetTranslation("stockName",stockName));
         }
         else if(_type == 2)
         {
            stockNotice = LanguageMgr.GetTranslation("stock.Message" + dealType,stockName,dealCnt,singleCost);
         }
         return LanguageMgr.GetTranslation("stock.Notice",date.month + 1,date.date,date.hours < 10?"0" + date.hours.toString():date.hours.toString(),date.minutes < 10?"0" + date.minutes.toString():date.minutes.toString(),stockNotice);
      }
   }
}
