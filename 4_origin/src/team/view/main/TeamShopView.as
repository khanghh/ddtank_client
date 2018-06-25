package team.view.main
{
   import ddt.data.ShopType;
   import ddt.manager.SoundManager;
   import morn.core.components.Box;
   import morn.core.components.Label;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.event.TeamEvent;
   import team.model.TeamShopInfo;
   import team.view.mornui.TeamShopViewUI;
   
   public class TeamShopView extends TeamShopViewUI
   {
       
      
      public function TeamShopView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         list_select.renderHandler = new Handler(__onRenderTab);
         list_select.selectHandler = new Handler(__onSelectTab);
         list_shop.renderHandler = new Handler(__onRenderShop);
         page_select.selectHandler = new Handler(__onPageSelect);
         list_select.array = TeamManager.instance.model.buyLimitLv;
         TeamManager.instance.addEventListener("updateselfinfo",__onUpdateSelfInfo);
      }
      
      private function __onRenderTab(item:Box, index:int) : void
      {
         var lv:Label = item.getChildByName("lv") as Label;
         lv.text = "Lv." + list_select.array[index];
      }
      
      private function __onSelectTab(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         tabToShop(index);
      }
      
      private function __onRenderShop(item:Box, index:int) : void
      {
         var view:TeamShopViewItem = item as TeamShopViewItem;
         if(index < list_shop.array.length)
         {
            view.info = list_shop.array[index] as TeamShopInfo;
         }
         else
         {
            view.info = null;
         }
      }
      
      private function tabToShop(tabIndex:int) : void
      {
         var shopType:int = ShopType.TEAM_SHOP[tabIndex];
         var list:Array = TeamManager.instance.model.shopList[shopType];
         list_shop.array = list;
         list_shop.page = 1;
         page_select.maxPage = list_shop.totalPage;
         page_select.currentPage = 1;
      }
      
      private function __onPageSelect(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         list_shop.page = index - 1;
      }
      
      public function update() : void
      {
         ex_active.count = TeamManager.instance.model.selfActive;
         list_select.selectedIndex = 0;
      }
      
      private function __onUpdateSelfInfo(e:TeamEvent) : void
      {
         ex_active.count = TeamManager.instance.model.selfActive;
      }
      
      override public function dispose() : void
      {
         TeamManager.instance.removeEventListener("updateselfinfo",__onUpdateSelfInfo);
         super.dispose();
      }
   }
}
