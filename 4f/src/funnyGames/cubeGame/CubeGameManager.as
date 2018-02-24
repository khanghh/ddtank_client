package funnyGames.cubeGame
{
   import ddt.CoreManager;
   import ddt.events.PkgEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperUIModuleLoad;
   import funnyGames.FunnyGamesManager;
   import funnyGames.cubeGame.data.CubeData;
   import funnyGames.cubeGame.data.CubeGameInfo;
   import funnyGames.cubeGame.data.CubeGameRankData;
   import funnyGames.cubeGame.event.CubeGameEvent;
   import road7th.comm.PackageOut;
   import uiModeManager.bombUI.HappyLittleGameManager;
   
   public class CubeGameManager extends CoreManager
   {
      
      private static var _instance:CubeGameManager;
      
      public static var DEBUG:Boolean = false;
      
      private static const EXIT_OPERATION_TYPE:uint = 0;
      
      private static const RESTART_OPERATION_TYPE:uint = 1;
       
      
      private var _gameInfo:CubeGameInfo;
      
      private var _todayRankDataList:Vector.<CubeGameRankData>;
      
      private var _totalRankDataList:Vector.<CubeGameRankData>;
      
      private var _status:Boolean = false;
      
      private var _lastCubeId:uint = 0;
      
      public var lock:Boolean = false;
      
      public function CubeGameManager(param1:SingleTon){super();}
      
      public static function getInstance() : CubeGameManager{return null;}
      
      public function setup() : void{}
      
      private function initData() : void{}
      
      private function initListeners() : void{}
      
      public function get gameInfo() : CubeGameInfo{return null;}
      
      public function startGame() : void{}
      
      public function checkEnergyEnough() : Boolean{return false;}
      
      public function endGame() : void{}
      
      private function enterGame() : void{}
      
      public function get status() : Boolean{return false;}
      
      public function addTotalRankData(param1:CubeGameRankData) : void{}
      
      public function addTodayRankData(param1:CubeGameRankData) : void{}
      
      public function clearTotalRankData() : void{}
      
      public function clearTodayRankData() : void{}
      
      public function getRankDataList(param1:int = 0, param2:int = 16777215, param3:Boolean = false) : Vector.<CubeGameRankData>{return null;}
      
      public function getSelfRank(param1:Boolean = false) : int{return 0;}
      
      private function checkNeedRequestRankInfo() : Boolean{return false;}
      
      public function requestStartCubeGame() : void{}
      
      private function __onResponseStartCubeGame(param1:PkgEvent) : void{}
      
      public function resquestDeleteCube(param1:int) : void{}
      
      private function __onResponseDeleteCube(param1:PkgEvent) : void{}
      
      private function __onResponseGenerateCube(param1:PkgEvent) : void{}
      
      private function __onResponseRandomCube(param1:PkgEvent) : void{}
      
      private function __onResponseGameResult(param1:PkgEvent) : void{}
      
      public function requestExitCubeGame() : void{}
      
      public function requestRestartGame() : void{}
      
      private function __onResponseGameExit(param1:PkgEvent) : void{}
   }
}

class SingleTon
{
    
   
   function SingleTon(){super();}
}
