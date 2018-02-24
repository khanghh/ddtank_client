package stock.mornUI.views
{
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   import morn.core.ex.PageNavigaterEx;
   import stock.items.StockShopItem;
   
   public class StockShopViewUI extends View
   {
       
      
      public var listShop:List = null;
      
      public var stockText1:Label = null;
      
      public var lablTime:Label = null;
      
      public var pageBar:PageNavigaterEx = null;
      
      public var lablLoan:Label = null;
      
      public function StockShopViewUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
