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
         var closeTime:Number = StockMgr.inst.model.shopCloseTime;
         var serverTime:Number = TimeManager.Instance.NowTime();
         var dateArr:Array = DateUtils.dateTimeRemainArr(Math.max(0,(StockMgr.inst.model.shopCloseTime - TimeManager.Instance.NowTime()) / 1000));
         lablTime.text = LanguageMgr.GetTranslation("stock.shopEndTime",dateArr[0],dateArr[1] < 10?"0" + dateArr[1]:dateArr[1],dateArr[2] < 10?"0" + dateArr[2]:dateArr[2],dateArr[3] < 10?"0" + dateArr[3]:dateArr[3]);
         if(!_timer)
         {
            _timer = new Timer(1000);
            _timer.addEventListener("timer",cooldown);
            _timer.start();
         }
      }
      
      private function cooldown(event:TimerEvent) : void
      {
         var durationTime:int = StockMgr.inst.model.shopCloseTime - TimeManager.Instance.NowTime();
         var dateArr:Array = DateUtils.dateTimeRemainArr(Math.max(0,(StockMgr.inst.model.shopCloseTime - TimeManager.Instance.NowTime()) / 1000));
         lablTime.text = LanguageMgr.GetTranslation("stock.shopEndTime",dateArr[0],dateArr[1] < 10?"0" + dateArr[1]:dateArr[1],dateArr[2] < 10?"0" + dateArr[2]:dateArr[2],dateArr[3] < 10?"0" + dateArr[3]:dateArr[3]);
         if(durationTime < 0)
         {
            _timer.stop();
         }
      }
      
      private function select(currentPage:int) : void
      {
         _idx = currentPage - 1;
         updateGoods();
      }
      
      private function itemRender(item:StockShopItem, index:int) : void
      {
         var render:StockShopItem = item as StockShopItem;
         if(index < listShop.length)
         {
            render.data = listShop.array[index];
         }
         else
         {
            render.hide();
         }
      }
      
      private function initEvent() : void
      {
         ShopManager.Instance.addEventListener("updatePersonalLimitShop",__onUpdatePersonLimitShop);
         StockMgr.inst.addEventListener("account_update",accountUpdate);
      }
      
      private function accountUpdate(evt:StockEvent = null) : void
      {
         lablLoan.text = StringHelper.parseMoneyFormat(StockMgr.inst.model.stockAccoutData.fund);
      }
      
      private function __onUpdatePersonLimitShop(event:CEvent) : void
      {
         if(event && int(event.data) == 117)
         {
            updateGoods();
         }
      }
      
      private function removeEvent() : void
      {
         ShopManager.Instance.removeEventListener("updatePersonalLimitShop",__onUpdatePersonLimitShop);
         StockMgr.inst.removeEventListener("account_update",accountUpdate);
      }
      
      private function updateGoods(evt:StockEvent = null) : void
      {
         var endIdx:int = 0;
         var goods:Array = StockMgr.inst.model.goodsList;
         pageBar.maxPage = Math.ceil(goods.length / 9);
         if(goods)
         {
            endIdx = Math.min(goods.length,9 * (_idx + 1));
            listShop.array = goods.slice(_idx * 9,endIdx);
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
