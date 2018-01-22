package mines.mornui.view
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class DigShowViewUI extends View
   {
       
      
      public var closeBtn:Button = null;
      
      public var titleLabel:Label = null;
      
      public var floor1Label:Label = null;
      
      public var floor2Label:Label = null;
      
      public var floor3Label:Label = null;
      
      public var floor4Label:Label = null;
      
      public var floor5Label:Label = null;
      
      public var mines1Label:Label = null;
      
      public var mines2Label:Label = null;
      
      public var mines3Label:Label = null;
      
      public var mines4Label:Label = null;
      
      public var mines5Label:Label = null;
      
      public function DigShowViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("view/DigShowView.xml");
      }
   }
}
