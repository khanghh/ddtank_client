package shop{   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemPrice;   import ddt.data.goods.ShopCarItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.data.player.PlayerInfo;   import ddt.data.player.SelfInfo;   import ddt.events.BagEvent;   import ddt.events.PlayerPropertyEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import road7th.data.DictionaryData;      public class ShopModel extends EventDispatcher   {            private static var DEFAULT_MAN_STYLE:String = "1101,2101,3101,4101,5101,6101,7001,13101,15001";            private static var DEFAULT_WOMAN_STYLE:String = "1201,2201,3201,4201,5201,6201,7002,13201,15001";            public static const SHOP_CART_MAX_LENGTH:uint = 20;                   public var leftCarList:Array;            public var leftManList:Array;            public var isBandList:Array;            public var leftWomanList:Array;            private var _bodyThings:DictionaryData;            private var _carList:Array;            private var _currentGift:int;            private var _currentGold:int;            private var _currentMedal:int;            private var _currentMoney:int;            private var _totalGold:int;            private var _totalMedal:int;            private var _totalMoney:int;            private var _defaultModel:int;            private var _manMemoryList:Array;            private var _manModel:PlayerInfo;            private var _manTempList:Array;            private var _womanMemoryList:Array;            private var _womanModel:PlayerInfo;            private var _womanTempList:Array;            private var _manHistoryList:Array;            private var _womanHistoryList:Array;            private var _self:SelfInfo;            private var _sex:Boolean;            private var _totalGift:int;            private var maleCollocation:Array;            private var femaleCollocation:Array;            public function ShopModel() { super(); }
            public function removeLatestItem() : void { }
            private function currentTempListHasItem(categoryID:int) : int { return 0; }
            public function get currentHistoryList() : Array { return null; }
            private function initRandom() : void { }
            public function random() : void { }
            public function get Self() : SelfInfo { return null; }
            public function isCarListMax() : Boolean { return false; }
            public function addTempEquip(item:*) : Boolean { return false; }
            public function addToShoppingCar(item:ShopCarItemInfo) : void { }
            private function __onItemChange(evt:Event) : void { }
            public function isOverCount(info:ShopItemInfo) : Boolean { return false; }
            public function get allItems() : Array { return null; }
            public function get allItemsCount() : int { return 0; }
            public function calcPrices(list:Array, list2:Array = null) : Array { return null; }
            public function canBuyLeastOneGood(array:Array) : Boolean { return false; }
            public function canChangSkin() : Boolean { return false; }
            public function clearAllitems() : void { }
            public function clearCurrentTempList(sex:int = 0) : void { }
            public function clearLeftList() : void { }
            public function get currentGift() : int { return 0; }
            public function get currentGold() : int { return 0; }
            public function get currentLeftList() : Array { return null; }
            public function get currentMedal() : int { return 0; }
            public function get currentMemoryList() : Array { return null; }
            public function get currentModel() : PlayerInfo { return null; }
            public function get currentMoney() : int { return 0; }
            public function get currentSkin() : String { return null; }
            public function get currentTempList() : Array { return null; }
            public function dispose() : void { }
            public function get fittingSex() : Boolean { return false; }
            public function set fittingSex(value:Boolean) : void { }
            public function get isSelfModel() : Boolean { return false; }
            public function get manModelInfo() : PlayerInfo { return null; }
            public function removeFromShoppingCar(item:ShopCarItemInfo) : void { }
            public function checkPoint() : Boolean { return false; }
            public function checkDiscount() : Boolean { return false; }
            public function removeItem(item:ShopCarItemInfo) : void { }
            public function removeTempEquip(item:ShopCarItemInfo) : void { }
            public function restoreAllItemsOnBody() : void { }
            public function revertToDefalt() : void { }
            public function setSelectedEquip(item:ShopCarItemInfo) : void { }
            public function get totalGift() : int { return 0; }
            public function get totalGold() : int { return 0; }
            public function get totalMedal() : int { return 0; }
            public function get totalMoney() : int { return 0; }
            public function updateCost() : void { }
            public function get womanModelInfo() : PlayerInfo { return null; }
            private function __bagChange(evt:BagEvent) : void { }
            private function __styleChange(evt:PlayerPropertyEvent) : void { }
            private function clearAllItemsOnBody() : void { }
            private function fillToShopCarInfo(item:ShopItemInfo) : ShopCarItemInfo { return null; }
            private function findEquip(id:Number, list:Array) : int { return 0; }
            private function init() : void { }
            private function initBodyThing() : void { }
            private function saveTriedList() : void { }
            public function getBagItems($id:int, $isIndex:Boolean = false) : int { return 0; }
   }}