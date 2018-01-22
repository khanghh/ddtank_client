package bank.view.mornui.bank
{
   import morn.core.components.Box;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class BankSaveRecordItemUI extends View
   {
       
      
      public var box:Box = null;
      
      public var itemLine:Image = null;
      
      public var saveTypeImg:Image = null;
      
      public var startTimeTxt:Label = null;
      
      public var moneyNum:Label = null;
      
      public var timeNum:Label = null;
      
      public var profitNum:Label = null;
      
      public var overTimeImg:Image = null;
      
      public function BankSaveRecordItemUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("bank/BankSaveRecordItem.xml");
      }
   }
}
