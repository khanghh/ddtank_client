package stock.items{   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Shape;   import morn.core.handlers.Handler;   import shop.view.ShopItemCell;   import stock.mornUI.items.StockShopItemUI;   import stock.views.StockBuySubmitFrame;      public class StockShopItem extends StockShopItemUI   {                   private var _bagCell:ShopItemCell = null;            private var _id:int = 0;            public function StockShopItem() { super(); }
            override protected function initialize() : void { }
            private function initView() : void { }
            public function hide() : void { }
            private function buyItem() : void { }
            public function set data(id:int) : void { }
            override public function dispose() : void { }
   }}