package stock.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.TimeManager;
   import morn.core.handlers.Handler;
   import stock.StockMgr;
   import stock.data.StockData;
   import stock.event.StockEvent;
   import stock.items.StockDataItem;
   import stock.mornUI.views.StockAccountViewUI;
   
   public class StockAccountView extends StockAccountViewUI
   {
       
      
      private var _sortBtns:Array = null;
      
      private var _sortStatus:Array = null;
      
      private var _sortFields:Array = null;
      
      private var _sortIdx:int = 0;
      
      public function StockAccountView()
      {
         super();
         initEvent();
      }
      
      private function initEvent() : void
      {
         StockMgr.inst.addEventListener("account_update",updateAccount);
         StockMgr.inst.addEventListener("stock_user_info",updateUserInfo);
         StockMgr.inst.addEventListener("stock_all_update",updateUserInfo);
         StockMgr.inst.addEventListener("stock_deal_message",stockMessageUpdate);
         StockMgr.inst.addEventListener("stock_choose",stockChoose);
         StockMgr.inst.addEventListener("stock_sell_out",stockSellOut);
      }
      
      private function updateUserInfo(param1:StockEvent = null) : void
      {
         listMyStocks.array = StockMgr.inst.getMyStocks();
         execRule();
      }
      
      private function stockMessageUpdate(param1:StockEvent = null) : void
      {
         var _loc3_:int = 0;
         var _loc2_:String = "";
         _loc3_ = StockMgr.inst.model.stockAccoutData.historyList.length - 1;
         while(_loc3_ >= 0)
         {
            _loc2_ = _loc2_ + StockMgr.inst.model.stockAccoutData.historyList[_loc3_].content;
            _loc3_--;
         }
         txtNotices.text = _loc2_;
      }
      
      private function removeEvent() : void
      {
         StockMgr.inst.removeEventListener("account_update",updateAccount);
         StockMgr.inst.removeEventListener("stock_user_info",updateUserInfo);
         StockMgr.inst.removeEventListener("stock_all_update",updateUserInfo);
         StockMgr.inst.removeEventListener("stock_deal_message",stockMessageUpdate);
         StockMgr.inst.removeEventListener("stock_choose",stockChoose);
         StockMgr.inst.removeEventListener("stock_sell_out",stockSellOut);
      }
      
      private function stockSellOut(param1:StockEvent) : void
      {
         if(listMyStocks.array && listMyStocks.array.length > 0)
         {
            listMyStocks.selectedIndex = 0;
         }
      }
      
      private function stockChoose(param1:StockEvent) : void
      {
         var _loc2_:int = param1.data;
         if(_loc2_ == 2)
         {
            if(listMyStocks.array && listMyStocks.array.length > 0)
            {
               listMyStocks.selectedIndex = 0;
            }
         }
      }
      
      override protected function initialize() : void
      {
         var _loc2_:int = 0;
         stockText1.text = LanguageMgr.GetTranslation("ddt.stock.allView.text19");
         stockText2.text = LanguageMgr.GetTranslation("ddt.stock.allView.text20");
         stockText3.text = LanguageMgr.GetTranslation("ddt.stock.allView.text21");
         stockText4.text = LanguageMgr.GetTranslation("ddt.stock.allView.text22");
         stockText5.text = LanguageMgr.GetTranslation("ddt.stock.allView.text23");
         stockText6.text = LanguageMgr.GetTranslation("ddt.stock.allView.text33");
         stockText7.text = LanguageMgr.GetTranslation("ddt.stock.allView.text34");
         stockText8.text = LanguageMgr.GetTranslation("ddt.stock.allView.text9");
         stockText9.text = LanguageMgr.GetTranslation("ddt.stock.allView.text10");
         stockText10.text = LanguageMgr.GetTranslation("ddt.stock.allView.text11");
         stockText11.text = LanguageMgr.GetTranslation("ddt.stock.allView.text24");
         stockText12.text = LanguageMgr.GetTranslation("ddt.stock.allView.text25");
         stockText13.text = LanguageMgr.GetTranslation("ddt.stock.allView.text26");
         stockText14.text = LanguageMgr.GetTranslation("ddt.stock.allView.text27");
         stockText15.text = LanguageMgr.GetTranslation("ddt.stock.allView.text28");
         var _loc1_:* = StockMgr.inst.model.stockBuyEndTime <= TimeManager.Instance.NowTime();
         btnLoadIn.clickHandler = new Handler(buyLoan);
         btnLoadIn.disabled = _loc1_;
         btnAccountBuy.clickHandler = new Handler(buyIn);
         btnAccountSell.clickHandler = new Handler(sellOut);
         listMyStocks.renderHandler = new Handler(render);
         listMyStocks.selectHandler = new Handler(select);
         txtNotices.editable = false;
         btnAccountBuy.disabled = _loc1_;
         _sortBtns = [btnID,btnPrice,btnHold,btnValid,btnBenefit];
         _sortStatus = [true,true,true,true,true];
         _sortFields = ["StockID","price","holdNum","validNum","floatBenefit"];
         _loc2_ = 0;
         while(_loc2_ < _sortBtns.length)
         {
            _sortBtns[_loc2_].clickHandler = new Handler(sort,[_loc2_]);
            _loc2_++;
         }
         updateAccount();
         updateUserInfo();
         stockMessageUpdate();
      }
      
      private function sort(param1:int) : void
      {
         _sortIdx = param1;
         var _loc2_:Boolean = _sortStatus[param1];
         _sortStatus[param1] = !_loc2_;
         execRule();
         listMyStocks.selectedIndex = 0;
      }
      
      private function execRule() : void
      {
         var _loc1_:String = _sortFields[_sortIdx];
         var _loc2_:Array = listMyStocks.array;
         _loc2_ = _loc2_.sortOn(_loc1_,!!_sortStatus[_sortIdx]?16:16 | 2);
         listMyStocks.array = _loc2_;
      }
      
      private function render(param1:StockDataItem, param2:int) : void
      {
         param1.data = listMyStocks.array[param2];
      }
      
      private function select(param1:int) : void
      {
         if(!listMyStocks || !listMyStocks.array || listMyStocks.array.length <= param1)
         {
            StockMgr.inst.model.stockID = 0;
            return;
         }
         StockMgr.inst.chooseStock((listMyStocks.array[param1] as StockData).StockID);
      }
      
      private function updateAccount(param1:StockEvent = null) : void
      {
         lablTotalAsset.text = StockMgr.inst.model.stockAccoutData.totalAssets.toString();
         lablTotalBenefit.text = StockMgr.inst.model.stockAccoutData.totalBenefit.toString();
         lablTotalMaketValue.text = StockMgr.inst.model.stockAccoutData.totalValue.toString();
         lablValidAsset.text = StockMgr.inst.model.stockAccoutData.validAsset.toString();
         lablTotalTickt.text = StockMgr.inst.model.stockAccoutData.validLoan.toString();
      }
      
      private function sellOut() : void
      {
         if(StockMgr.inst.model.stockID == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.selectStock"));
            return;
         }
         var _loc1_:StockSellFrame = ComponentFactory.Instance.creatCustomObject("stock.sellFrame",[StockMgr.inst.model.stockID]);
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
      
      private function buyIn() : void
      {
         if(StockMgr.inst.model.stockID == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.selectStock1"));
            return;
         }
         var _loc1_:* = ComponentFactory.Instance.creatCustomObject("stock.buyFrame",[StockMgr.inst.model.stockID]);
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
      
      private function buyLoan() : void
      {
         var _loc1_:* = ComponentFactory.Instance.creatCustomObject("stock.loanFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
      
      override public function dispose() : void
      {
         removeEvent();
         super.dispose();
      }
   }
}
