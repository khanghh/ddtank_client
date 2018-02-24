package bank.view.mornui.bank
{
   import morn.core.components.Button;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.TextInput;
   import morn.core.components.View;
   
   public class BankGetUI extends View
   {
       
      
      public var getTypeImg:Image = null;
      
      public var interestTitle:Label = null;
      
      public var principalTitle:Label = null;
      
      public var money1:Label = null;
      
      public var myMoney:Label = null;
      
      public var profitMoney:Label = null;
      
      public var InterestRate:Label = null;
      
      public var saveType:Label = null;
      
      public var moneyNum:Label = null;
      
      public var getInput:TextInput = null;
      
      public var note:Label = null;
      
      public var backViewBtn:Button = null;
      
      public var getTip:Label = null;
      
      public var money:Label = null;
      
      public var ddtMoney:Label = null;
      
      public var goSaveBtn:Button = null;
      
      public var getBtn:Button = null;
      
      public var leftTime:Label = null;
      
      public function BankGetUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
