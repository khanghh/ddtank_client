package worldboss
{
   import baglocked.BaglockedManager;
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.manager.CacheSysManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.CoreManager;
   import ddt.events.CEvent;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.manager.TimeManager;
   import ddt.utils.Helpers;
   import ddt.view.UIModuleSmallLoading;
   import ddtActivityIcon.DdtActivityIconManager;
   import ddtActivityIcon.DdtIconTxt;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.geom.Point;
   import flash.utils.clearInterval;
   import flash.utils.setTimeout;
   import hallIcon.HallIconManager;
   import hallIcon.HallIconType;
   import road7th.comm.PackageIn;
   import road7th.data.DictionaryData;
   import wantstrong.WantStrongManager;
   import wantstrong.event.WantStrongEvent;
   import worldBossHelper.WorldBossHelperManager;
   import worldBossHelper.event.WorldBossHelperEvent;
   import worldboss.event.WorldBossRoomEvent;
   import worldboss.model.WorldBossBuffInfo;
   import worldboss.model.WorldBossInfo;
   import worldboss.player.PlayerVO;
   import worldboss.player.RankingPersonInfo;
   import worldboss.view.WorldBossIcon;
   import worldboss.view.WorldBossRankingFram;
   
   public class WorldBossManager extends CoreManager
   {
      
      private static var _instance:WorldBossManager;
      
      public static var IsSuccessStartGame:Boolean = false;
       
      
      private var _ishallComplete:Boolean = false;
      
      private var _isOpen:Boolean = false;
      
      private var _mapload:BaseLoader;
      
      private var _bossInfo:WorldBossInfo;
      
      private var _entranceBtn:WorldBossIcon;
      
      private var _currentPVE_ID:int;
      
      private var _sky:MovieClip;
      
      public var iconEnterPath:String;
      
      public var mapPath:String;
      
      private var _autoBuyBuffs:DictionaryData;
      
      private var _appearPos:Array;
      
      private var _isShowBlood:Boolean = false;
      
      private var _isBuyBuffAlert:Boolean = false;
      
      private var _bossResourceId:String;
      
      private var _rankingInfos:Vector.<RankingPersonInfo>;
      
      private var _autoBlood:Boolean = false;
      
      private var _mapLoader:BaseLoader;
      
      private var _isLoadingState:Boolean = false;
      
      private var _activityTxt:DdtIconTxt;
      
      public var worldBossNum:int;
      
      public function WorldBossManager(){super();}
      
      public static function get Instance() : WorldBossManager{return null;}
      
      public function setup() : void{}
      
      override protected function start() : void{}
      
      public function get BossResourceId() : String{return null;}
      
      public function get isBuyBuffAlert() : Boolean{return false;}
      
      public function set isBuyBuffAlert(param1:Boolean) : void{}
      
      public function get autoBuyBuffs() : DictionaryData{return null;}
      
      public function get isShowBlood() : Boolean{return false;}
      
      public function get isAutoBlood() : Boolean{return false;}
      
      public function get rankingInfos() : Vector.<RankingPersonInfo>{return null;}
      
      private function __init(param1:PkgEvent) : void{}
      
      private function addSocketEvent() : void{}
      
      private function removeSocketEvent() : void{}
      
      protected function __updatePrivateInfo(param1:PkgEvent) : void{}
      
      protected function __updateBuffLevel(param1:PkgEvent) : void{}
      
      private function __gameRoomFull(param1:CrazyTankSocketEvent) : void{}
      
      public function creatEnterIcon(param1:Boolean = true, param2:int = 1, param3:String = null) : void{}
      
      public function disposeEnterBtn() : void{}
      
      private function __enter(param1:PkgEvent) : void{}
      
      private function loadMap() : void{}
      
      private function onMapSrcLoadedComplete(param1:Event) : void{}
      
      private function __loadingIsCloseRoom(param1:Event) : void{}
      
      private function __update(param1:PkgEvent) : void{}
      
      private function __fightOver(param1:PkgEvent) : void{}
      
      private function __leaveRoom(param1:Event) : void{}
      
      private function __showRanking(param1:PkgEvent) : void{}
      
      private function showRankingFrame(param1:PackageIn) : void{}
      
      private function showRankingInRoom(param1:PackageIn) : void{}
      
      private function __allOver(param1:PkgEvent) : void{}
      
      public function enterGame() : void{}
      
      public function exitGame() : void{}
      
      public function showEntranceBtn() : void{}
      
      public function addshowHallEntranceBtn() : void{}
      
      public function showHallSkyEffort(param1:MovieClip) : void{}
      
      public function set isOpen(param1:Boolean) : void{}
      
      public function get isOpen() : Boolean{return false;}
      
      public function get currentPVE_ID() : int{return 0;}
      
      public function get bossInfo() : WorldBossInfo{return null;}
      
      public function getWorldbossResource() : String{return null;}
      
      public function buyNewBuff(param1:int, param2:Boolean) : void{}
      
      public function set isLoadingState(param1:Boolean) : void{}
      
      public function get isLoadingState() : Boolean{return false;}
      
      public function get beforeStartTime() : int{return 0;}
      
      private function getDateHourTime(param1:Date) : int{return 0;}
      
      public function setSelfStatus(param1:int) : void{}
   }
}
