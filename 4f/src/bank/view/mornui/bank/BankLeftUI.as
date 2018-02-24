package bank.view.mornui.bank
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class BankLeftUI extends View
   {
       
      
      public var leftBtn:Button = null;
      
      public var rightBtn:Button = null;
      
      public var pageNum:Label = null;
      
      public function BankLeftUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
