package ddt.manager{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import ddt.data.ShopType;   import ddt.data.analyze.ShopItemAnalyzer;   import ddt.data.analyze.ShopItemDisCountAnalyzer;   import ddt.data.analyze.ShopItemSortAnalyzer;   import ddt.data.goods.ItemPrice;   import ddt.data.goods.ShopCarItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.data.player.SelfInfo;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import flash.events.EventDispatcher;   import flash.net.URLVariables;   import flash.utils.Dictionary;   import gemstone.GemstoneManager;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;   import shop.ShopEvent;      public class ShopManager extends EventDispatcher   {            private static var _instance:ShopManager;                   public var initialized:Boolean = false;            private var _shopGoods:DictionaryData;            private var _shopSortList:Dictionary;            private var _shopRealTimesDisCountGoods:Dictionary;            public function ShopManager(singleton:SingletonEnfocer) { super(); }
            public static function get Instance() : ShopManager { return null; }
            public function setup(analyzer:ShopItemAnalyzer) : void { }
            private function __syncLimitShopList(evt:PkgEvent) : void { }
            public function updateShopGoods(analyzer:ShopItemAnalyzer) : void { }
            public function sortShopItems(analyzer:ShopItemSortAnalyzer) : void { }
            private function __shopBuyLimitedCountHandler(evt:PkgEvent) : void { }
            public function getResultPages(type:int, count:int = 8) : int { return 0; }
            public function buyIt(list:Array) : Array { return null; }
            public function giveGift(list:Array, self:SelfInfo) : Array { return null; }
            private function __updateGoodsCount(evt:PkgEvent) : void { }
            public function getShopItemByGoodsID(id:int) : ShopItemInfo { return null; }
            public function getValidSortedGoodsByType(type:int, page:int, count:int = 8) : Vector.<ShopItemInfo> { return null; }
            public function getValidSortedGoodsByList(list:Vector.<ShopItemInfo>, page:int, count:int = 8) : Vector.<ShopItemInfo> { return null; }
            public function getGoodsByType(type:int) : Vector.<ShopItemInfo> { return null; }
            public function getValidGoodByType(type:int) : Vector.<ShopItemInfo> { return null; }
            public function getValidGoodsArrayByType(type:int) : Array { return null; }
            public function consortiaShopLevelTemplates(level:int) : Vector.<ShopItemInfo> { return null; }
            public function canAddPrice(templateID:int) : Boolean { return false; }
            public function getShopRechargeItemByTemplateId(id:int) : Array { return null; }
            public function getShopItemByTemplateID(id:int, type:int) : ShopItemInfo { return null; }
            public function getMoneyShopItemByTemplateID(id:int, shouldInShop:Boolean = false) : ShopItemInfo { return null; }
            private function getInfoByBuyType(list:Vector.<ShopItemInfo>) : ShopItemInfo { return null; }
            public function getMoneyShopItemByTemplateIDForGiftSystem(id:int) : ShopItemInfo { return null; }
            public function getBuriedGoodsList() : Vector.<ShopItemInfo> { return null; }
            private function getGoodsByTemplateIDOnlyUseXuFei(id:int) : ShopItemInfo { return null; }
            public function getGoodsByTemplateID(id:int, shopID:int = -1) : ShopItemInfo { return null; }
            public function getShopItemByTemplateIdAndType(id:int, type:int) : ShopItemInfo { return null; }
            public function getGiftShopItemByTemplateID(id:int, shouldInShop:Boolean = false) : ShopItemInfo { return null; }
            private function getType(type:*) : Array { return null; }
            public function getGoldShopItemByTemplateID(id:int) : ShopItemInfo { return null; }
            public function moneyGoods(list:Array, self:SelfInfo) : Array { return null; }
            public function buyLeastGood(list:Array, self:SelfInfo) : Boolean { return false; }
            public function getDesignatedAllShopItem() : Vector.<ShopItemInfo> { return null; }
            public function fuzzySearch($ShopItemList:Vector.<ShopItemInfo>, $shopName:String) : Vector.<ShopItemInfo> { return null; }
            public function getDisCountValidGoodByType(type:int) : Vector.<ShopItemInfo> { return null; }
            public function getDisCountResultPages(type:int, count:int = 8) : int { return 0; }
            public function getDisCountShopItemByGoodsID(id:int) : ShopItemInfo { return null; }
            public function getMoneySaleShopItemByTemplateID(id:int) : ShopItemInfo { return null; }
            public function getDisCountGoods(type:int = 1, page:int = 1, count:int = 8) : Vector.<ShopItemInfo> { return null; }
            public function getGoodsByTempId(tempId:int) : ShopItemInfo { return null; }
            public function isHasDisCountGoods(type:int) : Boolean { return false; }
            private function checkIsHasDisCount(result:DictionaryData) : Boolean { return false; }
            private function __updateGoodsDisCount(evt:PkgEvent) : void { }
            private function loadDisCounts() : void { }
            public function updateRealTimesItemsByDisCount(analyzer:ShopItemDisCountAnalyzer) : void { }
            public function get shopGoods() : DictionaryData { return null; }
            public function set shopGoods(value:DictionaryData) : void { }
   }}class SingletonEnfocer{          function SingletonEnfocer() { super(); }
}