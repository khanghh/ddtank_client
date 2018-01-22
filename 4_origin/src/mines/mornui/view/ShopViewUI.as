package mines.mornui.view
{
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class ShopViewUI extends View
   {
       
      
      public var infoLabel:Label = null;
      
      public function ShopViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("view/ShopView.xml");
      }
   }
}
