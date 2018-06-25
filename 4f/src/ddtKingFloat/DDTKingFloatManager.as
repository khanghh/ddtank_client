package ddtKingFloat{   import com.pickgliss.events.UIModuleEvent;   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.loader.UIModuleLoader;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.CoreManager;   import ddt.manager.ChatManager;   import ddt.manager.LanguageMgr;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import ddt.manager.TimeManager;   import ddt.utils.HelperUIModuleLoad;   import ddtKingFloat.data.DDTKingFloatCarInfo;   import ddtKingFloat.data.DDTKingFloatInfoVo;   import ddtKingFloat.data.DDTKingFloatPlayerInfo;   import ddtKingFloat.player.DDTKingFloatGamePlayer;   import ddtKingFloat.views.DDTKingFloatFrame;   import flash.events.Event;   import flash.events.TimerEvent;   import flash.utils.Timer;   import road7th.comm.PackageIn;   import road7th.utils.DateUtils;      public class DDTKingFloatManager extends CoreManager   {            public static const ICON_RES_LOAD_COMPLETE:String = "floatParadeIconResLoadComplete";            public static const CAR_STATUS_CHANGE:String = "floatParadeCarStatusChange";            public static const START_GAME:String = "floatParadeStartGame";            public static const ENTER_GAME:String = "floatParadeEnterGame";            public static const ALL_READY:String = "floatParadeAllReady";            public static const MOVE:String = "floatParadeMove";            public static const REFRESH_ITEM:String = "floatParadeAppearItem";            public static const REFRESH_BUFF:String = "floatParadeRefreshBuff";            public static const USE_SKILL:String = "floatParadeUseSkill";            public static const RANK_LIST:String = "floatParadeRankList";            public static const RANK_ARRIVE_LIST:String = "";            public static const ARRIVE:String = "floatParadeArrive";            public static const DESTROY:String = "floatParadeDestroy";            public static const RE_ENTER_ALL_INFO:String = "floatParadeReEnterAllInfo";            public static const CAN_ENTER:String = "floatParadeCanEnter";            public static const FIGHT_STATE_CHANGE:String = "floatParadeFightStateChange";            public static const LEAP_PROMPT_SHOW_HIDE:String = "floatParadeLeapPromptShowHide";            public static const END:String = "floatParadeEnd";            public static const REFRESH_ENTER_COUNT:String = "floatParadeRefreshEnterCount";            public static const REFRESH_ITEM_FREE_COUNT:String = "floatParadeRefreshItemCount";            public static const CANCEL_GAME:String = "floatParadeCancelGame";            public static const LAUNCH_MISSILE:String = "launchMissile";            private static var _instance:DDTKingFloatManager;                   private var _dataInfo:DDTKingFloatInfoVo;            public var isShowDungeonTip:Boolean = true;            private var _isStart:Boolean;            private var _isInGame:Boolean;            private var _carStatus:int;            private var _freeCount:int;            private var _usableCount:int;            private var _rankAddInfo:Array;            private var _playerList:Vector.<DDTKingFloatPlayerInfo>;            private var _accelerateRate:int;            private var _decelerateRate:int;            private var _buyRecordStatus:Array;            private var _startGameNeedMoney:int;            private var _doubleTimeArray:Array;            private var _timer:Timer;            private var _itemFreeCountList:Array;            private var _sprintAwardInfo:Array;            public var missileArgArr:Array;            public var selfPlayer:DDTKingFloatGamePlayer;            private var _isPromptDoubleTime:Boolean = false;            public function DDTKingFloatManager() { super(); }
            public static function get instance() : DDTKingFloatManager { return null; }
            public function get dataInfo() : DDTKingFloatInfoVo { return null; }
            public function set dataInfo(value:DDTKingFloatInfoVo) : void { }
            public function get sprintAwardInfo() : Array { return null; }
            public function get itemFreeCountList() : Array { return null; }
            public function get isInDoubleTime() : Boolean { return false; }
            public function get startGameNeedMoney() : int { return 0; }
            public function getBuyRecordStatus(index:int) : Object { return null; }
            public function get rankAddInfo() : Array { return null; }
            public function get decelerateRate() : int { return 0; }
            public function get accelerateRate() : int { return 0; }
            public function get playerList() : Vector.<DDTKingFloatPlayerInfo> { return null; }
            public function get usableCount() : int { return 0; }
            public function get freeCount() : int { return 0; }
            public function get carStatus() : int { return 0; }
            public function get isInGame() : Boolean { return false; }
            public function get isStart() : Boolean { return false; }
            public function setup() : void { }
            private function __onOpenView(e:DDTKingFloatEvent) : void { }
            private function loadComplete() : void { }
            public function enterGame() : void { }
            private function loadGameComplete() : void { }
            private function __onSocketMessage(e:DDTKingFloatEvent) : void { }
            private function pkgHandler(value:PackageIn) : void { }
            private function playLaunchMissileMC(pkg:PackageIn) : void { }
            private function refreshItemFreeCountHandler(pkg:PackageIn) : void { }
            private function refreshEnterCountHandler(pkg:PackageIn) : void { }
            private function refreshFightStateHandler(pkg:PackageIn) : void { }
            private function canEnterHandler(pkg:PackageIn) : void { }
            private function showDDTKingFloatFrame() : void { }
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
            private function timerHandler(event:TimerEvent) : void { }
            public function get npcSpeed() : int { return 0; }
            public function leaveMainViewHandler() : void { }
            public function open() : void { }
            private function loadIconCompleteHandler(event:UIModuleEvent) : void { }
            public function getPlayerResUrl(isSelf:Boolean, carType:int) : String { return null; }
            public function loadSound() : void { }
            private function loadSoundCompleteHandler(event:LoaderEvent) : void { }
            public function get activityBeginTime() : Date { return null; }
            public function get activityEndTime() : Date { return null; }
   }}