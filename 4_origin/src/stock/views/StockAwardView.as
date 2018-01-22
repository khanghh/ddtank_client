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
         var _loc2_:int = 0;
         var _loc1_:Array = [];
         _loc2_ = 0;
         while(StockMgr.inst.model.exchangedList && _loc2_ < StockMgr.inst.model.exchangedList.length)
         {
            _loc1_.push(StockMgr.inst.model.exchangedList[_loc2_]);
            _loc2_++;
         }
         return _loc1_;
      }
      
      private function updateLeftTime() : void
      {
         var _loc1_:Number = StockMgr.inst.model.shopCloseTime;
         var _loc2_:Number = TimeManager.Instance.NowTime();
         var _loc3_:Array = DateUtils.dateTimeRemainArr(Math.max(0,(StockMgr.inst.model.shopCloseTime - TimeManager.Instance.NowTime()) / 1000));
         lablTime.text = LanguageMgr.GetTranslation("stock.award.time",_loc3_[0],_loc3_[1] < 10?"0" + _loc3_[1]:_loc3_[1],_loc3_[2] < 10?"0" + _loc3_[2]:_loc3_[2],_loc3_[3] < 10?"0" + _loc3_[3]:_loc3_[3]);
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
         lablTime.text = LanguageMgr.GetTranslation("stock.award.time",_loc3_[0],_loc3_[1] < 10?"0" + _loc3_[1]:_loc3_[1],_loc3_[2] < 10?"0" + _loc3_[2]:_loc3_[2],_loc3_[3] < 10?"0" + _loc3_[3]:_loc3_[3]);
         if(_loc2_ < 0)
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
      
      private function __updateScore(param1:StockEvent) : void
      {
         update();
      }
      
      private function __updateStatus(param1:StockEvent) : void
      {
         update();
      }
      
      private function update() : void
      {
         lablScore.text = StockMgr.inst.model.myScore.toString();
         awardList.array = toArray();
      }
      
      private function render(param1:StockAwardItem, param2:int) : void
      {
         if(awardList.array == null || awardList.array.length == 0)
         {
            return;
         }
         param1.data = awardList.array[param2];
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
