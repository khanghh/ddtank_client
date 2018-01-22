package escort
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.data.ServerConfigInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.TimeManager;
   import escort.data.EscortCarInfo;
   import escort.data.EscortInfoVo;
   import escort.data.EscortPlayerInfo;
   import escort.event.EscortEvent;
   import escort.view.EscortBuyConfirmView;
   import escort.view.EscortFrame;
   import escort.view.EscortMainView;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   
   public class EscortControl extends EventDispatcher
   {
      
      public static const CAR_STATUS_CHANGE:String = "escortCarStatusChange";
      
      public static const START_GAME:String = "escortStartGame";
      
      public static const ENTER_GAME:String = "escortEnterGame";
      
      public static const ALL_READY:String = "escortAllReady";
      
      public static const MOVE:String = "escortMove";
      
      public static const REFRESH_ITEM:String = "escortAppearItem";
      
      public static const REFRESH_BUFF:String = "escortRefreshBuff";
      
      public static const USE_SKILL:String = "escortUseSkill";
      
      public static const RANK_LIST:String = "escortRankList";
      
      public static const RANK_ARRIVE_LIST:String = "";
      
      public static const ARRIVE:String = "escortArrive";
      
      public static const DESTROY:String = "escortDestroy";
      
      public static const RE_ENTER_ALL_INFO:String = "escortReEnterAllInfo";
      
      public static const FIGHT_STATE_CHANGE:String = "escortFightStateChange";
      
      public static const LEAP_PROMPT_SHOW_HIDE:String = "escortLeapPromptShowHide";
      
      public static const REFRESH_ENTER_COUNT:String = "escortRefreshEnterCount";
      
      public static const REFRESH_ITEM_FREE_COUNT:String = "escortRefreshItemCount";
      
      public static const ICON_RES_LOAD_COMPLETE:String = "iconresloadcomplete";
      
      private static var _instance:EscortControl;
       
      
      public var dataInfo:EscortInfoVo;
      
      private var _carStatus:int;
      
      private var _freeCount:int;
      
      private var _usableCount:int;
      
      private var _rankAddInfo:Array;
      
      private var _playerList:Vector.<EscortPlayerInfo>;
      
      private var _accelerateRate:int;
      
      private var _decelerateRate:int;
      
      private var _buyRecordStatus:Array;
      
      private var _startGameNeedMoney:int;
      
      private var _doubleTimeArray:Array;
      
      private var _timer:Timer;
      
      private var _itemFreeCountList:Array;
      
      private var _sprintAwardInfo:Array;
      
      private var _endTime:int = -1;
      
      private var _hasPrompted:DictionaryData;
      
      private var _isPromptDoubleTime:Boolean = false;
      
      public function EscortControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : EscortControl{return null;}
      
      public function setup() : void{}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function refreshItemFreeCountHandler(param1:PackageIn) : void{}
      
      private function refreshEnterCountHandler(param1:PackageIn) : void{}
      
      private function refreshFightStateHandler(param1:PackageIn) : void{}
      
      private function reEnterAllInfoHandler(param1:PackageIn) : void{}
      
      private function destroyHandler(param1:PackageIn) : void{}
      
      private function arriveHandler(param1:PackageIn) : void{}
      
      private function rankListHandler(param1:PackageIn) : void{}
      
      private function useSkillHandler(param1:PackageIn) : void{}
      
      private function refreshBuffHandler(param1:PackageIn) : void{}
      
      private function refreshItemHandler(param1:PackageIn) : void{}
      
      private function moveHandler(param1:PackageIn) : void{}
      
      private function allReadyHandler(param1:PackageIn) : void{}
      
      private function enterGameHandler(param1:PackageIn) : void{}
      
      private function startGameHandler(param1:PackageIn) : void{}
      
      private function changeCarStatus(param1:PackageIn) : void{}
      
      private function __showFrameHandler(param1:Event) : void{}
      
      public function checkInitData() : void{}
      
      private function __endHandler(param1:Event) : void{}
      
      private function __leaveMainViewHandler(param1:Event) : void{}
      
      public function get sprintAwardInfo() : Array{return null;}
      
      public function get itemFreeCountList() : Array{return null;}
      
      public function get isInDoubleTime() : Boolean{return false;}
      
      public function get startGameNeedMoney() : int{return 0;}
      
      public function getBuyRecordStatus(param1:int) : Object{return null;}
      
      public function get rankAddInfo() : Array{return null;}
      
      public function get decelerateRate() : int{return 0;}
      
      public function get accelerateRate() : int{return 0;}
      
      public function get playerList() : Vector.<EscortPlayerInfo>{return null;}
      
      public function get usableCount() : int{return 0;}
      
      public function get freeCount() : int{return 0;}
      
      public function get carStatus() : int{return 0;}
      
      private function timerHandler(param1:TimerEvent) : void{}
   }
}
