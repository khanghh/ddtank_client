package stock.items
{
   import ddt.manager.LanguageMgr;
   import stock.StockMgr;
   import stock.data.StockData;
   import stock.mornUI.items.StockDetailInfoItemUI;
   
   public class StockDetailInfoItem extends StockDetailInfoItemUI
   {
       
      
      public function StockDetailInfoItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         stockText1.text = LanguageMgr.GetTranslation("ddt.stock.allView.text29");
         stockText2.text = LanguageMgr.GetTranslation("ddt.stock.allView.text30");
         stockText3.text = LanguageMgr.GetTranslation("ddt.stock.allView.text31");
      }
      
      public function set data(value:*) : void
      {
         this.visible = true;
         lablTime.text = value.timeStr;
         lblDealPrice.text = value.dealPrice.toString();
         var changeValue:int = value.dealPrice - (StockMgr.inst.model.stocks[StockMgr.inst.model.stockID] as StockData).dayCenterPrice;
         var _loc3_:* = changeValue.toString();
         lblChangeG.text = _loc3_;
         lblChangeL.text = _loc3_;
         _loc3_ = changeValue >= 0;
         lblChangeG.visible = _loc3_;
         lblChangeL.visible = !_loc3_;
      }
   }
}
