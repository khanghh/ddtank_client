package stock.views{   import baglocked.BaglockedManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import morn.core.handlers.Handler;   import stock.StockMgr;   import stock.mornUI.views.StockLoanFrameUI;      public class StockLoanFrame extends StockLoanFrameUI   {            private static const _DEFAULT_CNT:int = 10;                   private var _cnt:int = 10;            public function StockLoanFrame() { super(); }
            override protected function initialize() : void { }
            private function select(index:int) : void { }
            private function buy() : void { }
            private function onCheckComplete() : void { }
            private function close() : void { }
            private function change(value:int) : void { }
            private function updateLoan() : void { }
   }}