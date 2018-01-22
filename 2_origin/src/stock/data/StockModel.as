package stock.data
{
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ShopManager;
   import ddt.manager.TimeManager;
   import flash.utils.Dictionary;
   import road7th.utils.DateUtils;
   
   public final class StockModel
   {
      
      public static const OPERATION_TYPE_INVALID:int = 0;
      
      public static const OPERATION_TYPE_ALL:int = 1;
      
      public static const OPERATION_TYPE_MINE:int = 2;
      
      public static const OPERATION_TYPE_SHOP:int = 3;
      
      public static const OPERATION_TYPE_AWARD:int = 4;
      
      public static const SORT_TYPE_ID:int = 0;
      
      public static const SORT_TYPE_PRICE:int = 1;
      
      public static const SORT_TYPE_CHANGE:int = 2;
      
      public static const DEAL_TYPE_STOCK_BUY:int = 0;
      
      public static const DEAL_TYPE_STOCK_SELL:int = 1;
      
      public static const DEAL_TYPE_FUND_BUY:int = 2;
      
      public static const INFO_TYPE_INVALID:int = -1;
      
      public static const INFO_TYPE_HOUR:int = 0;
      
      public static const INFO_TYPE_DAY:int = 1;
      
      public static const NEWS_TYPE_STOCK:int = 1;
      
      public static const NEWS_TYPE_USER:int = 2;
      
      public static const AWARD_STATUS_IVALID:int = 0;
      
      public static const AWARD_STATUS_ENABLE:int = 1;
      
      public static const AWARD_STATUS_GAINED:int = 2;
      
      public static const WAIT_TIMES:Array = [60,1800];
      
      public static const DAY_DURATION:int = 6;
       
      
      private var _cfgStocks:Dictionary = null;
      
      private var _cfgStockNews:Dictionary = null;
      
      private var _stockAccountData:StockAccountData = null;
      
      private var _myStocks:Vector.<int> = null;
      
      private var _stocks:Dictionary = null;
      
      private var _sortFlag:int = 0;
      
      private var _stockID:int = 0;
      
      private var _lastRequstTimes:Array;
      
      public var dailyLoanMax:int = 0;
      
      public var status:Boolean = false;
      
      public var hasRequestedNews:Boolean = false;
      
      public var dayGrahpicStartDate:Number = -1;
      
      public var myScore:int = 0;
      
      public var exchangedList:Vector.<StockAwardData> = null;
      
      public function StockModel()
      {
         _lastRequstTimes = [0,0];
         super();
         _stockAccountData = new StockAccountData();
         _myStocks = new Vector.<int>();
         _stocks = new Dictionary();
      }
      
      public function get stockAccoutData() : StockAccountData
      {
         return _stockAccountData;
      }
      
      public function get mytocks() : Vector.<int>
      {
         return _myStocks;
      }
      
      public function get stocks() : Dictionary
      {
         return _stocks;
      }
      
      public function get cfgStocks() : Dictionary
      {
         return _cfgStocks;
      }
      
      public function set cfgStocks(param1:Dictionary) : void
      {
         _cfgStocks = param1;
      }
      
      public function get sortFlag() : int
      {
         return _sortFlag;
      }
      
      public function set sortFlag(param1:int) : void
      {
         _sortFlag = param1;
      }
      
      public function get stockID() : int
      {
         return _stockID;
      }
      
      public function set stockID(param1:int) : void
      {
         _stockID = param1;
      }
      
      public function get lastRequstTimes() : Array
      {
         return _lastRequstTimes;
      }
      
      public function get goodsList() : Array
      {
         var _loc1_:Array = [];
         var _loc3_:Vector.<ShopItemInfo> = ShopManager.Instance.getGoodsByType(117);
         var _loc5_:int = 0;
         var _loc4_:* = _loc3_;
         for each(var _loc2_ in _loc3_)
         {
            _loc1_.push(_loc2_.GoodsID);
         }
         _loc1_ = _loc1_.sortOn("GoodsID",16);
         return _loc1_;
      }
      
      public function get startTime() : int
      {
         return parseOpenTime()[0];
      }
      
      public function get endTime() : int
      {
         return parseOpenTime()[1];
      }
      
      private function parseOpenTime() : Array
      {
         var _loc2_:Array = [];
         var _loc3_:String = ServerConfigManager.instance.StockOpenTime;
         var _loc5_:Array = _loc3_.split("|");
         var _loc6_:int = TimeManager.Instance.Now().hours;
         var _loc4_:int = parseInt(String(_loc5_[0]).split(",")[1]);
         var _loc1_:int = parseInt(String(_loc5_[0]).split(",")[0]);
         if(_loc6_ <= _loc4_)
         {
            _loc2_.push(_loc1_);
            _loc2_.push(_loc4_);
         }
         else
         {
            _loc2_.push(parseInt(String(_loc5_[1]).split(",")[0]));
            _loc2_.push(parseInt(String(_loc5_[1]).split(",")[1]));
         }
         return _loc2_;
      }
      
      public function get dayHours() : int
      {
         var _loc1_:Array = [];
         var _loc2_:String = ServerConfigManager.instance.StockOpenTime;
         var _loc5_:Array = _loc2_.split("|");
         var _loc3_:int = parseInt(String(_loc5_[0]).split(",")[1]) - parseInt(String(_loc5_[0]).split(",")[0]);
         var _loc4_:int = parseInt(String(_loc5_[1]).split(",")[1]) - parseInt(String(_loc5_[1]).split(",")[0]);
         return _loc3_ + _loc4_;
      }
      
      public function get cfgStockNews() : Dictionary
      {
         return _cfgStockNews;
      }
      
      public function set cfgStockNews(param1:Dictionary) : void
      {
         _cfgStockNews = param1;
      }
      
      public function get shopCloseTime() : Number
      {
         return DateUtils.getDateByStr(ServerConfigManager.instance.StockOverDate).time;
      }
      
      public function get stockStartTime() : Number
      {
         return DateUtils.getDateByStr(ServerConfigManager.instance.StockStartDate).time;
      }
      
      public function get stockBuyEndTime() : Number
      {
         return DateUtils.getDateByStr(ServerConfigManager.instance.StockEndDate).time;
      }
   }
}
