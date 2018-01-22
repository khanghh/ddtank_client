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
      
      public function StockShopView()
      {
         super();
         initEvent();
      }
      
      override protected function initialize() : void
      {
         stockText1.text = LanguageMgr.GetTranslation("ddt.stock.allView.text32");
         listShop.renderHandler = new Handler(itemRender);
         pageBar.selectHandler = new Handler(select);
         pageBar.isLoop = true;
         updateGoods();
         updateCloseTime();
         accountUpdate();
      }
      
      private function updateCloseTime() : void
      {
         var _loc1_:Number = StockMgr.inst.model.shopCloseTime;
         var _loc2_:Number = TimeManager.Instance.NowTime();
         var _loc3_:Array = DateUtils.dateTimeRemainArr(Math.max(0,(StockMgr.inst.model.shopCloseTime - TimeManager.Instance.NowTime()) / 1000));
         lablTime.text = LanguageMgr.GetTranslation("stock.shopEndTime",_loc3_[0],_loc3_[1] < 10?"0" + _loc3_[1]:_loc3_[1],_loc3_[2] < 10?"0" + _loc3_[2]:_loc3_[2],_loc3_[3] < 10?"0" + _loc3_[3]:_loc3_[3]);
         if(!_timer)
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",cooldown);
            _timer.start();
         }
      }
      
      private function cooldown(param1:TimerEvent) : void
      {
         var _loc2_:int = StockMgr.inst.model.shopCloseTime - TimeManager.Instance.NowTime();
         var _loc3_:Array = DateUtils.dateTimeRemainArr(Math.max(0,(StockMgr.inst.model.shopCloseTime - TimeManager.Instance.NowTime()) / 1000));
         lablTime.text = LanguageMgr.GetTranslation("stock.shopEndTime",_loc3_[0],_loc3_[1] < 10?"0" + _loc3_[1]:_loc3_[1],_loc3_[2] < 10?"0" + _loc3_[2]:_loc3_[2],_loc3_[3] < 10?"0" + _loc3_[3]:_loc3_[3]);
         if(_loc2_ < 0)
         {
            _timer.stop();
         }
      }
      
      private function select(param1:int) : void
      {
         _idx = param1 - 1;
         updateGoods();
      }
      
      private function itemRender(param1:StockShopItem, param2:int) : void
      {
         var _loc3_:StockShopItem = param1 as StockShopItem;
         if(param2 < listShop.length)
         {
            _loc3_.data = listShop.array[param2];
         }
         else
         {
            _loc3_.hide();
         }
      }
      
      private function initEvent() : void
      {
         ShopManager.Instance.addEventListener("updatePersonalLimitShop",__onUpdatePersonLimitShop);
         StockMgr.inst.addEventListener("account_update",accountUpdate);
      }
      
      private function accountUpdate(param1:StockEvent = null) : void
      {
         lablLoan.text = StringHelper.parseMoneyFormat(StockMgr.inst.model.stockAccoutData.fund);
      }
      
      private function __onUpdatePersonLimitShop(param1:CEvent) : void
      {
         if(param1 && int(param1.data) == 117)
         {
            updateGoods();
         }
      }
      
      private function removeEvent() : void
      {
         ShopManager.Instance.removeEventListener("updatePersonalLimitShop",__onUpdatePersonLimitShop);
         StockMgr.inst.removeEventListener("account_update",accountUpdate);
      }
      
      private function updateGoods(param1:StockEvent = null) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Array = StockMgr.inst.model.goodsList;
         pageBar.maxPage = Math.ceil(_loc3_.length / 9);
         if(_loc3_)
         {
            _loc2_ = Math.min(_loc3_.length,9 * (_idx + 1));
            listShop.array = _loc3_.slice(_idx * 9,_loc2_);
         }
      }
      
      override public function dispose() : void
      {
         removeEvent();
         if(_timer)
         {
            _timer.removeEventListener("timer",cooldown);
         }
         _timer = null;
         super.dispose();
      }
   }
}
