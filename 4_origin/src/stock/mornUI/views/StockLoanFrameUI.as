package stock.mornUI.views
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.RadioGroup;
   import morn.core.components.View;
   import morn.core.ex.NumericStepper;
   
   public class StockLoanFrameUI extends View
   {
       
      
      public var btnClose:Button = null;
      
      public var lablRechargeRate:Label = null;
      
      public var numStep:NumericStepper = null;
      
      public var radioGroup:RadioGroup = null;
      
      public var lablMoney:Label = null;
      
      public var stockText1:Label = null;
      
      public var lablBindMoney:Label = null;
      
      public var stockText2:Label = null;
      
      public var btnBuy:Button = null;
      
      public function StockLoanFrameUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("views/StockLoanFrame.xml");
      }
   }
}
