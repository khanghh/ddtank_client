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
      
      public function set activityInitData(value:Dictionary) : void
      {
         _activityInitData = value;
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
      
      protected function rookieRankHandler(event:PkgEvent) : void
      {
         var k:int = 0;
         var actId:* = null;
         var count:int = 0;
         var rookieRankInfoArr:* = null;
         var i:int = 0;
         var info:* = null;
         var pkg:PackageIn = event.pkg;
         var actCount:int = pkg.readInt();
         for(k = 0; k < actCount; )
         {
            actId = pkg.readUTF();
            count = pkg.readInt();
            rookieRankInfoArr = [];
            for(i = 0; i < count; )
            {
               info = new RookieRankInfo();
               info.userId = pkg.readInt();
               info.rank = pkg.readInt();
               info.playerName = pkg.readUTF();
               info.fightPower = pkg.readInt();
               rookieRankInfoArr.push(info);
               i++;
            }
            if(rookieRankInfoArr.length > 10)
            {
               rookieRankInfoArr = rookieRankInfoArr.slice(0,10);
            }
            rookieRankInfoArr.sortOn("rank",16);
            rankActDic[actId] = rookieRankInfoArr;
            k++;
         }
      }
      
      private function activityInitHandler(event:PkgEvent) : void
      {
         var updateInfoType:int = 0;
         var pkg:PackageIn = event.pkg;
         updateInfoType = pkg.readInt();
         if(updateInfoType == 0)
         {
            updateNewActivityXml();
            SocketManager.Instance.out.requestWonderfulActInit(2);
            SocketManager.Instance.out.requestWonderfulActInit(3);
         }
         else if(updateInfoType == 1)
         {
            activityInit(pkg);
            checkActivity();
            initFrame(isSkipFromHall,skipType);
            SocketManager.Instance.out.updateConsumeRank();
            SocketManager.Instance.out.updateRechargeRank();
            SocketManager.Instance.out.sendWonderfulActivity(0,-1);
         }
         else if(updateInfoType == 2)
         {
            activityInit(pkg);
            checkActivity(updateInfoType);
            dispatchEvent(new WonderfulActivityEvent("refresh"));
         }
         else if(updateInfoType == 3)
         {
            refreshSingleActivity(pkg);
            dispatchEvent(new WonderfulActivityEvent("refresh"));
         }
      }
      
      private function refreshSingleActivity(pkg:PackageIn) : void
      {
         var j:int = 0;
         var playerStatus:* = null;
         var k:int = 0;
         var giftCurInfo:* = null;
         var key:* = null;
         var actCount:int = pkg.readInt();
         if(actCount == 0)
         {
            return;
         }
         var actID:String = pkg.readUTF();
         var statusCount:int = pkg.readInt();
         var statusArr:Array = [];
         for(j = 0; j <= statusCount - 1; )
         {
            playerStatus = new PlayerCurInfo();
            playerStatus.statusID = pkg.readInt();
            playerStatus.statusValue = pkg.readInt();
            statusArr.push(playerStatus);
            j++;
         }
         var giftInfoCount:int = pkg.readInt();
         var giftInfoDic:Dictionary = new Dictionary();
         for(k = 0; k <= giftInfoCount - 1; )
         {
            giftCurInfo = new GiftCurInfo();
            key = pkg.readUTF();
            giftCurInfo.times = pkg.readInt();
            giftCurInfo.allGiftGetTimes = pkg.readInt();
            giftInfoDic[key] = giftCurInfo;
            k++;
         }
         activityInitData[actID] = {
            "statusArr":statusArr,
            "giftInfoDic":giftInfoDic
         };
         if(!leftViewInfoDic[actID] && !exchangeActLeftViewInfoDic[actID])
         {
            actID = _mutilIdMapping[actID];
         }
         if(currentView && currentView.hasOwnProperty("updateAwardState"))
         {
            currentView.updateAwardState();
         }
      }
      
      private function updateNewActivityXml() : void
      {
         var loader:BaseLoader = LoaderCreate.Instance.loadWonderfulActivityXml();
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function activityInit(pkg:PackageIn) : void
      {
         var i:int = 0;
         var actID:* = null;
         var statusCount:int = 0;
         var statusArr:* = null;
         var j:int = 0;
         var playerStatus:* = null;
         var giftInfoCount:int = 0;
         var giftInfoDic:* = null;
         var k:int = 0;
         var giftCurInfo:* = null;
         var key:* = null;
         var actCount:int = pkg.readInt();
         for(i = 0; i <= actCount - 1; )
         {
            actID = pkg.readUTF();
            statusCount = pkg.readInt();
            statusArr = [];
            for(j = 0; j <= statusCount - 1; )
            {
               playerStatus = new PlayerCurInfo();
               playerStatus.statusID = pkg.readInt();
               playerStatus.statusValue = pkg.readInt();
               statusArr.push(playerStatus);
               j++;
            }
            giftInfoCount = pkg.readInt();
            giftInfoDic = new Dictionary();
            for(k = 0; k <= giftInfoCount - 1; )
            {
               giftCurInfo = new GiftCurInfo();
               key = pkg.readUTF();
               giftCurInfo.times = pkg.readInt();
               giftCurInfo.allGiftGetTimes = pkg.readInt();
               giftInfoDic[key] = giftCurInfo;
               k++;
            }
            activityInitData[actID] = {
               "statusArr":statusArr,
               "giftInfoDic":giftInfoDic
            };
            i++;
         }
      }
      
      private function rechargeReturnHander(e:PkgEvent) : void
      {
         var id:int = 0;
         var count:int = 0;
         var startTime:* = null;
         var endTime:* = null;
         var loader:* = null;
         var data:* = null;
         var i:int = 0;
         var activityType:int = 0;
         var t:int = 0;
         var tt:int = 0;
         var nowDate:* = null;
         var type:int = e.pkg.readByte();
         if(type == 2)
         {
            if(StateManager.currentStateType == "main" || frameFlag)
            {
               loader = LoaderCreate.Instance.firstRechargeLoader();
               LoadResourceManager.Instance.startLoad(loader);
            }
         }
         else if(type == 0)
         {
            count = e.pkg.readInt();
            for(i = 0; i < count; )
            {
               activityType = -1;
               data = new CanGetData();
               data.id = e.pkg.readInt();
               var _loc14_:* = data.id;
               if(2001 !== _loc14_)
               {
                  if(3001 !== _loc14_)
                  {
                     if(4001 !== _loc14_)
                     {
                        tt = e.pkg.readInt();
                     }
                     else
                     {
                        activityType = 4001;
                        xiaoFeiScore = e.pkg.readInt();
                     }
                  }
                  else
                  {
                     activityType = 3001;
                     chongZhiScore = e.pkg.readInt();
                  }
               }
               else
               {
                  activityType = 2001;
                  t = e.pkg.readInt();
               }
               data.num = e.pkg.readInt();
               startTime = e.pkg.readDate();
               endTime = e.pkg.readDate();
               setActivityTime(data.id,startTime,endTime);
               updateStateList(data);
               if(activityType != -1)
               {
                  nowDate = TimeManager.Instance.Now();
                  if(nowDate.getTime() > startTime.getTime() && nowDate.getTime() < endTime.getTime() && data.num != -2)
                  {
                     addElement(activityType);
                  }
                  else
                  {
                     removeElement(activityType);
                  }
               }
               i++;
            }
            if(count == 1)
            {
               if(!data)
               {
               }
            }
         }
      }
      
      public function updateChargeActiveTemplateXml() : void
      {
         var loader:BaseLoader = LoaderCreate.Instance.creatWondActiveLoader();
         LoadResourceManager.Instance.startLoad(loader);
      }
      
      private function dispatchCheckEvent() : void
      {
         if(!frameFlag && !clickWonderfulActView)
         {
            dispatchEvent(new WonderfulActivityEvent("check_activity_state"));
         }
      }
      
      private function updateStateList(data:CanGetData) : void
      {
         var i:int = 0;
         var len:int = _stateList.length;
         for(i = 0; i < len; )
         {
            if(data.id == _stateList[i].id)
            {
               _stateList[i] = data;
               return;
            }
            i++;
         }
         _stateList.push(data);
      }
      
      private function endRequest() : void
      {
         var i:int = 0;
         var endDate:* = null;
         var diff:Number = NaN;
         var nowDate:Date = TimeManager.Instance.Now();
         for(i = 0; i <= endRequestArr.length - 1; )
         {
            endDate = DateUtils.getDateByStr(endRequestArr[i]);
            diff = Math.round((endDate.getTime() - nowDate.getTime()) / 1000);
            if(diff <= 0)
            {
               endRequestArr.splice(i,1);
               SocketManager.Instance.out.requestWonderfulActInit(2);
            }
            i++;
         }
      }
      
      private function timerHander(event:TimerEvent) : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = _timerHanderFun;
         for each(var timerHander in _timerHanderFun)
         {
            timerHander();
         }
      }
      
      public function addTimerFun(key:String, fun:Function) : void
      {
         _timerHanderFun[key] = fun;
         if(!_timer)
         {
            _timer = new Timer(1000);
            _timer.start();
            _timer.addEventListener("timer",timerHander);
         }
      }
      
      public function delTimerFun(key:String) : void
      {
         if(_timerHanderFun[key])
         {
            delete _timerHanderFun[key];
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
      
      private function isEmptyDictionary(dic:Dictionary) : Boolean
      {
         var _loc4_:int = 0;
         var _loc3_:* = dic;
         for(var str in dic)
         {
            if(str)
            {
               return false;
            }
         }
         return true;
      }
      
      public function getTimeDiff(endDate:Date, nowDate:Date) : String
      {
         var d:* = 0;
         var h:* = 0;
         var m:* = 0;
         var s:* = 0;
         var diff:Number = Math.round((endDate.getTime() - nowDate.getTime()) / 1000);
         if(diff >= 0)
         {
            d = uint(Math.floor(diff / 60 / 60 / 24));
            diff = diff % 86400;
            h = uint(Math.floor(diff / 60 / 60));
            diff = diff % 3600;
            m = uint(Math.floor(diff / 60));
            s = uint(diff % 60);
            if(d > 0)
            {
               return d + LanguageMgr.GetTranslation("wonderfulActivityManager.d");
            }
            if(h > 0)
            {
               return fixZero(h) + LanguageMgr.GetTranslation("wonderfulActivityManager.h");
            }
            if(m > 0)
            {
               return fixZero(m) + LanguageMgr.GetTranslation("wonderfulActivityManager.m");
            }
            if(s > 0)
            {
               return fixZero(s) + LanguageMgr.GetTranslation("wonderfulActivityManager.s");
            }
         }
         return "0";
      }
      
      private function fixZero(num:uint) : String
      {
         return num < 10?String(num):String(num);
      }
      
      private function setActivityTime(id:int, start:Date, end:Date) : void
      {
         var i:int = 0;
         var j:int = 0;
         if(id == 2001)
         {
            if(activityFighterList.length == 0)
            {
               return;
            }
            activityFighterList[0].StartTime = start;
            activityFighterList[0].EndTime = end;
         }
         else if(id >= 3001 && id < 4001)
         {
            if(activityRechargeList.length == 0)
            {
               return;
            }
            i = 0;
            while(i < activityRechargeList.length)
            {
               if(id == activityRechargeList[i].ID)
               {
                  activityRechargeList[i].StartTime = start;
                  activityRechargeList[i].EndTime = end;
                  break;
               }
               i++;
            }
         }
         else if(id >= 4001)
         {
            if(activityExpList.length == 0)
            {
               return;
            }
            j = 0;
            while(j < activityExpList.length)
            {
               if(id == activityExpList[i].ID)
               {
                  activityExpList[i].StartTime = start;
                  activityExpList[i].EndTime = end;
                  break;
               }
               j++;
            }
         }
      }
      
      public function wonderfulGMActiveInfo(analyer:WonderfulGMActAnalyer) : void
      {
         activityData = analyer.ActivityData;
         updateRealEndTime();
         FlowerGivingManager.instance.checkOpen();
         FoodActivityManager.Instance.checkOpen();
         PanicBuyingManager.instance.checkOpen();
         SocketManager.Instance.out.updateRechargeRank();
         SocketManager.Instance.out.requestWonderfulActInit(2);
      }
      
      public function wonderfulActiveType(analy:WonderfulActAnalyer) : void
      {
         var i:int = 0;
         activityFighterList = new Vector.<ActivityTypeData>();
         activityExpList = new Vector.<ActivityTypeData>();
         activityRechargeList = new Vector.<ActivityTypeData>();
         activityTypeList = analy.itemList;
         var len:int = activityTypeList.length;
         for(i = 0; i < len; )
         {
            activityTypeList[i].StartTime = new Date();
            activityTypeList[i].EndTime = new Date();
            if(activityTypeList[i].ID == 2001)
            {
               activityFighterList.push(activityTypeList[i]);
            }
            else if(activityTypeList[i].ID >= 3001 && activityTypeList[i].ID < 4001)
            {
               activityRechargeList.push(activityTypeList[i]);
            }
            else
            {
               activityExpList.push(activityTypeList[i]);
            }
            i++;
         }
         SocketManager.Instance.out.sendWonderfulActivity(0,-1);
      }
      
      private function initFrame(SkipFromHall:Boolean = false, type:String = "0") : void
      {
         isSkipFromHall = SkipFromHall;
         skipType = type;
         leftUnitViewType = !!leftViewInfoDic[skipType]?leftViewInfoDic[skipType].unitIndex:2;
         loadResouce();
      }
      
      private function loadResouce() : void
      {
         AssetModuleLoader.addModelLoader("ddtcalendar",6);
         AssetModuleLoader.addModelLoader("wonderfulactivity",6);
         AssetModuleLoader.addModelLoader("mark",7);
         AssetModuleLoader.startCodeLoader(loadComplete);
      }
      
      private function loadComplete() : void
      {
         CalendarManager.getInstance().open(-1);
         dispatchEvent(new WonderfulActivityEvent("wonderfulActivityOpenView"));
      }
      
      public function addElement(activityID:*) : void
      {
         activityID = String(activityID);
         if(_actList.indexOf(activityID) == -1)
         {
            _actList.unshift(activityID);
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
      
      public function removeElement(activityID:*) : void
      {
         activityID = String(activityID);
         var index:int = _actList.indexOf(activityID);
         if(index == -1)
         {
            return;
         }
         _actList.splice(index,1);
         dispatchEvent(new WonderfulActivityEvent("wonderfulActivityAddEment"));
         if(_actList.length == 0)
         {
            dispose();
            return;
         }
         if(_actList.length > 0)
         {
            if(currView == activityID)
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
         var endTime:* = null;
         var endShowTime:* = null;
         if(PlayerManager.Instance.Self.createPlayerDate == null)
         {
            return;
         }
         var _loc5_:int = 0;
         var _loc4_:* = activityData;
         for each(var item in activityData)
         {
            if(item.activityType == 39 && PlayerManager.Instance.Self.createPlayerDate)
            {
               item.beginTime = DateUtils.dateFormat3(PlayerManager.Instance.Self.createPlayerDate);
               item.beginShowTime = DateUtils.dateFormat3(PlayerManager.Instance.Self.createPlayerDate);
               endTime = new Date(PlayerManager.Instance.Self.createPlayerDate.time + (item.remain1 - 1) * 86400000);
               endShowTime = new Date(PlayerManager.Instance.Self.createPlayerDate.time + (item.remain2 - 1) * 86400000);
               item.endShowTime = DateUtils.dateFormat4(endShowTime);
               item.endTime = DateUtils.dateFormat4(endTime);
               break;
            }
         }
      }
      
      private function checkActivity(_type:int = 0) : void
      {
         var isHeroExist:Boolean = false;
         var temp:int = 0;
         var isRookieExist:Boolean = false;
         var isGiftExist:Boolean = false;
         var i:int = 0;
         rankFlag = false;
         var tmpArr:Array = [];
         var now:Date = TimeManager.Instance.Now();
         RoleRechargeMgr.instance.isOpen = false;
         SignActivityMgr.instance.isOpen = false;
         ConRechargeManager.instance.isOpen = false;
         var _loc22_:int = 0;
         var _loc21_:* = activityData;
         for each(var item in activityData)
         {
            if(!(now.time < Date.parse(item.beginTime) || now.time > Date.parse(item.endShowTime)))
            {
               if(endRequestArr.indexOf(item.endShowTime) < 0)
               {
                  endRequestArr.push(item.endShowTime);
               }
               var _loc16_:* = item.activityType;
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
                                                                                                      leftViewInfoDic[item.activityId] = new LeftViewInfoVo(101,"· " + item.activityName,item.icon);
                                                                                                      CondiscountManager.instance.model.giftbagArray = item.giftbagArray;
                                                                                                      CondiscountManager.instance.model.beginTime = item.beginTime;
                                                                                                      CondiscountManager.instance.model.endTime = item.endTime;
                                                                                                      CondiscountManager.instance.model.actId = item.activityId;
                                                                                                      CondiscountManager.instance.model.isOpen = DateUtils.checkTime(item.beginTime,item.endTime,TimeManager.Instance.Now());
                                                                                                   }
                                                                                                }
                                                                                                else
                                                                                                {
                                                                                                   leftViewInfoDic[item.activityId] = new LeftViewInfoVo(51,"· " + item.activityName,item.icon);
                                                                                                   addElement(item.activityId);
                                                                                                   tmpArr.push(item.activityId);
                                                                                                }
                                                                                             }
                                                                                             else
                                                                                             {
                                                                                                leftViewInfoDic[item.activityId] = new LeftViewInfoVo(52,"· " + item.activityName,item.icon);
                                                                                                addElement(item.activityId);
                                                                                                tmpArr.push(item.activityId);
                                                                                             }
                                                                                          }
                                                                                          else
                                                                                          {
                                                                                             leftViewInfoDic[item.activityId] = new LeftViewInfoVo(49,"· " + item.activityName,item.icon);
                                                                                             addElement(item.activityId);
                                                                                             tmpArr.push(item.activityId);
                                                                                          }
                                                                                       }
                                                                                       else
                                                                                       {
                                                                                          leftViewInfoDic[item.activityId] = new LeftViewInfoVo(48,"· " + item.activityName,item.icon);
                                                                                          addElement(item.activityId);
                                                                                          tmpArr.push(item.activityId);
                                                                                       }
                                                                                    }
                                                                                    else
                                                                                    {
                                                                                       leftViewInfoDic[item.activityId] = new LeftViewInfoVo(47,"· " + item.activityName,item.icon);
                                                                                       addElement(item.activityId);
                                                                                       tmpArr.push(item.activityId);
                                                                                    }
                                                                                 }
                                                                                 else
                                                                                 {
                                                                                    leftViewInfoDic[item.activityId] = new LeftViewInfoVo(46,"· " + item.activityName,item.icon);
                                                                                    addElement(item.activityId);
                                                                                    tmpArr.push(item.activityId);
                                                                                 }
                                                                              }
                                                                              else
                                                                              {
                                                                                 leftViewInfoDic[item.activityId] = new LeftViewInfoVo(45,"· " + item.activityName,item.icon);
                                                                                 addElement(item.activityId);
                                                                                 tmpArr.push(item.activityId);
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              leftViewInfoDic[item.activityId] = new LeftViewInfoVo(44,"· " + item.activityName,item.icon);
                                                                              addElement(item.activityId);
                                                                              tmpArr.push(item.activityId);
                                                                           }
                                                                        }
                                                                        else
                                                                        {
                                                                           leftViewInfoDic[item.activityId] = new LeftViewInfoVo(43,"· " + item.activityName,item.icon);
                                                                           addElement(item.activityId);
                                                                           tmpArr.push(item.activityId);
                                                                        }
                                                                     }
                                                                     else
                                                                     {
                                                                        leftViewInfoDic[item.activityId] = new LeftViewInfoVo(42,"· " + item.activityName,item.icon);
                                                                        addElement(item.activityId);
                                                                        tmpArr.push(item.activityId);
                                                                     }
                                                                  }
                                                                  else
                                                                  {
                                                                     ConRechargeManager.instance.giftbagArray = item.giftbagArray;
                                                                     ConRechargeManager.instance.beginTime = item.beginShowTime;
                                                                     ConRechargeManager.instance.endTime = item.endShowTime;
                                                                     ConRechargeManager.instance.actId = item.activityId;
                                                                     ConRechargeManager.instance.isOpen = true;
                                                                  }
                                                               }
                                                               else
                                                               {
                                                                  leftViewInfoDic[item.activityId] = new LeftViewInfoVo(100,"· " + item.activityName,item.icon);
                                                                  SignActivityMgr.instance.model.giftbagArray = item.giftbagArray;
                                                                  SignActivityMgr.instance.model.beginTime = item.beginShowTime.split(" ")[0];
                                                                  SignActivityMgr.instance.model.endTime = item.endShowTime.split(" ")[0];
                                                                  SignActivityMgr.instance.model.actId = item.activityId;
                                                                  SignActivityMgr.instance.isOpen = true;
                                                               }
                                                            }
                                                            else
                                                            {
                                                               leftViewInfoDic[item.activityId] = new LeftViewInfoVo(88,"· " + item.activityName,item.icon);
                                                               RoleRechargeMgr.instance.model.giftbagArray = item.giftbagArray;
                                                               RoleRechargeMgr.instance.model.beginTime = item.beginShowTime.split(" ")[0];
                                                               RoleRechargeMgr.instance.model.endTime = item.endShowTime.split(" ")[0];
                                                               RoleRechargeMgr.instance.model.actId = item.activityId;
                                                               RoleRechargeMgr.instance.isOpen = true;
                                                            }
                                                         }
                                                         else
                                                         {
                                                            rankDic[item.activityChildType] = item;
                                                            rankFlag = true;
                                                            RankManager.instance.model.beginTime = item.beginTime;
                                                            RankManager.instance.model.endTime = item.endTime;
                                                         }
                                                      }
                                                      else if(item.activityChildType == 2 || item.activityChildType == 1 || item.activityChildType == 4 || item.activityChildType == 3 || item.activityChildType == 0)
                                                      {
                                                         var _loc20_:int = 0;
                                                         var _loc19_:* = leftViewInfoDic;
                                                         for each(var viewInfoVo in leftViewInfoDic)
                                                         {
                                                            if(viewInfoVo.viewType == 39)
                                                            {
                                                               isGiftExist = true;
                                                               break;
                                                            }
                                                         }
                                                         if(!isGiftExist)
                                                         {
                                                            leftViewInfoDic[item.activityId] = new LeftViewInfoVo(39,"· " + item.activityName,item.icon);
                                                            addElement(item.activityId);
                                                            _existentId = item.activityId;
                                                         }
                                                         else
                                                         {
                                                            _mutilIdMapping[item.activityId] = _existentId;
                                                         }
                                                         if(tmpArr.indexOf(item.activityId) == -1)
                                                         {
                                                            tmpArr.push(item.activityId);
                                                         }
                                                      }
                                                   }
                                                   else
                                                   {
                                                      leftViewInfoDic[item.activityId] = new LeftViewInfoVo(38,"· " + item.activityName,item.icon);
                                                      addElement(item.activityId);
                                                      tmpArr.push(item.activityId);
                                                   }
                                                }
                                                else
                                                {
                                                   leftViewInfoDic[item.activityId] = new LeftViewInfoVo(37,"· " + item.activityName,item.icon);
                                                   addElement(item.activityId);
                                                   tmpArr.push(item.activityId);
                                                }
                                             }
                                             else if(item.activityChildType == 0)
                                             {
                                                leftViewInfoDic[item.activityId] = new LeftViewInfoVo(41,"· " + item.activityName,item.icon);
                                                addElement(item.activityId);
                                                tmpArr.push(item.activityId);
                                             }
                                          }
                                          else if(item.activityChildType == 0)
                                          {
                                             leftViewInfoDic[item.activityId] = new LeftViewInfoVo(24,"· " + item.activityName,item.icon);
                                             addElement(item.activityId);
                                             tmpArr.push(item.activityId);
                                          }
                                          else if(item.activityChildType == 1)
                                          {
                                             leftViewInfoDic[item.activityId] = new LeftViewInfoVo(25,"· " + item.activityName,item.icon);
                                             addElement(item.activityId);
                                             tmpArr.push(item.activityId);
                                          }
                                       }
                                       else
                                       {
                                          switch(int(item.activityChildType) - 1)
                                          {
                                             case 0:
                                                temp = 26;
                                                break;
                                             case 1:
                                                temp = 27;
                                                break;
                                             case 2:
                                                temp = 28;
                                                break;
                                             case 3:
                                                var _loc18_:int = 0;
                                                var _loc17_:* = leftViewInfoDic;
                                                for each(var leftViewInfoVo in leftViewInfoDic)
                                                {
                                                   if(leftViewInfoVo.viewType == 29)
                                                   {
                                                      isRookieExist = true;
                                                      break;
                                                   }
                                                }
                                                if(!isRookieExist)
                                                {
                                                   temp = 29;
                                                   _existentId = item.activityId;
                                                }
                                                else
                                                {
                                                   temp = 0;
                                                   _mutilIdMapping[item.activityId] = _existentId;
                                                }
                                                break;
                                             case 4:
                                                temp = 30;
                                                break;
                                             case 5:
                                                temp = 31;
                                                break;
                                             case 6:
                                                temp = 32;
                                                break;
                                             case 7:
                                                temp = 33;
                                                break;
                                             case 8:
                                                temp = 34;
                                                break;
                                             case 9:
                                                temp = 35;
                                                break;
                                             case 10:
                                             case 11:
                                                temp = 36;
                                          }
                                          if(temp != 0)
                                          {
                                             leftViewInfoDic[item.activityId] = new LeftViewInfoVo(temp,"· " + item.activityName,item.icon);
                                             addElement(item.activityId);
                                          }
                                          if(tmpArr.indexOf(item.activityId) == -1)
                                          {
                                             tmpArr.push(item.activityId);
                                          }
                                       }
                                    }
                                    else if(item.activityChildType == 1 || item.activityChildType == 2)
                                    {
                                       leftViewInfoDic[item.activityId] = new LeftViewInfoVo(22,"· " + item.activityName,item.icon);
                                       addElement(item.activityId);
                                       tmpArr.push(item.activityId);
                                    }
                                    else if(item.activityChildType == 3)
                                    {
                                       _info = item;
                                       if(_sendGiftFrame && activityInitData[_info.activityId] && activityInitData[_info.activityId].giftInfoDic[_info.giftbagArray[0].giftbagId].times != 0 && _sendGiftFrame.nowId == _info.activityId)
                                       {
                                          _sendGiftFrame.setBtnFalse();
                                          return;
                                       }
                                       if(_type == 2)
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
                                 else if(item.activityChildType == 2)
                                 {
                                    leftViewInfoDic[item.activityId] = new LeftViewInfoVo(21,"· " + item.activityName,item.icon);
                                    addElement(item.activityId);
                                    tmpArr.push(item.activityId);
                                 }
                              }
                              else if(item.activityChildType == 0)
                              {
                                 exchangeActLeftViewInfoDic[item.activityId] = new LeftViewInfoVo(20,"· " + item.activityName,item.icon);
                                 addElement(item.activityId);
                                 tmpArr.push(item.activityId);
                              }
                           }
                           else if(item.activityChildType == 0)
                           {
                              leftViewInfoDic[item.activityId] = new LeftViewInfoVo(15,"· " + item.activityName,item.icon);
                              addElement(item.activityId);
                              tmpArr.push(item.activityId);
                           }
                        }
                        else if(item.activityChildType == 1)
                        {
                           leftViewInfoDic[item.activityId] = new LeftViewInfoVo(14,"· " + item.activityName,item.icon);
                           addElement(item.activityId);
                           tmpArr.push(item.activityId);
                        }
                     }
                     else if(item.activityChildType == 0 || item.activityChildType == 1)
                     {
                        _loc16_ = 0;
                        var _loc15_:* = leftViewInfoDic;
                        for each(var leftViewInfo in leftViewInfoDic)
                        {
                           if(leftViewInfo.viewType == 10)
                           {
                              isHeroExist = true;
                              break;
                           }
                        }
                        if(!isHeroExist)
                        {
                           leftViewInfoDic[item.activityId] = new LeftViewInfoVo(10,"· " + item.activityName,item.icon);
                           addElement(item.activityId);
                           _existentId = item.activityId;
                        }
                        else
                        {
                           _mutilIdMapping[item.activityId] = _existentId;
                        }
                        if(tmpArr.indexOf(item.activityId) == -1)
                        {
                           tmpArr.push(item.activityId);
                        }
                     }
                  }
                  else
                  {
                     switch(int(item.activityChildType))
                     {
                        case 0:
                           leftViewInfoDic[item.activityId] = new LeftViewInfoVo(21,"· " + item.activityName,item.icon);
                           addElement(item.activityId);
                           tmpArr.push(item.activityId);
                           break;
                        case 1:
                           leftViewInfoDic[item.activityId] = new LeftViewInfoVo(19,"· " + item.activityName,item.icon);
                           addElement(item.activityId);
                           tmpArr.push(item.activityId);
                           break;
                        case 2:
                           leftViewInfoDic[item.activityId] = new LeftViewInfoVo(21,"· " + item.activityName,item.icon);
                           addElement(item.activityId);
                           tmpArr.push(item.activityId);
                     }
                  }
               }
               else
               {
                  switch(int(item.activityChildType))
                  {
                     case 0:
                        break;
                     case 1:
                        leftViewInfoDic[item.activityId] = new LeftViewInfoVo(21,"· " + item.activityName,item.icon);
                        addElement(item.activityId);
                        tmpArr.push(item.activityId);
                        break;
                     case 2:
                        leftViewInfoDic[item.activityId] = new LeftViewInfoVo(17,"· " + item.activityName,item.icon);
                        addElement(item.activityId);
                        tmpArr.push(item.activityId);
                        break;
                     case 3:
                        leftViewInfoDic[item.activityId] = new LeftViewInfoVo(12,"· " + item.activityName,item.icon);
                        addElement(item.activityId);
                        tmpArr.push(item.activityId);
                        break;
                     default:
                        leftViewInfoDic[item.activityId] = new LeftViewInfoVo(12,"· " + item.activityName,item.icon);
                        addElement(item.activityId);
                        tmpArr.push(item.activityId);
                        break;
                     case 5:
                        leftViewInfoDic[item.activityId] = new LeftViewInfoVo(9,"· " + item.activityName,item.icon);
                        addElement(item.activityId);
                        tmpArr.push(item.activityId);
                        break;
                     case 6:
                        leftViewInfoDic[item.activityId] = new LeftViewInfoVo(18,"· " + item.activityName,item.icon);
                        addElement(item.activityId);
                        tmpArr.push(item.activityId);
                        break;
                     case 7:
                        leftViewInfoDic[item.activityId] = new LeftViewInfoVo(40,"· " + item.activityName,item.icon);
                        addElement(item.activityId);
                        tmpArr.push(item.activityId);
                  }
               }
            }
         }
         var index:int = -1;
         for(i = 0; i <= tmpArr.length - 1; )
         {
            index = lastActList.indexOf(tmpArr[i]);
            if(index >= 0)
            {
               lastActList.splice(index,1);
            }
            i++;
         }
         var _loc24_:int = 0;
         var _loc23_:* = lastActList;
         for each(var type in lastActList)
         {
            if(leftViewInfoDic[type])
            {
               leftViewInfoDic[type] = null;
               delete leftViewInfoDic[type];
            }
            else if(exchangeActLeftViewInfoDic[type])
            {
               exchangeActLeftViewInfoDic[type] = null;
               delete exchangeActLeftViewInfoDic[type];
            }
            removeElement(type);
         }
         lastActList = tmpArr;
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
            for(var viewType in stateDic)
            {
               if(stateDic[viewType])
               {
                  _wonderfulIcon.setFrame(2);
                  return;
               }
            }
            _wonderfulIcon.setFrame(1);
         }
      }
      
      public function getActIdWithViewId(viewId:int) : String
      {
         var leftViewInfo:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = leftViewInfoDic;
         for(var key in leftViewInfoDic)
         {
            leftViewInfo = leftViewInfoDic[key];
            if(leftViewInfo.viewType == viewId)
            {
               return key;
            }
         }
         return "";
      }
      
      private function checkActState() : void
      {
         var leftViewInfo:* = null;
         var giftInfoDic:* = null;
         var statusArr:* = null;
         var item:* = null;
         var nowTime:Number = NaN;
         var alreadyGet:int = 0;
         var remain:int = 0;
         var alreadyGet2:int = 0;
         var remain2:int = 0;
         var alreadyGet3:int = 0;
         var remain4:int = 0;
         var grade:int = 0;
         var currentGrade:int = 0;
         var reallyHorseGrade:int = 0;
         var i_mountGrade:int = 0;
         var horseSkillType:int = 0;
         var horseSkillGrade:int = 0;
         var i_mountSkill:int = 0;
         var skillGrade:int = 0;
         var currentSkillGrade:int = 0;
         var grade1:int = 0;
         var currentGrade1:int = 0;
         var reallyHorseGrade1:int = 0;
         var i_mountGrade1:int = 0;
         var currentCondtion:int = 0;
         var carnivalMountGrade:int = 0;
         var carnivalMountCurrentGrade:int = 0;
         var condtion:int = 0;
         var sumCount:int = 0;
         var playerAlreadyGetCount:int = 0;
         var allGiftAlreadyGetCount:int = 0;
         var i_carnival:int = 0;
         var rookieCurInfo:* = null;
         var rookieItemArr:* = null;
         var power:int = 0;
         var rank1:int = 0;
         var now:* = null;
         var rookie:int = 0;
         var fightPower:int = 0;
         var fightPowerRankOne:int = 0;
         var fightPowerRankTwo:int = 0;
         var rookieSumCount:int = 0;
         var rookieTimes:int = 0;
         var i_rookie:int = 0;
         var selfNeedPetNum:int = 0;
         var personNeedPetNum:int = 0;
         var addedNeedPetNum:int = 0;
         var _addedIsSuperPet:Boolean = false;
         var _personIsSuperPet:Boolean = false;
         var _selfIsSuperPet:Boolean = false;
         var selfNeedPetStar:int = 0;
         var personNeedPetStar:int = 0;
         var addedNeedPetStar:int = 0;
         var getCount:int = 0;
         var addedNum:int = 0;
         var personNum:int = 0;
         var selfNum:int = 0;
         var wholePetTimes:int = 0;
         var j_wholePet:int = 0;
         var i_wholePet:int = 0;
         var addedBoolean:Boolean = false;
         var personBoolean:Boolean = false;
         var selfBoolean:Boolean = false;
         var timeBoolean:Boolean = false;
         var canGet:Boolean = false;
         var condition_selfGrade:int = 0;
         var condition_personNum:int = 0;
         var condition_addedNum:int = 0;
         var condition_vipGd:int = 0;
         var condition_addedVipGd:int = 0;
         var vipGetCount:int = 0;
         var vipAddedNum:int = 0;
         var vipPersonNum:int = 0;
         var vipSelfGrade:int = 0;
         var vipTimes:int = 0;
         var i_wholeVip:int = 0;
         var vip_addedBoolean:Boolean = false;
         var vip_personBoolean:Boolean = false;
         var vip_selfBoolean:Boolean = false;
         var vip_timeBoolean:Boolean = false;
         var vip_canGet:Boolean = false;
         var dailyGiftCurInfo:* = null;
         var dailyGiftItemArr:* = null;
         var _count:int = 0;
         var _temId:int = 0;
         var _getGoodsType:int = 0;
         var _beadGrade:int = 0;
         var _magicStoneQuality:int = 0;
         var _actType:int = 0;
         var dailyGiftTimes:int = 0;
         var dailyGift:int = 0;
         var i_dailyGift:int = 0;
         var magicStoneInfo:* = null;
         var beadInfo:* = null;
         var getTimes:int = 0;
         var condtion1:int = 0;
         var curCondition1:int = 0;
         var i:int = 0;
         var getTimes1:int = 0;
         var condtion2:int = 0;
         var startGrage:int = 0;
         var curGrade:int = 0;
         var conditionGrade:int = 0;
         var i5:int = 0;
         var condtion3:int = 0;
         var getTimes2:int = 0;
         var i2:int = 0;
         var isReceive:Boolean = false;
         var getTimes3:int = 0;
         var condtion4:int = 0;
         var remain3:int = 0;
         var condtion4Value:int = 0;
         var i3:int = 0;
         var getTimes4:int = 0;
         var conIndex:int = 0;
         var propId:int = 0;
         var useCount:int = 0;
         var curUseCount:int = 0;
         var i4:int = 0;
         var getTimes6:int = 0;
         var condtion7:int = 0;
         var currentCondtion7:int = 0;
         var i6:int = 0;
         var _loc228_:int = 0;
         var _loc227_:* = leftViewInfoDic;
         for(var key in leftViewInfoDic)
         {
            stateDic[leftViewInfoDic[key].viewType] = false;
            if(!(!activityData[key] || !activityInitData[key]))
            {
               leftViewInfo = leftViewInfoDic[key];
               giftInfoDic = activityInitData[key].giftInfoDic;
               statusArr = activityInitData[key].statusArr;
               item = activityData[key];
               nowTime = TimeManager.Instance.Now().time;
               var _loc160_:* = leftViewInfo.viewType;
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
                                                                                                         var _loc225_:* = item.giftbagArray;
                                                                                                         for each(var giftinfo6 in item.giftbagArray)
                                                                                                         {
                                                                                                            if(giftInfoDic[giftinfo6.giftbagId])
                                                                                                            {
                                                                                                               getTimes6 = giftInfoDic[giftinfo6.giftbagId].times;
                                                                                                               for(i6 = 0; i6 < giftinfo6.giftConditionArr.length; )
                                                                                                               {
                                                                                                                  if(giftinfo6.giftConditionArr[i6].conditionIndex == 0)
                                                                                                                  {
                                                                                                                     condtion7 = giftinfo6.giftConditionArr[i6].conditionValue;
                                                                                                                  }
                                                                                                                  i6++;
                                                                                                               }
                                                                                                               var _loc224_:int = 0;
                                                                                                               var _loc223_:* = statusArr;
                                                                                                               for each(var info6 in statusArr)
                                                                                                               {
                                                                                                                  if(info6.statusID == condtion7)
                                                                                                                  {
                                                                                                                     currentCondtion7 = info6.statusValue;
                                                                                                                     break;
                                                                                                                  }
                                                                                                               }
                                                                                                               if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && currentCondtion7 > 0 && getTimes6 == 0)
                                                                                                               {
                                                                                                                  stateDic[leftViewInfo.viewType] = true;
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
                                                                                                      var _loc221_:* = item.giftbagArray;
                                                                                                      for each(var giftinfo5 in item.giftbagArray)
                                                                                                      {
                                                                                                         if(giftInfoDic[giftinfo5.giftbagId])
                                                                                                         {
                                                                                                            getTimes4 = giftInfoDic[giftinfo5.giftbagId].times;
                                                                                                            for(i4 = 0; i4 < giftinfo5.giftConditionArr.length; )
                                                                                                            {
                                                                                                               conIndex = giftinfo5.giftConditionArr[i4].conditionIndex;
                                                                                                               if(conIndex > 50 && conIndex < 100)
                                                                                                               {
                                                                                                                  propId = giftinfo5.giftConditionArr[i4].conditionValue;
                                                                                                                  useCount = giftinfo5.giftConditionArr[i4].remain1;
                                                                                                               }
                                                                                                               i4++;
                                                                                                            }
                                                                                                            var _loc220_:int = 0;
                                                                                                            var _loc219_:* = statusArr;
                                                                                                            for each(var info5 in statusArr)
                                                                                                            {
                                                                                                               if(info5.statusID == propId)
                                                                                                               {
                                                                                                                  curUseCount = info5.statusValue;
                                                                                                                  break;
                                                                                                               }
                                                                                                            }
                                                                                                            if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && curUseCount >= useCount && getTimes4 == 0)
                                                                                                            {
                                                                                                               stateDic[leftViewInfo.viewType] = true;
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
                                                                                                   var _loc217_:* = item.giftbagArray;
                                                                                                   for each(var giftinfo4 in item.giftbagArray)
                                                                                                   {
                                                                                                      if(giftInfoDic[giftinfo4.giftbagId])
                                                                                                      {
                                                                                                         getTimes3 = giftInfoDic[giftinfo4.giftbagId].times;
                                                                                                         for(i3 = 0; i3 < giftinfo4.giftConditionArr.length; )
                                                                                                         {
                                                                                                            if(giftinfo4.giftConditionArr[i3].conditionIndex == 0)
                                                                                                            {
                                                                                                               condtion4 = giftinfo4.giftConditionArr[i3].conditionValue;
                                                                                                               remain3 = giftinfo4.giftConditionArr[i3].remain1;
                                                                                                            }
                                                                                                            i3++;
                                                                                                         }
                                                                                                         var _loc216_:int = 0;
                                                                                                         var _loc215_:* = statusArr;
                                                                                                         for each(var info4 in statusArr)
                                                                                                         {
                                                                                                            if(info4.statusID == condtion4)
                                                                                                            {
                                                                                                               condtion4Value = info4.statusValue;
                                                                                                            }
                                                                                                         }
                                                                                                         if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && condtion4Value >= remain3 && getTimes3 == 0)
                                                                                                         {
                                                                                                            stateDic[leftViewInfo.viewType] = true;
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
                                                                                                var _loc213_:* = item.giftbagArray;
                                                                                                for each(var giftinfo2 in item.giftbagArray)
                                                                                                {
                                                                                                   if(giftInfoDic[giftinfo2.giftbagId])
                                                                                                   {
                                                                                                      getTimes2 = giftInfoDic[giftinfo2.giftbagId].times;
                                                                                                      for(i2 = 0; i2 < giftinfo2.giftConditionArr.length; )
                                                                                                      {
                                                                                                         if(giftinfo2.giftConditionArr[i2].conditionIndex == 0)
                                                                                                         {
                                                                                                            condtion3 = giftinfo2.giftConditionArr[i2].conditionValue;
                                                                                                         }
                                                                                                         i2++;
                                                                                                      }
                                                                                                      isReceive = false;
                                                                                                      var _loc212_:int = 0;
                                                                                                      var _loc211_:* = statusArr;
                                                                                                      for each(var info3 in statusArr)
                                                                                                      {
                                                                                                         if(info3.statusID == condtion3)
                                                                                                         {
                                                                                                            if(info3.statusValue > 0)
                                                                                                            {
                                                                                                               isReceive = true;
                                                                                                               break;
                                                                                                            }
                                                                                                         }
                                                                                                      }
                                                                                                      if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && isReceive && getTimes2 == 0)
                                                                                                      {
                                                                                                         stateDic[leftViewInfo.viewType] = true;
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
                                                                                             var _loc209_:* = item.giftbagArray;
                                                                                             for each(var giftinfo1 in item.giftbagArray)
                                                                                             {
                                                                                                if(giftInfoDic[giftinfo1.giftbagId])
                                                                                                {
                                                                                                   getTimes1 = giftInfoDic[giftinfo1.giftbagId].times;
                                                                                                   for(i5 = 0; i5 < giftinfo1.giftConditionArr.length; )
                                                                                                   {
                                                                                                      if(giftinfo1.giftConditionArr[i5].conditionIndex == 0)
                                                                                                      {
                                                                                                         condtion2 = giftinfo1.giftConditionArr[i5].remain1;
                                                                                                      }
                                                                                                      i5++;
                                                                                                   }
                                                                                                   var _loc208_:int = 0;
                                                                                                   var _loc207_:* = statusArr;
                                                                                                   for each(var info in statusArr)
                                                                                                   {
                                                                                                      if(info.statusID == 0)
                                                                                                      {
                                                                                                         startGrage = info.statusValue;
                                                                                                      }
                                                                                                      else if(info.statusID == 1)
                                                                                                      {
                                                                                                         curGrade = info.statusValue;
                                                                                                      }
                                                                                                   }
                                                                                                   if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && startGrage < condtion2 && condtion2 <= curGrade && getTimes1 == 0)
                                                                                                   {
                                                                                                      stateDic[leftViewInfo.viewType] = true;
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
                                                                                    addr3245:
                                                                                    var _loc206_:int = 0;
                                                                                    var _loc205_:* = item.giftbagArray;
                                                                                    for each(var giftinfo in item.giftbagArray)
                                                                                    {
                                                                                       if(giftInfoDic[giftinfo.giftbagId])
                                                                                       {
                                                                                          getTimes = giftInfoDic[giftinfo.giftbagId].times;
                                                                                          for(i = 0; i < giftinfo.giftConditionArr.length; )
                                                                                          {
                                                                                             if(giftinfo.giftConditionArr[i].conditionIndex == 0)
                                                                                             {
                                                                                                condtion1 = giftinfo.giftConditionArr[i].conditionValue;
                                                                                             }
                                                                                             i++;
                                                                                          }
                                                                                          curCondition1 = statusArr[0].statusValue;
                                                                                          if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && getTimes == 0 && curCondition1 >= condtion1)
                                                                                          {
                                                                                             stateDic[leftViewInfo.viewType] = true;
                                                                                             break;
                                                                                          }
                                                                                          continue;
                                                                                       }
                                                                                       break;
                                                                                    }
                                                                                    continue;
                                                                                 }
                                                                                 §§goto(addr3245);
                                                                              }
                                                                              else
                                                                              {
                                                                                 dailyGiftItemArr = [];
                                                                                 var _loc200_:int = 0;
                                                                                 var _loc199_:* = activityData;
                                                                                 for each(var item_dailyGift in activityData)
                                                                                 {
                                                                                    if(item_dailyGift.activityType == 18)
                                                                                    {
                                                                                       dailyGiftItemArr.push(item_dailyGift);
                                                                                    }
                                                                                 }
                                                                                 _count = 0;
                                                                                 _temId = 0;
                                                                                 _getGoodsType = 0;
                                                                                 _beadGrade = 0;
                                                                                 _magicStoneQuality = 0;
                                                                                 for(dailyGift = 0; dailyGift < dailyGiftItemArr.length; )
                                                                                 {
                                                                                    var _loc204_:int = 0;
                                                                                    var _loc203_:* = dailyGiftItemArr[dailyGift].giftbagArray;
                                                                                    for each(var giftInfo_dailyGift in dailyGiftItemArr[dailyGift].giftbagArray)
                                                                                    {
                                                                                       if(activityInitData[dailyGiftItemArr[dailyGift].activityId].giftInfoDic[giftInfo_dailyGift.giftbagId])
                                                                                       {
                                                                                          dailyGiftCurInfo = activityInitData[dailyGiftItemArr[dailyGift].activityId].giftInfoDic[giftInfo_dailyGift.giftbagId];
                                                                                          if(giftInfo_dailyGift.rewardMark != 100)
                                                                                          {
                                                                                             dailyGiftTimes = dailyGiftCurInfo.times;
                                                                                             for(i_dailyGift = 0; i_dailyGift < giftInfo_dailyGift.giftConditionArr.length; )
                                                                                             {
                                                                                                if(giftInfo_dailyGift.giftConditionArr[i_dailyGift].conditionIndex == 0)
                                                                                                {
                                                                                                   _actType = 1;
                                                                                                }
                                                                                                else if(giftInfo_dailyGift.giftConditionArr[i_dailyGift].conditionIndex == 1)
                                                                                                {
                                                                                                   _actType = 2;
                                                                                                   _count = giftInfo_dailyGift.giftConditionArr[i_dailyGift].remain1;
                                                                                                   _getGoodsType = giftInfo_dailyGift.giftConditionArr[i_dailyGift].remain2;
                                                                                                   if(_getGoodsType == 2)
                                                                                                   {
                                                                                                      _beadGrade = giftInfo_dailyGift.giftConditionArr[i_dailyGift].conditionValue;
                                                                                                   }
                                                                                                   else
                                                                                                   {
                                                                                                      _magicStoneQuality = giftInfo_dailyGift.giftConditionArr[i_dailyGift].conditionValue;
                                                                                                   }
                                                                                                }
                                                                                                else if(giftInfo_dailyGift.giftConditionArr[i_dailyGift].conditionIndex == 2)
                                                                                                {
                                                                                                   _actType = 3;
                                                                                                }
                                                                                                else if(giftInfo_dailyGift.giftConditionArr[i_dailyGift].conditionIndex != 3)
                                                                                                {
                                                                                                   if(giftInfo_dailyGift.giftConditionArr[i_dailyGift].conditionIndex > 50 && giftInfo_dailyGift.giftConditionArr[i_dailyGift].conditionIndex < 100)
                                                                                                   {
                                                                                                      _temId = giftInfo_dailyGift.giftConditionArr[i_dailyGift].conditionValue;
                                                                                                      _count = giftInfo_dailyGift.giftConditionArr[i_dailyGift].remain1;
                                                                                                   }
                                                                                                }
                                                                                                i_dailyGift++;
                                                                                             }
                                                                                             var _loc202_:int = 0;
                                                                                             var _loc201_:* = activityInitData[dailyGiftItemArr[dailyGift].activityId].statusArr;
                                                                                             for each(var info_dailyGift in activityInitData[dailyGiftItemArr[dailyGift].activityId].statusArr)
                                                                                             {
                                                                                                if(_actType == 1 || _actType == 3)
                                                                                                {
                                                                                                   if(info_dailyGift.statusID == _temId)
                                                                                                   {
                                                                                                      if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && dailyGiftTimes == 0 && info_dailyGift.statusValue >= _count)
                                                                                                      {
                                                                                                         stateDic[leftViewInfo.viewType] = true;
                                                                                                         break;
                                                                                                      }
                                                                                                   }
                                                                                                }
                                                                                                else if(_getGoodsType == 3)
                                                                                                {
                                                                                                   if(info_dailyGift.statusID == _magicStoneQuality)
                                                                                                   {
                                                                                                      magicStoneInfo = info_dailyGift;
                                                                                                   }
                                                                                                }
                                                                                                else if(_getGoodsType == 2)
                                                                                                {
                                                                                                   if(info_dailyGift.statusID == _beadGrade)
                                                                                                   {
                                                                                                      beadInfo = info_dailyGift;
                                                                                                   }
                                                                                                }
                                                                                                else if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && dailyGiftTimes == 0 && info_dailyGift.statusValue >= _count)
                                                                                                {
                                                                                                   stateDic[leftViewInfo.viewType] = true;
                                                                                                   break;
                                                                                                }
                                                                                             }
                                                                                             if(_actType == 2)
                                                                                             {
                                                                                                if(_getGoodsType == 3)
                                                                                                {
                                                                                                   if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && magicStoneInfo?dailyGiftTimes == 0 && magicStoneInfo.statusValue >= _count:false)
                                                                                                   {
                                                                                                      stateDic[leftViewInfo.viewType] = true;
                                                                                                      break;
                                                                                                   }
                                                                                                }
                                                                                                else if(_getGoodsType == 2)
                                                                                                {
                                                                                                   if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && beadInfo?dailyGiftTimes == 0 && beadInfo.statusValue >= _count:false)
                                                                                                   {
                                                                                                      stateDic[leftViewInfo.viewType] = true;
                                                                                                      break;
                                                                                                   }
                                                                                                }
                                                                                             }
                                                                                          }
                                                                                          continue;
                                                                                       }
                                                                                       break;
                                                                                    }
                                                                                    dailyGift++;
                                                                                 }
                                                                                 continue;
                                                                              }
                                                                           }
                                                                           else
                                                                           {
                                                                              if(PlayerManager.Instance.Self.snapVip)
                                                                              {
                                                                                 stateDic[leftViewInfo.viewType] = false;
                                                                              }
                                                                              else
                                                                              {
                                                                                 var _loc198_:int = 0;
                                                                                 var _loc197_:* = item.giftbagArray;
                                                                                 for each(var giftInfo_wholeVip in item.giftbagArray)
                                                                                 {
                                                                                    if(giftInfoDic[giftInfo_wholeVip.giftbagId])
                                                                                    {
                                                                                       if(giftInfo_wholeVip.rewardMark != 100)
                                                                                       {
                                                                                          condition_selfGrade = -1;
                                                                                          condition_personNum = -1;
                                                                                          condition_addedNum = -1;
                                                                                          condition_vipGd = 0;
                                                                                          condition_addedVipGd = 0;
                                                                                          vipGetCount = 0;
                                                                                          vipAddedNum = 0;
                                                                                          vipPersonNum = 0;
                                                                                          vipSelfGrade = 0;
                                                                                          vipTimes = giftInfoDic[giftInfo_wholeVip.giftbagId].times;
                                                                                          for(i_wholeVip = 0; i_wholeVip < giftInfo_wholeVip.giftConditionArr.length; )
                                                                                          {
                                                                                             if(giftInfo_wholeVip.giftConditionArr[i_wholeVip].conditionIndex == 0)
                                                                                             {
                                                                                                condition_selfGrade = giftInfo_wholeVip.giftConditionArr[i_wholeVip].conditionValue;
                                                                                             }
                                                                                             else if(giftInfo_wholeVip.giftConditionArr[i_wholeVip].conditionIndex == 1)
                                                                                             {
                                                                                                condition_vipGd = giftInfo_wholeVip.giftConditionArr[i_wholeVip].conditionValue;
                                                                                                condition_personNum = giftInfo_wholeVip.giftConditionArr[i_wholeVip].remain1;
                                                                                             }
                                                                                             else if(giftInfo_wholeVip.giftConditionArr[i_wholeVip].conditionIndex == 2)
                                                                                             {
                                                                                                condition_addedVipGd = giftInfo_wholeVip.giftConditionArr[i_wholeVip].conditionValue;
                                                                                                condition_addedNum = giftInfo_wholeVip.giftConditionArr[i_wholeVip].remain1;
                                                                                             }
                                                                                             else if(giftInfo_wholeVip.giftConditionArr[i_wholeVip].conditionIndex == 3)
                                                                                             {
                                                                                                vipGetCount = giftInfo_wholeVip.giftConditionArr[i_wholeVip].conditionValue;
                                                                                             }
                                                                                             i_wholeVip++;
                                                                                          }
                                                                                          var _loc196_:int = 0;
                                                                                          var _loc195_:* = statusArr;
                                                                                          for each(var info_wholeVip in statusArr)
                                                                                          {
                                                                                             if(info_wholeVip.statusID == 0)
                                                                                             {
                                                                                                vipSelfGrade = info_wholeVip.statusValue;
                                                                                             }
                                                                                             else if(info_wholeVip.statusID == condition_vipGd)
                                                                                             {
                                                                                                vipPersonNum = info_wholeVip.statusValue;
                                                                                             }
                                                                                             else if(info_wholeVip.statusID == condition_addedVipGd)
                                                                                             {
                                                                                                vipAddedNum = info_wholeVip.statusValue;
                                                                                             }
                                                                                          }
                                                                                          vip_addedBoolean = condition_addedNum != -1?int(vipAddedNum / condition_addedNum) > vipTimes:true;
                                                                                          vip_personBoolean = condition_personNum != -1?vipPersonNum >= condition_personNum:true;
                                                                                          vip_selfBoolean = condition_selfGrade != -1?vipSelfGrade >= condition_selfGrade:true;
                                                                                          vip_timeBoolean = vipGetCount == 0?true:vipTimes < vipGetCount;
                                                                                          vip_canGet = nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && vip_addedBoolean && vip_personBoolean && vip_selfBoolean && vip_timeBoolean;
                                                                                          if(condition_addedNum != -1)
                                                                                          {
                                                                                             if(vip_canGet && int(vipAddedNum / condition_addedNum) - vipTimes >= 1)
                                                                                             {
                                                                                                stateDic[leftViewInfo.viewType] = true;
                                                                                                break;
                                                                                             }
                                                                                          }
                                                                                          else if(vip_canGet && vipTimes == 0)
                                                                                          {
                                                                                             stateDic[leftViewInfo.viewType] = true;
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
                                                                           var _loc193_:* = item.giftbagArray;
                                                                           for each(var giftInfo_wholePet in item.giftbagArray)
                                                                           {
                                                                              if(giftInfoDic[giftInfo_wholePet.giftbagId])
                                                                              {
                                                                                 if(giftInfo_wholePet.rewardMark != 100)
                                                                                 {
                                                                                    selfNeedPetNum = -1;
                                                                                    personNeedPetNum = -1;
                                                                                    addedNeedPetNum = -1;
                                                                                    _addedIsSuperPet = false;
                                                                                    _personIsSuperPet = false;
                                                                                    _selfIsSuperPet = false;
                                                                                    selfNeedPetStar = 0;
                                                                                    personNeedPetStar = 0;
                                                                                    addedNeedPetStar = 0;
                                                                                    getCount = 0;
                                                                                    addedNum = 0;
                                                                                    personNum = 0;
                                                                                    selfNum = 0;
                                                                                    wholePetTimes = giftInfoDic[giftInfo_wholePet.giftbagId].times;
                                                                                    for(j_wholePet = 0; j_wholePet < giftInfo_wholePet.giftConditionArr.length; )
                                                                                    {
                                                                                       if(giftInfo_wholePet.giftConditionArr[j_wholePet].conditionIndex == 4)
                                                                                       {
                                                                                          _selfIsSuperPet = true;
                                                                                       }
                                                                                       else if(giftInfo_wholePet.giftConditionArr[j_wholePet].conditionIndex == 5)
                                                                                       {
                                                                                          _personIsSuperPet = true;
                                                                                       }
                                                                                       else if(giftInfo_wholePet.giftConditionArr[j_wholePet].conditionIndex == 6)
                                                                                       {
                                                                                          _addedIsSuperPet = true;
                                                                                       }
                                                                                       j_wholePet++;
                                                                                    }
                                                                                    for(i_wholePet = 0; i_wholePet < giftInfo_wholePet.giftConditionArr.length; )
                                                                                    {
                                                                                       if(giftInfo_wholePet.giftConditionArr[i_wholePet].conditionIndex == (!!_selfIsSuperPet?4:0))
                                                                                       {
                                                                                          selfNeedPetStar = giftInfo_wholePet.giftConditionArr[i_wholePet].conditionValue;
                                                                                          selfNeedPetNum = giftInfo_wholePet.giftConditionArr[i_wholePet].remain1;
                                                                                       }
                                                                                       else if(giftInfo_wholePet.giftConditionArr[i_wholePet].conditionIndex == (!!_personIsSuperPet?5:1))
                                                                                       {
                                                                                          personNeedPetStar = giftInfo_wholePet.giftConditionArr[i_wholePet].conditionValue;
                                                                                          personNeedPetNum = giftInfo_wholePet.giftConditionArr[i_wholePet].remain1;
                                                                                       }
                                                                                       else if(giftInfo_wholePet.giftConditionArr[i_wholePet].conditionIndex == (!!_addedIsSuperPet?6:2))
                                                                                       {
                                                                                          addedNeedPetStar = giftInfo_wholePet.giftConditionArr[i_wholePet].conditionValue;
                                                                                          addedNeedPetNum = giftInfo_wholePet.giftConditionArr[i_wholePet].remain1;
                                                                                       }
                                                                                       else if(giftInfo_wholePet.giftConditionArr[i_wholePet].conditionIndex == 3)
                                                                                       {
                                                                                          getCount = giftInfo_wholePet.giftConditionArr[i_wholePet].conditionValue;
                                                                                       }
                                                                                       i_wholePet++;
                                                                                    }
                                                                                    var _loc192_:int = 0;
                                                                                    var _loc191_:* = statusArr;
                                                                                    for each(var info_wholePet in statusArr)
                                                                                    {
                                                                                       if(info_wholePet.statusID >= selfNeedPetStar + (!!_selfIsSuperPet?200:0) && info_wholePet.statusID < 50 + (!!_selfIsSuperPet?200:0))
                                                                                       {
                                                                                          selfNum = selfNum + info_wholePet.statusValue;
                                                                                       }
                                                                                       else if(info_wholePet.statusID == personNeedPetStar + (!!_personIsSuperPet?300:100))
                                                                                       {
                                                                                          personNum = info_wholePet.statusValue;
                                                                                       }
                                                                                       else if(info_wholePet.statusID == addedNeedPetStar + (!!_addedIsSuperPet?300:100))
                                                                                       {
                                                                                          addedNum = info_wholePet.statusValue;
                                                                                       }
                                                                                    }
                                                                                    addedBoolean = addedNeedPetNum != -1?int(addedNum / addedNeedPetNum) > wholePetTimes:true;
                                                                                    personBoolean = personNeedPetNum != -1?personNum >= personNeedPetNum:true;
                                                                                    selfBoolean = selfNeedPetNum != -1?selfNum >= selfNeedPetNum:true;
                                                                                    timeBoolean = getCount == 0?true:wholePetTimes < getCount;
                                                                                    canGet = nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && addedBoolean && personBoolean && selfBoolean && timeBoolean;
                                                                                    if(addedNeedPetNum != -1)
                                                                                    {
                                                                                       if(canGet && int(addedNum / addedNeedPetNum) - wholePetTimes >= 1)
                                                                                       {
                                                                                          stateDic[leftViewInfo.viewType] = true;
                                                                                          break;
                                                                                       }
                                                                                    }
                                                                                    else if(canGet && wholePetTimes == 0)
                                                                                    {
                                                                                       stateDic[leftViewInfo.viewType] = true;
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
                                                                        rookieItemArr = [];
                                                                        var _loc186_:int = 0;
                                                                        var _loc185_:* = activityData;
                                                                        for each(var item_rookie in activityData)
                                                                        {
                                                                           if(item_rookie.activityType == 15 && (item_rookie.activityChildType == 4 || item_rookie.activityChildType == 12))
                                                                           {
                                                                              rookieItemArr.push(item_rookie);
                                                                           }
                                                                        }
                                                                        power = 0;
                                                                        rank1 = 0;
                                                                        var _loc188_:int = 0;
                                                                        var _loc187_:* = statusArr;
                                                                        for each(var info_rookie in statusArr)
                                                                        {
                                                                           if(info_rookie.statusID == 0)
                                                                           {
                                                                              power = info_rookie.statusValue;
                                                                           }
                                                                           else
                                                                           {
                                                                              rank1 = info_rookie.statusValue;
                                                                           }
                                                                        }
                                                                        now = TimeManager.Instance.Now();
                                                                        for(rookie = 0; rookie < rookieItemArr.length; )
                                                                        {
                                                                           if(!(now.time < Date.parse(rookieItemArr[rookie].beginTime) || now.time > Date.parse(rookieItemArr[rookie].endShowTime)))
                                                                           {
                                                                              fightPower = -1;
                                                                              fightPowerRankOne = -1;
                                                                              fightPowerRankTwo = -1;
                                                                              rookieTimes = 0;
                                                                              var _loc190_:int = 0;
                                                                              var _loc189_:* = rookieItemArr[rookie].giftbagArray;
                                                                              for each(var giftInfo_rookie in rookieItemArr[rookie].giftbagArray)
                                                                              {
                                                                                 if(activityInitData[rookieItemArr[rookie].activityId].giftInfoDic[giftInfo_rookie.giftbagId])
                                                                                 {
                                                                                    rookieCurInfo = activityInitData[rookieItemArr[rookie].activityId].giftInfoDic[giftInfo_rookie.giftbagId];
                                                                                    if(giftInfo_rookie.rewardMark != 100)
                                                                                    {
                                                                                       rookieTimes = rookieCurInfo.times;
                                                                                       for(i_rookie = 0; i_rookie < giftInfo_rookie.giftConditionArr.length; )
                                                                                       {
                                                                                          if(giftInfo_rookie.giftConditionArr[i_rookie].conditionIndex == 0)
                                                                                          {
                                                                                             fightPower = giftInfo_rookie.giftConditionArr[i_rookie].conditionValue;
                                                                                          }
                                                                                          else if(giftInfo_rookie.giftConditionArr[i_rookie].conditionIndex == 1)
                                                                                          {
                                                                                             fightPowerRankOne = giftInfo_rookie.giftConditionArr[i_rookie].conditionValue;
                                                                                             fightPowerRankTwo = giftInfo_rookie.giftConditionArr[i_rookie].remain1;
                                                                                          }
                                                                                          else if(giftInfo_rookie.giftConditionArr[i_rookie].conditionIndex == 100)
                                                                                          {
                                                                                             rookieSumCount = giftInfo_rookie.giftConditionArr[i_rookie].conditionValue;
                                                                                          }
                                                                                          i_rookie++;
                                                                                       }
                                                                                       if(fightPower != -1)
                                                                                       {
                                                                                          if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && rookieTimes == 0 && power >= fightPower)
                                                                                          {
                                                                                             stateDic[leftViewInfo.viewType] = true;
                                                                                             break;
                                                                                          }
                                                                                       }
                                                                                       else if(nowTime >= Date.parse(item.endTime) && nowTime <= Date.parse(item.endShowTime) && rookieTimes == 0 && rank1 >= fightPowerRankOne && rank1 <= fightPowerRankTwo)
                                                                                       {
                                                                                          stateDic[leftViewInfo.viewType] = true;
                                                                                          break;
                                                                                       }
                                                                                    }
                                                                                    continue;
                                                                                 }
                                                                                 break;
                                                                              }
                                                                           }
                                                                           rookie++;
                                                                        }
                                                                        continue;
                                                                     }
                                                                  }
                                                               }
                                                               addr1267:
                                                               currentCondtion = statusArr[0].statusValue;
                                                               carnivalMountGrade = 0;
                                                               carnivalMountCurrentGrade = 0;
                                                               if(leftViewInfo.viewType == 35)
                                                               {
                                                                  var _loc182_:int = 0;
                                                                  var _loc181_:* = statusArr;
                                                                  for each(var info_carnivalMount in statusArr)
                                                                  {
                                                                     if(info_carnivalMount.statusID == 0)
                                                                     {
                                                                        carnivalMountGrade = info_carnivalMount.statusValue;
                                                                     }
                                                                     else if(info_carnivalMount.statusID == 1)
                                                                     {
                                                                        carnivalMountCurrentGrade = info_carnivalMount.statusValue;
                                                                     }
                                                                  }
                                                               }
                                                               var _loc184_:int = 0;
                                                               var _loc183_:* = item.giftbagArray;
                                                               for each(var giftInfo_carnival in item.giftbagArray)
                                                               {
                                                                  if(giftInfoDic[giftInfo_carnival.giftbagId])
                                                                  {
                                                                     if(giftInfo_carnival.rewardMark != 100)
                                                                     {
                                                                        playerAlreadyGetCount = giftInfoDic[giftInfo_carnival.giftbagId].times;
                                                                        allGiftAlreadyGetCount = giftInfoDic[giftInfo_carnival.giftbagId].allGiftGetTimes;
                                                                        for(i_carnival = 0; i_carnival < giftInfo_carnival.giftConditionArr.length; )
                                                                        {
                                                                           if(giftInfo_carnival.giftConditionArr[i_carnival].conditionIndex == 0)
                                                                           {
                                                                              condtion = giftInfo_carnival.giftConditionArr[i_carnival].conditionValue;
                                                                           }
                                                                           else if(giftInfo_carnival.giftConditionArr[i_carnival].conditionIndex == 100)
                                                                           {
                                                                              sumCount = giftInfo_carnival.giftConditionArr[i_carnival].conditionValue;
                                                                           }
                                                                           i_carnival++;
                                                                        }
                                                                        if(leftViewInfo.viewType == 35)
                                                                        {
                                                                           if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && playerAlreadyGetCount == 0 && condtion > carnivalMountGrade && condtion <= carnivalMountCurrentGrade && (sumCount == 0 || sumCount - allGiftAlreadyGetCount > 0))
                                                                           {
                                                                              stateDic[leftViewInfo.viewType] = true;
                                                                              break;
                                                                           }
                                                                        }
                                                                        else if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && playerAlreadyGetCount == 0 && currentCondtion >= condtion && (sumCount == 0 || sumCount - allGiftAlreadyGetCount > 0))
                                                                        {
                                                                           stateDic[leftViewInfo.viewType] = true;
                                                                           break;
                                                                        }
                                                                     }
                                                                     continue;
                                                                  }
                                                                  break;
                                                               }
                                                               continue;
                                                            }
                                                            addr1266:
                                                            §§goto(addr1267);
                                                         }
                                                         addr1265:
                                                         §§goto(addr1266);
                                                      }
                                                      addr1264:
                                                      §§goto(addr1265);
                                                   }
                                                   addr1263:
                                                   §§goto(addr1264);
                                                }
                                                addr1262:
                                                §§goto(addr1263);
                                             }
                                             addr1261:
                                             §§goto(addr1262);
                                          }
                                          addr1260:
                                          §§goto(addr1261);
                                       }
                                       §§goto(addr1260);
                                    }
                                    else
                                    {
                                       var _loc178_:int = 0;
                                       var _loc177_:* = statusArr;
                                       for each(var info_mountGrade1 in statusArr)
                                       {
                                          if(info_mountGrade1.statusID == 0)
                                          {
                                             grade1 = info_mountGrade1.statusValue;
                                          }
                                          else if(info_mountGrade1.statusID == 1)
                                          {
                                             currentGrade1 = info_mountGrade1.statusValue;
                                          }
                                       }
                                       var _loc180_:int = 0;
                                       var _loc179_:* = item.giftbagArray;
                                       for each(var giftInfo_mountGrade1 in item.giftbagArray)
                                       {
                                          if(!giftInfoDic[giftInfo_mountGrade1.giftbagId])
                                          {
                                             break;
                                          }
                                          i_mountGrade1 = 0;
                                          while(i_mountGrade1 < giftInfo_mountGrade1.giftConditionArr.length)
                                          {
                                             if(giftInfo_mountGrade1.giftConditionArr[i_mountGrade1].conditionIndex == 0)
                                             {
                                                reallyHorseGrade1 = giftInfo_mountGrade1.giftConditionArr[i_mountGrade1].remain1;
                                                break;
                                             }
                                             i_mountGrade1++;
                                          }
                                          if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && giftInfoDic[giftInfo_mountGrade1.giftbagId].times == 0 && reallyHorseGrade1 > grade1 && reallyHorseGrade1 <= currentGrade1)
                                          {
                                             stateDic[leftViewInfo.viewType] = true;
                                             break;
                                          }
                                       }
                                       continue;
                                    }
                                 }
                                 else
                                 {
                                    var _loc176_:int = 0;
                                    var _loc175_:* = item.giftbagArray;
                                    for each(var giftInfo_mountSkill in item.giftbagArray)
                                    {
                                       if(!giftInfoDic[giftInfo_mountSkill.giftbagId])
                                       {
                                          break;
                                       }
                                       i_mountSkill = 0;
                                       while(i_mountSkill < giftInfo_mountSkill.giftConditionArr.length)
                                       {
                                          if(giftInfo_mountSkill.giftConditionArr[i_mountSkill].conditionIndex == 0)
                                          {
                                             horseSkillType = giftInfo_mountSkill.giftConditionArr[i_mountSkill].conditionValue;
                                          }
                                          else
                                          {
                                             horseSkillGrade = giftInfo_mountSkill.giftConditionArr[i_mountSkill].conditionValue;
                                          }
                                          i_mountSkill++;
                                       }
                                       skillGrade = 0;
                                       currentSkillGrade = 0;
                                       var _loc174_:int = 0;
                                       var _loc173_:* = statusArr;
                                       for each(var info_mountSkill in statusArr)
                                       {
                                          if(info_mountSkill.statusID == horseSkillType)
                                          {
                                             skillGrade = info_mountSkill.statusValue;
                                          }
                                          else if(info_mountSkill.statusID == 100 + horseSkillType)
                                          {
                                             currentSkillGrade = info_mountSkill.statusValue;
                                          }
                                       }
                                       if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && giftInfoDic[giftInfo_mountSkill.giftbagId].times == 0 && horseSkillGrade > skillGrade && horseSkillGrade <= currentSkillGrade)
                                       {
                                          stateDic[leftViewInfo.viewType] = true;
                                          break;
                                       }
                                    }
                                    continue;
                                 }
                              }
                              else
                              {
                                 var _loc170_:int = 0;
                                 var _loc169_:* = statusArr;
                                 for each(var info_mountGrade in statusArr)
                                 {
                                    if(info_mountGrade.statusID == 0)
                                    {
                                       grade = info_mountGrade.statusValue;
                                    }
                                    else if(info_mountGrade.statusID == 1)
                                    {
                                       currentGrade = info_mountGrade.statusValue;
                                    }
                                 }
                                 var _loc172_:int = 0;
                                 var _loc171_:* = item.giftbagArray;
                                 for each(var giftInfo_mountGrade in item.giftbagArray)
                                 {
                                    if(!giftInfoDic[giftInfo_mountGrade.giftbagId])
                                    {
                                       break;
                                    }
                                    i_mountGrade = 0;
                                    while(i_mountGrade < giftInfo_mountGrade.giftConditionArr.length)
                                    {
                                       if(giftInfo_mountGrade.giftConditionArr[i_mountGrade].conditionIndex == 0)
                                       {
                                          reallyHorseGrade = giftInfo_mountGrade.giftConditionArr[i_mountGrade].remain1;
                                          break;
                                       }
                                       i_mountGrade++;
                                    }
                                    if(nowTime >= Date.parse(item.beginShowTime) && nowTime <= Date.parse(item.endShowTime) && giftInfoDic[giftInfo_mountGrade.giftbagId].times == 0 && reallyHorseGrade > grade && reallyHorseGrade <= currentGrade)
                                    {
                                       stateDic[leftViewInfo.viewType] = true;
                                       break;
                                    }
                                 }
                                 continue;
                              }
                           }
                           else
                           {
                              var _loc168_:int = 0;
                              var _loc167_:* = item.giftbagArray;
                              for each(var giftInfo3 in item.giftbagArray)
                              {
                                 if(giftInfoDic[giftInfo3.giftbagId])
                                 {
                                    alreadyGet3 = giftInfoDic[giftInfo3.giftbagId].times;
                                    var _loc166_:int = 0;
                                    var _loc165_:* = statusArr;
                                    for each(var playerStatus1 in statusArr)
                                    {
                                       if(playerStatus1.statusID == giftInfo3.giftConditionArr[0].conditionValue)
                                       {
                                          remain4 = playerStatus1.statusValue - alreadyGet3;
                                       }
                                    }
                                    if(giftInfo3.giftConditionArr[0].conditionValue == 0)
                                    {
                                       if(remain4 > 0)
                                       {
                                          stateDic[leftViewInfo.viewType] = true;
                                          break;
                                       }
                                    }
                                    else if(alreadyGet3 == 0 && remain4 > 0)
                                    {
                                       stateDic[leftViewInfo.viewType] = true;
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
                           var _loc163_:* = item.giftbagArray;
                           for each(var giftInfo2 in item.giftbagArray)
                           {
                              if(giftInfoDic[giftInfo2.giftbagId])
                              {
                                 alreadyGet2 = giftInfoDic[giftInfo2.giftbagId].times;
                                 var _loc162_:int = 0;
                                 var _loc161_:* = statusArr;
                                 for each(var playerStatus in statusArr)
                                 {
                                    if(playerStatus.statusID == giftInfo2.giftConditionArr[0].conditionValue)
                                    {
                                       remain2 = playerStatus.statusValue - alreadyGet2;
                                    }
                                 }
                                 if(giftInfo2.giftConditionArr[2].conditionValue == 0)
                                 {
                                    if(remain2 > 0)
                                    {
                                       stateDic[leftViewInfo.viewType] = true;
                                       break;
                                    }
                                 }
                                 else if(alreadyGet2 == 0 && remain2 > 0)
                                 {
                                    stateDic[leftViewInfo.viewType] = true;
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
                  var _loc159_:* = item.giftbagArray;
                  for each(var giftInfo in item.giftbagArray)
                  {
                     if(giftInfoDic[giftInfo.giftbagId])
                     {
                        alreadyGet = giftInfoDic[giftInfo.giftbagId].times;
                        if(giftInfo.giftConditionArr[2].conditionValue == 0)
                        {
                           remain = int(Math.floor(statusArr[0].statusValue / giftInfo.giftConditionArr[0].conditionValue)) - alreadyGet;
                           if(remain > 0)
                           {
                              stateDic[leftViewInfo.viewType] = true;
                              break;
                           }
                        }
                        else if(alreadyGet == 0 && Math.floor(statusArr[0].statusValue / giftInfo.giftConditionArr[0].conditionValue) > 0)
                        {
                           stateDic[leftViewInfo.viewType] = true;
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
      
      public function currentItem(item:IShineableCell) : void
      {
         _currentItem = item;
      }
      
      private function typeNeedShine(type:int) : Boolean
      {
         switch(int(type) - 2)
         {
            case 0:
               return true;
            default:
            default:
            case 3:
               return false;
         }
      }
      
      public function useBattleCompanion(info:InventoryItemInfo) : void
      {
         _battleCompanionInfo = info;
         _giveFriendOpenFrame = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ShopPresentClearingFrame");
         _giveFriendOpenFrame.nameInput.enable = false;
         _giveFriendOpenFrame.onlyFriendSelectView();
         _giveFriendOpenFrame.show();
         _giveFriendOpenFrame.presentBtn.addEventListener("click",__presentBtnClick,false,0,true);
         _giveFriendOpenFrame.addEventListener("response",__responseHandler2,false,0,true);
      }
      
      private function __responseHandler2(event:FrameEvent) : void
      {
         if(event.responseCode == 0 || event.responseCode == 1 || event.responseCode == 4)
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
      
      private function __presentBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         var name:String = _giveFriendOpenFrame.nameInput.text;
         if(name == "")
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("shop.ShopIIPresentView.give"));
            return;
         }
         if(FilterWordManager.IsNullorEmpty(name))
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
         var i:int = 0;
         var info:* = null;
         var arr:Array = [];
         var len:int = CalendarManager.getInstance().eventActives.length;
         var now:Date = TimeManager.Instance.Now();
         for(i = 0; i < len; )
         {
            info = CalendarManager.getInstance().eventActives[i];
            if(now.time > info.start.time && now.time < info.end.time)
            {
               arr.push(info);
            }
            i++;
         }
         return arr;
      }
      
      public function get eventsActiveDic() : Dictionary
      {
         return _eventsActiveDic;
      }
      
      public function getActiveEventsInfoByID(id:int) : ActiveEventsInfo
      {
         return _eventsActiveDic[id];
      }
      
      public function setLimitActivities(activities:Array) : void
      {
         var idStr:* = null;
         var tagId:int = 10000;
         _eventsActiveDic = new Dictionary();
         var now:Date = TimeManager.Instance.Now();
         var _loc7_:int = 0;
         var _loc6_:* = activities;
         for each(var info in activities)
         {
            if(info.ActiveType != 6)
            {
               if(now.time > info.start.time && now.time < info.end.time)
               {
                  _eventsActiveDic[tagId] = info;
                  idStr = tagId.toString();
                  leftViewInfoDic[idStr] = new LeftViewInfoVo(tagId,"· " + info.Title,1);
                  addElement(idStr);
                  tagId++;
               }
            }
         }
      }
      
      public function getActivityDataById(actId:String) : GmActivityInfo
      {
         return activityData[actId];
      }
      
      public function getActivityInitDataById(actId:String) : Object
      {
         return activityInitData[actId];
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
