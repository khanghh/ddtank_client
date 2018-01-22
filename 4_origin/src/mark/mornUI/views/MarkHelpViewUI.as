package mark.mornUI.views
{
   import mark.items.MarkHelpItem;
   import morn.core.components.Button;
   import morn.core.components.Container;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   
   public class MarkHelpViewUI extends View
   {
       
      
      public var label4:Label = null;
      
      public var btnClose:Button = null;
      
      public var bgCont:Container = null;
      
      public var listHelp:List = null;
      
      public function MarkHelpViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["mark.items.MarkHelpItem"] = MarkHelpItem;
         super.createChildren();
         loadUI("views/MarkHelpView.xml");
      }
   }
}
