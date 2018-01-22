package mines.mornui.view
{
   import morn.core.components.Button;
   import morn.core.components.ComboBox;
   import morn.core.components.Label;
   import morn.core.components.ProgressBar;
   import morn.core.components.View;
   
   public class DigViewUI extends View
   {
       
      
      public var costInfoLabel:Label = null;
      
      public var stopBtn:Button = null;
      
      public var infoLabel:Label = null;
      
      public var progress:ProgressBar = null;
      
      public var proLabel:Label = null;
      
      public var showBtn:Button = null;
      
      public var floorLabel:Label = null;
      
      public var combox:ComboBox = null;
      
      public var digBtn:Button = null;
      
      public function DigViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("view/DigView.xml");
      }
   }
}
