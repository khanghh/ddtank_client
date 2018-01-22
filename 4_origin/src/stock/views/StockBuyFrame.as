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
      
      public function StockBuyFrame(param1:int)
      {
         super();
         data = StockMgr.inst.model.stocks[param1];
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
      
      private function select(param1:int) : void
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
      
      private function change(param1:int) : void
      {
         _cnt = param1;
         updateCost();
      }
      
      private function updateCost() : void
      {
         var _loc1_:int = _cnt * _data.price;
         if(radioGroup.selectedIndex == 0)
         {
            lablLoan.text = _loc1_.toString();
            lablFund.text = "0";
         }
         else
         {
            lablFund.text = _loc1_.toString();
            lablLoan.text = "0";
         }
      }
      
      public function set data(param1:StockData) : void
      {
         if(!param1)
         {
            return;
         }
         _data = param1;
         numStep.maxValue = Math.min(param1.maxBuyNum,Math.floor((radioGroup.selectedIndex == 0?StockMgr.inst.model.stockAccoutData.validLoan:int(StockMgr.inst.model.stockAccoutData.fund)) / param1.price));
         numStep.numValue = 1;
         lablID.text = _data.StockID.toString();
         lablName.text = _data.StockName;
         lablBuyMaxCnt.text = _data.maxBuyNum.toString();
         lablCurPrice.text = _data.price.toString();
      }
   }
}
