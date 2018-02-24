package floatParade
{
   import com.pickgliss.events.UIModuleEvent;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.loader.UIModuleLoader;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import ddt.CoreManager;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import flash.events.TimerEvent;
   import flash.utils.Timer;
   import floatParade.data.FloatParadeCarInfo;
   import floatParade.data.FloatParadeInfoVo;
   import floatParade.data.FloatParadePlayerInfo;
   import floatParade.player.FloatParadeGamePlayer;
   import floatParade.views.FloatParadeFrame;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   
   public class FloatParadeManager extends CoreManager
   {
      
      public static const ICON_RES_LOAD_COMPLETE:String = "floatParadeIconResLoadComplete";
      
      public static const CAR_STATUS_CHANGE:String = "floatParadeCarStatusChange";
      
      public static const START_GAME:String = "floatParadeStartGame";
      
      public static const ENTER_GAME:String = "floatParadeEnterGame";
      
      public static const ALL_READY:String = "floatParadeAllReady";
      
      public static const MOVE:String = "floatParadeMove";
      
      public static const REFRESH_ITEM:String = "floatParadeAppearItem";
      
      public static const REFRESH_BUFF:String = "floatParadeRefreshBuff";
      
      public static const USE_SKILL:String = "floatParadeUseSkill";
      
      public static const RANK_LIST:String = "floatParadeRankList";
      
      public static const RANK_ARRIVE_LIST:String = "";
      
      public static const ARRIVE:String = "floatParadeArrive";
      
      public static const DESTROY:String = "floatParadeDestroy";
      
      public static const RE_ENTER_ALL_INFO:String = "floatParadeReEnterAllInfo";
      
      public static const CAN_ENTER:String = "floatParadeCanEnter";
      
      public static const FIGHT_STATE_CHANGE:String = "floatParadeFightStateChange";
      
      public static const LEAP_PROMPT_SHOW_HIDE:String = "floatParadeLeapPromptShowHide";
      
      public static const END:String = "floatParadeEnd";
      
      public static const REFRESH_ENTER_COUNT:String = "floatParadeRefreshEnterCount";
      
      public static const REFRESH_ITEM_FREE_COUNT:String = "floatParadeRefreshItemCount";
      
      public static const CANCEL_GAME:String = "floatParadeCancelGame";
      
      public static const LAUNCH_MISSILE:String = "launchMissile";
      
      private static var _instance:FloatParadeManager;
       
      
      public var dataInfo:FloatParadeInfoVo;
      
      public var isShowDungeonTip:Boolean = true;
      
      private var _isStart:Boolean;
      
      private var _isInGame:Boolean;
      
      private var _carStatus:int;
      
      private var _freeCount:int;
      
      private var _usableCount:int;
      
      private var _rankAddInfo:Array;
      
      private var _playerList:Vector.<FloatParadePlayerInfo>;
      
      private var _accelerateRate:int;
      
      private var _decelerateRate:int;
      
      private var _buyRecordStatus:Array;
      
      private var _startGameNeedMoney:int;
      
      private var _doubleTimeArray:Array;
      
      private var _timer:Timer;
      
      private var _itemFreeCountList:Array;
      
      private var _sprintAwardInfo:Array;
      
      public var missileArgArr:Array;
      
      public var selfPlayer:FloatParadeGamePlayer;
      
      private var _isPromptDoubleTime:Boolean = false;
      
      public function FloatParadeManager(){super();}
      
      public static function get instance() : FloatParadeManager{return null;}
      
      public function get sprintAwardInfo() : Array{return null;}
      
      public function get itemFreeCountList() : Array{return null;}
      
      public function get isInDoubleTime() : Boolean{return false;}
      
      public function get startGameNeedMoney() : int{return 0;}
      
      public function getBuyRecordStatus(param1:int) : Object{return null;}
      
      public function get rankAddInfo() : Array{return null;}
      
      public function get decelerateRate() : int{return 0;}
      
      public function get accelerateRate() : int{return 0;}
      
      public function get playerList() : Vector.<FloatParadePlayerInfo>{return null;}
      
      public function get usableCount() : int{return 0;}
      
      public function get freeCount() : int{return 0;}
      
      public function get carStatus() : int{return 0;}
      
      public function get isInGame() : Boolean{return false;}
      
      public function get isStart() : Boolean{return false;}
      
      public function setup() : void{}
      
      private function __onOpenView(param1:FloatParadeEvent) : void{}
      
      private function loadComplete() : void{}
      
      public function enterGame() : void{}
      
      private function loadGameComplete() : void{}
      
      private function __onSocketMessage(param1:FloatParadeEvent) : void{}
      
      private function pkgHandler(param1:PackageIn) : void{}
      
      private function playLaunchMissileMC(param1:PackageIn) : void{}
      
      private function refreshItemFreeCountHandler(param1:PackageIn) : void{}
      
      private function refreshEnterCountHandler(param1:PackageIn) : void{}
      
      private function refreshFightStateHandler(param1:PackageIn) : void{}
      
      private function canEnterHandler(param1:PackageIn) : void{}
      
      private function showFloatParadeFrame() : void{}
      
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
      
      private function openOrCloseHandler(param1:PackageIn) : void{}
      
      private function timerHandler(param1:TimerEvent) : void{}
      
      public function get npcSpeed() : int{return 0;}
      
      public function leaveMainViewHandler() : void{}
      
      public function open() : void{}
      
      private function loadIconCompleteHandler(param1:UIModuleEvent) : void{}
      
      public function getPlayerResUrl(param1:Boolean, param2:int) : String{return null;}
      
      public function loadSound() : void{}
      
      private function loadSoundCompleteHandler(param1:LoaderEvent) : void{}
      
      public function get activityBeginTime() : Date{return null;}
      
      public function get activityEndTime() : Date{return null;}
   }
}
