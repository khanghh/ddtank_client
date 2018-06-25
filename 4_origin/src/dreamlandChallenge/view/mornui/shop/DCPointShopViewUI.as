package dreamlandChallenge.view.mornui.shop
{
   import dreamlandChallenge.view.logicView.shop.DCPointShopItem;
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   import morn.core.ex.PageNavigaterEx;
   
   public class DCPointShopViewUI extends View
   {
       
      
      public var text1:Label = null;
      
      public var btn_close:Button = null;
      
      public var list_shops:List = null;
      
      public var text3:Label = null;
      
      public var lbl_point:Label = null;
      
      public var text2:Label = null;
      
      public var nav_changePage:PageNavigaterEx = null;
      
      public var btn_return:Button = null;
      
      public function DCPointShopViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["dreamlandChallenge.view.logicView.shop.DCPointShopItem"] = DCPointShopItem;
         super.createChildren();
         loadUI("shop/DCPointShopView.xml");
      }
   }
}
