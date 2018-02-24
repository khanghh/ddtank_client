package devilTurn.view.mornui
{
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class DevilTurnShopItemUI extends View
   {
       
      
      public var nameText:Label = null;
      
      public var goodsText:Label = null;
      
      public var buyBtn:Button = null;
      
      public var priceText:Label = null;
      
      public var buyTipsText:Label = null;
      
      public function DevilTurnShopItemUI(){super();}
      
      override protected function createChildren() : void{}
   }
}
