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
      
      public function StockSellFrame(param1:int){super();}
      
      override protected function initialize() : void{}
      
      private function sell() : void{}
      
      private function close() : void{}
      
      private function change(param1:int) : void{}
      
      public function set data(param1:StockData) : void{}
   }
}
