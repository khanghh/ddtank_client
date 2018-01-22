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
      
      public function HappyRechargeManager(param1:HappyRechargeInstance, param2:IEventDispatcher = null)
      {
         super(param2);
      }
      
      public static function get instance() : HappyRechargeManager
      {
         if(happyRechargeManager == null)
         {
            happyRechargeManager = new HappyRechargeManager(new HappyRechargeInstance());
         }
         return happyRechargeManager;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get lotteryCount() : int
      {
         return _lotteryCount;
      }
      
      public function get prizeItemID() : int
      {
         return _prizeItemID;
      }
      
      public function get prizeItem() : InventoryItemInfo
      {
         return _prizeItem;
      }
      
      public function get prizeCount() : int
      {
         return _prizeCount;
      }
      
      public function get exchangeItems() : Array
      {
         return _exchangeItems;
      }
      
      public function get ticketCount() : int
      {
         return _ticketCount;
      }
      
      public function get activityData() : String
      {
         return _activityData;
      }
      
      public function get specialPrizeCount() : Array
      {
         if(_specialPrizeCount == null)
         {
            _specialPrizeCount = ServerConfigManager.instance.getHappyRechargeSpecialItemCount();
         }
         return _specialPrizeCount;
      }
      
      public function get currentPrizeItemID() : int
      {
         return _currentPrizeItemID;
      }
      
      public function get currentPrizeItemSortID() : int
      {
         return _currentPrizeItemSortID;
      }
      
      public function get currentPrizeItemCount() : int
      {
         return _currentPrizeItemCount;
      }
      
      public function get turnItems() : Array
      {
         return _turnItems;
      }
      
      public function get recordArr() : Array
      {
         return _recordArr;
      }
      
      public function get moneyCount() : int
      {
         return _moneyCount;
      }
      
      public function loadResource() : void
      {
         if(StateManager.currentStateType == "main")
         {
            AssetModuleLoader.addModelLoader("happyRecharge",6);
            AssetModuleLoader.startCodeLoader(createFrame);
         }
      }
      
      private function createFrame() : void
      {
         SocketManager.Instance.out.happyRechargeEnter();
      }
      
      private function _socketManagerHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:* = param1.cmd & 255;
         switch(int(_loc2_) - 176)
         {
            case 0:
               _happyRechargePlayResponseHandler(_loc3_);
               break;
            case 1:
               _happyRechargeExchangeResponseHandler(_loc3_);
               break;
            case 2:
               _happyRechargeOpenResponseHandler(_loc3_);
               break;
            case 3:
               _happyRechargeEnterResponseHandler(_loc3_);
               break;
            case 4:
               _happyRechargeUpdateResponseHandler(_loc3_);
         }
      }
      
      private function _happyRechargePlayResponseHandler(param1:PackageIn) : void
      {
         _currentPrizeItemID = param1.readInt();
         _currentPrizeItemSortID = param1.readInt();
         _currentPrizeItemCount = param1.readInt();
         _lotteryCount = param1.readInt();
         _ticketCount = param1.readInt();
         if(HappyRechargeManager.instance.isAutoStart)
         {
            _frame.autoStartTuren(_currentPrizeItemSortID);
         }
         else
         {
            _frame.startTurn(_currentPrizeItemSortID);
         }
      }
      
      private function _happyRechargeExchangeResponseHandler(param1:PackageIn) : void
      {
         _ticketCount = param1.readInt();
         dispatchEvent(new Event("HAPPYRECHARGE_UPDATE_TICKET"));
      }
      
      private function _happyRechargeOpenResponseHandler(param1:PackageIn) : void
      {
         _isOpen = param1.readBoolean();
         if(_isOpen)
         {
            createIcon();
         }
         else
         {
            removeIcon();
         }
      }
      
      private function _happyRechargeEnterResponseHandler(param1:PackageIn) : void
      {
         var _loc23_:int = 0;
         var _loc9_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:int = 0;
         var _loc15_:* = null;
         var _loc14_:int = 0;
         var _loc22_:int = 0;
         var _loc12_:* = null;
         var _loc19_:int = 0;
         var _loc7_:int = 0;
         var _loc20_:int = 0;
         var _loc13_:int = 0;
         var _loc26_:* = null;
         var _loc11_:int = 0;
         var _loc2_:int = 0;
         var _loc27_:* = null;
         var _loc21_:int = 0;
         var _loc10_:* = null;
         _moneyCount = param1.readInt();
         _lotteryCount = param1.readInt();
         _ticketCount = param1.readInt();
         var _loc4_:Date = param1.readDate();
         var _loc8_:Date = param1.readDate();
         _createActivityDate(_loc4_,_loc8_);
         _prizeItemID = param1.readInt();
         _prizeCount = param1.readInt();
         var _loc3_:int = param1.readInt();
         var _loc25_:String = param1.readUTF();
         var _loc24_:int = param1.readInt();
         _prizeItem = __createPrizeItemInfo(_prizeItemID,_prizeCount,_loc3_,_loc25_,_loc24_);
         if(_turnItems == null)
         {
            _turnItems = [];
         }
         else
         {
            while(_turnItems.length > 0)
            {
               _turnItems.pop();
            }
         }
         var _loc18_:int = param1.readInt();
         _loc23_ = 0;
         while(_loc23_ < _loc18_)
         {
            _loc9_ = param1.readInt();
            _loc6_ = param1.readInt();
            _loc5_ = param1.readInt();
            _loc15_ = param1.readUTF();
            _loc14_ = param1.readInt();
            _loc22_ = param1.readInt();
            _loc12_ = _createTurnItemInfo(_loc14_,_loc9_,_loc6_,_loc5_,_loc15_,_loc22_);
            _turnItems.push(_loc12_);
            _loc23_++;
         }
         if(_exchangeItems == null)
         {
            _exchangeItems = [];
         }
         else
         {
            while(_exchangeItems.length > 0)
            {
               _exchangeItems.pop();
            }
         }
         var _loc17_:int = param1.readInt();
         _loc19_ = 0;
         while(_loc19_ < _loc17_)
         {
            _loc7_ = param1.readInt();
            _loc20_ = param1.readInt();
            _loc13_ = param1.readInt();
            _loc26_ = param1.readUTF();
            _loc11_ = param1.readUTF();
            _loc2_ = param1.readInt();
            _loc27_ = _createExchangeItemInfo(_loc7_,_loc20_,_loc13_,_loc26_,_loc11_,_loc2_);
            _exchangeItems.push(_loc27_);
            _loc19_++;
         }
         if(_recordArr == null)
         {
            _recordArr = [];
         }
         else
         {
            while(_recordArr.length > 0)
            {
               _recordArr.pop();
            }
         }
         var _loc16_:int = param1.readInt();
         _loc21_ = 0;
         while(_loc21_ < _loc16_)
         {
            _loc10_ = new HappyRechargeRecordItem();
            _loc10_.prizeType = param1.readInt();
            _loc10_.count = param1.readInt();
            _loc10_.nickName = param1.readUTF();
            _recordArr.push(_loc10_);
            _loc21_++;
         }
         _frame = ComponentFactory.Instance.creatComponentByStylename("happyrecharge.mainframe");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function _happyRechargeUpdateResponseHandler(param1:PackageIn) : void
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc2_:int = 0;
         var _loc4_:* = null;
         var _loc6_:int = param1.readInt();
         if(_loc6_ == 1)
         {
            _prizeCount = param1.readInt();
            _loc5_ = param1.readInt();
            _loc3_ = param1.readUTF();
            _loc2_ = param1.readInt();
            if(_frame)
            {
               if(_loc5_ > 9 && _loc5_ < 13)
               {
                  _loc4_ = new HappyRechargeRecordItem();
                  _loc4_.prizeType = _loc5_;
                  _loc4_.nickName = _loc3_;
                  _loc4_.count = _loc2_;
               }
               _frame.updateView(_loc4_);
            }
         }
         else if(_loc6_ == 2)
         {
            _lotteryCount = param1.readInt();
         }
      }
      
      private function _createActivityDate(param1:Date, param2:Date) : void
      {
         if(param1 && param2)
         {
            _activityData = param1.getFullYear() + "/" + (param1.getMonth() + 1) + "/" + param1.getDate() + " " + param1.getHours() + ":" + param1.getMinutes() + ":" + param1.getSeconds() + " - " + param2.getFullYear() + "/" + (param2.getMonth() + 1) + "/" + param2.getDate() + " " + param2.getHours() + ":" + param2.getMinutes() + ":" + param2.getSeconds();
         }
         else
         {
            _activityData = "1989/02/08 06:00:00 - ????/??/?? 00:00:00";
         }
      }
      
      private function __createPrizeItemInfo(param1:int, param2:int, param3:int, param4:String, param5:int) : InventoryItemInfo
      {
         var _loc6_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1);
         var _loc7_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc7_,_loc6_);
         _loc7_.ValidDate = param3;
         _createAttribute(_loc7_,param4);
         _loc7_.IsBinds = param5 == 1?true:false;
         return _loc7_;
      }
      
      private function _createTurnItemInfo(param1:int, param2:int, param3:int, param4:int, param5:String, param6:int) : HappyRechargeTurnItemInfo
      {
         var _loc8_:HappyRechargeTurnItemInfo = new HappyRechargeTurnItemInfo();
         _loc8_.indexId = param1;
         var _loc7_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param2);
         var _loc9_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc9_,_loc7_);
         _loc9_.Count = param3;
         _loc9_.ValidDate = Number(param4);
         _createAttribute(_loc9_,param5);
         _loc8_.itemInfo = _loc9_;
         _loc8_.itemInfo.IsBinds = param6 == 1?true:false;
         return _loc8_;
      }
      
      private function _createExchangeItemInfo(param1:int, param2:int, param3:int, param4:String, param5:int, param6:int) : HappyRechargeExchangeItem
      {
         var _loc9_:HappyRechargeExchangeItem = new HappyRechargeExchangeItem();
         var _loc7_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1);
         var _loc8_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc8_,_loc7_);
         _loc8_.Count = param2;
         _loc8_.ValidDate = param3;
         _loc8_.IsBinds = param6 == 1?true:false;
         _createAttribute(_loc8_,param4);
         _loc9_.info = _loc8_;
         _loc9_.count = param2;
         _loc9_.needCount = param5;
         return _loc9_;
      }
      
      private function _createAttribute(param1:InventoryItemInfo, param2:String) : void
      {
         var _loc4_:int = 0;
         var _loc3_:Array = param2.split(",");
         _loc4_ = 0;
         while(_loc4_ < _loc3_.length)
         {
            switch(int(_loc4_))
            {
               case 0:
                  param1.StrengthenLevel = _loc3_[_loc4_];
                  break;
               case 1:
                  param1.AttackCompose = _loc3_[_loc4_];
                  break;
               case 2:
                  param1.DefendCompose = _loc3_[_loc4_];
                  break;
               case 3:
                  param1.AgilityCompose = _loc3_[_loc4_];
                  break;
               case 4:
                  param1.LuckCompose = _loc3_[_loc4_];
                  break;
               case 5:
                  break;
               case 6:
                  param1.MagicAttack = _loc3_[_loc4_];
                  break;
               case 7:
                  param1.MagicDefence = _loc3_[_loc4_];
                  break;
               case 8:
                  param1.StrengthenExp = _loc3_[_loc4_];
            }
            _loc4_++;
         }
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener("happyRecharge",_socketManagerHandler);
      }
      
      public function createIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("happyRecharge",true);
      }
      
      public function removeIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("happyRecharge",false);
      }
      
      protected function onEnterClick(param1:MouseEvent) : void
      {
         HappyRechargeManager.instance.loadResource();
      }
   }
}

class HappyRechargeInstance
{
    
   
   function HappyRechargeInstance()
   {
      super();
   }
}
