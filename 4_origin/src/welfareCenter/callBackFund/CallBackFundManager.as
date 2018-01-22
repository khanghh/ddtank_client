package welfareCenter.callBackFund
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import welfareCenter.WelfareCenterManager;
   
   public class CallBackFundManager extends EventDispatcher
   {
      
      public static const EVENT_STATE_CHANGE:String = "event_state_change";
      
      public static const STATE_QUICK_BUY:int = 0;
      
      public static const STATE_QUICK_RECEIVE:int = 1;
      
      public static const STATE_TOMORROW_COME:int = 2;
      
      public static const STATE_RECEIVE_OVER:int = 3;
      
      private static var _instance:CallBackFundManager;
       
      
      private var _state:int;
      
      private var _isOpen:Boolean;
      
      public var startTime:Date;
      
      public var endTime:Date;
      
      public var buyFundTime:Date;
      
      public var lastGetRewardTime:Date;
      
      public var isBuyFund:Boolean;
      
      public var firstReturnCount:int;
      
      public var dailyReturnCount:int;
      
      public var buyFundCount:int;
      
      public var totalReturnCount:int;
      
      private var _timer:Timer;
      
      public var downRewardInfoList:Array;
      
      public var dailyRewardInfoList:Array;
      
      public function CallBackFundManager(param1:IEventDispatcher = null)
      {
         super();
         _instance = this;
      }
      
      public static function get instance() : CallBackFundManager
      {
         if(_instance == null)
         {
            _instance = new CallBackFundManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(343,1),onPackTypeBuyFund);
         SocketManager.Instance.addEventListener(PkgEvent.format(343,2),onPackTypeGetFund);
         SocketManager.Instance.addEventListener(PkgEvent.format(343,7),onPackTypeFundInfo);
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(param1)
         {
            downRewardInfoList = [];
            dailyRewardInfoList = [];
            _loc3_ = 0;
            while(_loc3_ < param1.length)
            {
               _loc2_ = param1[_loc3_];
               if(_loc2_.Quality == 1)
               {
                  downRewardInfoList.push(_loc2_);
               }
               else
               {
                  dailyRewardInfoList.push(_loc2_);
               }
               _loc3_++;
            }
         }
      }
      
      public function createCell(param1:CallBackFundRewardInfo) : BagCell
      {
         var _loc3_:InventoryItemInfo = CallBackFundManager.instance.getInventoryItemInfo(param1);
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc2_:BagCell = new BagCell(0,_loc3_,true);
         _loc2_.width = 64;
         _loc2_.height = 64;
         _loc2_.setCount(_loc3_.Count);
         return _loc2_;
      }
      
      public function getInventoryItemInfo(param1:CallBackFundRewardInfo) : InventoryItemInfo
      {
         var _loc3_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1.TemplateID);
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(_loc2_,_loc3_);
         _loc2_.LuckCompose = param1.TemplateID;
         _loc2_.ValidDate = param1.ValidDate;
         _loc2_.Count = param1.Count;
         _loc2_.IsBinds = param1.IsBind;
         _loc2_.StrengthenLevel = param1.StrengthLevel;
         _loc2_.AttackCompose = param1.AttackCompose;
         _loc2_.DefendCompose = param1.DefendCompose;
         _loc2_.AgilityCompose = param1.AgilityCompose;
         _loc2_.LuckCompose = param1.LuckCompose;
         return _loc2_;
      }
      
      private function onPackTypeBuyFund(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         isBuyFund = _loc2_.readBoolean();
         buyFundTime = _loc2_.readDate();
         updateLastGetRewardTime();
         dispatchEvent(new Event("event_state_change"));
      }
      
      private function onPackTypeGetFund(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         lastGetRewardTime = _loc2_.readDate();
         updateLastGetRewardTime();
         if(_state == 3)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("callBackFund.frame.receiveOverTip"));
            _isOpen = false;
            WelfareCenterManager.instance.showMainIcon();
         }
         dispatchEvent(new Event("event_state_change"));
      }
      
      private function onPackTypeFundInfo(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         startTime = _loc2_.readDate();
         endTime = _loc2_.readDate();
         buyFundTime = _loc2_.readDate();
         lastGetRewardTime = _loc2_.readDate();
         isBuyFund = _loc2_.readBoolean();
         firstReturnCount = _loc2_.readInt();
         dailyReturnCount = _loc2_.readInt();
         buyFundCount = _loc2_.readInt();
         totalReturnCount = firstReturnCount + 6 * dailyReturnCount;
         updateLastGetRewardTime();
         var _loc3_:Number = TimeManager.Instance.NowTime();
         _isOpen = PlayerManager.Instance.Self.isOld2 && (!isBuyFund && _loc3_ >= startTime.time && _loc3_ <= endTime.time || isBuyFund && _state != 3);
         if(PlayerManager.Instance.Self.isOld2 && (!isBuyFund && _loc3_ >= startTime.time && _loc3_ <= endTime.time))
         {
            if(_timer)
            {
               _timer.reset();
            }
            else
            {
               _timer = new Timer(1000,2147483647);
            }
            _timer.start();
            _timer.addEventListener("timer",onCheckOpenTimer);
         }
         WelfareCenterManager.instance.showMainIcon();
      }
      
      private function onCheckOpenTimer(param1:TimerEvent) : void
      {
         var _loc2_:Number = TimeManager.Instance.NowTime();
         _isOpen = PlayerManager.Instance.Self.isOld2 && (!isBuyFund && _loc2_ >= startTime.time && _loc2_ <= endTime.time || isBuyFund && _state != 3);
         if(!_isOpen)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onCheckOpenTimer);
            WelfareCenterManager.instance.showMainIcon();
         }
      }
      
      public function getLeftReceiveTime() : int
      {
         var _loc1_:Date = getBuyFundTimeAfter6Day();
         return int((_loc1_.time - lastGetRewardTime.time) / 86400000);
      }
      
      public function getBuyFundTimeAfter6Day() : Date
      {
         var _loc1_:Date = new Date(buyFundTime.time + 518400000);
         _loc1_.hours = 23;
         _loc1_.minutes = 59;
         _loc1_.seconds = 59;
         return _loc1_;
      }
      
      private function updateLastGetRewardTime() : void
      {
         var _loc2_:* = null;
         var _loc1_:Date = TimeManager.Instance.Now();
         _state = 0;
         if(isBuyFund)
         {
            _loc2_ = getBuyFundTimeAfter6Day();
            if(_loc2_.time > _loc1_.time)
            {
               if(_loc1_.fullYear == lastGetRewardTime.fullYear && _loc1_.month == lastGetRewardTime.month && _loc1_.date == lastGetRewardTime.date)
               {
                  if(_loc2_.date == lastGetRewardTime.date)
                  {
                     _state = 3;
                  }
                  else
                  {
                     _state = 2;
                  }
               }
               else
               {
                  _state = 1;
               }
            }
            else
            {
               _state = 3;
            }
         }
         WelfareCenterManager.instance.checkShineIcon();
      }
      
      public function getTodayBindQuanNum() : int
      {
         var _loc1_:Date = TimeManager.Instance.Now();
         if(_loc1_.fullYear == buyFundTime.fullYear && _loc1_.month == buyFundTime.month && _loc1_.date == buyFundTime.date)
         {
            return firstReturnCount;
         }
         return dailyReturnCount;
      }
      
      public function get isOpen() : Boolean
      {
         return _isOpen;
      }
      
      public function get state() : int
      {
         return _state;
      }
      
      public function set state(param1:int) : void
      {
         _state = param1;
      }
   }
}
