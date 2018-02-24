package stock.mornUI
{
   import morn.core.components.Box;
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   import morn.core.ex.TabListEx;
   
   public class StockMainFrameUI extends View
   {
       
      
      public var btnClose:Button = null;
      
      public var btnHelp:Button = null;
      
      public var spFundLoan:Box = null;
      
      public var stockText1:Label = null;
      
      public var lablFund:Label = null;
      
      public var stockText2:Label = null;
      
      public var lablLoan:Label = null;
      
      public var tabMain:TabListEx = null;
      
      public function StockMainFrameUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
