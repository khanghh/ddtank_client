package stock.views
{
   import baglocked.BaglockedManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import morn.core.handlers.Handler;
   import stock.StockMgr;
   import stock.data.StockData;
   import stock.mornUI.views.StockBuyFrameUI;
   
   public class StockBuyFrame extends StockBuyFrameUI
   {
       
      
      private var _data:StockData = null;
      
      private var _cnt:int = 0;
      
      public function StockBuyFrame(stockID:int)
      {
         super();
         data = StockMgr.inst.model.stocks[stockID];
         radioGroup.selectedIndex = 0;
      }
      
      override protected function initialize() : void
      {
         stockText1.text = LanguageMgr.GetTranslation("ddt.stock.allView.text4");
         stockText2.text = LanguageMgr.GetTranslation("ddt.stock.allView.text5");
         stockText3.text = LanguageMgr.GetTranslation("ddt.stock.allView.text18");
         stockText4.text = LanguageMgr.GetTranslation("ddt.stock.allView.text11");
         stockText5.text = LanguageMgr.GetTranslation("ddt.stock.allView.text3");
         stockText6.text = LanguageMgr.GetTranslation("ddt.stock.allView.text2");
         radioGroup.labels = LanguageMgr.GetTranslation("ddt.stock.allView.text3") + "," + LanguageMgr.GetTranslation("ddt.stock.allView.text2");
         numStep.changeHandler = new Handler(change);
         numStep.minValue = 1;
         radioGroup.selectHandler = new Handler(select);
         btnClose.clickHandler = new Handler(close);
         btnBuy.clickHandler = new Handler(buy);
      }
      
      private function select(index:int) : void
      {
         numStep.maxValue = Math.min(_data.maxBuyNum,Math.floor((radioGroup.selectedIndex == 0?StockMgr.inst.model.stockAccoutData.validLoan:int(StockMgr.inst.model.stockAccoutData.fund)) / _data.price));
         updateCost();
      }
      
      private function buy() : void
      {
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         StockMgr.inst.requestDealStock(numStep.numValue,true,radioGroup.selectedIndex);
         super.dispose();
      }
      
      private function close() : void
      {
         super.dispose();
      }
      
      private function change(value:int) : void
      {
         _cnt = value;
         updateCost();
      }
      
      private function updateCost() : void
      {
         var cost:int = _cnt * _data.price;
         if(radioGroup.selectedIndex == 0)
         {
            lablLoan.text = cost.toString();
            lablFund.text = "0";
         }
         else
         {
            lablFund.text = cost.toString();
            lablLoan.text = "0";
         }
      }
      
      public function set data(value:StockData) : void
      {
         if(!value)
         {
            return;
         }
         _data = value;
         numStep.maxValue = Math.min(value.maxBuyNum,Math.floor((radioGroup.selectedIndex == 0?StockMgr.inst.model.stockAccoutData.validLoan:int(StockMgr.inst.model.stockAccoutData.fund)) / value.price));
         numStep.numValue = 1;
         lablID.text = _data.StockID.toString();
         lablName.text = _data.StockName;
         lablBuyMaxCnt.text = _data.maxBuyNum.toString();
         lablCurPrice.text = _data.price.toString();
      }
   }
}
