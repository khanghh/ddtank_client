package mines.mornui.view
{
   import morn.core.components.Box;
   import morn.core.components.Button;
   import morn.core.components.CheckBox;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class ToolViewUI extends View
   {
       
      
      public var box:Box = null;
      
      public var allInCheckBtn:CheckBox = null;
      
      public var round:Image = null;
      
      public var upBtn:Button = null;
      
      public var toolName:Label = null;
      
      public var nextToolName:Label = null;
      
      public var proLabel:Label = null;
      
      public var toolImage:Image = null;
      
      public function ToolViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("view/ToolView.xml");
      }
   }
}
