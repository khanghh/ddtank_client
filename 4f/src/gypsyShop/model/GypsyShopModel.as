package gypsyShop.model{   import ddt.data.goods.InventoryItemInfo;   import ddt.events.PkgEvent;   import ddt.manager.GameInSocketOut;   import ddt.manager.SocketManager;   import flash.events.EventDispatcher;   import flash.utils.ByteArray;   import gypsyShop.I.IGypsyShopViewModel;   import gypsyShop.ctrl.GypsyShopManager;      public class GypsyShopModel extends EventDispatcher implements IGypsyShopViewModel   {            private static var instance:GypsyShopModel;                   public var isBind:Boolean = true;            private var _curRefreshedTimes:int;            private var _itemCount:int;            private var _itemDataList:Vector.<GypsyItemData>;            private var _buyResult:Object;            private var _listRareItemTempleteIDs:Vector.<int>;            public function GypsyShopModel(single:inner) { super(); }
            public static function getInstance() : GypsyShopModel { return null; }
            public function requestManualRefreshList() : void { }
            public function requestManualRefreshListWithRMB() : void { }
            public function requestBuyItem(id:int) : void { }
            public function requestRareList() : void { }
            public function requestRefreshList() : void { }
            public function init() : void { }
            protected function onRareItemListUpdated(e:PkgEvent) : void { }
            protected function onBuyResult(e:PkgEvent) : void { }
            protected function onItemListUpdated(e:PkgEvent) : void { }
            public function dispose() : void { }
            public function getNeedMoneyTotal() : int { return 0; }
            public function getUpdateTime() : String { return null; }
            public function getRareItemsList() : Vector.<InventoryItemInfo> { return null; }
            public function getHonour() : int { return 0; }
            public function get itemCount() : int { return 0; }
            public function get curRefreshedTimes() : int { return 0; }
            public function get itemDataList() : Vector.<GypsyItemData> { return null; }
            public function get buyResult() : Object { return null; }
            public function get listRareItemTempleteIDs() : Vector.<int> { return null; }
   }}class inner{          function inner() { super(); }
}