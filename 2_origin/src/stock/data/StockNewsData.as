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
      
      public function StockNewsData(param1:int)
      {
         super();
         _type = param1;
      }
      
      public function get content() : String
      {
         var _loc3_:* = null;
         var _loc2_:String = "";
         var _loc1_:String = StockMgr.inst.model.stocks[stockID].StockName;
         var _loc4_:Date = new Date(time);
         if(_type == 1)
         {
            _loc3_ = StockMgr.inst.model.cfgStockNews[NewsId];
            _loc2_ = _loc3_.NewsContent.replace("{0}",LanguageMgr.GetTranslation("stockName",_loc1_));
         }
         else if(_type == 2)
         {
            _loc2_ = LanguageMgr.GetTranslation("stock.Message" + dealType,_loc1_,dealCnt,singleCost);
         }
         return LanguageMgr.GetTranslation("stock.Notice",_loc4_.month + 1,_loc4_.date,_loc4_.hours < 10?"0" + _loc4_.hours.toString():_loc4_.hours.toString(),_loc4_.minutes < 10?"0" + _loc4_.minutes.toString():_loc4_.minutes.toString(),_loc2_);
      }
   }
}
