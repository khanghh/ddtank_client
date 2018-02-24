package devilTurn.view.mornui
{
   import devilTurn.view.DevilTurnShopItem;
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   import morn.core.ex.PageNavigaterEx;
   
   public class DevilTurnShopViewUI extends View
   {
       
      
      public var closeBtn:Button = null;
      
      public var text8:Label = null;
      
      public var selectPage:PageNavigaterEx = null;
      
      public var shopList:List = null;
      
      public var myMoneyText:Label = null;
      
      public function DevilTurnShopViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["devilTurn.view.DevilTurnShopItem"] = DevilTurnShopItem;
         super.createChildren();
         loadUI("DevilTurnShopView.xml");
      }
   }
}
