package mark.mornUI.views
{
   import mark.items.MarkBagItem;
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   
   public class MarkBagViewUI extends View
   {
       
      
      public var lblName:Label = null;
      
      public var btnHelp:Button = null;
      
      public var btnReturn:Button = null;
      
      public var btnSelectSell:Button = null;
      
      public var btnCancel:Button = null;
      
      public var btnSell:Button = null;
      
      public var listBag:List = null;
      
      public function MarkBagViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["mark.items.MarkBagItem"] = MarkBagItem;
         super.createChildren();
         loadUI("views/MarkBagView.xml");
      }
   }
}
