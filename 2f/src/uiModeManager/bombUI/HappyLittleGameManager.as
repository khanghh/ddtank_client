package uiModeManager.bombUI
{
   import com.pickgliss.loader.BaseLoader;
   import com.pickgliss.loader.LoadResourceManager;
   import com.pickgliss.ui.ComponentFactory;
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.loader.LoaderCreate;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.TimeManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import funnyGames.FunnyGamesManager;
   import funnyGames.event.FunnyGamesEvent;
   import times.utils.timerManager.TimerJuggler;
   import times.utils.timerManager.TimerManager;
   import uiModeManager.bombUI.event.HappyLittleGameEvent;
   import uiModeManager.bombUI.model.HappyMiniGameActiveInfo;
   import uiModeManager.bombUI.model.rank.HappyLittleGameRankAnalyzer;
   import uiModeManager.bombUI.model.rank.HappyMiniGameRankData;
   import uiModeManager.bombUI.model.rank.RankRewardCfg;
   
   public class HappyLittleGameManager extends CoreManager
   {
      
      private static var _instance:HappyLittleGameManager;
       
      
      public var currentGameState:int;
      
      private var _currentGameType:int;
      
      public var bombManager:BombGameManager;
      
      public var gameActiveInfos:Vector.<HappyMiniGameActiveInfo>;
      
      private var timer_fixed:TimerJuggler;
      
      private var timer_random:TimerJuggler;
      
      public var fixed_refresh:Boolean = true;
      
      public var random_refresh:Boolean = true;
      
      private var timerNum:int = 300000;
      
      private var _rankDataList:Vector.<HappyMiniGameRankData>;
      
      private var _rankRewardCfg:RankRewardCfg;
      
      private var _lastRequstRankDataTime:Date;
      
      public function HappyLittleGameManager(param1:IEventDispatcher = null){super(null);}
      
      public static function get instance() : HappyLittleGameManager{return null;}
      
      public function get currentGameType() : int{return 0;}
      
      public function get rankRewardCfg() : RankRewardCfg{return null;}
      
      public function set currentGameType(param1:int) : void{}
      
      private function onComplete() : void{}
      
      override protected function start() : void{}
      
      public function setUp() : void{}
      
      private function checkRankDataRequst() : Boolean{return false;}
      
      public function showRankFrame() : void{}
      
      private function requestRankInfo() : void{}
      
      public function onAnalyzeRankRewardCfg(param1:HappyLittleGameRankAnalyzer) : void{}
      
      private function onGameRankInfo(param1:PkgEvent) : void{}
      
      private function sortRankDataList(param1:HappyMiniGameRankData, param2:HappyMiniGameRankData) : int{return 0;}
      
      public function getRankDataList(param1:int = 0, param2:int = 16777215) : Vector.<HappyMiniGameRankData>{return null;}
      
      public function getSelfRank() : int{return 0;}
      
      private function __activeDataHandler(param1:PkgEvent) : void{}
      
      private function clearActiveInfo() : void{}
      
      public function startTimerByType(param1:int) : void{}
      
      private function cleartimer() : void{}
      
      private function __timerfixedComplete(param1:Event) : void{}
      
      private function __timerrandomComplete(param1:Event) : void{}
      
      public function clearData() : void{}
   }
}
