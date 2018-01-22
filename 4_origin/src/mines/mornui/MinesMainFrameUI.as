package mines.mornui
{
   import morn.core.components.Box;
   import morn.core.components.Button;
   import morn.core.components.Tab;
   import morn.core.components.View;
   
   public class MinesMainFrameUI extends View
   {
       
      
      public var closeBtn:Button = null;
      
      public var helpBtn:Button = null;
      
      public var tabMain:Tab = null;
      
      public var mainBox:Box = null;
      
      public var chatBtn:Button = null;
      
      public function MinesMainFrameUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("MinesMainFrame.xml");
      }
   }
}
