package mark.mornUI.views
{
   import mark.items.MarkSuitItem;
   import morn.core.components.List;
   import morn.core.components.View;
   
   public class MarkRightViewUI extends View
   {
       
      
      public var listBags:List = null;
      
      public function MarkRightViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["mark.items.MarkSuitItem"] = MarkSuitItem;
         super.createChildren();
         loadUI("views/MarkRightView.xml");
      }
   }
}
