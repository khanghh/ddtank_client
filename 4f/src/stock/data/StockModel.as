package stock.data{   import ddt.data.goods.ShopItemInfo;   import ddt.manager.ServerConfigManager;   import ddt.manager.ShopManager;   import ddt.manager.TimeManager;   import flash.utils.Dictionary;   import road7th.utils.DateUtils;      public final class StockModel   {            public static const OPERATION_TYPE_INVALID:int = 0;            public static const OPERATION_TYPE_ALL:int = 1;            public static const OPERATION_TYPE_MINE:int = 2;            public static const OPERATION_TYPE_SHOP:int = 3;            public static const OPERATION_TYPE_AWARD:int = 4;            public static const SORT_TYPE_ID:int = 0;            public static const SORT_TYPE_PRICE:int = 1;            public static const SORT_TYPE_CHANGE:int = 2;            public static const DEAL_TYPE_STOCK_BUY:int = 0;            public static const DEAL_TYPE_STOCK_SELL:int = 1;            public static const DEAL_TYPE_FUND_BUY:int = 2;            public static const INFO_TYPE_INVALID:int = -1;            public static const INFO_TYPE_HOUR:int = 0;            public static const INFO_TYPE_DAY:int = 1;            public static const NEWS_TYPE_STOCK:int = 1;            public static const NEWS_TYPE_USER:int = 2;            public static const AWARD_STATUS_IVALID:int = 0;            public static const AWARD_STATUS_ENABLE:int = 1;            public static const AWARD_STATUS_GAINED:int = 2;            public static const WAIT_TIMES:Array = [60,1800];            public static const DAY_DURATION:int = 6;                   private var _cfgStocks:Dictionary = null;            private var _cfgStockNews:Dictionary = null;            private var _stockAccountData:StockAccountData = null;            private var _myStocks:Vector.<int> = null;            private var _stocks:Dictionary = null;            private var _sortFlag:int = 0;            private var _stockID:int = 0;            private var _lastRequstTimes:Array;            public var dailyLoanMax:int = 0;            public var status:Boolean = false;            public var hasRequestedNews:Boolean = false;            public var dayGrahpicStartDate:Number = -1;            public var myScore:int = 0;            public var exchangedList:Vector.<StockAwardData> = null;            public function StockModel() { super(); }
            public function get stockAccoutData() : StockAccountData { return null; }
            public function get mytocks() : Vector.<int> { return null; }
            public function get stocks() : Dictionary { return null; }
            public function get cfgStocks() : Dictionary { return null; }
            public function set cfgStocks(value:Dictionary) : void { }
            public function get sortFlag() : int { return 0; }
            public function set sortFlag(value:int) : void { }
            public function get stockID() : int { return 0; }
            public function set stockID(value:int) : void { }
            public function get lastRequstTimes() : Array { return null; }
            public function get goodsList() : Array { return null; }
            public function get startTime() : int { return 0; }
            public function get endTime() : int { return 0; }
            private function parseOpenTime() : Array { return null; }
            public function get dayHours() : int { return 0; }
            public function get cfgStockNews() : Dictionary { return null; }
            public function set cfgStockNews(value:Dictionary) : void { }
            public function get shopCloseTime() : Number { return 0; }
            public function get stockStartTime() : Number { return 0; }
            public function get stockBuyEndTime() : Number { return 0; }
   }}