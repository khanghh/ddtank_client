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
      
      public function set cfgStocks(value:Dictionary) : void
      {
         _cfgStocks = value;
      }
      
      public function get sortFlag() : int
      {
         return _sortFlag;
      }
      
      public function set sortFlag(value:int) : void
      {
         _sortFlag = value;
      }
      
      public function get stockID() : int
      {
         return _stockID;
      }
      
      public function set stockID(value:int) : void
      {
         _stockID = value;
      }
      
      public function get lastRequstTimes() : Array
      {
         return _lastRequstTimes;
      }
      
      public function get goodsList() : Array
      {
         var arr:Array = [];
         var list:Vector.<ShopItemInfo> = ShopManager.Instance.getGoodsByType(117);
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var item in list)
         {
            arr.push(item.GoodsID);
         }
         arr = arr.sortOn("GoodsID",16);
         return arr;
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
         var arr:Array = [];
         var timeStr:String = ServerConfigManager.instance.StockOpenTime;
         var timeArr:Array = timeStr.split("|");
         var nowTime:int = TimeManager.Instance.Now().hours;
         var endTime:int = parseInt(String(timeArr[0]).split(",")[1]);
         var startTime:int = parseInt(String(timeArr[0]).split(",")[0]);
         if(nowTime <= endTime)
         {
            arr.push(startTime);
            arr.push(endTime);
         }
         else
         {
            arr.push(parseInt(String(timeArr[1]).split(",")[0]));
            arr.push(parseInt(String(timeArr[1]).split(",")[1]));
         }
         return arr;
      }
      
      public function get dayHours() : int
      {
         var arr:Array = [];
         var timeStr:String = ServerConfigManager.instance.StockOpenTime;
         var timeArr:Array = timeStr.split("|");
         var timeCnt1:int = parseInt(String(timeArr[0]).split(",")[1]) - parseInt(String(timeArr[0]).split(",")[0]);
         var timeCnt2:int = parseInt(String(timeArr[1]).split(",")[1]) - parseInt(String(timeArr[1]).split(",")[0]);
         return timeCnt1 + timeCnt2;
      }
      
      public function get cfgStockNews() : Dictionary
      {
         return _cfgStockNews;
      }
      
      public function set cfgStockNews(value:Dictionary) : void
      {
         _cfgStockNews = value;
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
