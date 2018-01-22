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
      
      public function DayActivityManager(param1:IEventDispatcher = null)
      {
         bossDataDic = new Dictionary();
         findBackDic = new Dictionary();
         speedActArr = [];
         super(param1);
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
      
      public function set activityValue(param1:int) : void
      {
         _activityValue = param1;
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
      
      private function onPackInfo(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         onlineRewardModel.serverDate = _loc2_.readDate();
         onlineRewardModel.onlineSec = _loc2_.readInt();
         onlineRewardModel.hasGetBoxId = _loc2_.readInt();
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
      
      private function onUpdateOnlineSecTimer(param1:TimerEvent) : void
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
         var _loc2_:Boolean = canGetOnlineReward();
         if(!onlineRewardModel.canGetBox && _loc2_)
         {
            onlineRewardModel.canGetBox = _loc2_;
            dispatchEvent(new Event("online_reward_status_change"));
         }
      }
      
      private function onPackGet(param1:PkgEvent) : void
      {
         var _loc10_:int = 0;
         var _loc8_:int = 0;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc6_:PackageIn = param1.pkg;
         var _loc9_:Date = _loc6_.readDate();
         onlineRewardModel.hasGetBoxId = _loc6_.readInt();
         var _loc3_:Array = [];
         var _loc2_:int = _loc6_.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc2_)
         {
            _loc8_ = _loc6_.readInt();
            _loc5_ = ItemManager.Instance.getTemplateById(_loc6_.readInt());
            _loc4_ = new InventoryItemInfo();
            ObjectUtils.copyProperties(_loc4_,_loc5_);
            _loc4_.Count = _loc6_.readInt();
            _loc4_.IsBinds = _loc6_.readBoolean();
            _loc4_.ValidDate = _loc6_.readInt();
            _loc6_.readInt();
            _loc6_.readInt();
            _loc6_.readInt();
            _loc6_.readInt();
            _loc6_.readInt();
            _loc6_.readInt();
            _loc6_.readInt();
            _loc3_[_loc8_ - 1] = _loc4_;
            _loc10_++;
         }
         onlineRewardModel.receiveGoodsArr = _loc3_;
         var _loc7_:Boolean = canGetOnlineReward();
         if(onlineRewardModel.canGetBox && !_loc7_)
         {
            onlineRewardModel.canGetBox = _loc7_;
            dispatchEvent(new Event("online_reward_status_change"));
         }
         dispatchEvent(new Event("event_online_reward_op_back_get"));
      }
      
      private function onPackBoxConfig(param1:PkgEvent) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         var _loc3_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = {
               "boxId":_loc4_.readInt(),
               "sec":_loc4_.readInt() * 60,
               "boxName":_loc4_.readUTF(),
               "worthMoney":_loc4_.readInt(),
               "isBind":_loc4_.readBoolean(),
               "valid":_loc4_.readInt()
            };
            _loc3_.push(_loc5_);
            _loc6_++;
         }
         onlineRewardModel.boxNum = _loc2_;
         onlineRewardModel.boxConfigArr = _loc3_;
      }
      
      private function onPackOpenClose(param1:PkgEvent) : void
      {
         var _loc2_:PackageIn = param1.pkg;
         onlineRewardModel.isOpen = _loc2_.readBoolean();
         onlineRewardModel.endDate = _loc2_.readDate();
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
         var _loc1_:int = 0;
         if(!onlineRewardModel.isOpen || !onlineRewardModel.serverDate)
         {
            return false;
         }
         _loc1_ = onlineRewardModel.hasGetBoxId;
         if(_loc1_ < onlineRewardModel.boxNum)
         {
            if(onlineRewardModel.boxConfigArr[_loc1_]["sec"] <= onlineRewardModel.onlineSec)
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
         var _loc1_:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("EveryDayActivePointTemplateInfoList.xml"),5);
         _loc1_.analyzer = new ActivityAnalyzer(everyDayActive);
      }
      
      private function creatActivePointLoader() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("EveryDayActiveProgressInfoList.xml"),5);
         _loc1_.analyzer = new ActivePointAnalzer(everyDayActivePoint);
      }
      
      private function creatRewardLoader() : void
      {
         var _loc1_:BaseLoader = LoadResourceManager.Instance.creatAndStartLoad(PathManager.solveRequestPath("EveryDayActiveRewardTemplateInfoList.xml"),5);
         _loc1_.analyzer = new ActivityRewardAnalyzer(activityRewardComp);
      }
      
      public function activityRewardComp(param1:ActivityRewardAnalyzer) : void
      {
         reweadDataList = param1.itemList;
      }
      
      public function everyDayActivePoint(param1:ActivePointAnalzer) : void
      {
         acitiveDataList = param1.itemList;
         DdtActivityIconManager.Instance.timerList = param1.itemList;
         setActionTime();
      }
      
      private function setActionTime() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = acitiveDataList.length;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            switch(int(acitiveDataList[_loc2_].JumpType) - 1)
            {
               case 0:
                  ZHANCHANG = acitiveDataList[_loc2_].ActiveTime;
                  break;
               case 1:
                  Entertainment = acitiveDataList[_loc2_].ActiveTime;
                  break;
               case 2:
                  LanternRiddles = acitiveDataList[_loc2_].ActiveTime;
                  break;
               case 3:
                  YUANGUJULONG = acitiveDataList[_loc2_].ActiveTime;
                  YUANGUJULONG_DAYOFWEEK = acitiveDataList[_loc2_].DayOfWeek;
                  break;
               case 4:
                  Rescue = acitiveDataList[_loc2_].ActiveTime;
                  break;
               case 5:
                  HorseRace = acitiveDataList[_loc2_].ActiveTime;
                  break;
               case 6:
                  SevenDouble = acitiveDataList[_loc2_].ActiveTime;
                  break;
               case 7:
                  CatchBeast = acitiveDataList[_loc2_].ActiveTime;
                  break;
               case 8:
                  ZHENYINGZHAN = acitiveDataList[_loc2_].ActiveTime;
                  break;
               case 9:
                  LIANSAI = acitiveDataList[_loc2_].ActiveTime;
                  break;
               case 10:
                  ZUQIUBOSS = acitiveDataList[_loc2_].ActiveTime;
                  ZUQIUBOSS_DAYOFWEEK = acitiveDataList[_loc2_].DayOfWeek;
                  break;
               case 11:
                  GONGHUIZHAN = acitiveDataList[_loc2_].ActiveTime;
            }
            _loc2_++;
         }
      }
      
      public function everyDayActive(param1:ActivityAnalyzer) : void
      {
         acitivityDataList = param1.itemList;
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
      
      public function deleNoOverListItem(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc2_:int = noOverList.length;
         _loc3_ = 0;
         while(_loc3_ < _loc2_)
         {
            if(param1 == noOverList[_loc3_].ActivityType)
            {
               noOverList.splice(_loc3_,1);
               break;
            }
            _loc3_++;
         }
      }
      
      public function initActivityList(param1:PkgEvent) : void
      {
         var _loc14_:int = 0;
         var _loc20_:* = null;
         var _loc10_:int = 0;
         var _loc21_:int = 0;
         var _loc2_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc11_:int = 0;
         var _loc19_:* = null;
         var _loc12_:int = 0;
         var _loc8_:int = 0;
         var _loc13_:int = 0;
         var _loc15_:int = 0;
         var _loc22_:int = 0;
         var _loc16_:int = 0;
         var _loc3_:int = 0;
         var _loc5_:* = null;
         var _loc18_:int = param1.pkg.readInt();
         overList.length = 0;
         noOverList.length = 0;
         noOverList = copyArr(acitivityDataList);
         rezArray = [];
         _loc14_ = 0;
         while(_loc14_ < _loc18_)
         {
            _loc20_ = [];
            _loc20_[0] = param1.pkg.readInt();
            _loc20_[1] = param1.pkg.readInt();
            if(_loc20_[0] == 4 || _loc20_[0] == 5 || _loc20_[0] == 6 || _loc20_[0] == 18 || _loc20_[0] == 19)
            {
               bossDataDic[_loc20_[0]] = _loc20_[1];
            }
            rezArray.push(_loc20_);
            _loc14_++;
         }
         btnArr = [[1,0],[2,0],[3,0],[4,0],[5,0]];
         var _loc17_:int = param1.pkg.readInt();
         _loc10_ = 0;
         while(_loc10_ < _loc17_)
         {
            _loc21_ = param1.pkg.readInt();
            _loc2_ = param1.pkg.readInt();
            _loc6_ = btnArr.length;
            _loc7_ = 0;
            while(_loc7_ < _loc6_)
            {
               if(btnArr[_loc7_][0] == _loc21_)
               {
                  btnArr[_loc7_][1] = _loc2_;
                  break;
               }
               _loc7_++;
            }
            _loc10_++;
         }
         sessionArr = [];
         var _loc24_:int = param1.pkg.readInt();
         _loc11_ = 0;
         while(_loc11_ < _loc24_)
         {
            _loc19_ = [];
            _loc19_[0] = param1.pkg.readInt();
            _loc19_[1] = param1.pkg.readInt();
            sessionArr.push(_loc19_);
            _loc11_++;
         }
         activityValue = param1.pkg.readInt();
         initSession();
         var _loc9_:int = rezArray.length;
         _loc12_ = 0;
         while(_loc12_ < _loc9_)
         {
            _loc8_ = noOverList.length;
            _loc13_ = 0;
            while(_loc13_ < _loc8_)
            {
               _loc15_ = rezArray[_loc12_][0];
               _loc22_ = rezArray[_loc12_][1];
               if(noOverList[_loc13_].ActivityType == _loc15_)
               {
                  noOverList[_loc13_].OverCount = _loc22_;
                  if(noOverList[_loc13_].OverCount >= noOverList[_loc13_].Count)
                  {
                     overList.push(noOverList[_loc13_]);
                     deleNoOverListItem(_loc15_);
                  }
                  break;
               }
               _loc13_++;
            }
            _loc12_++;
         }
         var _loc23_:int = param1.pkg.readInt();
         _loc16_ = 0;
         while(_loc16_ < _loc23_)
         {
            _loc3_ = param1.pkg.readInt();
            _loc5_ = [];
            _loc5_[0] = param1.pkg.readBoolean();
            _loc5_[1] = param1.pkg.readBoolean();
            findBackDic[_loc3_] = _loc5_;
            _loc16_++;
         }
         var _loc4_:String = param1.pkg.readUTF();
         speedActArr = _loc4_.split("|");
         WantStrongManager.Instance.findBackDic = findBackDic;
      }
      
      private function copyArr(param1:Vector.<ActivityData>) : Vector.<ActivityData>
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         var _loc3_:Vector.<ActivityData> = new Vector.<ActivityData>();
         if(!param1)
         {
            return _loc3_;
         }
         _loc4_ = 0;
         while(_loc4_ < param1.length)
         {
            param1[_loc4_].resetOverCount();
            _loc2_ = param1[_loc4_];
            _loc3_.push(_loc2_);
            _loc4_++;
         }
         return _loc3_;
      }
      
      private function initSession() : void
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < sessionArr.length)
         {
            _loc1_ = 0;
            while(_loc1_ < acitiveDataList.length)
            {
               if(sessionArr[_loc2_])
               {
                  if(sessionArr[_loc2_][0] == acitiveDataList[_loc1_].ActivityTypeID)
                  {
                     acitiveDataList[_loc1_].TotalCount = sessionArr[_loc2_][1];
                     break;
                  }
               }
               _loc1_++;
            }
            _loc2_++;
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
