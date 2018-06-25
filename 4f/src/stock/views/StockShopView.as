package stock.views{   import ddt.events.CEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.ShopManager;   import ddt.manager.TimeManager;   import flash.events.TimerEvent;   import flash.utils.Timer;   import morn.core.handlers.Handler;   import road7th.utils.DateUtils;   import road7th.utils.StringHelper;   import stock.StockMgr;   import stock.event.StockEvent;   import stock.items.StockShopItem;   import stock.mornUI.views.StockShopViewUI;      public class StockShopView extends StockShopViewUI   {            private static const _PAGE_CNT:uint = 9;                   private var _idx:int = 0;            private var _timer:Timer;            public function StockShopView() { super(); }
            override protected function initialize() : void { }
            private function updateCloseTime() : void { }
            private function cooldown(event:TimerEvent) : void { }
            private function select(currentPage:int) : void { }
            private function itemRender(item:StockShopItem, index:int) : void { }
            private function initEvent() : void { }
            private function accountUpdate(evt:StockEvent = null) : void { }
            private function __onUpdatePersonLimitShop(event:CEvent) : void { }
            private function removeEvent() : void { }
            private function updateGoods(evt:StockEvent = null) : void { }
            override public function dispose() : void { }
   }}