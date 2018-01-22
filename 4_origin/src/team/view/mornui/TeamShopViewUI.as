package team.view.mornui
{
   import morn.core.components.List;
   import morn.core.components.View;
   import morn.core.ex.NumberImageEx;
   import morn.core.ex.PageNavigaterEx;
   import team.view.main.TeamShopViewItem;
   
   public class TeamShopViewUI extends View
   {
       
      
      public var list_select:List = null;
      
      public var list_shop:List = null;
      
      public var ex_active:NumberImageEx = null;
      
      public var page_select:PageNavigaterEx = null;
      
      public function TeamShopViewUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["team.view.main.TeamShopViewItem"] = TeamShopViewItem;
         super.createChildren();
         loadUI("TeamShopView.xml");
      }
   }
}
