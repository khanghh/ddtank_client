package drgnBoat{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.UIModuleLoader;   import ddt.CoreManager;   import ddt.data.ServerConfigInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import drgnBoat.data.DrgnBoatCarInfo;   import drgnBoat.data.DrgnBoatInfoVo;   import drgnBoat.data.DrgnBoatPlayerInfo;   import drgnBoat.event.DrgnBoatEvent;   import drgnBoatBuild.DrgnBoatBuildManager;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.utils.Timer;   import road7th.comm.PackageIn;   import road7th.data.DictionaryData;      public class DrgnBoatManager extends CoreManager   {            public static const LEN:int = 33600;            public static const INIT_X:int = 280;            public static const ICON_RES_LOAD_COMPLETE:String = "drgnBoatIconResLoadComplete";            public static const CAR_STATUS_CHANGE:String = "drgnBoatCarStatusChange";            public static const START_GAME:String = "drgnBoatStartGame";            public static const ENTER_GAME:String = "drgnBoatEnterGame";            public static const ALL_READY:String = "drgnBoatAllReady";            public static const MOVE:String = "drgnBoatMove";            public static const REFRESH_ITEM:String = "drgnBoatAppearItem";            public static const REFRESH_BUFF:String = "drgnBoatRefreshBuff";            public static const USE_SKILL:String = "drgnBoatUseSkill";            public static const RANK_LIST:String = "drgnBoatRankList";            public static const RANK_ARRIVE_LIST:String = "";            public static const ARRIVE:String = "drgnBoatArrive";            public static const DESTROY:String = "drgnBoatDestroy";            public static const RE_ENTER_ALL_INFO:String = "drgnBoatReEnterAllInfo";            public static const CAN_ENTER:String = "drgnBoatCanEnter";            public static const FIGHT_STATE_CHANGE:String = "drgnBoatFightStateChange";            public static const LEAP_PROMPT_SHOW_HIDE:String = "drgnBoatLeapPromptShowHide";            public static const END:String = "drgnBoatEnd";            public static const REFRESH_ENTER_COUNT:String = "drgnBoatRefreshEnterCount";            public static const REFRESH_ITEM_FREE_COUNT:String = "drgnBoatRefreshItemCount";            public static const CANCEL_GAME:String = "drgnBoatCancelGame";            public static const LAUNCH_MISSILE:String = "launchMissile";            private static var _instance:DrgnBoatManager;                   public var isShowDungeonTip:Boolean = true;            public var dataInfo:DrgnBoatInfoVo;            private var _isStart:Boolean;            private var _isLoadIconComplete:Boolean;            private var _isInGame:Boolean;            private var _carStatus:int;            private var _freeCount:int;            private var _usableCount:int;            private var _playerList:Vector.<DrgnBoatPlayerInfo>;            private var _rankAddInfo:Array;            private var _accelerateRate:int;            private var _decelerateRate:int;            private var _buyRecordStatus:Array;            private var _startGameNeedMoney:int;            private var _doubleTimeArray:Array;            private var _timer:Timer;            private var _itemFreeCountList:Array;            private var _sprintAwardInfo:Array;            private var _endTime:int = -1;            private var _hasPrompted:DictionaryData;            public var missileArgArr:Array;            private var _isPromptDoubleTime:Boolean = false;            public function DrgnBoatManager() { super(); }
            public static function get instance() : DrgnBoatManager { return null; }
            public function get sprintAwardInfo() : Array { return null; }
            public function get itemFreeCountList() : Array { return null; }
            public function get isInDoubleTime() : Boolean { return false; }
            public function get startGameNeedMoney() : int { return 0; }
            public function getBuyRecordStatus(index:int) : Object { return null; }
            public function get rankAddInfo() : Array { return null; }
            public function get decelerateRate() : int { return 0; }
            public function get accelerateRate() : int { return 0; }
            public function get playerList() : Vector.<DrgnBoatPlayerInfo> { return null; }
            public function get usableCount() : int { return 0; }
            public function get freeCount() : int { return 0; }
            public function get carStatus() : int { return 0; }
            public function get isInGame() : Boolean { return false; }
            public function get isStart() : Boolean { return false; }
            public function get isLoadIconComplete() : Boolean { return false; }
            public function setup() : void { }
            private function pkgHandler(event:CrazyTankSocketEvent) : void { }
            private function playLaunchMissileMC(pkg:PackageIn) : void { }
            private function refreshItemFreeCountHandler(pkg:PackageIn) : void { }
            private function refreshEnterCountHandler(pkg:PackageIn) : void { }
            private function refreshFightStateHandler(pkg:PackageIn) : void { }
            private function canEnterHandler(pkg:PackageIn) : void { }
            private function reEnterAllInfoHandler(pkg:PackageIn) : void { }
            private function destroyHandler(pkg:PackageIn) : void { }
            private function arriveHandler(pkg:PackageIn) : void { }
            private function rankListHandler(pkg:PackageIn) : void { }
            private function useSkillHandler(pkg:PackageIn) : void { }
            private function refreshBuffHandler(pkg:PackageIn) : void { }
            private function refreshItemHandler(pkg:PackageIn) : void { }
            private function moveHandler(pkg:PackageIn) : void { }
            private function allReadyHandler(pkg:PackageIn) : void { }
            private function enterGameHandler(pkg:PackageIn) : void { }
            private function startGameHandler(pkg:PackageIn) : void { }
            private function changeCarStatus(pkg:PackageIn) : void { }
            private function openOrCloseHandler(pkg:PackageIn) : void { }
            private function open() : void { }
            private function loadIconCompleteHandler(event:UIModuleEvent) : void { }
            private function timerHandler(event:TimerEvent) : void { }
            public function enterMainViewHandler() : void { }
            public function leaveMainViewHandler() : void { }
            override protected function start() : void { }
            public function get npcSpeed() : int { return 0; }
            public function getPlayerResUrl(isSelf:Boolean, carType:int) : String { return null; }
            public function loadSound() : void { }
            private function loadSoundCompleteHandler(event:LoaderEvent) : void { }
   }}