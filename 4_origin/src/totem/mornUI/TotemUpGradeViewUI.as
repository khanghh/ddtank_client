package totem.mornUI
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class TotemUpGradeViewUI extends View
   {
       
      
      public var btn_close:Button = null;
      
      public var lbl_glory:Label = null;
      
      public var lbl_totem:Label = null;
      
      public var btn_upGrade:Button = null;
      
      public var btn_maxGrade:Button = null;
      
      public function TotemUpGradeViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("TotemUpGradeView.xml");
      }
   }
}
