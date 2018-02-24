package stock.mornUI.views
{
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   import stock.items.StockAwardItem;
   
   public class StockAwardViewUI extends View
   {
       
      
      public var lablDesc:Label = null;
      
      public var lablScore:Label = null;
      
      public var lablTime:Label = null;
      
      public var awardList:List = null;
      
      public function StockAwardViewUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
