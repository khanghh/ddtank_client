package stock{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.BaseButton;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.ServerManager;   import ddt.manager.SocketManager;   import ddt.manager.TimeManager;   import ddt.utils.AssetModuleLoader;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.MouseEvent;   import hall.HallStateView;   import hallIcon.HallIconManager;   import stock.data.StockAwardData;   import stock.data.StockData;   import stock.data.StockModel;   import stock.data.StockNewsData;   import stock.data.StockPointData;   import stock.event.StockEvent;      public final class StockMgr extends EventDispatcher   {            private static var _inst:StockMgr = null;                   private var _model:StockModel = null;            private var _operationType:int = 0;            private var _infoType:int = -1;            private var _hall:HallStateView = null;            private var _stockIcon:BaseButton = null;            private var _hasServerStockData:Boolean = false;            public function StockMgr(single:SingleTon) { super(); }
            public static function get inst() : StockMgr { return null; }
            private function initialize() : void { }
            public function setup() : void { }
            public function get model() : StockModel { return null; }
            public function checkStockIcon() : void { }
            public function showMainFrame(evt:MouseEvent = null) : void { }
            private function checkStockOpen() : Boolean { return false; }
            public function showStockSellFrame() : void { }
            public function chooseOperation(type:int) : void { }
            public function getStocks(sortType:int = 0) : Array { return null; }
            public function getMyStocks(sortType:int = 0) : Array { return null; }
            public function get operationType() : int { return 0; }
            public function get infoType() : int { return 0; }
            public function chooseInfoType(infType:int) : void { }
            private function verifyInfoType(type:int) : Boolean { return false; }
            private function verifyOperation(type:int) : Boolean { return false; }
            public function chooseStock(id:int) : void { }
            public function checkVaildHourData() : Boolean { return false; }
            public function parseStockScoreAward() : void { }
            private function __responseAllStockInfo(pkg:PkgEvent) : void { }
            public function requestUserAccountInfo() : void { }
            private function __responseUserAccountInfo(pkg:PkgEvent) : void { }
            public function requestDealStock(cnt:int, isBuy:Boolean = false, demandType:int = 0, isLoan:Boolean = false) : void { }
            public function checkDeal(isBuy:Boolean = false) : Boolean { return false; }
            private function verifyMyStock() : Boolean { return false; }
            private function __resposeDealStockOrFund(pkg:PkgEvent) : void { }
            public function requestStockSpecific() : void { }
            private function verifyStock(id:int) : Boolean { return false; }
            private function __resposeStockSpecific(pkg:PkgEvent) : void { }
            private function clearBadData(stockData:StockData) : void { }
            private function __responseUserStockInfo(pkg:PkgEvent) : void { }
            public function requestStockNews() : void { }
            private function __responseStockNews(pkg:PkgEvent) : void { }
            private function __responseStockOpenStatus(pkg:PkgEvent) : void { }
            private function __responseStockMarketValue(pkg:PkgEvent) : void { }
            private function __responseStockTradeMessage(pkg:PkgEvent) : void { }
            private function __responseHistoryAssets(pkg:PkgEvent) : void { }
            public function requestAward(index:int) : void { }
            private function verifyAward(index:int) : Boolean { return false; }
            private function __responseExchangeAward(pkg:PkgEvent) : void { }
            private function __changeServerHandler(evt:Event) : void { }
   }}class SingleTon{          function SingleTon() { super(); }
}