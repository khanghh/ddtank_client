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
      
      public function DayActivityManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get Instance() : DayActivityManager{return null;}
      
      public function get activityValue() : int{return 0;}
      
      public function set activityValue(param1:int) : void{}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      private function onPackInfo(param1:PkgEvent) : void{}
      
      private function onUpdateOnlineSecTimer(param1:TimerEvent) : void{}
      
      private function onPackGet(param1:PkgEvent) : void{}
      
      private function onPackBoxConfig(param1:PkgEvent) : void{}
      
      private function onPackOpenClose(param1:PkgEvent) : void{}
      
      public function canGetOnlineReward() : Boolean{return false;}
      
      public function isOnLineRewardOpen() : Boolean{return false;}
      
      private function creatActiveLoader() : void{}
      
      private function creatActivePointLoader() : void{}
      
      private function creatRewardLoader() : void{}
      
      public function activityRewardComp(param1:ActivityRewardAnalyzer) : void{}
      
      public function everyDayActivePoint(param1:ActivePointAnalzer) : void{}
      
      private function setActionTime() : void{}
      
      public function everyDayActive(param1:ActivityAnalyzer) : void{}
      
      public function get isHasActivityAward() : Boolean{return false;}
      
      public function deleNoOverListItem(param1:int) : void{}
      
      public function initActivityList(param1:PkgEvent) : void{}
      
      private function copyArr(param1:Vector.<ActivityData>) : Vector.<ActivityData>{return null;}
      
      private function initSession() : void{}
      
      public function show() : void{}
      
      protected function createActivityFrame() : void{}
   }
}
