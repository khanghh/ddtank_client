package worldcup.view.mornui
{
   import morn.core.components.Button;
   import morn.core.components.View;
   import morn.core.ex.TabListEx;
   
   public class WorldCupMainViewUI extends View
   {
       
      
      public var viewTab:TabListEx = null;
      
      public var closeBtn:Button = null;
      
      public function WorldCupMainViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("WorldCupMainView.xml");
      }
   }
}