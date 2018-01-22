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
      
      public function StockMgr(param1:SingleTon)
      {
         super();
         if(!param1)
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
      
      public function showMainFrame(param1:MouseEvent = null) : void
      {
         evt = param1;
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createStockLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createStockNewsLoader());
         AssetModuleLoader.addModelLoader("stock",7);
         AssetModuleLoader.startCodeLoader(function():void
         {
            var _loc1_:* = ComponentFactory.Instance.creatCustomObject("stock.mainFrame");
            LayerManager.Instance.addToLayer(_loc1_,3,false,1);
         });
      }
      
      private function checkStockOpen() : Boolean
      {
         return _model.stockStartTime >= TimeManager.Instance.NowTime() && TimeManager.Instance.NowTime() < _model.shopCloseTime;
      }
      
      public function showStockSellFrame() : void
      {
         var _loc1_:* = ComponentFactory.Instance.creatCustomObject("stock.sellFrame");
         LayerManager.Instance.addToLayer(_loc1_,3,false,1);
      }
      
      public function chooseOperation(param1:int) : void
      {
         _model.stockID = 0;
         if(verifyOperation(param1))
         {
            _operationType = param1;
            SocketManager.Instance.out.sendUpdateUserCmd(param1);
         }
         dispatchEvent(new StockEvent("stock_choose",param1));
      }
      
      public function getStocks(param1:int = 0) : Array
      {
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _model.stocks;
         for each(var _loc3_ in _model.stocks)
         {
            _loc2_.push(_loc3_);
         }
         return _loc2_;
      }
      
      public function getMyStocks(param1:int = 0) : Array
      {
         var _loc3_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _model.mytocks;
         for each(var _loc2_ in _model.mytocks)
         {
            _loc3_.push(_model.stocks[_loc2_]);
         }
         return _loc3_;
      }
      
      public function get operationType() : int
      {
         return _operationType;
      }
      
      public function get infoType() : int
      {
         return _infoType;
      }
      
      public function chooseInfoType(param1:int) : void
      {
         if(verifyInfoType(param1))
         {
            _infoType = param1;
            if(_hasServerStockData)
            {
               requestStockSpecific();
            }
         }
      }
      
      private function verifyInfoType(param1:int) : Boolean
      {
         if(param1 != 1 && param1 != 0)
         {
            return false;
         }
         return true;
      }
      
      private function verifyOperation(param1:int) : Boolean
      {
         if(param1 > 4)
         {
            return false;
         }
         return true;
      }
      
      public function chooseStock(param1:int) : void
      {
         if(verifyStock(param1))
         {
            _model.stockID = param1;
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
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc6_:int = 0;
         var _loc4_:* = null;
         var _loc3_:* = null;
         var _loc5_:int = 0;
         if(!_model.exchangedList)
         {
            _model.exchangedList = new Vector.<StockAwardData>();
            _loc2_ = ServerConfigManager.instance.StockScoreAward;
            _loc1_ = _loc2_.split("|");
            _loc6_ = _loc1_.length;
            _loc4_ = null;
            _loc3_ = null;
            _loc5_ = 0;
            while(_loc5_ < _loc6_)
            {
               _loc4_ = new StockAwardData();
               _loc4_.index = _loc5_;
               _loc3_ = String(_loc1_[_loc5_]).split(",");
               _loc4_.score = _loc3_.length == 0?0:int(_loc3_[0]);
               _loc4_.awardId = _loc3_.length < 2?0:int(_loc3_[1]);
               _model.exchangedList.push(_loc4_);
               _loc5_++;
            }
         }
      }
      
      private function __responseAllStockInfo(param1:PkgEvent) : void
      {
         var _loc4_:int = 0;
         var _loc5_:int = param1.pkg.readInt();
         var _loc3_:int = 0;
         var _loc2_:StockData = null;
         _loc4_ = 0;
         while(_loc4_ < _loc5_)
         {
            _loc3_ = param1.pkg.readInt();
            _loc2_ = _model.stocks[_loc3_];
            if(!_loc2_)
            {
               _loc2_ = new StockData(_loc3_);
               _model.stocks[_loc3_] = _loc2_;
            }
            _loc2_.price = param1.pkg.readInt();
            _loc2_.changeValue = param1.pkg.readInt();
            _loc2_.dealNum = param1.pkg.readInt();
            _loc2_.dayCenterPrice = param1.pkg.readInt();
            _loc2_.centerPrice = param1.pkg.readInt();
            _loc2_.maxBuyNum = param1.pkg.readInt();
            _loc4_++;
         }
         _hasServerStockData = true;
         requestStockNews();
         dispatchEvent(new StockEvent("stock_all_update"));
      }
      
      public function requestUserAccountInfo() : void
      {
         SocketManager.Instance.out.sendUserStockAccountInfo();
      }
      
      private function __responseUserAccountInfo(param1:PkgEvent) : void
      {
         _model.stockAccoutData.fund = param1.pkg.readInt();
         _model.stockAccoutData.validLoan = param1.pkg.readInt();
         _model.dailyLoanMax = param1.pkg.readInt();
         dispatchEvent(new StockEvent("account_update"));
      }
      
      public function requestDealStock(param1:int, param2:Boolean = false, param3:int = 0, param4:Boolean = false) : void
      {
         var _loc5_:* = null;
         if(param4)
         {
            SocketManager.Instance.out.sendBuyLoan(param1,param3);
         }
         else
         {
            _loc5_ = _model.stocks[_model.stockID];
            if(_loc5_)
            {
               if(checkDeal(param2))
               {
                  if(param2)
                  {
                     SocketManager.Instance.out.sendDealStockOrFund(0,_model.stockID,param1,param3,_loc5_.price);
                  }
                  else if(verifyMyStock())
                  {
                     SocketManager.Instance.out.sendDealStockOrFund(1,_model.stockID,param1,param3,_loc5_.price);
                     if(param1 == _loc5_.validNum)
                     {
                        dispatchEvent(new StockEvent("stock_sell_out"));
                     }
                  }
               }
            }
         }
      }
      
      public function checkDeal(param1:Boolean = false) : Boolean
      {
         var _loc2_:StockData = _model.stocks[_model.stockID];
         if(!_loc2_)
         {
            return false;
         }
         var _loc3_:Date = TimeManager.Instance.Now();
         if(param1)
         {
            if(_loc3_.hours < _model.startTime || _loc3_.hours >= _model.endTime)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.outTimeDeal0"));
               return false;
            }
         }
         else
         {
            if(!(_loc3_.hours >= _model.startTime && _loc3_.hours < _model.endTime || StockMgr.inst.model.stockBuyEndTime <= _loc3_.time && _loc3_.time <= StockMgr.inst.model.shopCloseTime))
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.outTimeDeal1"));
               return false;
            }
            if(_loc2_.validNum <= 0)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.zeroStock"));
               return false;
            }
         }
         return true;
      }
      
      private function verifyMyStock() : Boolean
      {
         var _loc1_:* = null;
         if(_model.mytocks.indexOf(_model.stockID) == -1)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.invalidStock"));
            return false;
         }
         _loc1_ = _model.stocks[_model.stockID];
         if(_loc1_ && _loc1_.validNum <= 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.zeroStock"));
            return false;
         }
         return true;
      }
      
      private function __resposeDealStockOrFund(param1:PkgEvent) : void
      {
         var _loc2_:int = param1.pkg.readByte();
         switch(int(_loc2_))
         {
            case 0:
            default:
         }
      }
      
      public function requestStockSpecific() : void
      {
         if(verifyStock(_model.stockID))
         {
            SocketManager.Instance.out.sendStockSpecific(_model.stockID,_infoType,0);
         }
      }
      
      private function verifyStock(param1:int) : Boolean
      {
         if(!_model.stocks[param1])
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("stock.notStock"));
            _model.stockID = 0;
            return false;
         }
         return true;
      }
      
      private function __resposeStockSpecific(param1:PkgEvent) : void
      {
         var _loc7_:Number = NaN;
         var _loc4_:* = null;
         var _loc5_:int = 0;
         var _loc8_:* = null;
         var _loc10_:int = 0;
         var _loc3_:int = 0;
         var _loc9_:int = 0;
         var _loc13_:int = 0;
         var _loc6_:int = 0;
         var _loc12_:int = param1.pkg.readInt();
         var _loc2_:int = param1.pkg.readByte();
         var _loc11_:StockData = _model.stocks[_loc12_];
         if(_loc11_)
         {
            _loc7_ = param1.pkg.readLong();
            if(_model.dayGrahpicStartDate <= 0 && _loc2_ == 1)
            {
               _model.dayGrahpicStartDate = _loc7_;
            }
            _loc4_ = new Date(_loc7_);
            _loc11_.diffValue = param1.pkg.readInt();
            _loc5_ = param1.pkg.extend2;
            _loc8_ = null;
            _loc10_ = 0;
            _loc3_ = 0;
            _loc9_ = 0;
            _loc13_ = 0;
            _loc11_.dailyPoints.length = 0;
            _loc11_.hourPoints.length = 0;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc8_ = new StockPointData();
               _loc8_.dealPrice = param1.pkg.readInt();
               if(_loc8_.dealPrice == 0)
               {
                  _loc8_.dealPrice = _loc11_.centerPrice;
               }
               if(_loc2_ == 1)
               {
                  _loc8_.timeIndex = _loc6_;
                  _loc11_.dailyPoints.push(_loc8_);
               }
               else if(_loc2_ == 0)
               {
                  _loc8_.time = _loc4_.hours * 3600 + _loc4_.minutes * 60 + _loc4_.seconds + _loc6_ * StockModel.WAIT_TIMES[_loc2_];
                  _loc11_.hourPoints.push(_loc8_);
               }
               _loc6_++;
            }
         }
         dispatchEvent(new StockEvent("stock_specifics_update"));
      }
      
      private function clearBadData(param1:StockData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:Vector.<StockPointData> = new Vector.<StockPointData>();
         _loc3_ = 0;
         while(_loc3_ < param1.hourPoints.length)
         {
            if(param1.hourPoints[_loc3_].time >= model.startTime * 3600)
            {
               _loc2_.push(param1.hourPoints[_loc3_]);
            }
            _loc3_++;
         }
         param1.hourPoints = _loc2_;
      }
      
      private function __responseUserStockInfo(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = param1.pkg.readInt();
         var _loc3_:StockData = null;
         _loc5_ = 0;
         while(_loc5_ < _loc6_)
         {
            _loc4_ = param1.pkg.readInt();
            if(_model.mytocks.indexOf(_loc4_) == -1)
            {
               _model.mytocks.push(_loc4_);
            }
            _loc3_ = _model.stocks[_loc4_];
            _loc3_.buyTotalValue = param1.pkg.readInt();
            _loc3_.sellTotalValue = param1.pkg.readInt();
            _loc3_.holdNum = param1.pkg.readInt();
            _loc3_.validNum = param1.pkg.readInt();
            if(_loc3_.holdNum <= 0)
            {
               _loc2_ = _model.mytocks.indexOf(_loc4_);
               _model.mytocks.splice(_loc2_,1);
            }
            _loc5_++;
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
      
      private function __responseStockNews(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc6_:int = 0;
         _model.hasRequestedNews = true;
         var _loc7_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         var _loc3_:* = 0;
         var _loc2_:StockNewsData = null;
         var _loc9_:int = param1.pkg.readByte();
         _loc8_ = 0;
         while(_loc8_ < _loc9_)
         {
            _loc7_ = param1.pkg.readShort();
            _loc5_ = param1.pkg.readByte();
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc2_ = new StockNewsData(1);
               _loc2_.NewsId = param1.pkg.readByte();
               _loc2_.stockID = _loc7_;
               _loc2_.time = param1.pkg.readLong();
               _model.stocks[_loc7_].notices.push(_loc2_);
               _loc6_++;
            }
            _loc8_++;
         }
         dispatchEvent(new StockEvent("stock_news"));
      }
      
      private function __responseStockOpenStatus(param1:PkgEvent) : void
      {
         _model.status = param1.pkg.readBoolean();
         checkStockIcon();
      }
      
      private function __responseStockMarketValue(param1:PkgEvent) : void
      {
         _model.stockAccoutData.totalValue = param1.pkg.readInt();
         dispatchEvent(new StockEvent("account_update"));
      }
      
      private function __responseStockTradeMessage(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         var _loc4_:int = param1.pkg.readInt();
         _model.stockAccoutData.historyList = new Vector.<StockNewsData>();
         _loc3_ = 0;
         while(_loc3_ < _loc4_)
         {
            _loc2_ = new StockNewsData(2);
            _loc2_.stockID = param1.pkg.readInt();
            _loc2_.dealType = param1.pkg.readInt();
            _loc2_.singleCost = param1.pkg.readInt();
            _loc2_.dealCnt = param1.pkg.readInt();
            _loc2_.time = param1.pkg.readLong();
            _model.stockAccoutData.historyList.push(_loc2_);
            _loc3_++;
         }
         dispatchEvent(new StockEvent("stock_deal_message"));
      }
      
      private function __responseHistoryAssets(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         _model.myScore = param1.pkg.readInt();
         var _loc2_:StockAwardData = null;
         _loc3_ = 0;
         while(_loc3_ < _model.exchangedList.length)
         {
            _loc2_ = _model.exchangedList[_loc3_];
            if(_loc2_.score > _model.myScore)
            {
               _loc2_.status = 0;
            }
            else if(_loc2_.status != 2)
            {
               _loc2_.status = 1;
            }
            _loc3_++;
         }
         dispatchEvent(new StockEvent("stock_update_score"));
      }
      
      public function requestAward(param1:int) : void
      {
         if(verifyAward(param1))
         {
            SocketManager.Instance.out.sendStockAward(param1);
         }
      }
      
      private function verifyAward(param1:int) : Boolean
      {
         if(param1 < 0 || param1 >= _model.exchangedList.length)
         {
            return false;
         }
         if(_model.exchangedList[param1].score > _model.myScore)
         {
            return false;
         }
         return true;
      }
      
      private function __responseExchangeAward(param1:PkgEvent) : void
      {
         var _loc2_:int = 0;
         var _loc3_:int = param1.pkg.readInt();
         _loc2_ = 0;
         while(_loc2_ < _loc3_)
         {
            _model.exchangedList[param1.pkg.readInt()].status = 2;
            _loc2_++;
         }
         dispatchEvent(new StockEvent("stock_exchange_award"));
      }
      
      private function __changeServerHandler(param1:Event) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _model.stocks;
         for each(var _loc2_ in _model.stocks)
         {
            _loc2_.dailyPoints = new Vector.<StockPointData>();
            _loc2_.hourPoints = new Vector.<StockPointData>();
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
