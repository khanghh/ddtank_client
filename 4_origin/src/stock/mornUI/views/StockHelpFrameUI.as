package stock.mornUI.views
{
   import morn.core.components.Button;
   import morn.core.components.View;
   
   public class StockHelpFrameUI extends View
   {
       
      
      public var btnClose:Button = null;
      
      public function StockHelpFrameUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("views/StockHelpFrame.xml");
      }
   }
}
