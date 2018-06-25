package shop.manager{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemPrice;   import ddt.data.goods.ShopCarItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.data.player.PlayerInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.ShopManager;   import farm.viewx.shop.FarmShopPayPnl;   import flash.display.DisplayObject;   import shop.view.BuyMultiGoodsView;   import shop.view.BuySingleGoodsView;      public class ShopBuyManager   {            private static var _instance:ShopBuyManager;            public static var crrItemId:int;                   private var view:DisplayObject;            private var farmview:DisplayObject;            public function ShopBuyManager() { super(); }
            public static function get Instance() : ShopBuyManager { return null; }
            public static function calcPrices(list:Vector.<ShopCarItemInfo>, isBindList:Array = null) : Array { return null; }
            public function buy($goodsID:int, isDiscount:int = 1, type:int = 1, isSale:Boolean = false) : void { }
            public function buyFarmShop($goodsID:int) : void { }
            public function buyAvatar(info:PlayerInfo) : void { }
            public function buyMutiGoods(goods:Vector.<ShopCarItemInfo>) : void { }
            public function get isShow() : Boolean { return false; }
            public function dispose() : void { }
   }}