package stock.views
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.TimeManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.geom.Point;
   import flash.utils.Timer;
   import morn.core.components.Label;
   import morn.core.handlers.Handler;
   import stock.StockMgr;
   import stock.data.StockData;
   import stock.data.StockPointData;
   import stock.event.StockEvent;
   import stock.items.StockDetailInfoItem;
   import stock.items.StockInfoItem;
   import stock.mornUI.views.StockMarketViewUI;
   
   public class StockMarketView extends StockMarketViewUI
   {
      
      private static const _WIDTH:Number = 463;
      
      private static const _HEIGHT:Number = 282;
      
      private static const _Y_CNT:int = 7;
      
      private static const _X_CNT:int = 7;
       
      
      private var _hourSp:Sprite = null;
      
      private var _daySp:Sprite = null;
      
      private var _bg:Sprite = null;
      
      private var _detailInfo:StockDetailInfoItem = null;
      
      private var _timer:Timer = null;
      
      private var _sortBtns:Array = null;
      
      private var _sortStatus:Array = null;
      
      private var _sortFields:Array = null;
      
      private var _sortIdx:int = 0;
      
      public function StockMarketView(){super();}
      
      override protected function initialize() : void{}
      
      private function sort(param1:int) : void{}
      
      private function execRule() : void{}
      
      private function change(param1:int) : void{}
      
      private function sell() : void{}
      
      private function select(param1:int) : void{}
      
      private function updateCurStockInfo() : void{}
      
      private function buy() : void{}
      
      private function render(param1:StockInfoItem, param2:int) : void{}
      
      private function initEvent() : void{}
      
      private function stockChoose(param1:StockEvent) : void{}
      
      private function stockSpecificsUpdate(param1:StockEvent) : void{}
      
      private function stockNewsUpdate(param1:StockEvent = null) : void{}
      
      private function stockAllUpdate(param1:StockEvent = null) : void{}
      
      private function removeEvent() : void{}
      
      private function stockSellOut(param1:StockEvent) : void{}
      
      private function overHandler(param1:MouseEvent) : void{}
      
      private function update(param1:TimerEvent) : void{}
      
      private function updateDetail(param1:Number, param2:Number) : void{}
      
      private function getPointInfo(param1:Number) : *{return null;}
      
      private function getPrice(param1:Number) : int{return 0;}
      
      private function checkValid(param1:Number) : Boolean{return false;}
      
      override public function dispose() : void{}
      
      private function updateChart() : void{}
      
      private function hideHourGraphics() : void{}
      
      private function createChart() : Sprite{return null;}
      
      private function parsePoint(param1:StockPointData) : void{}
   }
}
