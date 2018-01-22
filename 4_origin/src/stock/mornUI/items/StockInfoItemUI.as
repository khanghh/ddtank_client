package stock.mornUI.items
{
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class StockInfoItemUI extends View
   {
       
      
      public var lablID:Label = null;
      
      public var lablName:Label = null;
      
      public var lblChangeLN:Label = null;
      
      public var lablPriceLN:Label = null;
      
      public var lblDealNumLN:Label = null;
      
      public var lblHoldNumLN:Label = null;
      
      public var lablIDSelected:Label = null;
      
      public var lablNameSelected:Label = null;
      
      public var lblPriceLO:Label = null;
      
      public var lblChangeLO:Label = null;
      
      public var lblDealNumLO:Label = null;
      
      public var lblHoldNumLO:Label = null;
      
      public var lblChangeGO:Label = null;
      
      public var lblChangeGN:Label = null;
      
      public var lblPriceGO:Label = null;
      
      public var lablPriceGN:Label = null;
      
      public var lblDealNumGN:Label = null;
      
      public var lblDealNumGO:Label = null;
      
      public var lblHoldNumGO:Label = null;
      
      public var lblHoldNumGN:Label = null;
      
      public function StockInfoItemUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("items/StockInfoItem.xml");
      }
   }
}
