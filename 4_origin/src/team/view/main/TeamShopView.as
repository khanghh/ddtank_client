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
      
      private function __onRenderTab(param1:Box, param2:int) : void
      {
         var _loc3_:Label = param1.getChildByName("lv") as Label;
         _loc3_.text = "Lv." + list_select.array[param2];
      }
      
      private function __onSelectTab(param1:int) : void
      {
         SoundManager.instance.playButtonSound();
         tabToShop(param1);
      }
      
      private function __onRenderShop(param1:Box, param2:int) : void
      {
         var _loc3_:TeamShopViewItem = param1 as TeamShopViewItem;
         if(param2 < list_shop.array.length)
         {
            _loc3_.info = list_shop.array[param2] as TeamShopInfo;
         }
         else
         {
            _loc3_.info = null;
         }
      }
      
      private function tabToShop(param1:int) : void
      {
         var _loc2_:int = ShopType.TEAM_SHOP[param1];
         var _loc3_:Array = TeamManager.instance.model.shopList[_loc2_];
         list_shop.array = _loc3_;
         list_shop.page = 1;
         page_select.maxPage = list_shop.totalPage;
         page_select.currentPage = 1;
      }
      
      private function __onPageSelect(param1:int) : void
      {
         SoundManager.instance.playButtonSound();
         list_shop.page = param1 - 1;
      }
      
      public function update() : void
      {
         ex_active.count = TeamManager.instance.model.selfActive;
         list_select.selectedIndex = 0;
      }
      
      private function __onUpdateSelfInfo(param1:TeamEvent) : void
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
