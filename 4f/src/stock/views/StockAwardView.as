package stock.views{   import ddt.manager.LanguageMgr;   import ddt.manager.TimeManager;   import flash.events.TimerEvent;   import flash.utils.Timer;   import morn.core.handlers.Handler;   import road7th.utils.DateUtils;   import stock.StockMgr;   import stock.event.StockEvent;   import stock.items.StockAwardItem;   import stock.mornUI.views.StockAwardViewUI;      public class StockAwardView extends StockAwardViewUI   {                   private var _timer:Timer = null;            public function StockAwardView() { super(); }
            override protected function initialize() : void { }
            private function toArray() : Array { return null; }
            private function updateLeftTime() : void { }
            private function cooldown(event:TimerEvent) : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            private function __updateScore(evt:StockEvent) : void { }
            private function __updateStatus(evt:StockEvent) : void { }
            private function update() : void { }
            private function render(item:StockAwardItem, index:int) : void { }
            override public function dispose() : void { }
   }}