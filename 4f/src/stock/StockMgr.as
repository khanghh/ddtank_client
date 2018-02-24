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
      
      public function StockMgr(param1:SingleTon){super();}
      
      public static function get inst() : StockMgr{return null;}
      
      private function initialize() : void{}
      
      public function setup() : void{}
      
      public function get model() : StockModel{return null;}
      
      public function checkStockIcon() : void{}
      
      public function showMainFrame(param1:MouseEvent = null) : void{}
      
      private function checkStockOpen() : Boolean{return false;}
      
      public function showStockSellFrame() : void{}
      
      public function chooseOperation(param1:int) : void{}
      
      public function getStocks(param1:int = 0) : Array{return null;}
      
      public function getMyStocks(param1:int = 0) : Array{return null;}
      
      public function get operationType() : int{return 0;}
      
      public function get infoType() : int{return 0;}
      
      public function chooseInfoType(param1:int) : void{}
      
      private function verifyInfoType(param1:int) : Boolean{return false;}
      
      private function verifyOperation(param1:int) : Boolean{return false;}
      
      public function chooseStock(param1:int) : void{}
      
      public function checkVaildHourData() : Boolean{return false;}
      
      public function parseStockScoreAward() : void{}
      
      private function __responseAllStockInfo(param1:PkgEvent) : void{}
      
      public function requestUserAccountInfo() : void{}
      
      private function __responseUserAccountInfo(param1:PkgEvent) : void{}
      
      public function requestDealStock(param1:int, param2:Boolean = false, param3:int = 0, param4:Boolean = false) : void{}
      
      public function checkDeal(param1:Boolean = false) : Boolean{return false;}
      
      private function verifyMyStock() : Boolean{return false;}
      
      private function __resposeDealStockOrFund(param1:PkgEvent) : void{}
      
      public function requestStockSpecific() : void{}
      
      private function verifyStock(param1:int) : Boolean{return false;}
      
      private function __resposeStockSpecific(param1:PkgEvent) : void{}
      
      private function clearBadData(param1:StockData) : void{}
      
      private function __responseUserStockInfo(param1:PkgEvent) : void{}
      
      public function requestStockNews() : void{}
      
      private function __responseStockNews(param1:PkgEvent) : void{}
      
      private function __responseStockOpenStatus(param1:PkgEvent) : void{}
      
      private function __responseStockMarketValue(param1:PkgEvent) : void{}
      
      private function __responseStockTradeMessage(param1:PkgEvent) : void{}
      
      private function __responseHistoryAssets(param1:PkgEvent) : void{}
      
      public function requestAward(param1:int) : void{}
      
      private function verifyAward(param1:int) : Boolean{return false;}
      
      private function __responseExchangeAward(param1:PkgEvent) : void{}
      
      private function __changeServerHandler(param1:Event) : void{}
   }
}

class SingleTon
{
    
   
   function SingleTon(){super();}
}
