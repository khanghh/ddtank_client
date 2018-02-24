package stock.mornUI.items
{
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class StockDetailInfoItemUI extends View
   {
       
      
      public var stockText1:Label = null;
      
      public var lablTime:Label = null;
      
      public var stockText2:Label = null;
      
      public var lblDealPrice:Label = null;
      
      public var stockText3:Label = null;
      
      public var lblChangeL:Label = null;
      
      public var lblChangeG:Label = null;
      
      public function StockDetailInfoItemUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
