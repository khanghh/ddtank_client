package totem.mornUI
{
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class TotemUpGradeItemViewUI extends View
   {
       
      
      public var chapter_item:TotemTabItemCellUI = null;
      
      public var lbl_addPer:Label = null;
      
      public function TotemUpGradeItemViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["totem.mornUI.TotemTabItemCellUI"] = TotemTabItemCellUI;
         super.createChildren();
         loadUI("TotemUpGradeItemView.xml");
      }
   }
}
