package HappyRecharge
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.MouseEvent;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class HappyRechargeManager extends EventDispatcher
   {
      
      private static var happyRechargeManager:HappyRechargeManager;
       
      
      public var mouseClickEnable:Boolean;
      
      private var _frame:HappyRechargeFrame;
      
      private var _isOpen:Boolean = false;
      
      private var _enterBtn:SimpleBitmapButton;
      
      private var _lotteryCount:int;
      
      private var _prizeItemID:int;
      
      private var _prizeItem:InventoryItemInfo;
      
      private var _prizeCount:int;
      
      private var _exchangeItems:Array;
      
      private var _ticketCount:int = 5;
      
      private var _activityData:String;
      
      private var _specialPrizeCount:Array;
      
      private var _currentPrizeItemID:int;
      
      private var _currentPrizeItemSortID:int;
      
      private var _currentPrizeItemCount:int;
      
      private var _turnItems:Array;
      
      private var _recordArr:Array;
      
      private var _moneyCount:int;
      
      public var isAutoStart:Boolean = false;
      
      public function HappyRechargeManager(param1:HappyRechargeInstance, param2:IEventDispatcher = null){super(null);}
      
      public static function get instance() : HappyRechargeManager{return null;}
      
      public function get isOpen() : Boolean{return false;}
      
      public function get lotteryCount() : int{return 0;}
      
      public function get prizeItemID() : int{return 0;}
      
      public function get prizeItem() : InventoryItemInfo{return null;}
      
      public function get prizeCount() : int{return 0;}
      
      public function get exchangeItems() : Array{return null;}
      
      public function get ticketCount() : int{return 0;}
      
      public function get activityData() : String{return null;}
      
      public function get specialPrizeCount() : Array{return null;}
      
      public function get currentPrizeItemID() : int{return 0;}
      
      public function get currentPrizeItemSortID() : int{return 0;}
      
      public function get currentPrizeItemCount() : int{return 0;}
      
      public function get turnItems() : Array{return null;}
      
      public function get recordArr() : Array{return null;}
      
      public function get moneyCount() : int{return 0;}
      
      public function loadResource() : void{}
      
      private function createFrame() : void{}
      
      private function _socketManagerHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function _happyRechargePlayResponseHandler(param1:PackageIn) : void{}
      
      private function _happyRechargeExchangeResponseHandler(param1:PackageIn) : void{}
      
      private function _happyRechargeOpenResponseHandler(param1:PackageIn) : void{}
      
      private function _happyRechargeEnterResponseHandler(param1:PackageIn) : void{}
      
      private function _happyRechargeUpdateResponseHandler(param1:PackageIn) : void{}
      
      private function _createActivityDate(param1:Date, param2:Date) : void{}
      
      private function __createPrizeItemInfo(param1:int, param2:int, param3:int, param4:String, param5:int) : InventoryItemInfo{return null;}
      
      private function _createTurnItemInfo(param1:int, param2:int, param3:int, param4:int, param5:String, param6:int) : HappyRechargeTurnItemInfo{return null;}
      
      private function _createExchangeItemInfo(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int) : HappyRechargeExchangeItem{return null;}
      
      private function _createAttribute(param1:InventoryItemInfo, param2:String) : void{}
      
      public function setup() : void{}
      
      public function createIcon() : void{}
      
      public function removeIcon() : void{}
      
      protected function onEnterClick(param1:MouseEvent) : void{}
   }
}

class HappyRechargeInstance
{
    
   
   function HappyRechargeInstance(){super();}
}
