package mark.mornUI.views
{
   import morn.core.components.Button;
   import morn.core.components.View;
   
   public class MarkBagMenuUI extends View
   {
       
      
      public var btnHammer:Button = null;
      
      public var btnSell:Button = null;
      
      public var btnWear:Button = null;
      
      public function MarkBagMenuUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("views/MarkBagMenu.xml");
      }
   }
}
