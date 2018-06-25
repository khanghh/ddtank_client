package stock.views
{
   import baglocked.BaglockedManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import morn.core.handlers.Handler;
   import stock.StockMgr;
   import stock.data.StockData;
   import stock.mornUI.views.StockSellFrameUI;
   
   public class StockSellFrame extends StockSellFrameUI
   {
       
      
      private var _data:StockData = null;
      
      public function StockSellFrame(stockID:int)
      {
         super();
         data = StockMgr.inst.model.stocks[stockID];
      }
      
      override protected function initialize() : void
      {
         stockText1.text = LanguageMgr.GetTranslation("ddt.stock.allView.text4");
         stockText2.text = LanguageMgr.GetTranslation("ddt.stock.allView.text5");
         stockText3.text = LanguageMgr.GetTranslation("ddt.stock.allView.text6");
         stockText4.text = LanguageMgr.GetTranslation("ddt.stock.allView.text7");
         stockText5.text = LanguageMgr.GetTranslation("ddt.stock.allView.text8");
         numStep.changeHandler = new Handler(change);
         numStep.minValue = 1;
         btnClose.clickHandler = new Handler(close);
         btnSell.clickHandler = new Handler(sell);
      }
      
      private function sell() : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         StockMgr.inst.requestDealStock(numStep.numValue);
         super.dispose();
      }
      
      private function close() : void
      {
         super.dispose();
      }
      
      private function change(value:int) : void
      {
         lablFund.text = (value * _data.price).toString();
      }
      
      public function set data(value:StockData) : void
      {
         if(!value)
         {
            return;
         }
         _data = value;
         numStep.maxValue = _data.validNum;
         numStep.numValue = 1;
         lablID.text = _data.StockID.toString();
         lablName.text = _data.StockName;
         lablHoldCnt.text = _data.holdNum.toString();
         lablCurPrice.text = _data.price.toString();
         lablStockNum.text = _data.validNum.toString();
      }
   }
}
