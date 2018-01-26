package wonderfulActivity
{
   import RechargeRank.RechargeRankManager;
   import activeEvents.data.ActiveEventsInfo;
   import calendar.CalendarManager;
   import carnivalActivity.RookieRankInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.image.MovieImage;
   import com.pickgliss.utils.ObjectUtils;
   import conRecharge.ConRechargeManager;
   import condiscount.CondiscountManager;
   import consumeRank.ConsumeRankManager;
   import dayActivity.ActivityTypeData;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import ddt.utils.FilterWordManager;
   import exchangeAct.ExchangeActManager;
   import flash.events.EventDispatcher;
   import flash.events.MouseEvent;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import flowerGiving.FlowerGivingManager;
   import foodActivity.FoodActivityManager;
   import hall.HallStateView;
   import panicBuying.PanicBuyingManager;
   import rank.RankManager;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   import roleRecharge.RoleRechargeMgr;
   import shop.view.ShopPresentClearingFrame;
   import signActivity.SignActivityMgr;
   import wonderfulActivity.analyer.WonderfulActAnalyer;
   import wonderfulActivity.analyer.WonderfulGMActAnalyer;
   import wonderfulActivity.data.CanGetData;
   import wonderfulActivity.data.GiftBagInfo;
   import wonderfulActivity.data.GiftCurInfo;
   import wonderfulActivity.data.GmActivityInfo;
   import wonderfulActivity.data.LeftViewInfoVo;
   import wonderfulActivity.data.PlayerCurInfo;
   import wonderfulActivity.event.WonderfulActivityEvent;
   import wonderfulActivity.limitActivity.SendGiftActivityFrame;
   
   public class WonderfulActivityManager extends EventDispatcher
   {
      
      private static var _instance:WonderfulActivityManager;
       
      
      public var activityData:Dictionary;
      
      private var _activityInitData:Dictionary;
      
      public var leftViewInfoDic:Dictionary;
      
      public var exchangeActLeftViewInfoDic:Dictionary;
      
      public var currentView;
      
      private var _sendGiftFrame:SendGiftActivityFrame;
      
      private var _info:GmActivityInfo;
      
      private var _actList:Array;
      
      public var activityTypeList:Vector.<ActivityTypeData>;
      
      public var activityFighterList:Vector.<ActivityTypeData>;
      
      public var activityExpList:Vector.<ActivityTypeData>;
      
      public var activityRechargeList:Vector.<ActivityTypeData>;
      
      public var chickenEndTime:Date;
      
      public var rouleEndTime:Date;
      
      private var _timerHanderFun:Dictionary;
      
      private var _timer:Timer;
      
      private var endRequestArr:Array;
      
      public var xiaoFeiScore:int;
      
      public var chongZhiScore:int;
      
      public var _stateList:Vector.<CanGetData>;
      
      public var deleWAIcon:Function;
      
      public var addWAIcon:Function;
      
      public var hasActivity:Boolean = false;
      
      public var isRuning:Boolean = true;
      
      public var currView:String;
      
      public var frameCanClose:Boolean = true;
      
      public var clickWonderfulActView:Boolean;
      
      public var stateDic:Dictionary;
      
      private var _wonderfulIcon:MovieImage;
      
      private var _hallView:HallStateView;
      
      private var _mutilIdMapping:Dictionary;
      
      private var _existentId:String;
      
      public var rankActDic:Dictionary;
      
      public var frameFlag:Boolean;
      
      public var isSkipFromHall:Boolean;
      
      public var skipType:String;
      
      public var leftUnitViewType:int;
      
      public var isExchangeAct:Boolean = false;
      
      private var lastActList:Array;
      
      public var rankDic:Dictionary;
      
      public var rankFlag:Boolean;
      
      private var sendGiftIsOut:Boolean = false;
      
      private var firstShowSendGiftFrame:Boolean = true;
      
      private var _currentItem:IShineableCell;
      
      private var _giveFriendOpenFrame:ShopPresentClearingFrame;
      
      private var _battleCompanionInfo:InventoryItemInfo;
      
      private var _eventsActiveDic:Dictionary;
      
      public var selectId:String = "";
      
      public function WonderfulActivityManager(){super();}
      
      public static function get Instance() : WonderfulActivityManager{return null;}
      
      public function get activityInitData() : Dictionary{return null;}
      
      public function set activityInitData(param1:Dictionary) : void{}
      
      public function setup() : void{}
      
      private function initAdvIdName() : void{}
      
      private function addEvents() : void{}
      
      protected function rookieRankHandler(param1:PkgEvent) : void{}
      
      private function activityInitHandler(param1:PkgEvent) : void{}
      
      private function refreshSingleActivity(param1:PackageIn) : void{}
      
      private function updateNewActivityXml() : void{}
      
      private function activityInit(param1:PackageIn) : void{}
      
      private function rechargeReturnHander(param1:PkgEvent) : void{}
      
      public function updateChargeActiveTemplateXml() : void{}
      
      private function dispatchCheckEvent() : void{}
      
      private function updateStateList(param1:CanGetData) : void{}
      
      private function endRequest() : void{}
      
      private function timerHander(param1:TimerEvent) : void{}
      
      public function addTimerFun(param1:String, param2:Function) : void{}
      
      public function delTimerFun(param1:String) : void{}
      
      private function isEmptyDictionary(param1:Dictionary) : Boolean{return false;}
      
      public function getTimeDiff(param1:Date, param2:Date) : String{return null;}
      
      private function fixZero(param1:uint) : String{return null;}
      
      private function setActivityTime(param1:int, param2:Date, param3:Date) : void{}
      
      public function wonderfulGMActiveInfo(param1:WonderfulGMActAnalyer) : void{}
      
      public function wonderfulActiveType(param1:WonderfulActAnalyer) : void{}
      
      private function initFrame(param1:Boolean = false, param2:String = "0") : void{}
      
      private function loadResouce() : void{}
      
      private function loadComplete() : void{}
      
      public function addElement(param1:*) : void{}
      
      public function removeElement(param1:*) : void{}
      
      public function dispose() : void{}
      
      public function updateRealEndTime() : void{}
      
      private function checkActivity(param1:int = 0) : void{}
      
      public function checkShowSendGiftFrame() : void{}
      
      public function refreshIconStatus() : void{}
      
      public function getActIdWithViewId(param1:int) : String{return null;}
      
      private function checkActState() : void{}
      
      public function currentItem(param1:IShineableCell) : void{}
      
      private function typeNeedShine(param1:int) : Boolean{return false;}
      
      public function useBattleCompanion(param1:InventoryItemInfo) : void{}
      
      private function __responseHandler2(param1:FrameEvent) : void{}
      
      private function removeBattleCompanion() : void{}
      
      private function __presentBtnClick(param1:MouseEvent) : void{}
      
      private function getTodayList() : Array{return null;}
      
      public function get eventsActiveDic() : Dictionary{return null;}
      
      public function getActiveEventsInfoByID(param1:int) : ActiveEventsInfo{return null;}
      
      public function setLimitActivities(param1:Array) : void{}
      
      public function getActivityDataById(param1:String) : GmActivityInfo{return null;}
      
      public function getActivityInitDataById(param1:String) : Object{return null;}
      
      public function get sendFrame() : SendGiftActivityFrame{return null;}
      
      public function get actList() : Array{return null;}
   }
}
