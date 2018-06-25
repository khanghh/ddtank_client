package wonderfulActivity{   import RechargeRank.RechargeRankManager;   import activeEvents.data.ActiveEventsInfo;   import calendar.CalendarManager;   import carnivalActivity.RookieRankInfo;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.utils.ObjectUtils;   import conRecharge.ConRechargeManager;   import condiscount.CondiscountManager;   import consumeRank.ConsumeRankManager;   import dayActivity.ActivityTypeData;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.PkgEvent;   import ddt.loader.LoaderCreate;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.manager.TimeManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.FilterWordManager;   import exchangeAct.ExchangeActManager;   import flash.events.EventDispatcher;   import flash.events.MouseEvent;   import flash.events.TimerEvent;   import flash.utils.Dictionary;   import flash.utils.Timer;   import flowerGiving.FlowerGivingManager;   import foodActivity.FoodActivityManager;   import hall.HallStateView;   import panicBuying.PanicBuyingManager;   import rank.RankManager;   import road7th.comm.PackageIn;   import road7th.utils.DateUtils;   import roleRecharge.RoleRechargeMgr;   import shop.view.ShopPresentClearingFrame;   import signActivity.SignActivityMgr;   import wonderfulActivity.analyer.WonderfulActAnalyer;   import wonderfulActivity.analyer.WonderfulGMActAnalyer;   import wonderfulActivity.data.CanGetData;   import wonderfulActivity.data.GiftBagInfo;   import wonderfulActivity.data.GiftCurInfo;   import wonderfulActivity.data.GmActivityInfo;   import wonderfulActivity.data.LeftViewInfoVo;   import wonderfulActivity.data.PlayerCurInfo;   import wonderfulActivity.event.WonderfulActivityEvent;   import wonderfulActivity.limitActivity.SendGiftActivityFrame;      public class WonderfulActivityManager extends EventDispatcher   {            private static var _instance:WonderfulActivityManager;                   public var activityData:Dictionary;            private var _activityInitData:Dictionary;            public var leftViewInfoDic:Dictionary;            public var exchangeActLeftViewInfoDic:Dictionary;            public var currentView;            private var _sendGiftFrame:SendGiftActivityFrame;            private var _info:GmActivityInfo;            private var _actList:Array;            public var activityTypeList:Vector.<ActivityTypeData>;            public var activityFighterList:Vector.<ActivityTypeData>;            public var activityExpList:Vector.<ActivityTypeData>;            public var activityRechargeList:Vector.<ActivityTypeData>;            public var chickenEndTime:Date;            public var rouleEndTime:Date;            private var _timerHanderFun:Dictionary;            private var _timer:Timer;            private var endRequestArr:Array;            public var xiaoFeiScore:int;            public var chongZhiScore:int;            public var _stateList:Vector.<CanGetData>;            public var deleWAIcon:Function;            public var addWAIcon:Function;            public var hasActivity:Boolean = false;            public var isRuning:Boolean = true;            public var currView:String;            public var frameCanClose:Boolean = true;            public var clickWonderfulActView:Boolean;            public var stateDic:Dictionary;            private var _wonderfulIcon:MovieImage;            private var _hallView:HallStateView;            private var _mutilIdMapping:Dictionary;            private var _existentId:String;            public var rankActDic:Dictionary;            public var frameFlag:Boolean;            public var isSkipFromHall:Boolean;            public var skipType:String;            public var leftUnitViewType:int;            public var isExchangeAct:Boolean = false;            private var lastActList:Array;            public var rankDic:Dictionary;            public var rankFlag:Boolean;            private var sendGiftIsOut:Boolean = false;            private var firstShowSendGiftFrame:Boolean = true;            private var _currentItem:IShineableCell;            private var _giveFriendOpenFrame:ShopPresentClearingFrame;            private var _battleCompanionInfo:InventoryItemInfo;            private var _eventsActiveDic:Dictionary;            public var selectId:String = "";            public function WonderfulActivityManager() { super(); }
            public static function get Instance() : WonderfulActivityManager { return null; }
            public function get activityInitData() : Dictionary { return null; }
            public function set activityInitData(value:Dictionary) : void { }
            public function setup() : void { }
            private function initAdvIdName() : void { }
            private function addEvents() : void { }
            protected function rookieRankHandler(event:PkgEvent) : void { }
            private function activityInitHandler(event:PkgEvent) : void { }
            private function refreshSingleActivity(pkg:PackageIn) : void { }
            private function updateNewActivityXml() : void { }
            private function activityInit(pkg:PackageIn) : void { }
            private function rechargeReturnHander(e:PkgEvent) : void { }
            public function updateChargeActiveTemplateXml() : void { }
            private function dispatchCheckEvent() : void { }
            private function updateStateList(data:CanGetData) : void { }
            private function endRequest() : void { }
            private function timerHander(event:TimerEvent) : void { }
            public function addTimerFun(key:String, fun:Function) : void { }
            public function delTimerFun(key:String) : void { }
            private function isEmptyDictionary(dic:Dictionary) : Boolean { return false; }
            public function getTimeDiff(endDate:Date, nowDate:Date) : String { return null; }
            private function fixZero(num:uint) : String { return null; }
            private function setActivityTime(id:int, start:Date, end:Date) : void { }
            public function wonderfulGMActiveInfo(analyer:WonderfulGMActAnalyer) : void { }
            public function wonderfulActiveType(analy:WonderfulActAnalyer) : void { }
            private function initFrame(SkipFromHall:Boolean = false, type:String = "0") : void { }
            private function loadResouce() : void { }
            private function loadComplete() : void { }
            public function addElement(activityID:*) : void { }
            public function removeElement(activityID:*) : void { }
            public function dispose() : void { }
            public function updateRealEndTime() : void { }
            private function checkActivity(_type:int = 0) : void { }
            public function checkShowSendGiftFrame() : void { }
            public function refreshIconStatus() : void { }
            public function getActIdWithViewId(viewId:int) : String { return null; }
            private function checkActState() : void { }
            public function currentItem(item:IShineableCell) : void { }
            private function typeNeedShine(type:int) : Boolean { return false; }
            public function useBattleCompanion(info:InventoryItemInfo) : void { }
            private function __responseHandler2(event:FrameEvent) : void { }
            private function removeBattleCompanion() : void { }
            private function __presentBtnClick(event:MouseEvent) : void { }
            private function getTodayList() : Array { return null; }
            public function get eventsActiveDic() : Dictionary { return null; }
            public function getActiveEventsInfoByID(id:int) : ActiveEventsInfo { return null; }
            public function setLimitActivities(activities:Array) : void { }
            public function getActivityDataById(actId:String) : GmActivityInfo { return null; }
            public function getActivityInitDataById(actId:String) : Object { return null; }
            public function get sendFrame() : SendGiftActivityFrame { return null; }
            public function get actList() : Array { return null; }
   }}