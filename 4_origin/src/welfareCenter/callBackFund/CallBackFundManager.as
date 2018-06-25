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
      
      public function CallBackFundManager(target:IEventDispatcher = null)
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
      
      public function templateDataSetup(dataList:Array) : void
      {
         var i:int = 0;
         var info:* = null;
         if(dataList)
         {
            downRewardInfoList = [];
            dailyRewardInfoList = [];
            for(i = 0; i < dataList.length; )
            {
               info = dataList[i];
               if(info.Quality == 1)
               {
                  downRewardInfoList.push(info);
               }
               else
               {
                  dailyRewardInfoList.push(info);
               }
               i++;
            }
         }
      }
      
      public function createCell(info:CallBackFundRewardInfo) : BagCell
      {
         var itemInfo:InventoryItemInfo = CallBackFundManager.instance.getInventoryItemInfo(info);
         if(itemInfo == null)
         {
            return null;
         }
         var _cell:BagCell = new BagCell(0,itemInfo,true);
         _cell.width = 64;
         _cell.height = 64;
         _cell.setCount(itemInfo.Count);
         return _cell;
      }
      
      public function getInventoryItemInfo(info:CallBackFundRewardInfo) : InventoryItemInfo
      {
         var tempInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(info.TemplateID);
         var tInfo:InventoryItemInfo = new InventoryItemInfo();
         ObjectUtils.copyProperties(tInfo,tempInfo);
         tInfo.LuckCompose = info.TemplateID;
         tInfo.ValidDate = info.ValidDate;
         tInfo.Count = info.Count;
         tInfo.IsBinds = info.IsBind;
         tInfo.StrengthenLevel = info.StrengthLevel;
         tInfo.AttackCompose = info.AttackCompose;
         tInfo.DefendCompose = info.DefendCompose;
         tInfo.AgilityCompose = info.AgilityCompose;
         tInfo.LuckCompose = info.LuckCompose;
         return tInfo;
      }
      
      private function onPackTypeBuyFund(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         isBuyFund = pkg.readBoolean();
         buyFundTime = pkg.readDate();
         updateLastGetRewardTime();
         dispatchEvent(new Event("event_state_change"));
      }
      
      private function onPackTypeGetFund(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         lastGetRewardTime = pkg.readDate();
         updateLastGetRewardTime();
         if(_state == 3)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("callBackFund.frame.receiveOverTip"));
            _isOpen = false;
            WelfareCenterManager.instance.showMainIcon();
         }
         dispatchEvent(new Event("event_state_change"));
      }
      
      private function onPackTypeFundInfo(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         startTime = pkg.readDate();
         endTime = pkg.readDate();
         buyFundTime = pkg.readDate();
         lastGetRewardTime = pkg.readDate();
         isBuyFund = pkg.readBoolean();
         firstReturnCount = pkg.readInt();
         dailyReturnCount = pkg.readInt();
         buyFundCount = pkg.readInt();
         totalReturnCount = firstReturnCount + 6 * dailyReturnCount;
         updateLastGetRewardTime();
         var nowDateTime:Number = TimeManager.Instance.NowTime();
         _isOpen = PlayerManager.Instance.Self.isOld2 && (!isBuyFund && nowDateTime >= startTime.time && nowDateTime <= endTime.time || isBuyFund && _state != 3);
         if(PlayerManager.Instance.Self.isOld2 && (!isBuyFund && nowDateTime >= startTime.time && nowDateTime <= endTime.time))
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
      
      private function onCheckOpenTimer(evt:TimerEvent) : void
      {
         var nowDateTime:Number = TimeManager.Instance.NowTime();
         _isOpen = PlayerManager.Instance.Self.isOld2 && (!isBuyFund && nowDateTime >= startTime.time && nowDateTime <= endTime.time || isBuyFund && _state != 3);
         if(!_isOpen)
         {
            _timer.stop();
            _timer.removeEventListener("timer",onCheckOpenTimer);
            WelfareCenterManager.instance.showMainIcon();
         }
      }
      
      public function getLeftReceiveTime() : int
      {
         var buyFundTimeAfter6Day:Date = getBuyFundTimeAfter6Day();
         return int((buyFundTimeAfter6Day.time - lastGetRewardTime.time) / 86400000);
      }
      
      public function getBuyFundTimeAfter6Day() : Date
      {
         var buyFundTimeAfter6Day:Date = new Date(buyFundTime.time + 518400000);
         buyFundTimeAfter6Day.hours = 23;
         buyFundTimeAfter6Day.minutes = 59;
         buyFundTimeAfter6Day.seconds = 59;
         return buyFundTimeAfter6Day;
      }
      
      private function updateLastGetRewardTime() : void
      {
         var buyFundTimeAfter6Day:* = null;
         var nowDate:Date = TimeManager.Instance.Now();
         _state = 0;
         if(isBuyFund)
         {
            buyFundTimeAfter6Day = getBuyFundTimeAfter6Day();
            if(buyFundTimeAfter6Day.time > nowDate.time)
            {
               if(nowDate.fullYear == lastGetRewardTime.fullYear && nowDate.month == lastGetRewardTime.month && nowDate.date == lastGetRewardTime.date)
               {
                  if(buyFundTimeAfter6Day.date == lastGetRewardTime.date)
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
         var nowDate:Date = TimeManager.Instance.Now();
         if(nowDate.fullYear == buyFundTime.fullYear && nowDate.month == buyFundTime.month && nowDate.date == buyFundTime.date)
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
      
      public function set state(value:int) : void
      {
         _state = value;
      }
   }
}
