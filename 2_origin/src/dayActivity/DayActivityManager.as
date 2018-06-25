package dayActivity
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.ItemManager;
   import ddt.manager.PathManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.AssetModuleLoader;
   import ddtActivityIcon.DdtActivityIconManager;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Dictionary;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import wantstrong.WantStrongManager;
   
   public class DayActivityManager extends EventDispatcher
   {
      
      public static const EVENT_ONLINE_REWARD_OP_BACK_GET:String = "event_online_reward_op_back_get";
      
      public static const ACTIVITY_OPENVIEW:String = "activityOpenView";
      
      public static const ACTIVITY_VALUE_CHANGE:String = "daily_activity_value_change";
      
      public static const ACTIVITY_GET_STATUS_CHANGE:String = "daily_activity_get_status_change";
      
      public static const ONLINE_REWARD_STATUS_CHANGE:String = "online_reward_status_change";
      
      public static const DAY_ACTIVITY:int = 0;
      
      public static const DAY_ACTIVE:int = 1;
      
      public static const DAY_ACTIVITYADV:int = 2;
      
      private static var _instance:DayActivityManager;
       
      
      public var overList:Vector.<ActivityData>;
      
      public var noOverList:Vector.<ActivityData>;
      
      public var acitivityList:Vector.<ActivityData>;
      
      public var acitivityDataList:Vector.<ActivityData>;
      
      public var sessionArr:Array;
      
      public var acitiveDataList:Vector.<DayActiveData>;
      
      public var reweadDataList:Vector.<DayRewaidData>;
      
      public var bossDataDic:Dictionary;
      
      private var findBackDic:Dictionary;
      
      public var speedActArr:Array;
      
      private var _activityValue:int;
      
      public var isOverList:Array;
      
      private var rezArray:Array;
      
      public var btnArr:Array;
      
      public var ANYEBOJUE:String;
      
      public var ANYEBOJUE_DAYOFWEEK:String;
      
      public var YUANGUJULONG:String;
      
      public var YUANGUJULONG_DAYOFWEEK:String;
      
      public var LIANSAI:String;
      
      public var ZHANCHANG:String;
      
      public var GONGHUIBOSS:String;
      
      public var BOGUQUNYING:String;
      
      public var ZHENYINGZHAN:String;
      
      public var ZUQIUBOSS:String;
      
      public var ZUQIUBOSS_DAYOFWEEK:String;
      
      public var GONGHUIZHAN:String;
      
      public var Entertainment:String;
      
      public var LanternRiddles:String;
      
      public var Rescue:String;
      
      public var HorseRace:String;
      
      public var SevenDouble:String;
      
      public var CatchBeast:String;
      
      public var onlineRewardModel:OnlineRewardModel;
      
      private var _updateOnlineSecTimer:Timer;
      
      public function DayActivityManager(target:IEventDispatcher = null)
      {
         bossDataDic = new Dictionary();
         findBackDic = new Dictionary();
         speedActArr = [];
         super(target);
         overList = new Vector.<ActivityData>();
         noOverList = new Vector.<ActivityData>();
         acitivityList = new Vector.<ActivityData>();
         onlineRewardModel = new OnlineRewardModel();
      }
      
      public static function get Instance() : DayActivityManager
      {
         if(_instance == null)
         {
            _instance = new DayActivityManager();
         }
         return _instance;
      }
      
      public function get activityValue() : int
      {
         return _activityValue;
      }
      
      public function set activityValue(value:int) : void
      {
         _activityValue = value;
         dispatchEvent(new Event("daily_activity_value_change"));
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(155,1),initActivityList);
         SocketManager.Instance.addEventListener(PkgEvent.format(353,1),onPackInfo);
         SocketManager.Instance.addEventListener(PkgEvent.format(353,2),onPackGet);
         SocketManager.Instance.addEventListener(PkgEvent.format(353,3),onPackBoxConfig);
         SocketManager.Instance.addEventListener(PkgEvent.format(353,4),onPackOpenClose);
      }
      
      private function onPackInfo(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         onlineRewardModel.serverDate = pkg.readDate();
         onlineRewardModel.onlineSec = pkg.readInt();
         onlineRewardModel.hasGetBoxId = pkg.readInt();
         onlineRewardModel.canGetBox = canGetOnlineReward();
         dispatchEvent(new Event("online_reward_status_change"));
         if(onlineRewardModel.isOpen)
         {
            if(!_updateOnlineSecTimer)
            {
               _updateOnlineSecTimer = new Timer(1000,2147483647);
            }
            _updateOnlineSecTimer.reset();
            _updateOnlineSecTimer.addEventListener("timer",onUpdateOnlineSecTimer);
            _updateOnlineSecTimer.start();
         }
      }
      
      private function onUpdateOnlineSecTimer(evt:TimerEvent) : void
      {
         onlineRewardModel.onlineSec++;
         if(!onlineRewardModel.isOpen)
         {
            _updateOnlineSecTimer.removeEventListener("timer",onUpdateOnlineSecTimer);
            _updateOnlineSecTimer.stop();
         }
         if(onlineRewardModel.endDate.time < TimeManager.Instance.NowTime())
         {
            onlineRewardModel.isOpen = false;
         }
         var canGet:Boolean = canGetOnlineReward();
         if(!onlineRewardModel.canGetBox && canGet)
         {
            onlineRewardModel.canGetBox = canGet;
            dispatchEvent(new Event("online_reward_status_change"));
         }
      }
      
      private function onPackGet(evt:PkgEvent) : void
      {
         var i:int = 0;
         var hasGetBoxId:int = 0;
         var templeteInfo:* = null;
         var inventoryItemInfo:* = null;
         var pkg:PackageIn = evt.pkg;
         var date:Date = pkg.readDate();
         onlineRewardModel.hasGetBoxId = pkg.readInt();
         var receiveGoodsArr:Array = [];
         var receiveGoodsArrLength:int = pkg.readInt();
         for(i = 0; i < receiveGoodsArrLength; )
         {
            hasGetBoxId = pkg.readInt();
            templeteInfo = ItemManager.Instance.getTemplateById(pkg.readInt());
            inventoryItemInfo = new InventoryItemInfo();
            ObjectUtils.copyProperties(inventoryItemInfo,templeteInfo);
            inventoryItemInfo.Count = pkg.readInt();
            inventoryItemInfo.IsBinds = pkg.readBoolean();
            inventoryItemInfo.ValidDate = pkg.readInt();
            pkg.readInt();
            pkg.readInt();
            pkg.readInt();
            pkg.readInt();
            pkg.readInt();
            pkg.readInt();
            pkg.readInt();
            receiveGoodsArr[hasGetBoxId - 1] = inventoryItemInfo;
            i++;
         }
         onlineRewardModel.receiveGoodsArr = receiveGoodsArr;
         var canGet:Boolean = canGetOnlineReward();
         if(onlineRewardModel.canGetBox && !canGet)
         {
            onlineRewardModel.canGetBox = canGet;
            dispatchEvent(new Event("online_reward_status_change"));
         }
         dispatchEvent(new Event("event_online_reward_op_back_get"));
      }
      
      private function onPackBoxConfig(evt:PkgEvent) : void
      {
         var i:int = 0;
         var box:* = null;
         var pkg:PackageIn = evt.pkg;
         var boxArrLength:int = pkg.readInt();
         var boxArr:Array = [];
         for(i = 0; i < boxArrLength; )
         {
            box = {
               "boxId":pkg.readInt(),
               "sec":pkg.readInt() * 60,
               "boxName":pkg.readUTF(),
               "worthMoney":pkg.readInt(),
               "isBind":pkg.readBoolean(),
               "valid":pkg.readInt()
            };
            boxArr.push(box);
            i++;
         }
         onlineRewardModel.boxNum = boxArrLength;
         onlineRewardModel.boxConfigArr = boxArr;
      }
      
      private function onPackOpenClose(evt:PkgEvent) : void
      {
         var pkg:PackageIn = evt.pkg;
         onlineRewardModel.isOpen = pkg.readBoolean();
         onlineRewardModel.endDate = pkg.readDate();
         if(onlineRewardModel.isOpen)
         {
            if(onlineRewardModel.boxConfigArr == null)
            {
               SocketManager.Instance.out.queryOnlineRewardBoxConfig();
            }
            SocketManager.Instance.out.queryOnlineRewardInfo();
         }
         else
         {
            onlineRewardModel.canGetBox = false;
            dispatchEvent(new Event("online_reward_status_change"));
         }
      }
      
      public function canGetOnlineReward() : Boolean
      {
         var i:int = 0;
         if(!onlineRewardModel.isOpen || !onlineRewardModel.serverDate)
         {
            return false;
         }
         i = onlineRewardModel.hasGetBoxId;
         if(i < onlineRewardModel.boxNum)
         {
            if(onlineRewardModel.boxConfigArr[i]["sec"] <= onlineRewardModel.onlineSec)
            {
               return true;
            }
         }
         return false;
      }
      
      public function isOnLineRewardOpen() : Boolean
      {
         return onlineRewardModel.isOpen && onlineRewardModel.hasGetBoxId < onlineRewardModel.boxNum;
      }
      
      private function creatActiveLoader() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("EveryDayActivePointTemplateInfoList.xml"),5);
         loader.analyzer = new ActivityAnalyzer(everyDayActive);
      }
      
      private function creatActivePointLoader() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("EveryDayActiveProgressInfoList.xml"),5);
         loader.analyzer = new ActivePointAnalzer(everyDayActivePoint);
      }
      
      private function creatRewardLoader() : void
      {
         var loader:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("EveryDayActiveRewardTemplateInfoList.xml"),5);
         loader.analyzer = new ActivityRewardAnalyzer(activityRewardComp);
      }
      
      public function activityRewardComp(data:ActivityRewardAnalyzer) : void
      {
         reweadDataList = data.itemList;
      }
      
      public function everyDayActivePoint(analy:ActivePointAnalzer) : void
      {
         acitiveDataList = analy.itemList;
         DdtActivityIconManager.Instance.timerList = analy.itemList;
         setActionTime();
      }
      
      private function setActionTime() : void
      {
         var i:int = 0;
         var len:int = acitiveDataList.length;
         for(i = 0; i < len; )
         {
            switch(int(int(acitiveDataList[i].JumpType)) - 1)
            {
               case 0:
                  ZHANCHANG = acitiveDataList[i].ActiveTime;
                  break;
               case 1:
                  Entertainment = acitiveDataList[i].ActiveTime;
                  break;
               case 2:
                  LanternRiddles = acitiveDataList[i].ActiveTime;
                  break;
               case 3:
                  YUANGUJULONG = acitiveDataList[i].ActiveTime;
                  YUANGUJULONG_DAYOFWEEK = acitiveDataList[i].DayOfWeek;
                  break;
               case 4:
                  Rescue = acitiveDataList[i].ActiveTime;
                  break;
               case 5:
                  HorseRace = acitiveDataList[i].ActiveTime;
                  break;
               case 6:
                  SevenDouble = acitiveDataList[i].ActiveTime;
                  break;
               case 7:
                  CatchBeast = acitiveDataList[i].ActiveTime;
                  break;
               case 8:
                  ZHENYINGZHAN = acitiveDataList[i].ActiveTime;
                  break;
               case 9:
                  LIANSAI = acitiveDataList[i].ActiveTime;
                  break;
               case 10:
                  ZUQIUBOSS = acitiveDataList[i].ActiveTime;
                  ZUQIUBOSS_DAYOFWEEK = acitiveDataList[i].DayOfWeek;
                  break;
               case 11:
                  GONGHUIZHAN = acitiveDataList[i].ActiveTime;
            }
            i++;
         }
      }
      
      public function everyDayActive(analy:ActivityAnalyzer) : void
      {
         acitivityDataList = analy.itemList;
         noOverList = copyArr(acitivityDataList);
      }
      
      public function get isHasActivityAward() : Boolean
      {
         if(!btnArr || btnArr.length == 0)
         {
            return false;
         }
         if(activityValue >= 30 && btnArr[0][1] == 0)
         {
            return true;
         }
         if(activityValue >= 60 && btnArr[1][1] == 0)
         {
            return true;
         }
         if(activityValue >= 80 && btnArr[2][1] == 0)
         {
            return true;
         }
         if(activityValue >= 100 && btnArr[3][1] == 0)
         {
            return true;
         }
         if(activityValue >= 120 && btnArr[4][1] == 0)
         {
            return true;
         }
         return false;
      }
      
      public function deleNoOverListItem(type:int) : void
      {
         var i:int = 0;
         var len:int = noOverList.length;
         for(i = 0; i < len; )
         {
            if(type == noOverList[i].ActivityType)
            {
               noOverList.splice(i,1);
               break;
            }
            i++;
         }
      }
      
      public function initActivityList(event:PkgEvent) : void
      {
         var i:int = 0;
         var arr1:* = null;
         var tmpIndex:int = 0;
         var tmpValue:int = 0;
         var tmpLen:int = 0;
         var n:int = 0;
         var arr3:* = null;
         var conut:int = 0;
         var t_i:int = 0;
         var id:int = 0;
         var overCount:int = 0;
         var bType:int = 0;
         var arr:* = null;
         var bType1:int = 0;
         var arr2:* = null;
         var count1:int = event.pkg.readInt();
         overList.length = 0;
         noOverList.length = 0;
         noOverList = copyArr(acitivityDataList);
         rezArray = [];
         for(i = 0; i < count1; )
         {
            arr1 = [];
            arr1[0] = event.pkg.readInt();
            arr1[1] = event.pkg.readInt();
            if(arr1[0] == 4 || arr1[0] == 5 || arr1[0] == 6 || arr1[0] == 18 || arr1[0] == 19)
            {
               bossDataDic[arr1[0]] = arr1[1];
            }
            rezArray.push(arr1);
            i++;
         }
         btnArr = [[1,0],[2,0],[3,0],[4,0],[5,0]];
         var count2:int = event.pkg.readInt();
         for(i = 0; i < count2; )
         {
            tmpIndex = event.pkg.readInt();
            tmpValue = event.pkg.readInt();
            tmpLen = btnArr.length;
            for(n = 0; n < tmpLen; )
            {
               if(btnArr[n][0] == tmpIndex)
               {
                  btnArr[n][1] = tmpValue;
                  break;
               }
               n++;
            }
            i++;
         }
         sessionArr = [];
         var count3:int = event.pkg.readInt();
         for(i = 0; i < count3; )
         {
            arr3 = [];
            arr3[0] = event.pkg.readInt();
            arr3[1] = event.pkg.readInt();
            sessionArr.push(arr3);
            i++;
         }
         activityValue = event.pkg.readInt();
         initSession();
         var len:int = rezArray.length;
         for(i = 0; i < len; )
         {
            conut = noOverList.length;
            for(t_i = 0; t_i < conut; )
            {
               id = rezArray[i][0];
               overCount = rezArray[i][1];
               if(noOverList[t_i].ActivityType == id)
               {
                  noOverList[t_i].OverCount = overCount;
                  if(noOverList[t_i].OverCount >= noOverList[t_i].Count)
                  {
                     overList.push(noOverList[t_i]);
                     deleNoOverListItem(id);
                  }
                  break;
               }
               t_i++;
            }
            i++;
         }
         var count4:int = event.pkg.readInt();
         for(i = 0; i < count4; )
         {
            bType = event.pkg.readInt();
            arr = [];
            arr[0] = event.pkg.readBoolean();
            arr[1] = event.pkg.readBoolean();
            findBackDic[bType] = arr;
            i++;
         }
         var wantstrongBoolStr:String = event.pkg.readUTF();
         speedActArr = wantstrongBoolStr.split("|");
         WantStrongManager.Instance.bossFlag = event.pkg.readInt();
         var count5:int = event.pkg.readByte();
         for(i = 0; i < count5; )
         {
            bType1 = event.pkg.readByte();
            arr2 = [];
            arr2[0] = event.pkg.readBoolean();
            arr2[1] = event.pkg.readBoolean();
            findBackDic[bType1] = arr2;
            i++;
         }
         WantStrongManager.Instance.findBackDic = findBackDic;
      }
      
      private function copyArr(arr:Vector.<ActivityData>) : Vector.<ActivityData>
      {
         var i:int = 0;
         var data:* = null;
         var vet:Vector.<ActivityData> = new Vector.<ActivityData>();
         if(!arr)
         {
            return vet;
         }
         for(i = 0; i < arr.length; )
         {
            arr[i].resetOverCount();
            data = arr[i];
            vet.push(data);
            i++;
         }
         return vet;
      }
      
      private function initSession() : void
      {
         var i:int = 0;
         var j:int = 0;
         for(i = 0; i < sessionArr.length; )
         {
            for(j = 0; j < acitiveDataList.length; )
            {
               if(sessionArr[i])
               {
                  if(sessionArr[i][0] == acitiveDataList[j].ActivityTypeID)
                  {
                     acitiveDataList[j].TotalCount = sessionArr[i][1];
                     break;
                  }
               }
               j++;
            }
            i++;
         }
      }
      
      public function show() : void
      {
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.createConsortiaBossTemplateLoader());
         AssetModuleLoader.addRequestLoader(LoaderCreate.Instance.creatRewardLoader());
         AssetModuleLoader.addModelLoader("dayactivity",6);
         AssetModuleLoader.startCodeLoader(createActivityFrame);
      }
      
      protected function createActivityFrame() : void
      {
         dispatchEvent(new Event("activityOpenView"));
      }
   }
}
