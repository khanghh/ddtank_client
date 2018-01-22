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
      
      public function WonderfulActivityManager()
      {
         lastActList = [];
         super();
         _actList = [];
         _timerHanderFun = new Dictionary();
         _stateList = new Vector.<CanGetData>();
         activityInitData = new Dictionary();
         leftViewInfoDic = new Dictionary();
         exchangeActLeftViewInfoDic = new Dictionary();
         activityFighterList = new Vector.<ActivityTypeData>();
         activityExpList = new Vector.<ActivityTypeData>();
         activityRechargeList = new Vector.<ActivityTypeData>();
         stateDic = new Dictionary();
         _mutilIdMapping = new Dictionary();
         rankActDic = new Dictionary();
         rankDic = new Dictionary();
         endRequestArr = [];
      }
      
      public static function get Instance() : WonderfulActivityManager
      {
         if(!_instance)
         {
            _instance = new WonderfulActivityManager();
         }
         return _instance;
      }
      
      public function get activityInitData() : Dictionary
      {
         return _activityInitData;
      }
      
      public function set activityInitData(param1:Dictionary) : void
      {
         _activityInitData = param1;
      }
      
      public function setup() : void
      {
         initAdvIdName();
         addEvents();
         ConsumeRankManager.instance.setup();
         RechargeRankManager.instance.setup();
      }
      
      private function initAdvIdName() : void
      {
         leftViewInfoDic[3001] = new LeftViewInfoVo(3001,LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt1"));
         leftViewInfoDic[4001] = new LeftViewInfoVo(4001,LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt2"));
         leftViewInfoDic[2001] = new LeftViewInfoVo(2001,LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt6"));
         leftViewInfoDic[50] = new LeftViewInfoVo(50,LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt17"));
         leftViewInfoDic[51] = new LeftViewInfoVo(51,LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt18"));
         exchangeActLeftViewInfoDic[20] = new LeftViewInfoVo(20,LanguageMgr.GetTranslation("wonderfulActivityManager.btnTxt16"));
      }
      
      private function addEvents() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(159),rechargeReturnHander);
         SocketManager.Instance.addEventListener(PkgEvent.format(405),activityInitHandler);
         SocketManager.Instance.addEventListener(PkgEvent.format(286),rookieRankHandler);
      }
      
      protected function rookieRankHandler(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc7_:* = null;
         var _loc9_:int = 0;
         var _loc8_:* = null;
         var _loc5_:PackageIn = param1.pkg;
         var _loc4_:int = _loc5_.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc4_)
         {
            _loc2_ = _loc5_.readUTF();
            _loc3_ = _loc5_.readInt();
            _loc7_ = [];
            _loc9_ = 0;
            while(_loc9_ < _loc3_)
            {
               _loc8_ = new RookieRankInfo();
               _loc8_.userId = _loc5_.readInt();
               _loc8_.rank = _loc5_.readInt();
               _loc8_.playerName = _loc5_.readUTF();
               _loc8_.fightPower = _loc5_.readInt();
               _loc7_.push(_loc8_);
               _loc9_++;
            }
            if(_loc7_.length > 10)
            {
               _loc7_ = _loc7_.slice(0,10);
            }
            _loc7_.sortOn("rank",16);
            rankActDic[_loc2_] = _loc7_;
            _loc6_++;
         }
      }
      
      private function activityInitHandler(param1:PkgEvent) : void
      {
         var _loc3_:int = 0;
         var _loc2_:PackageIn = param1.pkg;
         _loc3_ = _loc2_.readInt();
         if(_loc3_ == 0)
         {
            updateNewActivityXml();
            SocketManager.Instance.out.requestWonderfulActInit(2);
            SocketManager.Instance.out.requestWonderfulActInit(3);
         }
         else if(_loc3_ == 1)
         {
            activityInit(_loc2_);
            checkActivity();
            initFrame(isSkipFromHall,skipType);
            SocketManager.Instance.out.updateConsumeRank();
            SocketManager.Instance.out.updateRechargeRank();
            SocketManager.Instance.out.sendWonderfulActivity(0,-1);
         }
         else if(_loc3_ == 2)
         {
            activityInit(_loc2_);
            checkActivity(_loc3_);
            dispatchEvent(new WonderfulActivityEvent("refresh"));
         }
         else if(_loc3_ == 3)
         {
            refreshSingleActivity(_loc2_);
            dispatchEvent(new WonderfulActivityEvent("refresh"));
         }
      }
      
      private function refreshSingleActivity(param1:PackageIn) : void
      {
         var _loc8_:int = 0;
         var _loc6_:* = null;
         var _loc10_:int = 0;
         var _loc3_:* = null;
         var _loc11_:* = null;
         var _loc7_:int = param1.readInt();
         if(_loc7_ == 0)
         {
            return;
         }
         var _loc5_:String = param1.readUTF();
         var _loc12_:int = param1.readInt();
         var _loc9_:Array = [];
         _loc8_ = 0;
         while(_loc8_ <= _loc12_ - 1)
         {
            _loc6_ = new PlayerCurInfo();
            _loc6_.statusID = param1.readInt();
            _loc6_.statusValue = param1.readInt();
            _loc9_.push(_loc6_);
            _loc8_++;
         }
         var _loc4_:int = param1.readInt();
         var _loc2_:Dictionary = new Dictionary();
         _loc10_ = 0;
         while(_loc10_ <= _loc4_ - 1)
         {
            _loc3_ = new GiftCurInfo();
            _loc11_ = param1.readUTF();
            _loc3_.times = param1.readInt();
            _loc3_.allGiftGetTimes = param1.readInt();
            _loc2_[_loc11_] = _loc3_;
            _loc10_++;
         }
         activityInitData[_loc5_] = {
            "statusArr":_loc9_,
            "giftInfoDic":_loc2_
         };
         if(!leftViewInfoDic[_loc5_] && !exchangeActLeftViewInfoDic[_loc5_])
         {
            _loc5_ = _mutilIdMapping[_loc5_];
         }
         if(currentView && currentView.hasOwnProperty("updateAwardState"))
         {
            currentView.updateAwardState();
         }
      }
      
      private function updateNewActivityXml() : void
      {
         var _loc1_:BaseLoader = LoaderCreate.Instance.loadWonderfulActivityXml();
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function activityInit(param1:PackageIn) : void
      {
         var _loc9_:int = 0;
         var _loc3_:* = null;
         var _loc12_:int = 0;
         var _loc6_:* = null;
         var _loc7_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = 0;
         var _loc10_:* = null;
         var _loc8_:int = 0;
         var _loc2_:* = null;
         var _loc13_:* = null;
         var _loc11_:int = param1.readInt();
         _loc9_ = 0;
         while(_loc9_ <= _loc11_ - 1)
         {
            _loc3_ = param1.readUTF();
            _loc12_ = param1.readInt();
            _loc6_ = [];
            _loc7_ = 0;
            while(_loc7_ <= _loc12_ - 1)
            {
               _loc5_ = new PlayerCurInfo();
               _loc5_.statusID = param1.readInt();
               _loc5_.statusValue = param1.readInt();
               _loc6_.push(_loc5_);
               _loc7_++;
            }
            _loc4_ = param1.readInt();
            _loc10_ = new Dictionary();
            _loc8_ = 0;
            while(_loc8_ <= _loc4_ - 1)
            {
               _loc2_ = new GiftCurInfo();
               _loc13_ = param1.readUTF();
               _loc2_.times = param1.readInt();
               _loc2_.allGiftGetTimes = param1.readInt();
               _loc10_[_loc13_] = _loc2_;
               _loc8_++;
            }
            activityInitData[_loc3_] = {
               "statusArr":_loc6_,
               "giftInfoDic":_loc10_
            };
            _loc9_++;
         }
      }
      
      private function rechargeReturnHander(param1:PkgEvent) : void
      {
         var _loc8_:int = 0;
         var _loc2_:int = 0;
         var _loc9_:* = null;
         var _loc6_:* = null;
         var _loc3_:* = null;
         var _loc4_:* = null;
         var _loc7_:int = 0;
         var _loc13_:int = 0;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:* = null;
         var _loc5_:int = param1.pkg.readByte();
         if(_loc5_ == 2)
         {
            if(StateManager.currentStateType == "main" || frameFlag)
            {
               _loc3_ = LoaderCreate.Instance.firstRechargeLoader();
               LoadResourceManager.Instance.startLoad(_loc3_);
            }
         }
         else if(_loc5_ == 0)
         {
            _loc2_ = param1.pkg.readInt();
            _loc7_ = 0;
            while(_loc7_ < _loc2_)
            {
               _loc13_ = -1;
               _loc4_ = new CanGetData();
               _loc4_.id = param1.pkg.readInt();
               var _loc14_:* = _loc4_.id;
               if(2001 !== _loc14_)
               {
                  if(3001 !== _loc14_)
                  {
                     if(4001 !== _loc14_)
                     {
                        _loc11_ = param1.pkg.readInt();
                     }
                     else
                     {
                        _loc13_ = 4001;
                        xiaoFeiScore = param1.pkg.readInt();
                     }
                  }
                  else
                  {
                     _loc13_ = 3001;
                     chongZhiScore = param1.pkg.readInt();
                  }
               }
               else
               {
                  _loc13_ = 2001;
                  _loc10_ = param1.pkg.readInt();
               }
               _loc4_.num = param1.pkg.readInt();
               _loc9_ = param1.pkg.readDate();
               _loc6_ = param1.pkg.readDate();
               setActivityTime(_loc4_.id,_loc9_,_loc6_);
               updateStateList(_loc4_);
               if(_loc13_ != -1)
               {
                  _loc12_ = TimeManager.Instance.Now();
                  if(_loc12_.getTime() > _loc9_.getTime() && _loc12_.getTime() < _loc6_.getTime() && _loc4_.num != -2)
                  {
                     addElement(_loc13_);
                  }
                  else
                  {
                     removeElement(_loc13_);
                  }
               }
               _loc7_++;
            }
            if(_loc2_ == 1)
            {
               if(!_loc4_)
               {
               }
            }
         }
      }
      
      public function updateChargeActiveTemplateXml() : void
      {
         var _loc1_:BaseLoader = LoaderCreate.Instance.creatWondActiveLoader();
         LoadResourceManager.Instance.startLoad(_loc1_);
      }
      
      private function dispatchCheckEvent() : void
      {
         if(!frameFlag && !clickWonderfulActView)
         {
            dispatchEvent(new WonderfulActivityEvent("check_activity_state"));
         }
      }
      
      private function updateStateList(param1:CanGetData) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = _stateList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1.id == _stateList[_loc3_].id)
            {
               _stateList[_loc3_] = param1;
               return;
            }
            _loc3_++;
         }
         _stateList.push(param1);
      }
      
      private function endRequest() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc1_:Number = NaN;
         var _loc2_:Date = TimeManager.Instance.Now();
         _loc4_ = 0;
         while(_loc4_ <= endRequestArr.length - 1)
         {
            _loc3_ = DateUtils.getDateByStr(endRequestArr[_loc4_]);
            _loc1_ = Math.round((_loc3_.getTime() - _loc2_.getTime()) / 1000);
            if(_loc1_ <= 0)
            {
               endRequestArr.splice(_loc4_,1);
               SocketManager.Instance.out.requestWonderfulActInit(2);
            }
            _loc4_++;
         }
      }
      
      private function timerHander(param1:TimerEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _timerHanderFun;
         for each(var _loc2_ in _timerHanderFun)
         {
            _loc2_();
         }
      }
      
      public function addTimerFun(param1:String, param2:Function) : void
      {
         _timerHanderFun[param1] = param2;
         if(!_timer)
         {
            _timer = new Timer(1000);
            _timer.start();
            _timer.addEventListener("timer",timerHander);
         }
      }
      
      public function delTimerFun(param1:String) : void
      {
         if(_timerHanderFun[param1])
         {
            delete _timerHanderFun[param1];
         }
         if(isEmptyDictionary(_timerHanderFun))
         {
            if(_timer)
            {
               _timer.stop();
               _timer.removeEventListener("timer",timerHander);
               _timer = null;
            }
         }
      }
      
      private function isEmptyDictionary(param1:Dictionary) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = param1;
         for(var _loc2_ in param1)
         {
            if(_loc2_)
            {
               return false;
            }
         }
         return true;
      }
      
      public function getTimeDiff(param1:Date, param2:Date) : String
      {
         var _loc3_:* = 0;
         var _loc7_:* = 0;
         var _loc6_:* = 0;
         var _loc4_:* = 0;
         var _loc5_:Number = Math.round((param1.getTime() - param2.getTime()) / 1000);
         if(_loc5_ >= 0)
         {
            _loc3_ = uint(Math.floor(_loc5_ / 60 / 60 / 24));
            _loc5_ = _loc5_ % 86400;
            _loc7_ = uint(Math.floor(_loc5_ / 60 / 60));
            _loc5_ = _loc5_ % 3600;
            _loc6_ = uint(Math.floor(_loc5_ / 60));
            _loc4_ = uint(_loc5_ % 60);
            if(_loc3_ > 0)
            {
               return _loc3_ + LanguageMgr.GetTranslation("wonderfulActivityManager.d");
            }
            if(_loc7_ > 0)
            {
               return fixZero(_loc7_) + LanguageMgr.GetTranslation("wonderfulActivityManager.h");
            }
            if(_loc6_ > 0)
            {
               return fixZero(_loc6_) + LanguageMgr.GetTranslation("wonderfulActivityManager.m");
            }
            if(_loc4_ > 0)
            {
               return fixZero(_loc4_) + LanguageMgr.GetTranslation("wonderfulActivityManager.s");
            }
         }
         return "0";
      }
      
      private function fixZero(param1:uint) : String
      {
         return param1 < 10?String(param1):String(param1);
      }
      
      private function setActivityTime(param1:int, param2:Date, param3:Date) : void
      {
         var _loc5_:int = 0;
         var _loc4_:int = 0;
         if(param1 == 2001)
         {
            if(activityFighterList.length == 0)
            {
               return;
            }
            activityFighterList[0].StartTime = param2;
            activityFighterList[0].EndTime = param3;
         }
         else if(param1 >= 3001 && param1 < 4001)
         {
            if(activityRechargeList.length == 0)
            {
               return;
            }
            _loc5_ = 0;
            while(_loc5_ < activityRechargeList.length)
            {
               if(param1 == activityRechargeList[_loc5_].ID)
               {
                  activityRechargeList[_loc5_].StartTime = param2;
                  activityRechargeList[_loc5_].EndTime = param3;
                  break;
               }
               _loc5_++;
            }
         }
         else if(param1 >= 4001)
         {
            if(activityExpList.length == 0)
            {
               return;
            }
            _loc4_ = 0;
            while(_loc4_ < activityExpList.length)
            {
               if(param1 == activityExpList[_loc5_].ID)
               {
                  activityExpList[_loc5_].StartTime = param2;
                  activityExpList[_loc5_].EndTime = param3;
                  break;
               }
               _loc4_++;
            }
         }
      }
      
      public function wonderfulGMActiveInfo(param1:WonderfulGMActAnalyer) : void
      {
         activityData = param1.ActivityData;
         updateRealEndTime();
         FlowerGivingManager.instance.checkOpen();
         FoodActivityManager.Instance.checkOpen();
         PanicBuyingManager.instance.checkOpen();
         SocketManager.Instance.out.updateRechargeRank();
         SocketManager.Instance.out.requestWonderfulActInit(2);
      }
      
      public function wonderfulActiveType(param1:WonderfulActAnalyer) : void
      {
         var _loc3_:int = 0;
         activityFighterList = new Vector.<ActivityTypeData>();
         activityExpList = new Vector.<ActivityTypeData>();
         activityRechargeList = new Vector.<ActivityTypeData>();
         activityTypeList = param1.itemList;
         var _loc2_:int = activityTypeList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            activityTypeList[_loc3_].StartTime = new Date();
            activityTypeList[_loc3_].EndTime = new Date();
            if(activityTypeList[_loc3_].ID == 2001)
            {
               activityFighterList.push(activityTypeList[_loc3_]);
            }
            else if(activityTypeList[_loc3_].ID >= 3001 && activityTypeList[_loc3_].ID < 4001)
            {
               activityRechargeList.push(activityTypeList[_loc3_]);
            }
            else
            {
               activityExpList.push(activityTypeList[_loc3_]);
            }
            _loc3_++;
         }
         SocketManager.Instance.out.sendWonderfulActivity(0,-1);
      }
      
      private function initFrame(param1:Boolean = false, param2:String = "0") : void
      {
         isSkipFromHall = param1;
         skipType = param2;
         leftUnitViewType = !!leftViewInfoDic[skipType]?leftViewInfoDic[skipType].unitIndex:2;
         loadResouce();
      }
      
      private function loadResouce() : void
      {
         AssetModuleLoader.addModelLoader("ddtcalendar",6);
         AssetModuleLoader.addModelLoader("wonderfulactivity",6);
         AssetModuleLoader.startCodeLoader(loadComplete);
      }
      
      private function loadComplete() : void
      {
         CalendarManager.getInstance().open(-1);
         dispatchEvent(new WonderfulActivityEvent("wonderfulActivityOpenView"));
      }
      
      public function addElement(param1:*) : void
      {
         param1 = String(param1);
         if(_actList.indexOf(param1) == -1)
         {
            _actList.unshift(param1);
         }
         if(_actList.length > 0)
         {
            if(addWAIcon != null)
            {
               addWAIcon();
            }
         }
         dispatchEvent(new WonderfulActivityEvent("wonderfulActivityAddEment"));
      }
      
      public function removeElement(param1:*) : void
      {
         param1 = String(param1);
         var _loc2_:int = _actList.indexOf(param1);
         if(_loc2_ == -1)
         {
            return;
         }
         _actList.splice(_loc2_,1);
         dispatchEvent(new WonderfulActivityEvent("wonderfulActivityAddEment"));
         if(_actList.length == 0)
         {
            dispose();
            return;
         }
         if(_actList.length > 0)
         {
            if(currView == param1)
            {
               currView = _actList[0];
            }
         }
      }
      
      public function dispose() : void
      {
         if(!isRuning)
         {
            return;
         }
         frameFlag = false;
         clickWonderfulActView = false;
         currentView = null;
         isSkipFromHall = false;
         skipType = "0";
         if(_timer)
         {
            _timer.stop();
            _timer.removeEventListener("timer",timerHander);
            _timer = null;
         }
         if(_actList.length == 0)
         {
            if(deleWAIcon != null)
            {
               deleWAIcon();
            }
         }
      }
      
      public function updateRealEndTime() : void
      {
         var _loc3_:* = null;
         var _loc2_:* = null;
         if(PlayerManager.Instance.Self.createPlayerDate == null)
         {
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:* = activityData;
         for each(var _loc1_ in activityData)
         {
            if(_loc1_.activityType == 39 && PlayerManager.Instance.Self.createPlayerDate)
            {
               _loc1_.beginTime = DateUtils.dateFormat3(PlayerManager.Instance.Self.createPlayerDate);
               _loc1_.beginShowTime = DateUtils.dateFormat3(PlayerManager.Instance.Self.createPlayerDate);
               _loc3_ = new Date(PlayerManager.Instance.Self.createPlayerDate.time + (_loc1_.remain1 - 1) * 86400000);
               _loc2_ = new Date(PlayerManager.Instance.Self.createPlayerDate.time + (_loc1_.remain2 - 1) * 86400000);
               _loc1_.endShowTime = DateUtils.dateFormat4(_loc2_);
               _loc1_.endTime = DateUtils.dateFormat4(_loc3_);
               break;
            }
         }
      }
      
      private function checkActivity(param1:int = 0) : void
      {
         var _loc4_:Boolean = false;
         var _loc14_:int = 0;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc8_:int = 0;
         rankFlag = false;
         var _loc3_:Array = [];
         var _loc12_:Date = TimeManager.Instance.Now();
         RoleRechargeMgr.instance.isOpen = false;
         SignActivityMgr.instance.isOpen = false;
         ConRechargeManager.instance.isOpen = false;
         var _loc22_:int = 0;
         var _loc21_:* = activityData;
         for each(var _loc13_ in activityData)
         {
            if(!(_loc12_.time < Date.parse(_loc13_.beginTime) || _loc12_.time > Date.parse(_loc13_.endShowTime)))
            {
               if(endRequestArr.indexOf(_loc13_.endShowTime) < 0)
               {
                  endRequestArr.push(_loc13_.endShowTime);
               }
               var _loc16_:* = _loc13_.activityType;
               if(0 !== _loc16_)
               {
                  if(1 !== _loc16_)
                  {
                     if(7 !== _loc16_)
                     {
                        if(6 !== _loc16_)
                        {
                           if(8 !== _loc16_)
                           {
                              if(2 !== _loc16_)
                              {
                                 if(4 !== _loc16_)
                                 {
                                    if(5 !== _loc16_)
                                    {
                                       if(15 !== _loc16_)
                                       {
                                          if(14 !== _loc16_)
                                          {
                                             if(20 !== _loc16_)
                                             {
                                                if(16 !== _loc16_)
                                                {
                                                   if(17 !== _loc16_)
                                                   {
                                                      if(18 !== _loc16_)
                                                      {
                                                         if(30 !== _loc16_)
                                                         {
                                                            if(29 !== _loc16_)
                                                            {
                                                               if(31 !== _loc16_)
                                                               {
                                                                  if(60 !== _loc16_)
                                                                  {
                                                                     if(21 !== _loc16_)
                                                                     {
                                                                        if(22 !== _loc16_)
                                                                        {
                                                                           if(23 !== _loc16_)
                                                                           {
                                                                              if(27 !== _loc16_)
                                                                              {
                                                                                 if(24 !== _loc16_)
                                                                                 {
                                                                                    if(25 !== _loc16_)
                                                                                    {
                                                                                       if(26 !== _loc16_)
                                                                                       {
                                                                                          if(28 !== _loc16_)
                                                                                          {
                                                                                             if(39 !== _loc16_)
                                                                                             {
                                                                                                if(29 !== _loc16_)
                                                                                                {
                                                                                                   if(62 === _loc16_)
                                                                                                   {
                                                                                                      leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(101,"· " + _loc13_.activityName,_loc13_.icon);
                                                                                                      CondiscountManager.instance.model.giftbagArray = _loc13_.giftbagArray;
                                                                                                      CondiscountManager.instance.model.beginTime = _loc13_.beginTime;
                                                                                                      CondiscountManager.instance.model.endTime = _loc13_.endTime;
                                                                                                      CondiscountManager.instance.model.actId = _loc13_.activityId;
                                                                                                      CondiscountManager.instance.model.isOpen = DateUtils.checkTime(_loc13_.beginTime,_loc13_.endTime,TimeManager.Instance.Now());
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(51,"· " + _loc13_.activityName,_loc13_.icon);
                                                                                                   addElement(_loc13_.activityId);
                                                                                                   _loc3_.push(_loc13_.activityId);
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(52,"· " + _loc13_.activityName,_loc13_.icon);
                                                                                                addElement(_loc13_.activityId);
                                                                                                _loc3_.push(_loc13_.activityId);
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(49,"· " + _loc13_.activityName,_loc13_.icon);
                                                                                             addElement(_loc13_.activityId);
                                                                                             _loc3_.push(_loc13_.activityId);
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(48,"· " + _loc13_.activityName,_loc13_.icon);
                                                                                          addElement(_loc13_.activityId);
                                                                                          _loc3_.push(_loc13_.activityId);
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(47,"· " + _loc13_.activityName,_loc13_.icon);
                                                                                       addElement(_loc13_.activityId);
                                                                                       _loc3_.push(_loc13_.activityId);
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(46,"· " + _loc13_.activityName,_loc13_.icon);
                                                                                    addElement(_loc13_.activityId);
                                                                                    _loc3_.push(_loc13_.activityId);
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(45,"· " + _loc13_.activityName,_loc13_.icon);
                                                                                 addElement(_loc13_.activityId);
                                                                                 _loc3_.push(_loc13_.activityId);
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(44,"· " + _loc13_.activityName,_loc13_.icon);
                                                                              addElement(_loc13_.activityId);
                                                                              _loc3_.push(_loc13_.activityId);
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(43,"· " + _loc13_.activityName,_loc13_.icon);
                                                                           addElement(_loc13_.activityId);
                                                                           _loc3_.push(_loc13_.activityId);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(42,"· " + _loc13_.activityName,_loc13_.icon);
                                                                        addElement(_loc13_.activityId);
                                                                        _loc3_.push(_loc13_.activityId);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     ConRechargeManager.instance.giftbagArray = _loc13_.giftbagArray;
                                                                     ConRechargeManager.instance.beginTime = _loc13_.beginShowTime;
                                                                     ConRechargeManager.instance.endTime = _loc13_.endShowTime;
                                                                     ConRechargeManager.instance.actId = _loc13_.activityId;
                                                                     ConRechargeManager.instance.isOpen = true;
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(100,"· " + _loc13_.activityName,_loc13_.icon);
                                                                  SignActivityMgr.instance.model.giftbagArray = _loc13_.giftbagArray;
                                                                  SignActivityMgr.instance.model.beginTime = _loc13_.beginShowTime.split(" ")[0];
                                                                  SignActivityMgr.instance.model.endTime = _loc13_.endShowTime.split(" ")[0];
                                                                  SignActivityMgr.instance.model.actId = _loc13_.activityId;
                                                                  SignActivityMgr.instance.isOpen = true;
                                                               }
                                                            }
                                                            else
                                                            {
                                                               leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(88,"· " + _loc13_.activityName,_loc13_.icon);
                                                               RoleRechargeMgr.instance.model.giftbagArray = _loc13_.giftbagArray;
                                                               RoleRechargeMgr.instance.model.beginTime = _loc13_.beginShowTime.split(" ")[0];
                                                               RoleRechargeMgr.instance.model.endTime = _loc13_.endShowTime.split(" ")[0];
                                                               RoleRechargeMgr.instance.model.actId = _loc13_.activityId;
                                                               RoleRechargeMgr.instance.isOpen = true;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            rankDic[_loc13_.activityChildType] = _loc13_;
                                                            rankFlag = true;
                                                            RankManager.instance.model.beginTime = _loc13_.beginTime;
                                                            RankManager.instance.model.endTime = _loc13_.endTime;
                                                         }
                                                      }
                                                      else if(_loc13_.activityChildType == 2 || _loc13_.activityChildType == 1 || _loc13_.activityChildType == 4 || _loc13_.activityChildType == 3 || _loc13_.activityChildType == 0)
                                                      {
                                                         var _loc20_:int = 0;
                                                         var _loc19_:* = leftViewInfoDic;
                                                         for each(var _loc6_ in leftViewInfoDic)
                                                         {
                                                            if(_loc6_.viewType == 39)
                                                            {
                                                               _loc10_ = true;
                                                               break;
                                                            }
                                                         }
                                                         if(!_loc10_)
                                                         {
                                                            leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(39,"· " + _loc13_.activityName,_loc13_.icon);
                                                            addElement(_loc13_.activityId);
                                                            _existentId = _loc13_.activityId;
                                                         }
                                                         else
                                                         {
                                                            _mutilIdMapping[_loc13_.activityId] = _existentId;
                                                         }
                                                         if(_loc3_.indexOf(_loc13_.activityId) == -1)
                                                         {
                                                            _loc3_.push(_loc13_.activityId);
                                                         }
                                                      }
                                                   }
                                                   else
                                                   {
                                                      leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(38,"· " + _loc13_.activityName,_loc13_.icon);
                                                      addElement(_loc13_.activityId);
                                                      _loc3_.push(_loc13_.activityId);
                                                   }
                                                }
                                                else
                                                {
                                                   leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(37,"· " + _loc13_.activityName,_loc13_.icon);
                                                   addElement(_loc13_.activityId);
                                                   _loc3_.push(_loc13_.activityId);
                                                }
                                             }
                                             else if(_loc13_.activityChildType == 0)
                                             {
                                                leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(41,"· " + _loc13_.activityName,_loc13_.icon);
                                                addElement(_loc13_.activityId);
                                                _loc3_.push(_loc13_.activityId);
                                             }
                                          }
                                          else if(_loc13_.activityChildType == 0)
                                          {
                                             leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(24,"· " + _loc13_.activityName,_loc13_.icon);
                                             addElement(_loc13_.activityId);
                                             _loc3_.push(_loc13_.activityId);
                                          }
                                          else if(_loc13_.activityChildType == 1)
                                          {
                                             leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(25,"· " + _loc13_.activityName,_loc13_.icon);
                                             addElement(_loc13_.activityId);
                                             _loc3_.push(_loc13_.activityId);
                                          }
                                       }
                                       else
                                       {
                                          switch(int(_loc13_.activityChildType) - 1)
                                          {
                                             case 0:
                                                _loc14_ = 26;
                                                break;
                                             case 1:
                                                _loc14_ = 27;
                                                break;
                                             case 2:
                                                _loc14_ = 28;
                                                break;
                                             case 3:
                                                var _loc18_:int = 0;
                                                var _loc17_:* = leftViewInfoDic;
                                                for each(var _loc5_ in leftViewInfoDic)
                                                {
                                                   if(_loc5_.viewType == 29)
                                                   {
                                                      _loc9_ = true;
                                                      break;
                                                   }
                                                }
                                                if(!_loc9_)
                                                {
                                                   _loc14_ = 29;
                                                   _existentId = _loc13_.activityId;
                                                }
                                                else
                                                {
                                                   _loc14_ = 0;
                                                   _mutilIdMapping[_loc13_.activityId] = _existentId;
                                                }
                                                break;
                                             case 4:
                                                _loc14_ = 30;
                                                break;
                                             case 5:
                                                _loc14_ = 31;
                                                break;
                                             case 6:
                                                _loc14_ = 32;
                                                break;
                                             case 7:
                                                _loc14_ = 33;
                                                break;
                                             case 8:
                                                _loc14_ = 34;
                                                break;
                                             case 9:
                                                _loc14_ = 35;
                                                break;
                                             case 10:
                                             case 11:
                                                _loc14_ = 36;
                                          }
                                          if(_loc14_ != 0)
                                          {
                                             leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(_loc14_,"· " + _loc13_.activityName,_loc13_.icon);
                                             addElement(_loc13_.activityId);
                                          }
                                          if(_loc3_.indexOf(_loc13_.activityId) == -1)
                                          {
                                             _loc3_.push(_loc13_.activityId);
                                          }
                                       }
                                    }
                                    else if(_loc13_.activityChildType == 1 || _loc13_.activityChildType == 2)
                                    {
                                       leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(22,"· " + _loc13_.activityName,_loc13_.icon);
                                       addElement(_loc13_.activityId);
                                       _loc3_.push(_loc13_.activityId);
                                    }
                                    else if(_loc13_.activityChildType == 3)
                                    {
                                       _info = _loc13_;
                                       if(_sendGiftFrame && activityInitData[_info.activityId] && activityInitData[_info.activityId].giftInfoDic[_info.giftbagArray[0].giftbagId].times != 0 && _sendGiftFrame.nowId == _info.activityId)
                                       {
                                          _sendGiftFrame.setBtnFalse();
                                          return;
                                       }
                                       if(param1 == 2)
                                       {
                                          if(PlayerManager.Instance.Self.Grade > 2 && !sendGiftIsOut && activityInitData[_info.activityId] && activityInitData[_info.activityId].giftInfoDic[_info.giftbagArray[0].giftbagId].times == 0 && !_sendGiftFrame)
                                          {
                                             _sendGiftFrame = ComponentFactory.Instance.creatComponentByStylename("com.wonderfulActivity.sendGiftFrame");
                                             _sendGiftFrame.setData(_info);
                                             sendGiftIsOut = true;
                                          }
                                       }
                                       else
                                       {
                                          continue;
                                       }
                                    }
                                 }
                                 else if(_loc13_.activityChildType == 2)
                                 {
                                    leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(21,"· " + _loc13_.activityName,_loc13_.icon);
                                    addElement(_loc13_.activityId);
                                    _loc3_.push(_loc13_.activityId);
                                 }
                              }
                              else if(_loc13_.activityChildType == 0)
                              {
                                 exchangeActLeftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(20,"· " + _loc13_.activityName,_loc13_.icon);
                                 addElement(_loc13_.activityId);
                                 _loc3_.push(_loc13_.activityId);
                              }
                           }
                           else if(_loc13_.activityChildType == 0)
                           {
                              leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(15,"· " + _loc13_.activityName,_loc13_.icon);
                              addElement(_loc13_.activityId);
                              _loc3_.push(_loc13_.activityId);
                           }
                        }
                        else if(_loc13_.activityChildType == 1)
                        {
                           leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(14,"· " + _loc13_.activityName,_loc13_.icon);
                           addElement(_loc13_.activityId);
                           _loc3_.push(_loc13_.activityId);
                        }
                     }
                     else if(_loc13_.activityChildType == 0 || _loc13_.activityChildType == 1)
                     {
                        _loc16_ = 0;
                        var _loc15_:* = leftViewInfoDic;
                        for each(var _loc11_ in leftViewInfoDic)
                        {
                           if(_loc11_.viewType == 10)
                           {
                              _loc4_ = true;
                              break;
                           }
                        }
                        if(!_loc4_)
                        {
                           leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(10,"· " + _loc13_.activityName,_loc13_.icon);
                           addElement(_loc13_.activityId);
                           _existentId = _loc13_.activityId;
                        }
                        else
                        {
                           _mutilIdMapping[_loc13_.activityId] = _existentId;
                        }
                        if(_loc3_.indexOf(_loc13_.activityId) == -1)
                        {
                           _loc3_.push(_loc13_.activityId);
                        }
                     }
                  }
                  else
                  {
                     switch(int(_loc13_.activityChildType))
                     {
                        case 0:
                           leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(21,"· " + _loc13_.activityName,_loc13_.icon);
                           addElement(_loc13_.activityId);
                           _loc3_.push(_loc13_.activityId);
                           break;
                        case 1:
                           leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(19,"· " + _loc13_.activityName,_loc13_.icon);
                           addElement(_loc13_.activityId);
                           _loc3_.push(_loc13_.activityId);
                           break;
                        case 2:
                           leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(21,"· " + _loc13_.activityName,_loc13_.icon);
                           addElement(_loc13_.activityId);
                           _loc3_.push(_loc13_.activityId);
                     }
                  }
               }
               else
               {
                  switch(int(_loc13_.activityChildType))
                  {
                     case 0:
                        break;
                     case 1:
                        leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(21,"· " + _loc13_.activityName,_loc13_.icon);
                        addElement(_loc13_.activityId);
                        _loc3_.push(_loc13_.activityId);
                        break;
                     case 2:
                        leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(17,"· " + _loc13_.activityName,_loc13_.icon);
                        addElement(_loc13_.activityId);
                        _loc3_.push(_loc13_.activityId);
                        break;
                     case 3:
                        leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(12,"· " + _loc13_.activityName,_loc13_.icon);
                        addElement(_loc13_.activityId);
                        _loc3_.push(_loc13_.activityId);
                        break;
                     default:
                        leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(12,"· " + _loc13_.activityName,_loc13_.icon);
                        addElement(_loc13_.activityId);
                        _loc3_.push(_loc13_.activityId);
                        break;
                     case 5:
                        leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(9,"· " + _loc13_.activityName,_loc13_.icon);
                        addElement(_loc13_.activityId);
                        _loc3_.push(_loc13_.activityId);
                        break;
                     case 6:
                        leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(18,"· " + _loc13_.activityName,_loc13_.icon);
                        addElement(_loc13_.activityId);
                        _loc3_.push(_loc13_.activityId);
                        break;
                     case 7:
                        leftViewInfoDic[_loc13_.activityId] = new LeftViewInfoVo(40,"· " + _loc13_.activityName,_loc13_.icon);
                        addElement(_loc13_.activityId);
                        _loc3_.push(_loc13_.activityId);
                  }
               }
            }
         }
         var _loc2_:int = -1;
         _loc8_ = 0;
         while(_loc8_ <= _loc3_.length - 1)
         {
            _loc2_ = lastActList.indexOf(_loc3_[_loc8_]);
            if(_loc2_ >= 0)
            {
               lastActList.splice(_loc2_,1);
            }
            _loc8_++;
         }
         var _loc24_:int = 0;
         var _loc23_:* = lastActList;
         for each(var _loc7_ in lastActList)
         {
            if(leftViewInfoDic[_loc7_])
            {
               leftViewInfoDic[_loc7_] = null;
               delete leftViewInfoDic[_loc7_];
            }
            else if(exchangeActLeftViewInfoDic[_loc7_])
            {
               exchangeActLeftViewInfoDic[_loc7_] = null;
               delete exchangeActLeftViewInfoDic[_loc7_];
            }
            removeElement(_loc7_);
         }
         lastActList = _loc3_;
         if(endRequestArr.length > 0)
         {
            addTimerFun("endRequest",endRequest);
         }
         else
         {
            delTimerFun("endRequest");
         }
         refreshIconStatus();
      }
      
      public function checkShowSendGiftFrame() : void
      {
         if(sendGiftIsOut && firstShowSendGiftFrame)
         {
            firstShowSendGiftFrame = false;
            LayerManager.Instance.addToLayer(_sendGiftFrame,2,true,1);
         }
      }
      
      public function refreshIconStatus() : void
      {
         checkActState();
         ExchangeActManager.Instance.creatWonderfulIcon();
         if(_wonderfulIcon)
         {
            var _loc3_:int = 0;
            var _loc2_:* = stateDic;
            for(var _loc1_ in stateDic)
            {
               if(stateDic[_loc1_])
               {
                  _wonderfulIcon.setFrame(2);
                  return;
               }
            }
            _wonderfulIcon.setFrame(1);
         }
      }
      
      public function getActIdWithViewId(param1:int) : String
      {
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = leftViewInfoDic;
         for(var _loc3_ in leftViewInfoDic)
         {
            _loc2_ = leftViewInfoDic[_loc3_];
            if(_loc2_.viewType == param1)
            {
               return _loc3_;
            }
         }
         return "";
      }
      
      private function checkActState() : void
      {
         var _loc11_:* = null;
         var _loc119_:* = null;
         var _loc86_:* = null;
         var _loc69_:* = null;
         var _loc23_:Number = NaN;
         var _loc153_:int = 0;
         var _loc66_:int = 0;
         var _loc126_:int = 0;
         var _loc46_:int = 0;
         var _loc128_:int = 0;
         var _loc42_:int = 0;
         var _loc54_:int = 0;
         var _loc134_:int = 0;
         var _loc20_:int = 0;
         var _loc87_:int = 0;
         var _loc3_:int = 0;
         var _loc157_:int = 0;
         var _loc95_:int = 0;
         var _loc75_:int = 0;
         var _loc26_:int = 0;
         var _loc125_:int = 0;
         var _loc150_:int = 0;
         var _loc116_:int = 0;
         var _loc1_:int = 0;
         var _loc135_:int = 0;
         var _loc7_:int = 0;
         var _loc57_:int = 0;
         var _loc131_:int = 0;
         var _loc144_:int = 0;
         var _loc19_:int = 0;
         var _loc118_:int = 0;
         var _loc18_:int = 0;
         var _loc67_:* = null;
         var _loc147_:* = null;
         var _loc91_:int = 0;
         var _loc156_:int = 0;
         var _loc25_:* = null;
         var _loc60_:int = 0;
         var _loc28_:int = 0;
         var _loc146_:int = 0;
         var _loc117_:int = 0;
         var _loc70_:int = 0;
         var _loc16_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = 0;
         var _loc49_:int = 0;
         var _loc41_:int = 0;
         var _loc61_:Boolean = false;
         var _loc109_:Boolean = false;
         var _loc132_:Boolean = false;
         var _loc110_:int = 0;
         var _loc102_:int = 0;
         var _loc55_:int = 0;
         var _loc77_:int = 0;
         var _loc106_:int = 0;
         var _loc136_:int = 0;
         var _loc120_:int = 0;
         var _loc36_:int = 0;
         var _loc112_:int = 0;
         var _loc24_:int = 0;
         var _loc92_:Boolean = false;
         var _loc123_:Boolean = false;
         var _loc29_:Boolean = false;
         var _loc27_:Boolean = false;
         var _loc140_:Boolean = false;
         var _loc43_:int = 0;
         var _loc78_:int = 0;
         var _loc17_:int = 0;
         var _loc138_:int = 0;
         var _loc48_:int = 0;
         var _loc12_:int = 0;
         var _loc79_:int = 0;
         var _loc65_:int = 0;
         var _loc93_:int = 0;
         var _loc72_:int = 0;
         var _loc40_:int = 0;
         var _loc127_:Boolean = false;
         var _loc148_:Boolean = false;
         var _loc39_:Boolean = false;
         var _loc21_:Boolean = false;
         var _loc80_:Boolean = false;
         var _loc52_:* = null;
         var _loc130_:* = null;
         var _loc155_:int = 0;
         var _loc37_:int = 0;
         var _loc13_:int = 0;
         var _loc64_:int = 0;
         var _loc14_:int = 0;
         var _loc141_:int = 0;
         var _loc154_:int = 0;
         var _loc6_:int = 0;
         var _loc151_:int = 0;
         var _loc63_:* = null;
         var _loc139_:* = null;
         var _loc121_:int = 0;
         var _loc85_:int = 0;
         var _loc145_:int = 0;
         var _loc62_:int = 0;
         var _loc101_:int = 0;
         var _loc84_:int = 0;
         var _loc38_:int = 0;
         var _loc100_:int = 0;
         var _loc47_:int = 0;
         var _loc31_:int = 0;
         var _loc82_:int = 0;
         var _loc103_:int = 0;
         var _loc34_:int = 0;
         var _loc35_:Boolean = false;
         var _loc107_:int = 0;
         var _loc81_:int = 0;
         var _loc44_:int = 0;
         var _loc97_:int = 0;
         var _loc33_:int = 0;
         var _loc108_:int = 0;
         var _loc129_:int = 0;
         var _loc113_:int = 0;
         var _loc58_:int = 0;
         var _loc89_:int = 0;
         var _loc32_:int = 0;
         var _loc111_:int = 0;
         var _loc152_:int = 0;
         var _loc53_:int = 0;
         var _loc30_:int = 0;
         var _loc228_:int = 0;
         var _loc227_:* = leftViewInfoDic;
         for(var _loc99_ in leftViewInfoDic)
         {
            stateDic[leftViewInfoDic[_loc99_].viewType] = false;
            if(!(!activityData[_loc99_] || !activityInitData[_loc99_]))
            {
               _loc11_ = leftViewInfoDic[_loc99_];
               _loc119_ = activityInitData[_loc99_].giftInfoDic;
               _loc86_ = activityInitData[_loc99_].statusArr;
               _loc69_ = activityData[_loc99_];
               _loc23_ = TimeManager.Instance.Now().time;
               var _loc160_:* = _loc11_.viewType;
               if(16 !== _loc160_)
               {
                  if(18 !== _loc160_)
                  {
                     if(19 !== _loc160_)
                     {
                        if(17 !== _loc160_)
                        {
                           if(88 !== _loc160_)
                           {
                              if(24 !== _loc160_)
                              {
                                 if(25 !== _loc160_)
                                 {
                                    if(41 !== _loc160_)
                                    {
                                       if(30 !== _loc160_)
                                       {
                                          if(33 !== _loc160_)
                                          {
                                             if(28 !== _loc160_)
                                             {
                                                if(26 !== _loc160_)
                                                {
                                                   if(36 !== _loc160_)
                                                   {
                                                      if(32 !== _loc160_)
                                                      {
                                                         if(27 !== _loc160_)
                                                         {
                                                            if(31 !== _loc160_)
                                                            {
                                                               if(34 !== _loc160_)
                                                               {
                                                                  if(35 !== _loc160_)
                                                                  {
                                                                     if(29 !== _loc160_)
                                                                     {
                                                                        if(38 !== _loc160_)
                                                                        {
                                                                           if(37 !== _loc160_)
                                                                           {
                                                                              if(39 !== _loc160_)
                                                                              {
                                                                                 if(42 !== _loc160_)
                                                                                 {
                                                                                    if(46 !== _loc160_)
                                                                                    {
                                                                                       if(43 !== _loc160_)
                                                                                       {
                                                                                          if(47 !== _loc160_)
                                                                                          {
                                                                                             if(44 !== _loc160_)
                                                                                             {
                                                                                                if(45 !== _loc160_)
                                                                                                {
                                                                                                   if(49 !== _loc160_)
                                                                                                   {
                                                                                                      if(48 === _loc160_)
                                                                                                      {
                                                                                                         var _loc226_:int = 0;
                                                                                                         var _loc225_:* = _loc69_.giftbagArray;
                                                                                                         for each(var _loc68_ in _loc69_.giftbagArray)
                                                                                                         {
                                                                                                            if(_loc119_[_loc68_.giftbagId])
                                                                                                            {
                                                                                                               _loc111_ = _loc119_[_loc68_.giftbagId].times;
                                                                                                               _loc30_ = 0;
                                                                                                               while(_loc30_ < _loc68_.giftConditionArr.length)
                                                                                                               {
                                                                                                                  if(_loc68_.giftConditionArr[_loc30_].conditionIndex == 0)
                                                                                                                  {
                                                                                                                     _loc152_ = _loc68_.giftConditionArr[_loc30_].conditionValue;
                                                                                                                  }
                                                                                                                  _loc30_++;
                                                                                                               }
                                                                                                               var _loc224_:int = 0;
                                                                                                               var _loc223_:* = _loc86_;
                                                                                                               for each(var _loc90_ in _loc86_)
                                                                                                               {
                                                                                                                  if(_loc90_.statusID == _loc152_)
                                                                                                                  {
                                                                                                                     _loc53_ = _loc90_.statusValue;
                                                                                                                     break;
                                                                                                                  }
                                                                                                               }
                                                                                                               if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc53_ > 0 && _loc111_ == 0)
                                                                                                               {
                                                                                                                  stateDic[_loc11_.viewType] = true;
                                                                                                                  break;
                                                                                                               }
                                                                                                               continue;
                                                                                                            }
                                                                                                            break;
                                                                                                         }
                                                                                                      }
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      var _loc222_:int = 0;
                                                                                                      var _loc221_:* = _loc69_.giftbagArray;
                                                                                                      for each(var _loc71_ in _loc69_.giftbagArray)
                                                                                                      {
                                                                                                         if(_loc119_[_loc71_.giftbagId])
                                                                                                         {
                                                                                                            _loc108_ = _loc119_[_loc71_.giftbagId].times;
                                                                                                            _loc32_ = 0;
                                                                                                            while(_loc32_ < _loc71_.giftConditionArr.length)
                                                                                                            {
                                                                                                               _loc129_ = _loc71_.giftConditionArr[_loc32_].conditionIndex;
                                                                                                               if(_loc129_ > 50 && _loc129_ < 100)
                                                                                                               {
                                                                                                                  _loc113_ = _loc71_.giftConditionArr[_loc32_].conditionValue;
                                                                                                                  _loc58_ = _loc71_.giftConditionArr[_loc32_].remain1;
                                                                                                               }
                                                                                                               _loc32_++;
                                                                                                            }
                                                                                                            var _loc220_:int = 0;
                                                                                                            var _loc219_:* = _loc86_;
                                                                                                            for each(var _loc94_ in _loc86_)
                                                                                                            {
                                                                                                               if(_loc94_.statusID == _loc113_)
                                                                                                               {
                                                                                                                  _loc89_ = _loc94_.statusValue;
                                                                                                                  break;
                                                                                                               }
                                                                                                            }
                                                                                                            if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc89_ >= _loc58_ && _loc108_ == 0)
                                                                                                            {
                                                                                                               stateDic[_loc11_.viewType] = true;
                                                                                                               break;
                                                                                                            }
                                                                                                            continue;
                                                                                                         }
                                                                                                         break;
                                                                                                      }
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   var _loc218_:int = 0;
                                                                                                   var _loc217_:* = _loc69_.giftbagArray;
                                                                                                   for each(var _loc73_ in _loc69_.giftbagArray)
                                                                                                   {
                                                                                                      if(_loc119_[_loc73_.giftbagId])
                                                                                                      {
                                                                                                         _loc107_ = _loc119_[_loc73_.giftbagId].times;
                                                                                                         _loc33_ = 0;
                                                                                                         while(_loc33_ < _loc73_.giftConditionArr.length)
                                                                                                         {
                                                                                                            if(_loc73_.giftConditionArr[_loc33_].conditionIndex == 0)
                                                                                                            {
                                                                                                               _loc81_ = _loc73_.giftConditionArr[_loc33_].conditionValue;
                                                                                                               _loc44_ = _loc73_.giftConditionArr[_loc33_].remain1;
                                                                                                            }
                                                                                                            _loc33_++;
                                                                                                         }
                                                                                                         var _loc216_:int = 0;
                                                                                                         var _loc215_:* = _loc86_;
                                                                                                         for each(var _loc96_ in _loc86_)
                                                                                                         {
                                                                                                            if(_loc96_.statusID == _loc81_)
                                                                                                            {
                                                                                                               _loc97_ = _loc96_.statusValue;
                                                                                                            }
                                                                                                         }
                                                                                                         if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc97_ >= _loc44_ && _loc107_ == 0)
                                                                                                         {
                                                                                                            stateDic[_loc11_.viewType] = true;
                                                                                                            break;
                                                                                                         }
                                                                                                         continue;
                                                                                                      }
                                                                                                      break;
                                                                                                   }
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                var _loc214_:int = 0;
                                                                                                var _loc213_:* = _loc69_.giftbagArray;
                                                                                                for each(var _loc74_ in _loc69_.giftbagArray)
                                                                                                {
                                                                                                   if(_loc119_[_loc74_.giftbagId])
                                                                                                   {
                                                                                                      _loc103_ = _loc119_[_loc74_.giftbagId].times;
                                                                                                      _loc34_ = 0;
                                                                                                      while(_loc34_ < _loc74_.giftConditionArr.length)
                                                                                                      {
                                                                                                         if(_loc74_.giftConditionArr[_loc34_].conditionIndex == 0)
                                                                                                         {
                                                                                                            _loc82_ = _loc74_.giftConditionArr[_loc34_].conditionValue;
                                                                                                         }
                                                                                                         _loc34_++;
                                                                                                      }
                                                                                                      _loc35_ = false;
                                                                                                      var _loc212_:int = 0;
                                                                                                      var _loc211_:* = _loc86_;
                                                                                                      for each(var _loc98_ in _loc86_)
                                                                                                      {
                                                                                                         if(_loc98_.statusID == _loc82_)
                                                                                                         {
                                                                                                            if(_loc98_.statusValue > 0)
                                                                                                            {
                                                                                                               _loc35_ = true;
                                                                                                               break;
                                                                                                            }
                                                                                                         }
                                                                                                      }
                                                                                                      if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc35_ && _loc103_ == 0)
                                                                                                      {
                                                                                                         stateDic[_loc11_.viewType] = true;
                                                                                                         break;
                                                                                                      }
                                                                                                      continue;
                                                                                                   }
                                                                                                   break;
                                                                                                }
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             var _loc210_:int = 0;
                                                                                             var _loc209_:* = _loc69_.giftbagArray;
                                                                                             for each(var _loc76_ in _loc69_.giftbagArray)
                                                                                             {
                                                                                                if(_loc119_[_loc76_.giftbagId])
                                                                                                {
                                                                                                   _loc101_ = _loc119_[_loc76_.giftbagId].times;
                                                                                                   _loc31_ = 0;
                                                                                                   while(_loc31_ < _loc76_.giftConditionArr.length)
                                                                                                   {
                                                                                                      if(_loc76_.giftConditionArr[_loc31_].conditionIndex == 0)
                                                                                                      {
                                                                                                         _loc84_ = _loc76_.giftConditionArr[_loc31_].remain1;
                                                                                                      }
                                                                                                      _loc31_++;
                                                                                                   }
                                                                                                   var _loc208_:int = 0;
                                                                                                   var _loc207_:* = _loc86_;
                                                                                                   for each(var _loc9_ in _loc86_)
                                                                                                   {
                                                                                                      if(_loc9_.statusID == 0)
                                                                                                      {
                                                                                                         _loc38_ = _loc9_.statusValue;
                                                                                                      }
                                                                                                      else if(_loc9_.statusID == 1)
                                                                                                      {
                                                                                                         _loc100_ = _loc9_.statusValue;
                                                                                                      }
                                                                                                   }
                                                                                                   if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc38_ < _loc84_ && _loc84_ <= _loc100_ && _loc101_ == 0)
                                                                                                   {
                                                                                                      stateDic[_loc11_.viewType] = true;
                                                                                                      break;
                                                                                                   }
                                                                                                   continue;
                                                                                                }
                                                                                                break;
                                                                                             }
                                                                                          }
                                                                                          continue;
                                                                                       }
                                                                                    }
                                                                                    addr2599:
                                                                                    var _loc206_:int = 0;
                                                                                    var _loc205_:* = _loc69_.giftbagArray;
                                                                                    for each(var _loc88_ in _loc69_.giftbagArray)
                                                                                    {
                                                                                       if(_loc119_[_loc88_.giftbagId])
                                                                                       {
                                                                                          _loc121_ = _loc119_[_loc88_.giftbagId].times;
                                                                                          _loc62_ = 0;
                                                                                          while(_loc62_ < _loc88_.giftConditionArr.length)
                                                                                          {
                                                                                             if(_loc88_.giftConditionArr[_loc62_].conditionIndex == 0)
                                                                                             {
                                                                                                _loc85_ = _loc88_.giftConditionArr[_loc62_].conditionValue;
                                                                                             }
                                                                                             _loc62_++;
                                                                                          }
                                                                                          _loc145_ = _loc86_[0].statusValue;
                                                                                          if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc121_ == 0 && _loc145_ >= _loc85_)
                                                                                          {
                                                                                             stateDic[_loc11_.viewType] = true;
                                                                                             break;
                                                                                          }
                                                                                          continue;
                                                                                       }
                                                                                       break;
                                                                                    }
                                                                                    continue;
                                                                                 }
                                                                                 §§goto(addr2599);
                                                                              }
                                                                              else
                                                                              {
                                                                                 _loc130_ = [];
                                                                                 var _loc200_:int = 0;
                                                                                 var _loc199_:* = activityData;
                                                                                 for each(var _loc59_ in activityData)
                                                                                 {
                                                                                    if(_loc59_.activityType == 18)
                                                                                    {
                                                                                       _loc130_.push(_loc59_);
                                                                                    }
                                                                                 }
                                                                                 _loc155_ = 0;
                                                                                 _loc37_ = 0;
                                                                                 _loc13_ = 0;
                                                                                 _loc64_ = 0;
                                                                                 _loc14_ = 0;
                                                                                 _loc6_ = 0;
                                                                                 while(_loc6_ < _loc130_.length)
                                                                                 {
                                                                                    var _loc204_:int = 0;
                                                                                    var _loc203_:* = _loc130_[_loc6_].giftbagArray;
                                                                                    for each(var _loc122_ in _loc130_[_loc6_].giftbagArray)
                                                                                    {
                                                                                       if(activityInitData[_loc130_[_loc6_].activityId].giftInfoDic[_loc122_.giftbagId])
                                                                                       {
                                                                                          _loc52_ = activityInitData[_loc130_[_loc6_].activityId].giftInfoDic[_loc122_.giftbagId];
                                                                                          if(_loc122_.rewardMark != 100)
                                                                                          {
                                                                                             _loc154_ = _loc52_.times;
                                                                                             _loc151_ = 0;
                                                                                             while(_loc151_ < _loc122_.giftConditionArr.length)
                                                                                             {
                                                                                                if(_loc122_.giftConditionArr[_loc151_].conditionIndex == 0)
                                                                                                {
                                                                                                   _loc141_ = 1;
                                                                                                }
                                                                                                else if(_loc122_.giftConditionArr[_loc151_].conditionIndex == 1)
                                                                                                {
                                                                                                   _loc141_ = 2;
                                                                                                   _loc155_ = _loc122_.giftConditionArr[_loc151_].remain1;
                                                                                                   _loc13_ = _loc122_.giftConditionArr[_loc151_].remain2;
                                                                                                   if(_loc13_ == 2)
                                                                                                   {
                                                                                                      _loc64_ = _loc122_.giftConditionArr[_loc151_].conditionValue;
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      _loc14_ = _loc122_.giftConditionArr[_loc151_].conditionValue;
                                                                                                   }
                                                                                                }
                                                                                                else if(_loc122_.giftConditionArr[_loc151_].conditionIndex == 2)
                                                                                                {
                                                                                                   _loc141_ = 3;
                                                                                                }
                                                                                                else if(_loc122_.giftConditionArr[_loc151_].conditionIndex != 3)
                                                                                                {
                                                                                                   if(_loc122_.giftConditionArr[_loc151_].conditionIndex > 50 && _loc122_.giftConditionArr[_loc151_].conditionIndex < 100)
                                                                                                   {
                                                                                                      _loc37_ = _loc122_.giftConditionArr[_loc151_].conditionValue;
                                                                                                      _loc155_ = _loc122_.giftConditionArr[_loc151_].remain1;
                                                                                                   }
                                                                                                }
                                                                                                _loc151_++;
                                                                                             }
                                                                                             var _loc202_:int = 0;
                                                                                             var _loc201_:* = activityInitData[_loc130_[_loc6_].activityId].statusArr;
                                                                                             for each(var _loc124_ in activityInitData[_loc130_[_loc6_].activityId].statusArr)
                                                                                             {
                                                                                                if(_loc141_ == 1 || _loc141_ == 3)
                                                                                                {
                                                                                                   if(_loc124_.statusID == _loc37_)
                                                                                                   {
                                                                                                      if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc154_ == 0 && _loc124_.statusValue >= _loc155_)
                                                                                                      {
                                                                                                         stateDic[_loc11_.viewType] = true;
                                                                                                         break;
                                                                                                      }
                                                                                                   }
                                                                                                }
                                                                                                else if(_loc13_ == 3)
                                                                                                {
                                                                                                   if(_loc124_.statusID == _loc14_)
                                                                                                   {
                                                                                                      _loc63_ = _loc124_;
                                                                                                   }
                                                                                                }
                                                                                                else if(_loc13_ == 2)
                                                                                                {
                                                                                                   if(_loc124_.statusID == _loc64_)
                                                                                                   {
                                                                                                      _loc139_ = _loc124_;
                                                                                                   }
                                                                                                }
                                                                                                else if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc154_ == 0 && _loc124_.statusValue >= _loc155_)
                                                                                                {
                                                                                                   stateDic[_loc11_.viewType] = true;
                                                                                                   break;
                                                                                                }
                                                                                             }
                                                                                             if(_loc141_ == 2)
                                                                                             {
                                                                                                if(_loc13_ == 3)
                                                                                                {
                                                                                                   if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc63_?_loc154_ == 0 && _loc63_.statusValue >= _loc155_:false)
                                                                                                   {
                                                                                                      stateDic[_loc11_.viewType] = true;
                                                                                                      break;
                                                                                                   }
                                                                                                }
                                                                                                else if(_loc13_ == 2)
                                                                                                {
                                                                                                   if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc139_?_loc154_ == 0 && _loc139_.statusValue >= _loc155_:false)
                                                                                                   {
                                                                                                      stateDic[_loc11_.viewType] = true;
                                                                                                      break;
                                                                                                   }
                                                                                                }
                                                                                             }
                                                                                          }
                                                                                          continue;
                                                                                       }
                                                                                       break;
                                                                                    }
                                                                                    _loc6_++;
                                                                                 }
                                                                                 continue;
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              if(PlayerManager.Instance.Self.snapVip)
                                                                              {
                                                                                 stateDic[_loc11_.viewType] = false;
                                                                              }
                                                                              else
                                                                              {
                                                                                 var _loc198_:int = 0;
                                                                                 var _loc197_:* = _loc69_.giftbagArray;
                                                                                 for each(var _loc4_ in _loc69_.giftbagArray)
                                                                                 {
                                                                                    if(_loc119_[_loc4_.giftbagId])
                                                                                    {
                                                                                       if(_loc4_.rewardMark != 100)
                                                                                       {
                                                                                          _loc43_ = -1;
                                                                                          _loc78_ = -1;
                                                                                          _loc17_ = -1;
                                                                                          _loc138_ = 0;
                                                                                          _loc48_ = 0;
                                                                                          _loc12_ = 0;
                                                                                          _loc79_ = 0;
                                                                                          _loc65_ = 0;
                                                                                          _loc93_ = 0;
                                                                                          _loc72_ = _loc119_[_loc4_.giftbagId].times;
                                                                                          _loc40_ = 0;
                                                                                          while(_loc40_ < _loc4_.giftConditionArr.length)
                                                                                          {
                                                                                             if(_loc4_.giftConditionArr[_loc40_].conditionIndex == 0)
                                                                                             {
                                                                                                _loc43_ = _loc4_.giftConditionArr[_loc40_].conditionValue;
                                                                                             }
                                                                                             else if(_loc4_.giftConditionArr[_loc40_].conditionIndex == 1)
                                                                                             {
                                                                                                _loc138_ = _loc4_.giftConditionArr[_loc40_].conditionValue;
                                                                                                _loc78_ = _loc4_.giftConditionArr[_loc40_].remain1;
                                                                                             }
                                                                                             else if(_loc4_.giftConditionArr[_loc40_].conditionIndex == 2)
                                                                                             {
                                                                                                _loc48_ = _loc4_.giftConditionArr[_loc40_].conditionValue;
                                                                                                _loc17_ = _loc4_.giftConditionArr[_loc40_].remain1;
                                                                                             }
                                                                                             else if(_loc4_.giftConditionArr[_loc40_].conditionIndex == 3)
                                                                                             {
                                                                                                _loc12_ = _loc4_.giftConditionArr[_loc40_].conditionValue;
                                                                                             }
                                                                                             _loc40_++;
                                                                                          }
                                                                                          var _loc196_:int = 0;
                                                                                          var _loc195_:* = _loc86_;
                                                                                          for each(var _loc149_ in _loc86_)
                                                                                          {
                                                                                             if(_loc149_.statusID == 0)
                                                                                             {
                                                                                                _loc93_ = _loc149_.statusValue;
                                                                                             }
                                                                                             else if(_loc149_.statusID == _loc138_)
                                                                                             {
                                                                                                _loc65_ = _loc149_.statusValue;
                                                                                             }
                                                                                             else if(_loc149_.statusID == _loc48_)
                                                                                             {
                                                                                                _loc79_ = _loc149_.statusValue;
                                                                                             }
                                                                                          }
                                                                                          _loc127_ = _loc17_ != -1?int(_loc79_ / _loc17_) > _loc72_:true;
                                                                                          _loc148_ = _loc78_ != -1?_loc65_ >= _loc78_:true;
                                                                                          _loc39_ = _loc43_ != -1?_loc93_ >= _loc43_:true;
                                                                                          _loc21_ = _loc12_ == 0?true:_loc72_ < _loc12_;
                                                                                          _loc80_ = _loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc127_ && _loc148_ && _loc39_ && _loc21_;
                                                                                          if(_loc17_ != -1)
                                                                                          {
                                                                                             if(_loc80_ && int(_loc79_ / _loc17_) - _loc72_ >= 1)
                                                                                             {
                                                                                                stateDic[_loc11_.viewType] = true;
                                                                                                break;
                                                                                             }
                                                                                          }
                                                                                          else if(_loc80_ && _loc72_ == 0)
                                                                                          {
                                                                                             stateDic[_loc11_.viewType] = true;
                                                                                             break;
                                                                                          }
                                                                                       }
                                                                                       continue;
                                                                                    }
                                                                                    break;
                                                                                 }
                                                                              }
                                                                              continue;
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           var _loc194_:int = 0;
                                                                           var _loc193_:* = _loc69_.giftbagArray;
                                                                           for each(var _loc137_ in _loc69_.giftbagArray)
                                                                           {
                                                                              if(_loc119_[_loc137_.giftbagId])
                                                                              {
                                                                                 if(_loc137_.rewardMark != 100)
                                                                                 {
                                                                                    _loc5_ = -1;
                                                                                    _loc49_ = -1;
                                                                                    _loc41_ = -1;
                                                                                    _loc61_ = false;
                                                                                    _loc109_ = false;
                                                                                    _loc132_ = false;
                                                                                    _loc110_ = 0;
                                                                                    _loc102_ = 0;
                                                                                    _loc55_ = 0;
                                                                                    _loc77_ = 0;
                                                                                    _loc106_ = 0;
                                                                                    _loc136_ = 0;
                                                                                    _loc120_ = 0;
                                                                                    _loc36_ = _loc119_[_loc137_.giftbagId].times;
                                                                                    _loc112_ = 0;
                                                                                    while(_loc112_ < _loc137_.giftConditionArr.length)
                                                                                    {
                                                                                       if(_loc137_.giftConditionArr[_loc112_].conditionIndex == 4)
                                                                                       {
                                                                                          _loc132_ = true;
                                                                                       }
                                                                                       else if(_loc137_.giftConditionArr[_loc112_].conditionIndex == 5)
                                                                                       {
                                                                                          _loc109_ = true;
                                                                                       }
                                                                                       else if(_loc137_.giftConditionArr[_loc112_].conditionIndex == 6)
                                                                                       {
                                                                                          _loc61_ = true;
                                                                                       }
                                                                                       _loc112_++;
                                                                                    }
                                                                                    _loc24_ = 0;
                                                                                    while(_loc24_ < _loc137_.giftConditionArr.length)
                                                                                    {
                                                                                       if(_loc137_.giftConditionArr[_loc24_].conditionIndex == (!!_loc132_?4:0))
                                                                                       {
                                                                                          _loc110_ = _loc137_.giftConditionArr[_loc24_].conditionValue;
                                                                                          _loc5_ = _loc137_.giftConditionArr[_loc24_].remain1;
                                                                                       }
                                                                                       else if(_loc137_.giftConditionArr[_loc24_].conditionIndex == (!!_loc109_?5:1))
                                                                                       {
                                                                                          _loc102_ = _loc137_.giftConditionArr[_loc24_].conditionValue;
                                                                                          _loc49_ = _loc137_.giftConditionArr[_loc24_].remain1;
                                                                                       }
                                                                                       else if(_loc137_.giftConditionArr[_loc24_].conditionIndex == (!!_loc61_?6:2))
                                                                                       {
                                                                                          _loc55_ = _loc137_.giftConditionArr[_loc24_].conditionValue;
                                                                                          _loc41_ = _loc137_.giftConditionArr[_loc24_].remain1;
                                                                                       }
                                                                                       else if(_loc137_.giftConditionArr[_loc24_].conditionIndex == 3)
                                                                                       {
                                                                                          _loc77_ = _loc137_.giftConditionArr[_loc24_].conditionValue;
                                                                                       }
                                                                                       _loc24_++;
                                                                                    }
                                                                                    var _loc192_:int = 0;
                                                                                    var _loc191_:* = _loc86_;
                                                                                    for each(var _loc158_ in _loc86_)
                                                                                    {
                                                                                       if(_loc158_.statusID >= _loc110_ + (!!_loc132_?200:0) && _loc158_.statusID < 50 + (!!_loc132_?200:0))
                                                                                       {
                                                                                          _loc120_ = _loc120_ + _loc158_.statusValue;
                                                                                       }
                                                                                       else if(_loc158_.statusID == _loc102_ + (!!_loc109_?300:100))
                                                                                       {
                                                                                          _loc136_ = _loc158_.statusValue;
                                                                                       }
                                                                                       else if(_loc158_.statusID == _loc55_ + (!!_loc61_?300:100))
                                                                                       {
                                                                                          _loc106_ = _loc158_.statusValue;
                                                                                       }
                                                                                    }
                                                                                    _loc92_ = _loc41_ != -1?int(_loc106_ / _loc41_) > _loc36_:true;
                                                                                    _loc123_ = _loc49_ != -1?_loc136_ >= _loc49_:true;
                                                                                    _loc29_ = _loc5_ != -1?_loc120_ >= _loc5_:true;
                                                                                    _loc27_ = _loc77_ == 0?true:_loc36_ < _loc77_;
                                                                                    _loc140_ = _loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc92_ && _loc123_ && _loc29_ && _loc27_;
                                                                                    if(_loc41_ != -1)
                                                                                    {
                                                                                       if(_loc140_ && int(_loc106_ / _loc41_) - _loc36_ >= 1)
                                                                                       {
                                                                                          stateDic[_loc11_.viewType] = true;
                                                                                          break;
                                                                                       }
                                                                                    }
                                                                                    else if(_loc140_ && _loc36_ == 0)
                                                                                    {
                                                                                       stateDic[_loc11_.viewType] = true;
                                                                                       break;
                                                                                    }
                                                                                 }
                                                                                 continue;
                                                                              }
                                                                              break;
                                                                           }
                                                                           continue;
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        _loc147_ = [];
                                                                        var _loc186_:int = 0;
                                                                        var _loc185_:* = activityData;
                                                                        for each(var _loc104_ in activityData)
                                                                        {
                                                                           if(_loc104_.activityType == 15 && (_loc104_.activityChildType == 4 || _loc104_.activityChildType == 12))
                                                                           {
                                                                              _loc147_.push(_loc104_);
                                                                           }
                                                                        }
                                                                        _loc91_ = 0;
                                                                        _loc156_ = 0;
                                                                        var _loc188_:int = 0;
                                                                        var _loc187_:* = _loc86_;
                                                                        for each(var _loc15_ in _loc86_)
                                                                        {
                                                                           if(_loc15_.statusID == 0)
                                                                           {
                                                                              _loc91_ = _loc15_.statusValue;
                                                                           }
                                                                           else
                                                                           {
                                                                              _loc156_ = _loc15_.statusValue;
                                                                           }
                                                                        }
                                                                        _loc25_ = TimeManager.Instance.Now();
                                                                        _loc60_ = 0;
                                                                        while(_loc60_ < _loc147_.length)
                                                                        {
                                                                           if(!(_loc25_.time < Date.parse(_loc147_[_loc60_].beginTime) || _loc25_.time > Date.parse(_loc147_[_loc60_].endShowTime)))
                                                                           {
                                                                              _loc28_ = -1;
                                                                              _loc146_ = -1;
                                                                              _loc117_ = -1;
                                                                              _loc16_ = 0;
                                                                              var _loc190_:int = 0;
                                                                              var _loc189_:* = _loc147_[_loc60_].giftbagArray;
                                                                              for each(var _loc115_ in _loc147_[_loc60_].giftbagArray)
                                                                              {
                                                                                 if(activityInitData[_loc147_[_loc60_].activityId].giftInfoDic[_loc115_.giftbagId])
                                                                                 {
                                                                                    _loc67_ = activityInitData[_loc147_[_loc60_].activityId].giftInfoDic[_loc115_.giftbagId];
                                                                                    if(_loc115_.rewardMark != 100)
                                                                                    {
                                                                                       _loc16_ = _loc67_.times;
                                                                                       _loc2_ = 0;
                                                                                       while(_loc2_ < _loc115_.giftConditionArr.length)
                                                                                       {
                                                                                          if(_loc115_.giftConditionArr[_loc2_].conditionIndex == 0)
                                                                                          {
                                                                                             _loc28_ = _loc115_.giftConditionArr[_loc2_].conditionValue;
                                                                                          }
                                                                                          else if(_loc115_.giftConditionArr[_loc2_].conditionIndex == 1)
                                                                                          {
                                                                                             _loc146_ = _loc115_.giftConditionArr[_loc2_].conditionValue;
                                                                                             _loc117_ = _loc115_.giftConditionArr[_loc2_].remain1;
                                                                                          }
                                                                                          else if(_loc115_.giftConditionArr[_loc2_].conditionIndex == 100)
                                                                                          {
                                                                                             _loc70_ = _loc115_.giftConditionArr[_loc2_].conditionValue;
                                                                                          }
                                                                                          _loc2_++;
                                                                                       }
                                                                                       if(_loc28_ != -1)
                                                                                       {
                                                                                          if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc16_ == 0 && _loc91_ >= _loc28_)
                                                                                          {
                                                                                             stateDic[_loc11_.viewType] = true;
                                                                                             break;
                                                                                          }
                                                                                       }
                                                                                       else if(_loc23_ >= Date.parse(_loc69_.endTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc16_ == 0 && _loc156_ >= _loc146_ && _loc156_ <= _loc117_)
                                                                                       {
                                                                                          stateDic[_loc11_.viewType] = true;
                                                                                          break;
                                                                                       }
                                                                                    }
                                                                                    continue;
                                                                                 }
                                                                                 break;
                                                                              }
                                                                           }
                                                                           _loc60_++;
                                                                        }
                                                                        continue;
                                                                     }
                                                                  }
                                                               }
                                                               addr960:
                                                               _loc135_ = _loc86_[0].statusValue;
                                                               _loc7_ = 0;
                                                               _loc57_ = 0;
                                                               if(_loc11_.viewType == 35)
                                                               {
                                                                  var _loc182_:int = 0;
                                                                  var _loc181_:* = _loc86_;
                                                                  for each(var _loc83_ in _loc86_)
                                                                  {
                                                                     if(_loc83_.statusID == 0)
                                                                     {
                                                                        _loc7_ = _loc83_.statusValue;
                                                                     }
                                                                     else if(_loc83_.statusID == 1)
                                                                     {
                                                                        _loc57_ = _loc83_.statusValue;
                                                                     }
                                                                  }
                                                               }
                                                               var _loc184_:int = 0;
                                                               var _loc183_:* = _loc69_.giftbagArray;
                                                               for each(var _loc10_ in _loc69_.giftbagArray)
                                                               {
                                                                  if(_loc119_[_loc10_.giftbagId])
                                                                  {
                                                                     if(_loc10_.rewardMark != 100)
                                                                     {
                                                                        _loc19_ = _loc119_[_loc10_.giftbagId].times;
                                                                        _loc118_ = _loc119_[_loc10_.giftbagId].allGiftGetTimes;
                                                                        _loc18_ = 0;
                                                                        while(_loc18_ < _loc10_.giftConditionArr.length)
                                                                        {
                                                                           if(_loc10_.giftConditionArr[_loc18_].conditionIndex == 0)
                                                                           {
                                                                              _loc131_ = _loc10_.giftConditionArr[_loc18_].conditionValue;
                                                                           }
                                                                           else if(_loc10_.giftConditionArr[_loc18_].conditionIndex == 100)
                                                                           {
                                                                              _loc144_ = _loc10_.giftConditionArr[_loc18_].conditionValue;
                                                                           }
                                                                           _loc18_++;
                                                                        }
                                                                        if(_loc11_.viewType == 35)
                                                                        {
                                                                           if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc19_ == 0 && _loc131_ > _loc7_ && _loc131_ <= _loc57_ && (_loc144_ == 0 || _loc144_ - _loc118_ > 0))
                                                                           {
                                                                              stateDic[_loc11_.viewType] = true;
                                                                              break;
                                                                           }
                                                                        }
                                                                        else if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc19_ == 0 && _loc135_ >= _loc131_ && (_loc144_ == 0 || _loc144_ - _loc118_ > 0))
                                                                        {
                                                                           stateDic[_loc11_.viewType] = true;
                                                                           break;
                                                                        }
                                                                     }
                                                                     continue;
                                                                  }
                                                                  break;
                                                               }
                                                               continue;
                                                            }
                                                            addr959:
                                                            §§goto(addr960);
                                                         }
                                                         addr958:
                                                         §§goto(addr959);
                                                      }
                                                      addr957:
                                                      §§goto(addr958);
                                                   }
                                                   addr956:
                                                   §§goto(addr957);
                                                }
                                                addr955:
                                                §§goto(addr956);
                                             }
                                             addr954:
                                             §§goto(addr955);
                                          }
                                          addr953:
                                          §§goto(addr954);
                                       }
                                       §§goto(addr953);
                                    }
                                    else
                                    {
                                       var _loc178_:int = 0;
                                       var _loc177_:* = _loc86_;
                                       for each(var _loc133_ in _loc86_)
                                       {
                                          if(_loc133_.statusID == 0)
                                          {
                                             _loc125_ = _loc133_.statusValue;
                                          }
                                          else if(_loc133_.statusID == 1)
                                          {
                                             _loc150_ = _loc133_.statusValue;
                                          }
                                       }
                                       var _loc180_:int = 0;
                                       var _loc179_:* = _loc69_.giftbagArray;
                                       for each(var _loc56_ in _loc69_.giftbagArray)
                                       {
                                          if(_loc119_[_loc56_.giftbagId])
                                          {
                                             _loc1_ = 0;
                                             while(_loc1_ < _loc56_.giftConditionArr.length)
                                             {
                                                if(_loc56_.giftConditionArr[_loc1_].conditionIndex == 0)
                                                {
                                                   _loc116_ = _loc56_.giftConditionArr[_loc1_].remain1;
                                                   break;
                                                }
                                                _loc1_++;
                                             }
                                             if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc119_[_loc56_.giftbagId].times == 0 && _loc116_ > _loc125_ && _loc116_ <= _loc150_)
                                             {
                                                stateDic[_loc11_.viewType] = true;
                                                break;
                                             }
                                             continue;
                                          }
                                          break;
                                       }
                                       continue;
                                    }
                                 }
                                 else
                                 {
                                    var _loc176_:int = 0;
                                    var _loc175_:* = _loc69_.giftbagArray;
                                    for each(var _loc22_ in _loc69_.giftbagArray)
                                    {
                                       if(_loc119_[_loc22_.giftbagId])
                                       {
                                          _loc95_ = 0;
                                          while(_loc95_ < _loc22_.giftConditionArr.length)
                                          {
                                             if(_loc22_.giftConditionArr[_loc95_].conditionIndex == 0)
                                             {
                                                _loc3_ = _loc22_.giftConditionArr[_loc95_].conditionValue;
                                             }
                                             else
                                             {
                                                _loc157_ = _loc22_.giftConditionArr[_loc95_].conditionValue;
                                             }
                                             _loc95_++;
                                          }
                                          _loc75_ = 0;
                                          _loc26_ = 0;
                                          var _loc174_:int = 0;
                                          var _loc173_:* = _loc86_;
                                          for each(var _loc50_ in _loc86_)
                                          {
                                             if(_loc50_.statusID == _loc3_)
                                             {
                                                _loc75_ = _loc50_.statusValue;
                                             }
                                             else if(_loc50_.statusID == 100 + _loc3_)
                                             {
                                                _loc26_ = _loc50_.statusValue;
                                             }
                                          }
                                          if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc119_[_loc22_.giftbagId].times == 0 && _loc157_ > _loc75_ && _loc157_ <= _loc26_)
                                          {
                                             stateDic[_loc11_.viewType] = true;
                                             break;
                                          }
                                          continue;
                                       }
                                       break;
                                    }
                                    continue;
                                 }
                              }
                              else
                              {
                                 var _loc170_:int = 0;
                                 var _loc169_:* = _loc86_;
                                 for each(var _loc8_ in _loc86_)
                                 {
                                    if(_loc8_.statusID == 0)
                                    {
                                       _loc54_ = _loc8_.statusValue;
                                    }
                                    else if(_loc8_.statusID == 1)
                                    {
                                       _loc134_ = _loc8_.statusValue;
                                    }
                                 }
                                 var _loc172_:int = 0;
                                 var _loc171_:* = _loc69_.giftbagArray;
                                 for each(var _loc45_ in _loc69_.giftbagArray)
                                 {
                                    if(_loc119_[_loc45_.giftbagId])
                                    {
                                       _loc87_ = 0;
                                       while(_loc87_ < _loc45_.giftConditionArr.length)
                                       {
                                          if(_loc45_.giftConditionArr[_loc87_].conditionIndex == 0)
                                          {
                                             _loc20_ = _loc45_.giftConditionArr[_loc87_].remain1;
                                             break;
                                          }
                                          _loc87_++;
                                       }
                                       if(_loc23_ >= Date.parse(_loc69_.beginShowTime) && _loc23_ <= Date.parse(_loc69_.endShowTime) && _loc119_[_loc45_.giftbagId].times == 0 && _loc20_ > _loc54_ && _loc20_ <= _loc134_)
                                       {
                                          stateDic[_loc11_.viewType] = true;
                                          break;
                                       }
                                       continue;
                                    }
                                    break;
                                 }
                                 continue;
                              }
                           }
                           else
                           {
                              var _loc168_:int = 0;
                              var _loc167_:* = _loc69_.giftbagArray;
                              for each(var _loc143_ in _loc69_.giftbagArray)
                              {
                                 if(_loc119_[_loc143_.giftbagId])
                                 {
                                    _loc128_ = _loc119_[_loc143_.giftbagId].times;
                                    var _loc166_:int = 0;
                                    var _loc165_:* = _loc86_;
                                    for each(var _loc105_ in _loc86_)
                                    {
                                       if(_loc105_.statusID == _loc143_.giftConditionArr[0].conditionValue)
                                       {
                                          _loc42_ = _loc105_.statusValue - _loc128_;
                                       }
                                    }
                                    if(_loc143_.giftConditionArr[0].conditionValue == 0)
                                    {
                                       if(_loc42_ > 0)
                                       {
                                          stateDic[_loc11_.viewType] = true;
                                          break;
                                       }
                                    }
                                    else if(_loc128_ == 0 && _loc42_ > 0)
                                    {
                                       stateDic[_loc11_.viewType] = true;
                                       break;
                                    }
                                    continue;
                                 }
                                 break;
                              }
                              continue;
                           }
                        }
                        else
                        {
                           var _loc164_:int = 0;
                           var _loc163_:* = _loc69_.giftbagArray;
                           for each(var _loc142_ in _loc69_.giftbagArray)
                           {
                              if(_loc119_[_loc142_.giftbagId])
                              {
                                 _loc126_ = _loc119_[_loc142_.giftbagId].times;
                                 var _loc162_:int = 0;
                                 var _loc161_:* = _loc86_;
                                 for each(var _loc114_ in _loc86_)
                                 {
                                    if(_loc114_.statusID == _loc142_.giftConditionArr[0].conditionValue)
                                    {
                                       _loc46_ = _loc114_.statusValue - _loc126_;
                                    }
                                 }
                                 if(_loc142_.giftConditionArr[2].conditionValue == 0)
                                 {
                                    if(_loc46_ > 0)
                                    {
                                       stateDic[_loc11_.viewType] = true;
                                       break;
                                    }
                                 }
                                 else if(_loc126_ == 0 && _loc46_ > 0)
                                 {
                                    stateDic[_loc11_.viewType] = true;
                                    break;
                                 }
                                 continue;
                              }
                              break;
                           }
                           continue;
                        }
                     }
                  }
                  _loc160_ = 0;
                  var _loc159_:* = _loc69_.giftbagArray;
                  for each(var _loc51_ in _loc69_.giftbagArray)
                  {
                     if(_loc119_[_loc51_.giftbagId])
                     {
                        _loc153_ = _loc119_[_loc51_.giftbagId].times;
                        if(_loc51_.giftConditionArr[2].conditionValue == 0)
                        {
                           _loc66_ = int(Math.floor(_loc86_[0].statusValue / _loc51_.giftConditionArr[0].conditionValue)) - _loc153_;
                           if(_loc66_ > 0)
                           {
                              stateDic[_loc11_.viewType] = true;
                              break;
                           }
                        }
                        else if(_loc153_ == 0 && Math.floor(_loc86_[0].statusValue / _loc51_.giftConditionArr[0].conditionValue) > 0)
                        {
                           stateDic[_loc11_.viewType] = true;
                           break;
                        }
                        continue;
                     }
                     break;
                  }
               }
            }
         }
         _currentItem && _currentItem.setCanAwardStatus(WonderfulActivityManager.Instance.stateDic[_currentItem.type]);
         dispatchCheckEvent();
      }
      
      public function currentItem(param1:IShineableCell) : void
      {
         _currentItem = param1;
      }
      
      private function typeNeedShine(param1:int) : Boolean
      {
         switch(int(param1) - 2)
         {
            case 0:
               return true;
            default:
            default:
            case 3:
               return false;
         }
      }
      
      public function useBattleCompanion(param1:InventoryItemInfo) : void
      {
         _battleCompanionInfo = param1;
         _giveFriendOpenFrame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ShopPresentClearingFrame");
         _giveFriendOpenFrame.nameInput.enable = false;
         _giveFriendOpenFrame.onlyFriendSelectView();
         _giveFriendOpenFrame.show();
         _giveFriendOpenFrame.presentBtn.addEventListener("click",__presentBtnClick,false,0,true);
         _giveFriendOpenFrame.addEventListener("response",__responseHandler2,false,0,true);
      }
      
      private function __responseHandler2(param1:FrameEvent) : void
      {
         if(param1.responseCode == 0 || param1.responseCode == 1 || param1.responseCode == 4)
         {
            removeBattleCompanion();
            _giveFriendOpenFrame = null;
         }
      }
      
      private function removeBattleCompanion() : void
      {
         if(_giveFriendOpenFrame && _giveFriendOpenFrame.presentBtn)
         {
            _giveFriendOpenFrame.presentBtn.removeEventListener("click",__presentBtnClick);
         }
         if(_giveFriendOpenFrame)
         {
            _giveFriendOpenFrame.removeEventListener("response",__responseHandler2);
         }
         _battleCompanionInfo = null;
      }
      
      private function __presentBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var _loc2_:String = _giveFriendOpenFrame.nameInput.text;
         if(_loc2_ == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.give"));
            return;
         }
         if(FilterWordManager.IsNullorEmpty(_loc2_))
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.space"));
            return;
         }
         SocketManager.Instance.out.sendBattleCompanionGive(_giveFriendOpenFrame.selectPlayerId,_battleCompanionInfo.BagType,_battleCompanionInfo.Place);
         removeBattleCompanion();
         ObjectUtils.disposeObject(_giveFriendOpenFrame);
         _giveFriendOpenFrame = null;
      }
      
      private function getTodayList() : Array
      {
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc2_:Array = [];
         var _loc3_:int = CalendarManager.getInstance().eventActives.length;
         var _loc1_:Date = TimeManager.Instance.Now();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = CalendarManager.getInstance().eventActives[_loc5_];
            if(_loc1_.time > _loc4_.start.time && _loc1_.time < _loc4_.end.time)
            {
               _loc2_.push(_loc4_);
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function get eventsActiveDic() : Dictionary
      {
         return _eventsActiveDic;
      }
      
      public function getActiveEventsInfoByID(param1:int) : ActiveEventsInfo
      {
         return _eventsActiveDic[param1];
      }
      
      public function setLimitActivities(param1:Array) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 10000;
         _eventsActiveDic = new Dictionary();
         var _loc2_:Date = TimeManager.Instance.Now();
         var _loc7_:int = 0;
         var _loc6_:* = param1;
         for each(var _loc5_ in param1)
         {
            if(_loc5_.ActiveType != 6)
            {
               if(_loc2_.time > _loc5_.start.time && _loc2_.time < _loc5_.end.time)
               {
                  _eventsActiveDic[_loc3_] = _loc5_;
                  _loc4_ = _loc3_.toString();
                  leftViewInfoDic[_loc4_] = new LeftViewInfoVo(_loc3_,"· " + _loc5_.Title,1);
                  addElement(_loc4_);
                  _loc3_++;
               }
            }
         }
      }
      
      public function getActivityDataById(param1:String) : GmActivityInfo
      {
         return activityData[param1];
      }
      
      public function getActivityInitDataById(param1:String) : Object
      {
         return activityInitData[param1];
      }
      
      public function get sendFrame() : SendGiftActivityFrame
      {
         return _sendGiftFrame;
      }
      
      public function get actList() : Array
      {
         return _actList;
      }
   }
}
