package stock.views
{
   import morn.core.handlers.Handler;
   import stock.mornUI.views.StockHelpFrameUI;
   
   public class StockHelpFrame extends StockHelpFrameUI
   {
       
      
      public function StockHelpFrame()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         btnClose.clickHandler = new Handler(close);
      }
      
      private function close() : void
      {
         super.dispose();
      }
   }
}
