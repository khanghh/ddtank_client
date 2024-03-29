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
      
      public function StockAccountView(){super();}
      
      private function initEvent() : void{}
      
      private function updateUserInfo(param1:StockEvent = null) : void{}
      
      private function stockMessageUpdate(param1:StockEvent = null) : void{}
      
      private function removeEvent() : void{}
      
      private function stockSellOut(param1:StockEvent) : void{}
      
      private function stockChoose(param1:StockEvent) : void{}
      
      override protected function initialize() : void{}
      
      private function sort(param1:int) : void{}
      
      private function execRule() : void{}
      
      private function render(param1:StockDataItem, param2:int) : void{}
      
      private function select(param1:int) : void{}
      
      private function updateAccount(param1:StockEvent = null) : void{}
      
      private function sellOut() : void{}
      
      private function buyIn() : void{}
      
      private function buyLoan() : void{}
      
      override public function dispose() : void{}
   }
}
