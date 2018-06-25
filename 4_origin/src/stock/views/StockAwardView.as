package stock.views
{
   import ddt.manager.LanguageMgr;
   import ddt.manager.TimeManager;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import morn.core.handlers.Handler;
   import road7th.utils.DateUtils;
   import stock.StockMgr;
   import stock.event.StockEvent;
   import stock.items.StockAwardItem;
   import stock.mornUI.views.StockAwardViewUI;
   
   public class StockAwardView extends StockAwardViewUI
   {
       
      
      private var _timer:Timer = null;
      
      public function StockAwardView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         lablDesc.text = LanguageMgr.GetTranslation("stock.award.des");
         awardList.renderHandler = new Handler(render);
         updateLeftTime();
         addEvent();
         awardList.array = toArray();
      }
      
      private function toArray() : Array
      {
         var i:int = 0;
         var tmp:Array = [];
         i = 0;
         while(StockMgr.inst.model.exchangedList && i < StockMgr.inst.model.exchangedList.length)
         {
            tmp.push(StockMgr.inst.model.exchangedList[i]);
            i++;
         }
         return tmp;
      }
      
      private function updateLeftTime() : void
      {
         var closeTime:Number = StockMgr.inst.model.shopCloseTime;
         var serverTime:Number = TimeManager.Instance.NowTime();
         var dateArr:Array = DateUtils.dateTimeRemainArr(Math.max(0,(StockMgr.inst.model.shopCloseTime - TimeManager.Instance.NowTime()) / 1000));
         lablTime.text = LanguageMgr.GetTranslation("stock.award.time",dateArr[0],dateArr[1] < 10?"0" + dateArr[1]:dateArr[1],dateArr[2] < 10?"0" + dateArr[2]:dateArr[2],dateArr[3] < 10?"0" + dateArr[3]:dateArr[3]);
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
         lablTime.text = LanguageMgr.GetTranslation("stock.award.time",dateArr[0],dateArr[1] < 10?"0" + dateArr[1]:dateArr[1],dateArr[2] < 10?"0" + dateArr[2]:dateArr[2],dateArr[3] < 10?"0" + dateArr[3]:dateArr[3]);
         if(durationTime < 0)
         {
            _timer.stop();
         }
      }
      
      private function addEvent() : void
      {
         StockMgr.inst.addEventListener("stock_update_score",__updateScore);
         StockMgr.inst.addEventListener("stock_exchange_award",__updateStatus);
      }
      
      private function removeEvent() : void
      {
         StockMgr.inst.removeEventListener("stock_update_score",__updateScore);
         StockMgr.inst.removeEventListener("stock_exchange_award",__updateStatus);
      }
      
      private function __updateScore(evt:StockEvent) : void
      {
         update();
      }
      
      private function __updateStatus(evt:StockEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         lablScore.text = StockMgr.inst.model.myScore.toString();
         awardList.array = toArray();
      }
      
      private function render(item:StockAwardItem, index:int) : void
      {
         if(awardList.array == null || awardList.array.length == 0)
         {
            return;
         }
         item.data = awardList.array[index];
      }
      
      override public function dispose() : void
      {
         super.dispose();
         removeEvent();
         if(_timer)
         {
            _timer.removeEventListener("timer",cooldown);
         }
         _timer = null;
      }
   }
}
