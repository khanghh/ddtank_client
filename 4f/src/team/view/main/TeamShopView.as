package team.view.main{   import ddt.data.ShopType;   import ddt.manager.SoundManager;   import morn.core.components.Box;   import morn.core.components.Label;   import morn.core.handlers.Handler;   import team.TeamManager;   import team.event.TeamEvent;   import team.model.TeamShopInfo;   import team.view.mornui.TeamShopViewUI;      public class TeamShopView extends TeamShopViewUI   {                   public function TeamShopView() { super(); }
            override protected function initialize() : void { }
            private function __onRenderTab(item:Box, index:int) : void { }
            private function __onSelectTab(index:int) : void { }
            private function __onRenderShop(item:Box, index:int) : void { }
            private function tabToShop(tabIndex:int) : void { }
            private function __onPageSelect(index:int) : void { }
            public function update() : void { }
            private function __onUpdateSelfInfo(e:TeamEvent) : void { }
            override public function dispose() : void { }
   }}