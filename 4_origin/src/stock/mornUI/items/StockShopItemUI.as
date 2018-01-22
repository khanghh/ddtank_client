package stock.mornUI.items
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class StockShopItemUI extends View
   {
       
      
      public var lablName:Label = null;
      
      public var lablPrice:Label = null;
      
      public var stockText1:Label = null;
      
      public var stockText2:Label = null;
      
      public var lablCnt:Label = null;
      
      public var btnLoadIn:Button = null;
      
      public function StockShopItemUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("items/StockShopItem.xml");
      }
   }
}
