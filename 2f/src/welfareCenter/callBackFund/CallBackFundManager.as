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
      
      public function CallBackFundManager(param1:IEventDispatcher = null){super();}
      
      public static function get instance() : CallBackFundManager{return null;}
      
      public function setup() : void{}
      
      public function templateDataSetup(param1:Array) : void{}
      
      public function createCell(param1:CallBackFundRewardInfo) : BagCell{return null;}
      
      public function getInventoryItemInfo(param1:CallBackFundRewardInfo) : InventoryItemInfo{return null;}
      
      private function onPackTypeBuyFund(param1:PkgEvent) : void{}
      
      private function onPackTypeGetFund(param1:PkgEvent) : void{}
      
      private function onPackTypeFundInfo(param1:PkgEvent) : void{}
      
      private function onCheckOpenTimer(param1:TimerEvent) : void{}
      
      public function getLeftReceiveTime() : int{return 0;}
      
      public function getBuyFundTimeAfter6Day() : Date{return null;}
      
      private function updateLastGetRewardTime() : void{}
      
      public function getTodayBindQuanNum() : int{return 0;}
      
      public function get isOpen() : Boolean{return false;}
      
      public function get state() : int{return 0;}
      
      public function set state(param1:int) : void{}
   }
}
