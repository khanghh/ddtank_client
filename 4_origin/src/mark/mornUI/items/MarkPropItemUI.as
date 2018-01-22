package mark.mornUI.items
{
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.RadioButton;
   import morn.core.components.View;
   
   public class MarkPropItemUI extends View
   {
       
      
      public var radio:RadioButton = null;
      
      public var radioTxt:Label = null;
      
      public var maxTxt:Image = null;
      
      public function MarkPropItemUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("items/MarkPropItem.xml");
      }
   }
}
