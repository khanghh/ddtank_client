package stock.views{   import baglocked.BaglockedManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import morn.core.handlers.Handler;   import stock.StockMgr;   import stock.data.StockData;   import stock.mornUI.views.StockBuyFrameUI;      public class StockBuyFrame extends StockBuyFrameUI   {                   private var _data:StockData = null;            private var _cnt:int = 0;            public function StockBuyFrame(stockID:int) { super(); }
            override protected function initialize() : void { }
            private function select(index:int) : void { }
            private function buy() : void { }
            private function close() : void { }
            private function change(value:int) : void { }
            private function updateCost() : void { }
            public function set data(value:StockData) : void { }
   }}