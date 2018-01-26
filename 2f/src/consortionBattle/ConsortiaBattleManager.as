package consortionBattle
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.BitmapLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.loader.LoaderEvent;
   import com.pickgliss.utils.ObjectUtils;
   import consortionBattle.event.ConsBatEvent;
   import consortionBattle.player.ConsortiaBattlePlayerInfo;
   import consortionBattle.view.ConsortiaBattleEntryBtn;
   import ddt.data.player.SelfInfo;
   import ddt.events.PkgEvent;
   import ddt.manager.ChatManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddtActivityIcon.DdtActivityIconManager;
   import ddtActivityIcon.DdtIconTxt;
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import flash.events.IEventDispatcher;
   import flash.geom.Point;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   
   public class ConsortiaBattleManager extends EventDispatcher
   {
      
      public static const ICON_AND_MAP_LOAD_COMPLETE:String = "consBatIconMapComplete";
      
      public static const CLOSE:String = "consortiaBattleClose";
      
      public static const MOVE_PLAYER:String = "consortiaBattleMovePlayer";
      
      public static const UPDATE_SCENE_INFO:String = "consortiaBattleUpdateSceneInfo";
      
      public static const HIDE_RECORD_CHANGE:String = "consortiaBattleHideRecordChange";
      
      public static const UPDATE_SCORE:String = "consortiaBattleUpdateScore";
      
      public static const BROADCAST:String = "consortiaBattleBroadcast";
      
      private static var _instance:ConsortiaBattleManager;
       
      
      public const resourcePrUrl:String = PathManager.SITE_MAIN + "image/factionwar/";
      
      public var isAutoPowerFull:Boolean = false;
      
      private var _entryBtn:ConsortiaBattleEntryBtn;
      
      private var _isOpen:Boolean = false;
      
      private var _isLoadIconComplete:Boolean = false;
      
      private var _isLoadMapComplete:Boolean = false;
      
      private var _playerDataList:DictionaryData;
      
      private var _buffPlayerList:DictionaryData;
      
      private var _buffCreatePlayerList:DictionaryData;
      
      private var _timer:TimerJuggler;
      
      public var isInMainView:Boolean = false;
      
      private var _startTime:Date;
      
      private var _endTime:Date;
      
      private var _isPowerFullUsed:Boolean = true;
      
      private var _isDoubleScoreUsed:Boolean = true;
      
      private var _victoryCount:int;
      
      private var _winningStreak:int;
      
      private var _score:int;
      
      private var _curHp:int;
      
      private var _hideRecord:int = 0;
      
      private var _buyRecordStatus:Array;
      
      private var _isCanEnter:Boolean;
      
      private var _activityTxt:DdtIconTxt;
      
      private var _isHadLoadRes:Boolean = false;
      
      private var _isHadShowOpenTip:Boolean = false;
      
      public function ConsortiaBattleManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : ConsortiaBattleManager{return null;}
      
      public function get playerDataList() : DictionaryData{return null;}
      
      public function get isPowerFullUsed() : Boolean{return false;}
      
      public function get isDoubleScoreUsed() : Boolean{return false;}
      
      public function get victoryCount() : int{return 0;}
      
      public function get winningStreak() : int{return 0;}
      
      public function get score() : int{return 0;}
      
      public function get curHp() : int{return 0;}
      
      public function get isCanEnter() : Boolean{return false;}
      
      private function timerHandler(param1:Event) : void{}
      
      public function judgeCreatePlayer(param1:Number, param2:Number) : void{}
      
      public function getBuyRecordStatus(param1:int) : Object{return null;}
      
      public function get isOpen() : Boolean{return false;}
      
      public function get isLoadIconMapComplete() : Boolean{return false;}
      
      public function get beforeStartTime() : int{return 0;}
      
      public function get toEndTime() : int{return 0;}
      
      public function setup() : void{}
      
      private function getDateHourTime(param1:Date) : int{return 0;}
      
      public function changeHideRecord(param1:int, param2:Boolean) : void{}
      
      public function isHide(param1:int) : Boolean{return false;}
      
      public function addEntryBtn(param1:Boolean, param2:String = null) : void{}
      
      private function closeHandler(param1:Event) : void{}
      
      public function disposeEntryBtn() : void{}
      
      private function pkgHandler(param1:PkgEvent) : void{}
      
      private function broadcastHandler(param1:PackageIn) : void{}
      
      private function splitMergeHandler() : void{}
      
      private function updateScore(param1:PackageIn) : void{}
      
      private function updateSceneInfo(param1:PackageIn) : void{}
      
      private function updatePlayerStatus(param1:PackageIn) : void{}
      
      private function deletePlayer(param1:PackageIn) : void{}
      
      private function movePlayer(param1:PackageIn) : void{}
      
      private function addPlayerInfo(param1:PackageIn) : void{}
      
      private function initSelfInfo(param1:PackageIn) : void{}
      
      public function getPlayerInfo(param1:int) : ConsortiaBattlePlayerInfo{return null;}
      
      public function clearPlayerInfo() : void{}
      
      private function openOrCloseHandler(param1:PackageIn) : void{}
      
      private function open() : void{}
      
      private function loadMap() : void{}
      
      private function loadIcon() : void{}
      
      private function onIconLoadComplete(param1:LoaderEvent) : void{}
      
      private function onMapLoadComplete(param1:LoaderEvent) : void{}
      
      public function createLoader(param1:String) : BitmapLoader{return null;}
   }
}
