package stock.views
{
   import ddt.events.CEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.manager.TimeManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import morn.core.handlers.Handler;
   import road7th.utils.DateUtils;
   import road7th.utils.StringHelper;
   import stock.StockMgr;
   import stock.event.StockEvent;
   import stock.items.StockShopItem;
   import stock.mornUI.views.StockShopViewUI;
   
   public class StockShopView extends StockShopViewUI
   {
      
      private static const _PAGE_CNT:uint = 9;
       
      
      private var _idx:int = 0;
      
      private var _timer:Timer;
      
      public function StockShopView(){super();}
      
      override protected function initialize() : void{}
      
      private function updateCloseTime() : void{}
      
      private function cooldown(param1:TimerEvent) : void{}
      
      private function select(param1:int) : void{}
      
      private function itemRender(param1:StockShopItem, param2:int) : void{}
      
      private function initEvent() : void{}
      
      private function accountUpdate(param1:StockEvent = null) : void{}
      
      private function __onUpdatePersonLimitShop(param1:CEvent) : void{}
      
      private function removeEvent() : void{}
      
      private function updateGoods(param1:StockEvent = null) : void{}
      
      override public function dispose() : void{}
   }
}
