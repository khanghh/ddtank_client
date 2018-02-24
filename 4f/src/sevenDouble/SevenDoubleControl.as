package sevenDouble
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
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import sevenDouble.data.SevenDoubleCarInfo;
   import sevenDouble.data.SevenDoubleInfoVo;
   import sevenDouble.data.SevenDoublePlayerInfo;
   import sevenDouble.event.SevenDoubleEvent;
   import sevenDouble.view.SevenDoubleBuyConfirmView;
   import sevenDouble.view.SevenDoubleFrame;
   import sevenDouble.view.SevenDoubleMainView;
   
   public class SevenDoubleControl extends EventDispatcher
   {
      
      public static const CAR_STATUS_CHANGE:String = "sevenDoubleCarStatusChange";
      
      public static const START_GAME:String = "sevenDoubleStartGame";
      
      public static const ENTER_GAME:String = "sevenDoubleEnterGame";
      
      public static const ALL_READY:String = "sevenDoubleAllReady";
      
      public static const MOVE:String = "sevenDoubleMove";
      
      public static const REFRESH_ITEM:String = "sevenDoubleAppearItem";
      
      public static const REFRESH_BUFF:String = "sevenDoubleRefreshBuff";
      
      public static const USE_SKILL:String = "sevenDoubleUseSkill";
      
      public static const RANK_LIST:String = "sevenDoubleRankList";
      
      public static const RANK_ARRIVE_LIST:String = "";
      
      public static const ARRIVE:String = "sevenDoubleArrive";
      
      public static const DESTROY:String = "sevenDoubleDestroy";
      
      public static const RE_ENTER_ALL_INFO:String = "sevenDoubleReEnterAllInfo";
      
      public static const FIGHT_STATE_CHANGE:String = "sevenDoubleFightStateChange";
      
      public static const LEAP_PROMPT_SHOW_HIDE:String = "sevenDoubleLeapPromptShowHide";
      
      public static const REFRESH_ENTER_COUNT:String = "sevenDoubleRefreshEnterCount";
      
      public static const REFRESH_ITEM_FREE_COUNT:String = "sevenDoubleRefreshItemCount";
      
      public static const CANCEL_GAME:String = "sevenDoubleCancelGame";
      
      private static var _instance:SevenDoubleControl;
       
      
      public var dataInfo:SevenDoubleInfoVo;
      
      private var _carStatus:int;
      
      private var _freeCount:int;
      
      private var _usableCount:int;
      
      private var _rankAddInfo:Array;
      
      private var _playerList:Vector.<SevenDoublePlayerInfo>;
      
      private var _accelerateRate:int;
      
      private var _decelerateRate:int;
      
      private var _buyRecordStatus:Array;
      
      private var _startGameNeedMoney:int;
      
      private var _doubleTimeArray:Array;
      
      private var _timer:Timer;
      
      private var _sprintAwardInfo:Array;
      
      private var _itemFreeCountList:Array;
      
      private var _endTime:int = -1;
      
      private var _hasPrompted:DictionaryData;
      
      private var _isPromptDoubleTime:Boolean = false;
      
      public function SevenDoubleControl(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : SevenDoubleControl{return null;}
      
      public function setup() : void{}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      public function get sprintAwardInfo() : Array{return null;}
      
      public function get itemFreeCountList() : Array{return null;}
      
      private function refreshItemFreeCountHandler(param1:PackageIn) : void{}
      
      private function __endHandler(param1:Event) : void{}
      
      private function __showFrameHandler(param1:Event) : void{}
      
      public function checkInitData() : void{}
      
      public function get isInDoubleTime() : Boolean{return false;}
      
      public function get startGameNeedMoney() : int{return 0;}
      
      public function getBuyRecordStatus(param1:int) : Object{return null;}
      
      public function get rankAddInfo() : Array{return null;}
      
      public function get decelerateRate() : int{return 0;}
      
      public function get accelerateRate() : int{return 0;}
      
      public function get playerList() : Vector.<SevenDoublePlayerInfo>{return null;}
      
      public function get usableCount() : int{return 0;}
      
      public function get freeCount() : int{return 0;}
      
      public function get carStatus() : int{return 0;}
      
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
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      private function __leaveMainViewHandler(param1:Event) : void{}
   }
}
