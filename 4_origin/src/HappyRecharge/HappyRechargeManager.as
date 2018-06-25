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
      
      public function HappyRechargeManager($happyRechargeInstance:HappyRechargeInstance, target:IEventDispatcher = null)
      {
         super(target);
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
      
      private function _socketManagerHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:* = event.cmd & 255;
         switch(int(cmd) - 176)
         {
            case 0:
               _happyRechargePlayResponseHandler(pkg);
               break;
            case 1:
               _happyRechargeExchangeResponseHandler(pkg);
               break;
            case 2:
               _happyRechargeOpenResponseHandler(pkg);
               break;
            case 3:
               _happyRechargeEnterResponseHandler(pkg);
               break;
            case 4:
               _happyRechargeUpdateResponseHandler(pkg);
         }
      }
      
      private function _happyRechargePlayResponseHandler(pkg:PackageIn) : void
      {
         _currentPrizeItemID = pkg.readInt();
         _currentPrizeItemSortID = pkg.readInt();
         _currentPrizeItemCount = pkg.readInt();
         _lotteryCount = pkg.readInt();
         _ticketCount = pkg.readInt();
         if(HappyRechargeManager.instance.isAutoStart)
         {
            _frame.autoStartTuren(_currentPrizeItemSortID);
         }
         else
         {
            _frame.startTurn(_currentPrizeItemSortID);
         }
      }
      
      private function _happyRechargeExchangeResponseHandler(pkg:PackageIn) : void
      {
         _ticketCount = pkg.readInt();
         dispatchEvent(new Event("HAPPYRECHARGE_UPDATE_TICKET"));
      }
      
      private function _happyRechargeOpenResponseHandler(pkg:PackageIn) : void
      {
         _isOpen = pkg.readBoolean();
         if(_isOpen)
         {
            createIcon();
         }
         else
         {
            removeIcon();
         }
      }
      
      private function _happyRechargeEnterResponseHandler(pkg:PackageIn) : void
      {
         var i:int = 0;
         var itemid:int = 0;
         var count:int = 0;
         var tvalid:int = 0;
         var tattributes:* = null;
         var index:int = 0;
         var tisbind:int = 0;
         var iteminfo:* = null;
         var j:int = 0;
         var exId:int = 0;
         var exCount:int = 0;
         var exValid:int = 0;
         var exAttribute:* = null;
         var ticketCount:int = 0;
         var exisbind:int = 0;
         var exchangeIteminfo:* = null;
         var k:int = 0;
         var recordItem:* = null;
         _moneyCount = pkg.readInt();
         _lotteryCount = pkg.readInt();
         _ticketCount = pkg.readInt();
         var startDate:Date = pkg.readDate();
         var endDate:Date = pkg.readDate();
         _createActivityDate(startDate,endDate);
         _prizeItemID = pkg.readInt();
         _prizeCount = pkg.readInt();
         var valid:int = pkg.readInt();
         var attributes:String = pkg.readUTF();
         var isbind:int = pkg.readInt();
         _prizeItem = __createPrizeItemInfo(_prizeItemID,_prizeCount,valid,attributes,isbind);
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
         var len:int = pkg.readInt();
         for(i = 0; i < len; )
         {
            itemid = pkg.readInt();
            count = pkg.readInt();
            tvalid = pkg.readInt();
            tattributes = pkg.readUTF();
            index = pkg.readInt();
            tisbind = pkg.readInt();
            iteminfo = _createTurnItemInfo(index,itemid,count,tvalid,tattributes,tisbind);
            _turnItems.push(iteminfo);
            i++;
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
         var len2:int = pkg.readInt();
         for(j = 0; j < len2; )
         {
            exId = pkg.readInt();
            exCount = pkg.readInt();
            exValid = pkg.readInt();
            exAttribute = pkg.readUTF();
            ticketCount = pkg.readUTF();
            exisbind = pkg.readInt();
            exchangeIteminfo = _createExchangeItemInfo(exId,exCount,exValid,exAttribute,ticketCount,exisbind);
            _exchangeItems.push(exchangeIteminfo);
            j++;
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
         var len3:int = pkg.readInt();
         for(k = 0; k < len3; )
         {
            recordItem = new HappyRechargeRecordItem();
            recordItem.prizeType = pkg.readInt();
            recordItem.count = pkg.readInt();
            recordItem.nickName = pkg.readUTF();
            _recordArr.push(recordItem);
            k++;
         }
         _frame = ComponentFactory.Instance.creatComponentByStylename("happyrecharge.mainframe");
         LayerManager.Instance.addToLayer(_frame,3,true,1);
      }
      
      private function _happyRechargeUpdateResponseHandler(pkg:PackageIn) : void
      {
         var prizetype:int = 0;
         var nickname:* = null;
         var count:int = 0;
         var item:* = null;
         var type:int = pkg.readInt();
         if(type == 1)
         {
            _prizeCount = pkg.readInt();
            prizetype = pkg.readInt();
            nickname = pkg.readUTF();
            count = pkg.readInt();
            if(_frame)
            {
               if(prizetype > 9 && prizetype < 13)
               {
                  item = new HappyRechargeRecordItem();
                  item.prizeType = prizetype;
                  item.nickName = nickname;
                  item.count = count;
               }
               _frame.updateView(item);
            }
         }
         else if(type == 2)
         {
            _lotteryCount = pkg.readInt();
         }
      }
      
      private function _createActivityDate(startDate:Date, endDate:Date) : void
      {
         if(startDate && endDate)
         {
            _activityData = startDate.getFullYear() + "/" + (startDate.getMonth() + 1) + "/" + startDate.getDate() + " " + startDate.getHours() + ":" + startDate.getMinutes() + ":" + startDate.getSeconds() + " - " + endDate.getFullYear() + "/" + (endDate.getMonth() + 1) + "/" + endDate.getDate() + " " + endDate.getHours() + ":" + endDate.getMinutes() + ":" + endDate.getSeconds();
         }
         else
         {
            _activityData = "1989/02/08 06:00:00 - ????/??/?? 00:00:00";
         }
      }
      
      private function __createPrizeItemInfo(itemid:int, count:int, valid:int, att:String, isbind:int) : InventoryItemInfo
      {
         var oinfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(itemid);
         var info:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(info,oinfo);
         info.ValidDate = valid;
         _createAttribute(info,att);
         info.IsBinds = isbind == 1?true:false;
         return info;
      }
      
      private function _createTurnItemInfo(index:int, itemid:int, count:int, valid:int, attri:String, isbind:int) : HappyRechargeTurnItemInfo
      {
         var iteminfo:HappyRechargeTurnItemInfo = new HappyRechargeTurnItemInfo();
         iteminfo.indexId = index;
         var oinfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(itemid);
         var info:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(info,oinfo);
         info.Count = count;
         info.ValidDate = Number(valid);
         _createAttribute(info,attri);
         iteminfo.itemInfo = info;
         iteminfo.itemInfo.IsBinds = isbind == 1?true:false;
         return iteminfo;
      }
      
      private function _createExchangeItemInfo(itemid:int, count:int, valid:int, att:String, ticket:int, isbind:int) : HappyRechargeExchangeItem
      {
         var exchangeItem:HappyRechargeExchangeItem = new HappyRechargeExchangeItem();
         var oinfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(itemid);
         var info:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(info,oinfo);
         info.Count = count;
         info.ValidDate = valid;
         info.IsBinds = isbind == 1?true:false;
         _createAttribute(info,att);
         exchangeItem.info = info;
         exchangeItem.count = count;
         exchangeItem.needCount = ticket;
         return exchangeItem;
      }
      
      private function _createAttribute(info:InventoryItemInfo, att:String) : void
      {
         var i:int = 0;
         var arr:Array = att.split(",");
         for(i = 0; i < arr.length; )
         {
            switch(int(i))
            {
               case 0:
                  info.StrengthenLevel = arr[i];
                  break;
               case 1:
                  info.AttackCompose = arr[i];
                  break;
               case 2:
                  info.DefendCompose = arr[i];
                  break;
               case 3:
                  info.AgilityCompose = arr[i];
                  break;
               case 4:
                  info.LuckCompose = arr[i];
                  break;
               case 5:
                  break;
               case 6:
                  info.MagicAttack = arr[i];
                  break;
               case 7:
                  info.MagicDefence = arr[i];
                  break;
               case 8:
                  info.StrengthenExp = arr[i];
            }
            i++;
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
      
      protected function onEnterClick(e:MouseEvent) : void
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
