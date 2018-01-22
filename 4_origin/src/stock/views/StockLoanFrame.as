package stock.views
{
   import baglocked.BaglockedManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import morn.core.handlers.Handler;
   import stock.StockMgr;
   import stock.mornUI.views.StockLoanFrameUI;
   
   public class StockLoanFrame extends StockLoanFrameUI
   {
      
      private static const _DEFAULT_CNT:int = 10;
       
      
      private var _cnt:int = 10;
      
      public function StockLoanFrame()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         lablRechargeRate.text = LanguageMgr.GetTranslation("stock.rechargeRate",ServerConfigManager.instance.stockLoanRechageRate);
         numStep.changeHandler = new Handler(change);
         numStep.minValue = 10;
         numStep.numValue = 10;
         numStep.maxValue = StockMgr.inst.model.dailyLoanMax;
         stockText1.text = LanguageMgr.GetTranslation("money");
         stockText2.text = LanguageMgr.GetTranslation("ddtMoney");
         radioGroup.labels = LanguageMgr.GetTranslation("money") + "," + LanguageMgr.GetTranslation("ddtMoney");
         radioGroup.selectHandler = new Handler(select);
         btnClose.clickHandler = new Handler(close);
         btnBuy.clickHandler = new Handler(buy);
      }
      
      private function select(param1:int) : void
      {
         updateLoan();
      }
      
      private function buy() : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(numStep.numValue % ServerConfigManager.instance.stockLoanRechageRate != 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.remaind",ServerConfigManager.instance.stockLoanRechageRate));
            return;
         }
         CheckMoneyUtils.instance.checkMoney(radioGroup.selectedIndex == 1,1 / ServerConfigManager.instance.stockLoanRechageRate * numStep.numValue,onCheckComplete);
      }
      
      private function onCheckComplete() : void
      {
         StockMgr.inst.requestDealStock(numStep.numValue,true,!!CheckMoneyUtils.instance.isBind?1:0,true);
         super.dispose();
      }
      
      private function close() : void
      {
         super.dispose();
      }
      
      private function change(param1:int) : void
      {
         _cnt = param1;
         updateLoan();
      }
      
      private function updateLoan() : void
      {
         var _loc1_:int = _cnt * 1 / ServerConfigManager.instance.stockLoanRechageRate;
         if(radioGroup.selectedIndex == 0)
         {
            lablMoney.text = _loc1_.toString();
            lablBindMoney.text = "0";
         }
         else
         {
            lablBindMoney.text = _loc1_.toString();
            lablMoney.text = "0";
         }
      }
   }
}
