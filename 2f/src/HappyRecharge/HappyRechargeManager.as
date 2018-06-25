package HappyRecharge{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.ItemManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.utils.AssetModuleLoader;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.events.MouseEvent;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class HappyRechargeManager extends EventDispatcher   {            private static var happyRechargeManager:HappyRechargeManager;                   public var mouseClickEnable:Boolean;            private var _frame:HappyRechargeFrame;            private var _isOpen:Boolean = false;            private var _enterBtn:SimpleBitmapButton;            private var _lotteryCount:int;            private var _prizeItemID:int;            private var _prizeItem:InventoryItemInfo;            private var _prizeCount:int;            private var _exchangeItems:Array;            private var _ticketCount:int = 5;            private var _activityData:String;            private var _specialPrizeCount:Array;            private var _currentPrizeItemID:int;            private var _currentPrizeItemSortID:int;            private var _currentPrizeItemCount:int;            private var _turnItems:Array;            private var _recordArr:Array;            private var _moneyCount:int;            public var isAutoStart:Boolean = false;            public function HappyRechargeManager($happyRechargeInstance:HappyRechargeInstance, target:IEventDispatcher = null) { super(null); }
            public static function get instance() : HappyRechargeManager { return null; }
            public function get isOpen() : Boolean { return false; }
            public function get lotteryCount() : int { return 0; }
            public function get prizeItemID() : int { return 0; }
            public function get prizeItem() : InventoryItemInfo { return null; }
            public function get prizeCount() : int { return 0; }
            public function get exchangeItems() : Array { return null; }
            public function get ticketCount() : int { return 0; }
            public function get activityData() : String { return null; }
            public function get specialPrizeCount() : Array { return null; }
            public function get currentPrizeItemID() : int { return 0; }
            public function get currentPrizeItemSortID() : int { return 0; }
            public function get currentPrizeItemCount() : int { return 0; }
            public function get turnItems() : Array { return null; }
            public function get recordArr() : Array { return null; }
            public function get moneyCount() : int { return 0; }
            public function loadResource() : void { }
            private function createFrame() : void { }
            private function _socketManagerHandler(event:CrazyTankSocketEvent) : void { }
            private function _happyRechargePlayResponseHandler(pkg:PackageIn) : void { }
            private function _happyRechargeExchangeResponseHandler(pkg:PackageIn) : void { }
            private function _happyRechargeOpenResponseHandler(pkg:PackageIn) : void { }
            private function _happyRechargeEnterResponseHandler(pkg:PackageIn) : void { }
            private function _happyRechargeUpdateResponseHandler(pkg:PackageIn) : void { }
            private function _createActivityDate(startDate:Date, endDate:Date) : void { }
            private function __createPrizeItemInfo(itemid:int, count:int, valid:int, att:String, isbind:int) : InventoryItemInfo { return null; }
            private function _createTurnItemInfo(index:int, itemid:int, count:int, valid:int, attri:String, isbind:int) : HappyRechargeTurnItemInfo { return null; }
            private function _createExchangeItemInfo(itemid:int, count:int, valid:int, att:String, ticket:int, isbind:int) : HappyRechargeExchangeItem { return null; }
            private function _createAttribute(info:InventoryItemInfo, att:String) : void { }
            public function setup() : void { }
            public function createIcon() : void { }
            public function removeIcon() : void { }
            protected function onEnterClick(e:MouseEvent) : void { }
   }}class HappyRechargeInstance{          function HappyRechargeInstance() { super(); }
}