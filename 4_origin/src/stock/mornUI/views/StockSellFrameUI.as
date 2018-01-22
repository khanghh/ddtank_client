package stock.mornUI.views
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   import morn.core.ex.NumericStepper;
   
   public class StockSellFrameUI extends View
   {
       
      
      public var btnClose:Button = null;
      
      public var numStep:NumericStepper = null;
      
      public var btnSell:Button = null;
      
      public var lablFund:Label = null;
      
      public var stockText1:Label = null;
      
      public var stockText4:Label = null;
      
      public var stockText3:Label = null;
      
      public var lablID:Label = null;
      
      public var stockText2:Label = null;
      
      public var stockText5:Label = null;
      
      public var lablName:Label = null;
      
      public var lablHoldCnt:Label = null;
      
      public var lablCurPrice:Label = null;
      
      public var lablStockNum:Label = null;
      
      public function StockSellFrameUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("views/StockSellFrame.xml");
      }
   }
}
