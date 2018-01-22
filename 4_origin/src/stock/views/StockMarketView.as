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
         var _loc1_:int = 0;
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
         _loc1_ = 0;
         while(_loc1_ < _sortBtns.length)
         {
            _sortBtns[_loc1_].clickHandler = new Handler(sort,[_loc1_]);
            _loc1_++;
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
      
      private function sort(param1:int) : void
      {
         _sortIdx = param1;
         var _loc2_:Boolean = _sortStatus[param1];
         _sortStatus[param1] = !_loc2_;
         execRule();
         listAllStocks.selectedIndex = 0;
      }
      
      private function execRule() : void
      {
         var _loc1_:String = _sortFields[_sortIdx];
         var _loc2_:Array = listAllStocks.array;
         _loc2_ = _loc2_.sortOn(_loc1_,!!_sortStatus[_sortIdx]?16:16 | 2);
         listAllStocks.array = _loc2_;
      }
      
      private function change(param1:int) : void
      {
         StockMgr.inst.chooseInfoType(param1);
         if(param1 == 0 && StockMgr.inst.checkVaildHourData())
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
         var _loc1_:StockSellFrame = ComponentFactory.Instance.creatCustomObject("stock.sellFrame",[StockMgr.inst.model.stockID]);
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
      
      private function select(param1:int) : void
      {
         if(!listAllStocks || !listAllStocks.array || listAllStocks.array.length <= param1)
         {
            return;
         }
         StockMgr.inst.chooseStock((listAllStocks.array[param1] as StockData).StockID);
         updateCurStockInfo();
         stockNewsUpdate();
      }
      
      private function updateCurStockInfo() : void
      {
         var _loc1_:StockData = StockMgr.inst.model.stocks[StockMgr.inst.model.stockID];
         if(_loc1_ == null)
         {
            return;
         }
         lablStockName.text = _loc1_.StockName;
         var _loc2_:* = _loc1_.changeValue < 0?3069696:16711680;
         lablFloatBenefit.color = _loc2_;
         _loc2_ = _loc2_;
         lablStockBenefit.color = _loc2_;
         lablStockPrice.color = _loc2_;
         lablStockPrice.text = _loc1_.price.toString();
         lablStockBenefit.text = _loc1_.changeValue.toString();
         lablFloatBenefit.text = (_loc1_.changeValue / _loc1_.centerPrice * 100).toFixed(2) + "%";
      }
      
      private function buy() : void
      {
         if(StockMgr.inst.model.stockID == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.selectStock1"));
            return;
         }
         var _loc1_:* = ComponentFactory.Instance.creatCustomObject("stock.buyFrame",[StockMgr.inst.model.stockID]);
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
      
      private function render(param1:StockInfoItem, param2:int) : void
      {
         if(listAllStocks.array == null || listAllStocks.array.length == 0)
         {
            return;
         }
         param1.data = listAllStocks.array[param2];
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
      
      private function stockChoose(param1:StockEvent) : void
      {
         var _loc2_:int = param1.data;
         if(_loc2_ == 1)
         {
            if(listAllStocks.array && listAllStocks.array.length > 0)
            {
               listAllStocks.selectedIndex = 0;
            }
         }
      }
      
      private function stockSpecificsUpdate(param1:StockEvent) : void
      {
         updateChart();
         listAllStocks.array = StockMgr.inst.getStocks();
         execRule();
      }
      
      private function stockNewsUpdate(param1:StockEvent = null) : void
      {
         var _loc3_:int = 0;
         txtNotices.text = "";
         var _loc2_:StockData = StockMgr.inst.model.stocks[StockMgr.inst.model.stockID];
         if(_loc2_)
         {
            _loc3_ = _loc2_.notices.length - 1;
            while(_loc3_ >= 0)
            {
               txtNotices.appendText(_loc2_.notices[_loc3_].content);
               _loc3_--;
            }
         }
      }
      
      private function stockAllUpdate(param1:StockEvent = null) : void
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
      
      private function stockSellOut(param1:StockEvent) : void
      {
         if(listAllStocks.array && listAllStocks.array.length > 0)
         {
            listAllStocks.selectedIndex = 0;
         }
      }
      
      private function overHandler(param1:MouseEvent) : void
      {
         var _loc2_:* = param1.type == "mouseOver";
         if(StockMgr.inst.infoType == 0)
         {
            return;
         }
         if(!_loc2_)
         {
            _timer.stop();
            _bg.graphics.clear();
            _detailInfo.visible = false;
            return;
         }
         updateDetail(param1.localX,param1.localY);
         if(!_timer)
         {
            _timer = new Timer(100);
            _timer.addEventListener("timer",update);
         }
         _timer.start();
      }
      
      private function update(param1:TimerEvent) : void
      {
         var _loc3_:Number = dayBg.mouseX - dayBg.x;
         var _loc2_:Number = dayBg.mouseY - dayBg.y;
         updateDetail(_loc3_,_loc2_);
      }
      
      private function updateDetail(param1:Number, param2:Number) : void
      {
         if(!_detailInfo)
         {
            _detailInfo = new StockDetailInfoItem();
            _daySp.addChild(_detailInfo);
         }
         if(!checkValid(param1))
         {
            _detailInfo.visible = false;
            _bg.graphics.clear();
            return;
         }
         PositionUtils.setPos(_detailInfo,{
            "x":param1,
            "y":0
         });
         _detailInfo.data = getPointInfo(_detailInfo.x);
         _detailInfo.visible = false;
         _bg.graphics.clear();
         _bg.graphics.lineStyle(0.5,16777215,0.6);
         _bg.graphics.moveTo(param1,0);
         _bg.graphics.lineTo(param1,282);
         _bg.graphics.moveTo(0,param2);
         _bg.graphics.lineTo(463,param2);
      }
      
      private function getPointInfo(param1:Number) : *
      {
         var _loc4_:Number = param1 / 463;
         var _loc3_:Number = _loc4_ * 6 * StockMgr.inst.model.dayHours * 3600;
         var _loc6_:Date = new Date(StockMgr.inst.model.dayGrahpicStartDate + _loc3_ * 1000);
         var _loc5_:String = LanguageMgr.GetTranslation("stock.detailInfoTime",_loc6_.getHours() < 10?"0" + _loc6_.getHours():_loc6_.getHours(),_loc6_.getMinutes() < 10?"0" + _loc6_.getMinutes():_loc6_.getMinutes());
         var _loc2_:String = getPrice(param1).toString();
         return {
            "timeStr":_loc5_,
            "dealPrice":_loc2_
         };
      }
      
      private function getPrice(param1:Number) : int
      {
         var _loc3_:* = null;
         var _loc5_:* = null;
         var _loc2_:* = null;
         var _loc6_:int = 0;
         var _loc4_:StockData = StockMgr.inst.model.stocks[StockMgr.inst.model.stockID];
         if(_loc4_ && _loc4_.dailyPoints.length > 0)
         {
            _loc3_ = _loc4_.dailyPoints[0];
            _loc5_ = _loc3_;
            _loc2_ = null;
            _loc6_ = 0;
            while(_loc6_ < _loc4_.dailyPoints.length)
            {
               _loc2_ = _loc4_.dailyPoints[_loc6_];
               if(_loc2_.dayPoint.x < param1)
               {
                  _loc3_ = _loc2_;
               }
               if(_loc2_.dayPoint.x >= param1)
               {
                  _loc5_ = _loc2_;
                  break;
               }
               _loc6_++;
            }
            return _loc3_.dealPrice + (_loc5_.dealPrice - _loc3_.dealPrice) / (_loc5_.dayPoint.x - _loc3_.dayPoint.x) * (param1 - _loc3_.dayPoint.x);
         }
         return 0;
      }
      
      private function checkValid(param1:Number) : Boolean
      {
         var _loc2_:StockData = StockMgr.inst.model.stocks[StockMgr.inst.model.stockID];
         if(_loc2_ && _loc2_.dailyPoints.length > 0)
         {
            return param1 <= _loc2_.dailyPoints[_loc2_.dailyPoints.length - 1].dayPoint.x;
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
         var _loc1_:* = null;
         var _loc12_:int = 0;
         var _loc11_:Number = NaN;
         var _loc10_:* = undefined;
         var _loc4_:* = undefined;
         var _loc6_:* = undefined;
         var _loc3_:int = 0;
         var _loc7_:Number = NaN;
         var _loc5_:int = 0;
         var _loc2_:Number = NaN;
         var _loc9_:* = null;
         var _loc8_:StockData = StockMgr.inst.model.stocks[StockMgr.inst.model.stockID];
         if(_loc8_)
         {
            _loc1_ = null;
            _loc12_ = 0;
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
               _loc12_ = 0;
               while(_loc12_ < _loc8_.hourPoints.length)
               {
                  parsePoint(_loc8_.hourPoints[_loc12_]);
                  _hourSp.graphics.lineTo(_loc8_.hourPoints[_loc12_].hourPoint.x,_loc8_.hourPoints[_loc12_].hourPoint.y);
                  _loc12_++;
               }
            }
            else if(StockMgr.inst.infoType == 1)
            {
               _daySp.visible = true;
               _hourSp.visible = false;
               _daySp.graphics.clear();
               _daySp.graphics.lineStyle(1,16777215);
               _daySp.graphics.moveTo(0,282 / 2);
               _loc12_ = 0;
               while(_loc12_ < _loc8_.dailyPoints.length)
               {
                  parsePoint(_loc8_.dailyPoints[_loc12_]);
                  _daySp.graphics.lineTo(_loc8_.dailyPoints[_loc12_].dayPoint.x,_loc8_.dailyPoints[_loc12_].dayPoint.y);
                  _loc12_++;
               }
            }
            _loc11_ = _loc8_.diffValue / 7;
            _loc10_ = new <Label>[lablUp1,lablUp2,lablUp3,lablUp4,lablUp5,lablUp6,lablUp7];
            _loc4_ = new <Label>[lablDown1,lablDown2,lablDown3,lablDown4,lablDown5,lablDown6,lablDown7];
            _loc6_ = new <Label>[lablTime1,lablTime2,lablTime3,lablTime4,lablTime5,lablTime6,lablTime7];
            _loc3_ = StockMgr.inst.infoType == 1?_loc8_.dayCenterPrice:int(_loc8_.centerPrice);
            lablUp0.text = _loc3_.toString();
            lablUp0.visible = true;
            _loc12_ = 0;
            while(_loc12_ < 7)
            {
               var _loc13_:Boolean = true;
               _loc4_[_loc12_].visible = _loc13_;
               _loc10_[_loc12_].visible = _loc13_;
               _loc10_[_loc12_].text = (_loc3_ + int(_loc11_ * (_loc12_ + 1))).toString();
               _loc4_[_loc12_].text = (_loc3_ - int(_loc11_ * (_loc12_ + 1))).toString();
               _loc12_++;
            }
            _loc5_ = Math.max(1,7 - 1);
            if(StockMgr.inst.infoType == 0)
            {
               _loc2_ = Math.abs(StockMgr.inst.model.endTime - StockMgr.inst.model.startTime);
               _loc7_ = _loc2_ / _loc5_;
            }
            else
            {
               _loc7_ = 6 / _loc5_;
            }
            _loc9_ = null;
            _loc12_ = 0;
            while(_loc12_ < 7)
            {
               _loc6_[_loc12_].visible = true;
               if(StockMgr.inst.infoType == 0)
               {
                  _loc6_[_loc12_].text = LanguageMgr.GetTranslation("stock.xTime",StockMgr.inst.model.startTime + _loc7_ * _loc12_);
               }
               else
               {
                  _loc9_ = new Date(StockMgr.inst.model.dayGrahpicStartDate + _loc7_ * _loc12_ * 24 * 3600 * 1000);
                  _loc6_[_loc12_].text = LanguageMgr.GetTranslation("stock.xTime1",_loc9_.month + 1,_loc9_.date);
               }
               _loc12_++;
            }
         }
      }
      
      private function hideHourGraphics() : void
      {
         _hourSp.visible = false;
         var _loc3_:Vector.<Label> = new <Label>[lablUp1,lablUp2,lablUp3,lablUp4,lablUp5,lablUp6,lablUp7];
         var _loc1_:Vector.<Label> = new <Label>[lablDown1,lablDown2,lablDown3,lablDown4,lablDown5,lablDown6,lablDown7];
         var _loc2_:Vector.<Label> = new <Label>[lablTime1,lablTime2,lablTime3,lablTime4,lablTime5,lablTime6,lablTime7];
         var _loc4_:int = 0;
         _loc4_ = 0;
         while(_loc4_ < 7)
         {
            var _loc5_:Boolean = false;
            _loc1_[_loc4_].visible = _loc5_;
            _loc3_[_loc4_].visible = _loc5_;
            _loc4_++;
         }
         lablUp0.visible = false;
         _loc4_ = 0;
         while(_loc4_ < 7)
         {
            _loc2_[_loc4_].visible = false;
            _loc4_++;
         }
      }
      
      private function createChart() : Sprite
      {
         var _loc1_:Sprite = new Sprite();
         addChild(_loc1_);
         PositionUtils.setPos(_loc1_,{
            "x":378,
            "y":119
         });
         return _loc1_;
      }
      
      private function parsePoint(param1:StockPointData) : void
      {
         var _loc5_:* = NaN;
         var _loc4_:* = NaN;
         var _loc3_:int = 0;
         var _loc2_:Point = new Point();
         var _loc6_:StockData = StockMgr.inst.model.stocks[StockMgr.inst.model.stockID];
         if(_loc6_)
         {
            _loc5_ = 0;
            _loc4_ = 0;
            if(StockMgr.inst.infoType == 0)
            {
               _loc5_ = Number(StockMgr.inst.model.endTime - StockMgr.inst.model.startTime);
               _loc4_ = Number((param1.time - StockMgr.inst.model.startTime * 3600) / (_loc5_ * 3600));
            }
            else
            {
               _loc5_ = Number(6 * StockMgr.inst.model.dayHours * 60 * 60);
               _loc4_ = Number(param1.timeIndex / (26 * 6));
            }
            _loc2_.x = _loc4_ * 463;
            _loc3_ = StockMgr.inst.infoType == 1?_loc6_.dayCenterPrice:int(_loc6_.centerPrice);
            _loc4_ = Number((param1.dealPrice - _loc3_) / _loc6_.diffValue);
            _loc2_.y = 282 / 2 - _loc4_ * (282 / 2);
         }
         if(StockMgr.inst.infoType == 0)
         {
            param1.hourPoint = _loc2_;
         }
         else if(StockMgr.inst.infoType == 1)
         {
            param1.dayPoint = _loc2_;
         }
      }
   }
}
