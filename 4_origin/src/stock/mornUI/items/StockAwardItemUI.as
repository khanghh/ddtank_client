package stock.mornUI.items
{
   import morn.core.components.Button;
   import morn.core.components.Clip;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class StockAwardItemUI extends View
   {
       
      
      public var itemBg:Clip = null;
      
      public var lblScore:Label = null;
      
      public var btnAward:Button = null;
      
      public var imgGained:Image = null;
      
      public function StockAwardItemUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("items/StockAwardItem.xml");
      }
   }
}
