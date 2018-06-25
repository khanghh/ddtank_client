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
      
      public function StockMarketView()
      {
         super();
         initEvent();
      }
      
      override protected function initialize() : void
      {
         var i:int = 0;
         stockText1.text = LanguageMgr.GetTranslation("ddt.stock.allView.text9");
         stockText2.text = LanguageMgr.GetTranslation("ddt.stock.allView.text10");
         stockText3.text = LanguageMgr.GetTranslation("ddt.stock.allView.text11");
         stockText4.text = LanguageMgr.GetTranslation("ddt.stock.allView.text12");
         stockText5.text = LanguageMgr.GetTranslation("ddt.stock.allView.text13");
         stockText6.text = LanguageMgr.GetTranslation("ddt.stock.allView.text14");
         listAllStocks.renderHandler = new Handler(render);
         listAllStocks.selectHandler = new Handler(select);
         btnBuy.clickHandler = new Handler(buy);
         btnBuy.disabled = StockMgr.inst.model.stockBuyEndTime <= TimeManager.Instance.NowTime();
         btnSell.clickHandler = new Handler(sell);
         tabMin.selectHandler = new Handler(change);
         txtNotices.editable = false;
         _sortBtns = [btnID,btnPrice,btnChange,btnHold];
         _sortStatus = [true,true,true,true];
         _sortFields = ["StockID","price","changeValue","holdNum"];
         for(i = 0; i < _sortBtns.length; )
         {
            _sortBtns[i].clickHandler = new Handler(sort,[i]);
            i++;
         }
         _hourSp = createChart();
         var _loc2_:Boolean = false;
         _hourSp.mouseEnabled = _loc2_;
         _hourSp.mouseChildren = _loc2_;
         _daySp = createChart();
         _loc2_ = false;
         _daySp.mouseEnabled = _loc2_;
         _daySp.mouseChildren = _loc2_;
         _bg = createChart();
         _loc2_ = false;
         _bg.mouseEnabled = _loc2_;
         _bg.mouseChildren = _loc2_;
         _loc2_ = true;
         dayBg.mouseEnabled = _loc2_;
         dayBg.mouseChildren = _loc2_;
         dayBg.addEventListener("mouseOver",overHandler);
         dayBg.addEventListener("mouseOut",overHandler);
         stockAllUpdate();
      }
      
      private function sort(idx:int) : void
      {
         _sortIdx = idx;
         var status:Boolean = _sortStatus[idx];
         _sortStatus[idx] = !status;
         execRule();
         listAllStocks.selectedIndex = 0;
      }
      
      private function execRule() : void
      {
         var field:String = _sortFields[_sortIdx];
         var arr:Array = listAllStocks.array;
         arr = arr.sortOn(field,!!_sortStatus[_sortIdx]?16:16 | 2);
         listAllStocks.array = arr;
      }
      
      private function change(index:int) : void
      {
         StockMgr.inst.chooseInfoType(index);
         if(index == 0 && StockMgr.inst.checkVaildHourData())
         {
            _daySp.visible = false;
            hideHourGraphics();
         }
      }
      
      private function sell() : void
      {
         if(StockMgr.inst.model.stockID == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.selectStock"));
            return;
         }
         var frame:StockSellFrame = ComponentFactory.Instance.creatCustomObject("stock.sellFrame",[StockMgr.inst.model.stockID]);
         LayerManager.Instance.addToLayer(frame,3,false,1);
      }
      
      private function select(index:int) : void
      {
         if(!listAllStocks || !listAllStocks.array || listAllStocks.array.length <= index)
         {
            return;
         }
         StockMgr.inst.chooseStock((listAllStocks.array[index] as StockData).StockID);
         updateCurStockInfo();
         stockNewsUpdate();
      }
      
      private function updateCurStockInfo() : void
      {
         var stockData:StockData = StockMgr.inst.model.stocks[StockMgr.inst.model.stockID];
         if(stockData == null)
         {
            return;
         }
         lablStockName.text = stockData.StockName;
         var _loc2_:* = stockData.changeValue < 0?3069696:16711680;
         lablFloatBenefit.color = _loc2_;
         _loc2_ = _loc2_;
         lablStockBenefit.color = _loc2_;
         lablStockPrice.color = _loc2_;
         lablStockPrice.text = stockData.price.toString();
         lablStockBenefit.text = stockData.changeValue.toString();
         lablFloatBenefit.text = (stockData.changeValue / stockData.centerPrice * 100).toFixed(2) + "%";
      }
      
      private function buy() : void
      {
         if(StockMgr.inst.model.stockID == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.selectStock1"));
            return;
         }
         var frame:* = ComponentFactory.Instance.creatCustomObject("stock.buyFrame",[StockMgr.inst.model.stockID]);
         LayerManager.Instance.addToLayer(frame,3,false,1);
      }
      
      private function render(item:StockInfoItem, index:int) : void
      {
         if(listAllStocks.array == null || listAllStocks.array.length == 0)
         {
            return;
         }
         item.data = listAllStocks.array[index];
      }
      
      private function initEvent() : void
      {
         StockMgr.inst.addEventListener("stock_all_update",stockAllUpdate);
         StockMgr.inst.addEventListener("stock_specifics_update",stockSpecificsUpdate);
         StockMgr.inst.addEventListener("stock_user_info",stockAllUpdate);
         StockMgr.inst.addEventListener("stock_news",stockNewsUpdate);
         StockMgr.inst.addEventListener("stock_choose",stockChoose);
         StockMgr.inst.addEventListener("stock_sell_out",stockSellOut);
      }
      
      private function stockChoose(evt:StockEvent) : void
      {
         var type:int = evt.data;
         if(type == 1)
         {
            if(listAllStocks.array && listAllStocks.array.length > 0)
            {
               listAllStocks.selectedIndex = 0;
            }
         }
      }
      
      private function stockSpecificsUpdate(event:StockEvent) : void
      {
         updateChart();
         listAllStocks.array = StockMgr.inst.getStocks();
         execRule();
      }
      
      private function stockNewsUpdate(event:StockEvent = null) : void
      {
         var i:int = 0;
         txtNotices.text = "";
         var stockData:StockData = StockMgr.inst.model.stocks[StockMgr.inst.model.stockID];
         if(stockData)
         {
            for(i = stockData.notices.length - 1; i >= 0; )
            {
               txtNotices.appendText(stockData.notices[i].content);
               i--;
            }
         }
      }
      
      private function stockAllUpdate(event:StockEvent = null) : void
      {
         listAllStocks.array = StockMgr.inst.getStocks();
         execRule();
         updateCurStockInfo();
         stockNewsUpdate();
         if(StockMgr.inst.model.stockID == 0)
         {
            listAllStocks.selectedIndex = 0;
            tabMin.selectedIndex = 0;
         }
      }
      
      private function removeEvent() : void
      {
         StockMgr.inst.removeEventListener("stock_all_update",stockAllUpdate);
         StockMgr.inst.removeEventListener("stock_specifics_update",stockSpecificsUpdate);
         StockMgr.inst.removeEventListener("stock_news",stockNewsUpdate);
         StockMgr.inst.removeEventListener("stock_user_info",stockAllUpdate);
         StockMgr.inst.removeEventListener("stock_choose",stockChoose);
         StockMgr.inst.removeEventListener("stock_sell_out",stockSellOut);
         dayBg.removeEventListener("mouseOver",overHandler);
         dayBg.removeEventListener("mouseOut",overHandler);
      }
      
      private function stockSellOut(evt:StockEvent) : void
      {
         if(listAllStocks.array && listAllStocks.array.length > 0)
         {
            listAllStocks.selectedIndex = 0;
         }
      }
      
      private function overHandler(event:MouseEvent) : void
      {
         var isOver:* = event.type == "mouseOver";
         if(StockMgr.inst.infoType == 0)
         {
            return;
         }
         if(!isOver)
         {
            _timer.stop();
            _bg.graphics.clear();
            _detailInfo.visible = false;
            return;
         }
         updateDetail(event.localX,event.localY);
         if(!_timer)
         {
            _timer = new Timer(100);
            _timer.addEventListener("timer",update);
         }
         _timer.start();
      }
      
      private function update(evt:TimerEvent) : void
      {
         var x:Number = dayBg.mouseX - dayBg.x;
         var y:Number = dayBg.mouseY - dayBg.y;
         updateDetail(x,y);
      }
      
      private function updateDetail(x:Number, y:Number) : void
      {
         if(!_detailInfo)
         {
            _detailInfo = new StockDetailInfoItem();
            _daySp.addChild(_detailInfo);
         }
         if(!checkValid(x))
         {
            _detailInfo.visible = false;
            _bg.graphics.clear();
            return;
         }
         PositionUtils.setPos(_detailInfo,{
            "x":x,
            "y":0
         });
         _detailInfo.data = getPointInfo(_detailInfo.x);
         _detailInfo.visible = false;
         _bg.graphics.clear();
         _bg.graphics.lineStyle(0.5,16777215,0.6);
         _bg.graphics.moveTo(x,0);
         _bg.graphics.lineTo(x,282);
         _bg.graphics.moveTo(0,y);
         _bg.graphics.lineTo(463,y);
      }
      
      private function getPointInfo(posX:Number) : *
      {
         var rate:Number = posX / 463;
         var time:Number = rate * 6 * StockMgr.inst.model.dayHours * 3600;
         var date:Date = new Date(StockMgr.inst.model.dayGrahpicStartDate + time * 1000);
         var timeStr:String = LanguageMgr.GetTranslation("stock.detailInfoTime",date.getHours() < 10?"0" + date.getHours():date.getHours(),date.getMinutes() < 10?"0" + date.getMinutes():date.getMinutes());
         var priceStr:String = getPrice(posX).toString();
         return {
            "timeStr":timeStr,
            "dealPrice":priceStr
         };
      }
      
      private function getPrice(pos:Number) : int
      {
         var leftPoint:* = null;
         var rightPoint:* = null;
         var tmpPoint:* = null;
         var i:int = 0;
         var stockData:StockData = StockMgr.inst.model.stocks[StockMgr.inst.model.stockID];
         if(stockData && stockData.dailyPoints.length > 0)
         {
            leftPoint = stockData.dailyPoints[0];
            rightPoint = leftPoint;
            tmpPoint = null;
            for(i = 0; i < stockData.dailyPoints.length; )
            {
               tmpPoint = stockData.dailyPoints[i];
               if(tmpPoint.dayPoint.x < pos)
               {
                  leftPoint = tmpPoint;
               }
               if(tmpPoint.dayPoint.x >= pos)
               {
                  rightPoint = tmpPoint;
                  break;
               }
               i++;
            }
            return leftPoint.dealPrice + (rightPoint.dealPrice - leftPoint.dealPrice) / (rightPoint.dayPoint.x - leftPoint.dayPoint.x) * (pos - leftPoint.dayPoint.x);
         }
         return 0;
      }
      
      private function checkValid(pos:Number) : Boolean
      {
         var stockData:StockData = StockMgr.inst.model.stocks[StockMgr.inst.model.stockID];
         if(stockData && stockData.dailyPoints.length > 0)
         {
            return pos <= stockData.dailyPoints[stockData.dailyPoints.length - 1].dayPoint.x;
         }
         return false;
      }
      
      override public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_daySp);
         _daySp = null;
         ObjectUtils.disposeObject(_hourSp);
         _hourSp = null;
         ObjectUtils.disposeObject(_bg);
         _hourSp = null;
         if(_timer)
         {
            _timer.removeEventListener("timer",update);
            _timer = null;
         }
         super.dispose();
      }
      
      private function updateChart() : void
      {
         var point:* = null;
         var i:int = 0;
         var durationValue:Number = NaN;
         var upLabels:* = undefined;
         var downLabels:* = undefined;
         var xLabels:* = undefined;
         var centerPrice:int = 0;
         var xDuration:Number = NaN;
         var cnt:int = 0;
         var time:Number = NaN;
         var date:* = null;
         var stockData:StockData = StockMgr.inst.model.stocks[StockMgr.inst.model.stockID];
         if(stockData)
         {
            point = null;
            i = 0;
            if(StockMgr.inst.infoType == 0)
            {
               if(StockMgr.inst.checkVaildHourData())
               {
                  hideHourGraphics();
                  return;
               }
               _hourSp.visible = true;
               _daySp.visible = false;
               _hourSp.graphics.clear();
               _hourSp.graphics.lineStyle(1,16777215);
               _hourSp.graphics.moveTo(0,282 / 2);
               for(i = 0; i < stockData.hourPoints.length; )
               {
                  parsePoint(stockData.hourPoints[i]);
                  _hourSp.graphics.lineTo(stockData.hourPoints[i].hourPoint.x,stockData.hourPoints[i].hourPoint.y);
                  i++;
               }
            }
            else if(StockMgr.inst.infoType == 1)
            {
               _daySp.visible = true;
               _hourSp.visible = false;
               _daySp.graphics.clear();
               _daySp.graphics.lineStyle(1,16777215);
               _daySp.graphics.moveTo(0,282 / 2);
               for(i = 0; i < stockData.dailyPoints.length; )
               {
                  parsePoint(stockData.dailyPoints[i]);
                  _daySp.graphics.lineTo(stockData.dailyPoints[i].dayPoint.x,stockData.dailyPoints[i].dayPoint.y);
                  i++;
               }
            }
            durationValue = stockData.diffValue / 7;
            upLabels = new <Label>[lablUp1,lablUp2,lablUp3,lablUp4,lablUp5,lablUp6,lablUp7];
            downLabels = new <Label>[lablDown1,lablDown2,lablDown3,lablDown4,lablDown5,lablDown6,lablDown7];
            xLabels = new <Label>[lablTime1,lablTime2,lablTime3,lablTime4,lablTime5,lablTime6,lablTime7];
            centerPrice = StockMgr.inst.infoType == 1?stockData.dayCenterPrice:int(stockData.centerPrice);
            lablUp0.text = centerPrice.toString();
            lablUp0.visible = true;
            for(i = 0; i < 7; )
            {
               var _loc13_:Boolean = true;
               downLabels[i].visible = _loc13_;
               upLabels[i].visible = _loc13_;
               upLabels[i].text = (centerPrice + int(durationValue * (i + 1))).toString();
               downLabels[i].text = (centerPrice - int(durationValue * (i + 1))).toString();
               i++;
            }
            cnt = Math.max(1,7 - 1);
            if(StockMgr.inst.infoType == 0)
            {
               time = Math.abs(StockMgr.inst.model.endTime - StockMgr.inst.model.startTime);
               xDuration = time / cnt;
            }
            else
            {
               xDuration = 6 / cnt;
            }
            date = null;
            for(i = 0; i < 7; )
            {
               xLabels[i].visible = true;
               if(StockMgr.inst.infoType == 0)
               {
                  xLabels[i].text = LanguageMgr.GetTranslation("stock.xTime",StockMgr.inst.model.startTime + xDuration * i);
               }
               else
               {
                  date = new Date(StockMgr.inst.model.dayGrahpicStartDate + xDuration * i * 24 * 3600 * 1000);
                  xLabels[i].text = LanguageMgr.GetTranslation("stock.xTime1",date.month + 1,date.date);
               }
               i++;
            }
         }
      }
      
      private function hideHourGraphics() : void
      {
         _hourSp.visible = false;
         var upLabels:Vector.<Label> = new <Label>[lablUp1,lablUp2,lablUp3,lablUp4,lablUp5,lablUp6,lablUp7];
         var downLabels:Vector.<Label> = new <Label>[lablDown1,lablDown2,lablDown3,lablDown4,lablDown5,lablDown6,lablDown7];
         var xLabels:Vector.<Label> = new <Label>[lablTime1,lablTime2,lablTime3,lablTime4,lablTime5,lablTime6,lablTime7];
         var i:int = 0;
         for(i = 0; i < 7; )
         {
            var _loc5_:Boolean = false;
            downLabels[i].visible = _loc5_;
            upLabels[i].visible = _loc5_;
            i++;
         }
         lablUp0.visible = false;
         for(i = 0; i < 7; )
         {
            xLabels[i].visible = false;
            i++;
         }
      }
      
      private function createChart() : Sprite
      {
         var sp:Sprite = new Sprite();
         addChild(sp);
         PositionUtils.setPos(sp,{
            "x":378,
            "y":119
         });
         return sp;
      }
      
      private function parsePoint(value:StockPointData) : void
      {
         var timeDuration:* = NaN;
         var rate:* = NaN;
         var centerPrice:int = 0;
         var point:Point = new Point();
         var stockData:StockData = StockMgr.inst.model.stocks[StockMgr.inst.model.stockID];
         if(stockData)
         {
            timeDuration = 0;
            rate = 0;
            if(StockMgr.inst.infoType == 0)
            {
               timeDuration = Number(StockMgr.inst.model.endTime - StockMgr.inst.model.startTime);
               rate = Number((value.time - StockMgr.inst.model.startTime * 3600) / (timeDuration * 3600));
            }
            else
            {
               timeDuration = Number(6 * StockMgr.inst.model.dayHours * 60 * 60);
               rate = Number(value.timeIndex / (26 * 6));
            }
            point.x = rate * 463;
            centerPrice = StockMgr.inst.infoType == 1?stockData.dayCenterPrice:int(stockData.centerPrice);
            rate = Number((value.dealPrice - centerPrice) / stockData.diffValue);
            point.y = 282 / 2 - rate * (282 / 2);
         }
         if(StockMgr.inst.infoType == 0)
         {
            value.hourPoint = point;
         }
         else if(StockMgr.inst.infoType == 1)
         {
            value.dayPoint = point;
         }
      }
   }
}
