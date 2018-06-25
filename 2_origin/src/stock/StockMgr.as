package stock
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.BaseButton;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ServerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import hall.HallStateView;
   import hallIcon.HallIconManager;
   import stock.data.StockAwardData;
   import stock.data.StockData;
   import stock.data.StockModel;
   import stock.data.StockNewsData;
   import stock.data.StockPointData;
   import stock.event.StockEvent;
   
   public final class StockMgr extends EventDispatcher
   {
      
      private static var _inst:StockMgr = null;
       
      
      private var _model:StockModel = null;
      
      private var _operationType:int = 0;
      
      private var _infoType:int = -1;
      
      private var _hall:HallStateView = null;
      
      private var _stockIcon:BaseButton = null;
      
      private var _hasServerStockData:Boolean = false;
      
      public function StockMgr(single:SingleTon)
      {
         super();
         if(!single)
         {
            throw new Error("this is a single instance!");
         }
         initialize();
      }
      
      public static function get inst() : StockMgr
      {
         if(!_inst)
         {
            _inst = new StockMgr(new SingleTon());
         }
         return _inst;
      }
      
      private function initialize() : void
      {
         _model = new StockModel();
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(411,1),__responseAllStockInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(411,6),__responseUserAccountInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(411,5),__resposeDealStockOrFund);
         SocketManager.Instance.addEventListener(PkgEvent.format(411,3),__resposeStockSpecific);
         SocketManager.Instance.addEventListener(PkgEvent.format(411,7),__responseUserStockInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(411,4),__responseStockNews);
         SocketManager.Instance.addEventListener(PkgEvent.format(411,8),__responseStockOpenStatus);
         SocketManager.Instance.addEventListener(PkgEvent.format(411,9),__responseStockMarketValue);
         SocketManager.Instance.addEventListener(PkgEvent.format(411,16),__responseStockTradeMessage);
         SocketManager.Instance.addEventListener(PkgEvent.format(411,18),__responseExchangeAward);
         SocketManager.Instance.addEventListener(PkgEvent.format(411,19),__responseHistoryAssets);
         ServerManager.Instance.addEventListener("changeServer",__changeServerHandler);
      }
      
      public function get model() : StockModel
      {
         return _model;
      }
      
      public function checkStockIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("stock",_model.status);
      }
      
      public function showMainFrame(evt:MouseEvent = null) : void
      {
         evt = evt;
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createStockLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createStockNewsLoader());
         AssetModuleLoader.addModelLoader("stock",7);
         AssetModuleLoader.startCodeLoader(function():void
         {
            var frame:* = ComponentFactory.Instance.creatCustomObject("stock.mainFrame");
            LayerManager.Instance.addToLayer(frame,3,false,1);
         });
      }
      
      private function checkStockOpen() : Boolean
      {
         return _model.stockStartTime >= TimeManager.Instance.NowTime() && TimeManager.Instance.NowTime() < _model.shopCloseTime;
      }
      
      public function showStockSellFrame() : void
      {
         var frame:* = ComponentFactory.Instance.creatCustomObject("stock.sellFrame");
         LayerManager.Instance.addToLayer(frame,3,false,1);
      }
      
      public function chooseOperation(type:int) : void
      {
         _model.stockID = 0;
         if(verifyOperation(type))
         {
            _operationType = type;
            SocketManager.Instance.out.sendUpdateUserCmd(type);
         }
         dispatchEvent(new StockEvent("stock_choose",type));
      }
      
      public function getStocks(sortType:int = 0) : Array
      {
         var arr:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _model.stocks;
         for each(var item in _model.stocks)
         {
            arr.push(item);
         }
         return arr;
      }
      
      public function getMyStocks(sortType:int = 0) : Array
      {
         var arr:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _model.mytocks;
         for each(var id in _model.mytocks)
         {
            arr.push(_model.stocks[id]);
         }
         return arr;
      }
      
      public function get operationType() : int
      {
         return _operationType;
      }
      
      public function get infoType() : int
      {
         return _infoType;
      }
      
      public function chooseInfoType(infType:int) : void
      {
         if(verifyInfoType(infType))
         {
            _infoType = infType;
            if(_hasServerStockData)
            {
               requestStockSpecific();
            }
         }
      }
      
      private function verifyInfoType(type:int) : Boolean
      {
         if(type != 1 && type != 0)
         {
            return false;
         }
         return true;
      }
      
      private function verifyOperation(type:int) : Boolean
      {
         if(type > 4)
         {
            return false;
         }
         return true;
      }
      
      public function chooseStock(id:int) : void
      {
         if(verifyStock(id))
         {
            _model.stockID = id;
            if(_operationType == 1)
            {
               chooseInfoType(_infoType == -1?0:int(_infoType));
            }
         }
      }
      
      public function checkVaildHourData() : Boolean
      {
         return TimeManager.Instance.Now().time >= _model.stockBuyEndTime;
      }
      
      public function parseStockScoreAward() : void
      {
         var awardStr:* = null;
         var pairs:* = null;
         var size:int = 0;
         var awardData:* = null;
         var pair:* = null;
         var i:int = 0;
         if(!_model.exchangedList)
         {
            _model.exchangedList = new Vector.<StockAwardData>();
            awardStr = ServerConfigManager.instance.StockScoreAward;
            pairs = awardStr.split("|");
            size = pairs.length;
            awardData = null;
            pair = null;
            for(i = 0; i < size; )
            {
               awardData = new StockAwardData();
               awardData.index = i;
               pair = String(pairs[i]).split(",");
               awardData.score = pair.length == 0?0:int(pair[0]);
               awardData.awardId = pair.length < 2?0:int(pair[1]);
               _model.exchangedList.push(awardData);
               i++;
            }
         }
      }
      
      private function __responseAllStockInfo(pkg:PkgEvent) : void
      {
         var i:int = 0;
         var size:int = pkg.pkg.readInt();
         var stockID:int = 0;
         var stockData:StockData = null;
         for(i = 0; i < size; )
         {
            stockID = pkg.pkg.readInt();
            stockData = _model.stocks[stockID];
            if(!stockData)
            {
               stockData = new StockData(stockID);
               _model.stocks[stockID] = stockData;
            }
            stockData.price = pkg.pkg.readInt();
            stockData.changeValue = pkg.pkg.readInt();
            stockData.dealNum = pkg.pkg.readInt();
            stockData.dayCenterPrice = pkg.pkg.readInt();
            stockData.centerPrice = pkg.pkg.readInt();
            stockData.maxBuyNum = pkg.pkg.readInt();
            i++;
         }
         _hasServerStockData = true;
         requestStockNews();
         dispatchEvent(new StockEvent("stock_all_update"));
      }
      
      public function requestUserAccountInfo() : void
      {
         SocketManager.Instance.out.sendUserStockAccountInfo();
      }
      
      private function __responseUserAccountInfo(pkg:PkgEvent) : void
      {
         _model.stockAccoutData.fund = pkg.pkg.readInt();
         _model.stockAccoutData.validLoan = pkg.pkg.readInt();
         _model.dailyLoanMax = pkg.pkg.readInt();
         dispatchEvent(new StockEvent("account_update"));
      }
      
      public function requestDealStock(cnt:int, isBuy:Boolean = false, demandType:int = 0, isLoan:Boolean = false) : void
      {
         var stockData:* = null;
         if(isLoan)
         {
            SocketManager.Instance.out.sendBuyLoan(cnt,demandType);
         }
         else
         {
            stockData = _model.stocks[_model.stockID];
            if(stockData)
            {
               if(checkDeal(isBuy))
               {
                  if(isBuy)
                  {
                     SocketManager.Instance.out.sendDealStockOrFund(0,_model.stockID,cnt,demandType,stockData.price);
                  }
                  else if(verifyMyStock())
                  {
                     SocketManager.Instance.out.sendDealStockOrFund(1,_model.stockID,cnt,demandType,stockData.price);
                     if(cnt == stockData.validNum)
                     {
                        dispatchEvent(new StockEvent("stock_sell_out"));
                     }
                  }
               }
            }
         }
      }
      
      public function checkDeal(isBuy:Boolean = false) : Boolean
      {
         var stockData:StockData = _model.stocks[_model.stockID];
         if(!stockData)
         {
            return false;
         }
         var date:Date = TimeManager.Instance.Now();
         if(isBuy)
         {
            if(date.hours < _model.startTime || date.hours >= _model.endTime)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.outTimeDeal0"));
               return false;
            }
         }
         else
         {
            if(!(date.hours >= _model.startTime && date.hours < _model.endTime || StockMgr.inst.model.stockBuyEndTime <= date.time && date.time <= StockMgr.inst.model.shopCloseTime))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.outTimeDeal1"));
               return false;
            }
            if(stockData.validNum <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.zeroStock"));
               return false;
            }
         }
         return true;
      }
      
      private function verifyMyStock() : Boolean
      {
         var stockData:* = null;
         if(_model.mytocks.indexOf(_model.stockID) == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.invalidStock"));
            return false;
         }
         stockData = _model.stocks[_model.stockID];
         if(stockData && stockData.validNum <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.zeroStock"));
            return false;
         }
         return true;
      }
      
      private function __resposeDealStockOrFund(pkg:PkgEvent) : void
      {
         var type:int = pkg.pkg.readByte();
         switch(int(type))
         {
            case 0:
               break;
            case 1:
         }
      }
      
      public function requestStockSpecific() : void
      {
         if(verifyStock(_model.stockID))
         {
            SocketManager.Instance.out.sendStockSpecific(_model.stockID,_infoType,0);
         }
      }
      
      private function verifyStock(id:int) : Boolean
      {
         if(!_model.stocks[id])
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.notStock"));
            _model.stockID = 0;
            return false;
         }
         return true;
      }
      
      private function __resposeStockSpecific(pkg:PkgEvent) : void
      {
         var startTime:Number = NaN;
         var date:* = null;
         var size:int = 0;
         var point:* = null;
         var hourCnt:int = 0;
         var dayCnt:int = 0;
         var tmpDayCnt:int = 0;
         var tmpHourCnt:int = 0;
         var i:int = 0;
         var stockID:int = pkg.pkg.readInt();
         var infoType:int = pkg.pkg.readByte();
         var stockData:StockData = _model.stocks[stockID];
         if(stockData)
         {
            startTime = pkg.pkg.readLong();
            if(_model.dayGrahpicStartDate <= 0 && infoType == 1)
            {
               _model.dayGrahpicStartDate = startTime;
            }
            date = new Date(startTime);
            stockData.diffValue = pkg.pkg.readInt();
            size = pkg.pkg.extend2;
            point = null;
            hourCnt = 0;
            dayCnt = 0;
            tmpDayCnt = 0;
            tmpHourCnt = 0;
            stockData.dailyPoints.length = 0;
            stockData.hourPoints.length = 0;
            for(i = 0; i < size; )
            {
               point = new StockPointData();
               point.dealPrice = pkg.pkg.readInt();
               if(point.dealPrice == 0)
               {
                  point.dealPrice = stockData.centerPrice;
               }
               if(infoType == 1)
               {
                  point.timeIndex = i;
                  stockData.dailyPoints.push(point);
               }
               else if(infoType == 0)
               {
                  point.time = date.hours * 3600 + date.minutes * 60 + date.seconds + i * StockModel.WAIT_TIMES[infoType];
                  stockData.hourPoints.push(point);
               }
               i++;
            }
         }
         dispatchEvent(new StockEvent("stock_specifics_update"));
      }
      
      private function clearBadData(stockData:StockData) : void
      {
         var i:int = 0;
         var tmpList:Vector.<StockPointData> = new Vector.<StockPointData>();
         for(i = 0; i < stockData.hourPoints.length; )
         {
            if(stockData.hourPoints[i].time >= model.startTime * 3600)
            {
               tmpList.push(stockData.hourPoints[i]);
            }
            i++;
         }
         stockData.hourPoints = tmpList;
      }
      
      private function __responseUserStockInfo(pkg:PkgEvent) : void
      {
         var i:int = 0;
         var stockID:int = 0;
         var idx:int = 0;
         var size:int = pkg.pkg.readInt();
         var stockData:StockData = null;
         for(i = 0; i < size; )
         {
            stockID = pkg.pkg.readInt();
            if(_model.mytocks.indexOf(stockID) == -1)
            {
               _model.mytocks.push(stockID);
            }
            stockData = _model.stocks[stockID];
            stockData.buyTotalValue = pkg.pkg.readInt();
            stockData.sellTotalValue = pkg.pkg.readInt();
            stockData.holdNum = pkg.pkg.readInt();
            stockData.validNum = pkg.pkg.readInt();
            if(stockData.holdNum <= 0)
            {
               idx = _model.mytocks.indexOf(stockID);
               _model.mytocks.splice(idx,1);
            }
            i++;
         }
         dispatchEvent(new StockEvent("stock_user_info"));
      }
      
      public function requestStockNews() : void
      {
         if(!_model.hasRequestedNews)
         {
            SocketManager.Instance.out.sendStockNews();
         }
      }
      
      private function __responseStockNews(pkg:PkgEvent) : void
      {
         var i:int = 0;
         var j:int = 0;
         _model.hasRequestedNews = true;
         var stockID:int = 0;
         var newsCnt:int = 0;
         var newsID:int = 0;
         var newsTime:* = 0;
         var stockNewsData:StockNewsData = null;
         var size:int = pkg.pkg.readByte();
         for(i = 0; i < size; )
         {
            stockID = pkg.pkg.readShort();
            newsCnt = pkg.pkg.readByte();
            for(j = 0; j < newsCnt; )
            {
               stockNewsData = new StockNewsData(1);
               stockNewsData.NewsId = pkg.pkg.readByte();
               stockNewsData.stockID = stockID;
               stockNewsData.time = pkg.pkg.readLong();
               _model.stocks[stockID].notices.push(stockNewsData);
               j++;
            }
            i++;
         }
         dispatchEvent(new StockEvent("stock_news"));
      }
      
      private function __responseStockOpenStatus(pkg:PkgEvent) : void
      {
         _model.status = pkg.pkg.readBoolean();
         checkStockIcon();
      }
      
      private function __responseStockMarketValue(pkg:PkgEvent) : void
      {
         _model.stockAccoutData.totalValue = pkg.pkg.readInt();
         dispatchEvent(new StockEvent("account_update"));
      }
      
      private function __responseStockTradeMessage(pkg:PkgEvent) : void
      {
         var i:int = 0;
         var stockNewsData:* = null;
         var size:int = pkg.pkg.readInt();
         _model.stockAccoutData.historyList = new Vector.<StockNewsData>();
         for(i = 0; i < size; )
         {
            stockNewsData = new StockNewsData(2);
            stockNewsData.stockID = pkg.pkg.readInt();
            stockNewsData.dealType = pkg.pkg.readInt();
            stockNewsData.singleCost = pkg.pkg.readInt();
            stockNewsData.dealCnt = pkg.pkg.readInt();
            stockNewsData.time = pkg.pkg.readLong();
            _model.stockAccoutData.historyList.push(stockNewsData);
            i++;
         }
         dispatchEvent(new StockEvent("stock_deal_message"));
      }
      
      private function __responseHistoryAssets(pkg:PkgEvent) : void
      {
         var i:int = 0;
         _model.myScore = pkg.pkg.readInt();
         var awardData:StockAwardData = null;
         for(i = 0; i < _model.exchangedList.length; )
         {
            awardData = _model.exchangedList[i];
            if(awardData.score > _model.myScore)
            {
               awardData.status = 0;
            }
            else if(awardData.status != 2)
            {
               awardData.status = 1;
            }
            i++;
         }
         dispatchEvent(new StockEvent("stock_update_score"));
      }
      
      public function requestAward(index:int) : void
      {
         if(verifyAward(index))
         {
            SocketManager.Instance.out.sendStockAward(index);
         }
      }
      
      private function verifyAward(index:int) : Boolean
      {
         if(index < 0 || index >= _model.exchangedList.length)
         {
            return false;
         }
         if(_model.exchangedList[index].score > _model.myScore)
         {
            return false;
         }
         return true;
      }
      
      private function __responseExchangeAward(pkg:PkgEvent) : void
      {
         var i:int = 0;
         var size:int = pkg.pkg.readInt();
         for(i = 0; i < size; )
         {
            _model.exchangedList[pkg.pkg.readInt()].status = 2;
            i++;
         }
         dispatchEvent(new StockEvent("stock_exchange_award"));
      }
      
      private function __changeServerHandler(evt:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _model.stocks;
         for each(var item in _model.stocks)
         {
            item.dailyPoints = new Vector.<StockPointData>();
            item.hourPoints = new Vector.<StockPointData>();
         }
      }
   }
}

class SingleTon
{
    
   
   function SingleTon()
   {
      super();
   }
}
