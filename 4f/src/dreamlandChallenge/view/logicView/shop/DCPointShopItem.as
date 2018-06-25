package dreamlandChallenge.view.logicView.shop{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemPrice;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import dreamlandChallenge.view.mornui.shop.DCPointSHopItemUI;   import flash.display.Shape;   import morn.core.handlers.Handler;      public class DCPointShopItem extends DCPointSHopItemUI   {                   private var _info:ShopItemInfo;            private var _bagCell:BagCell;            public function DCPointShopItem() { super(); }
            override protected function initialize() : void { }
            private function onClickBuyGoods() : void { }
            public function set info(value:ShopItemInfo) : void { }
            private function getCellBg() : Shape { return null; }
            override public function dispose() : void { }
   }}