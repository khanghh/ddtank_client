package funnyGames.cubeGame{   import ddt.CoreManager;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import ddt.manager.StateManager;   import ddt.utils.HelperUIModuleLoad;   import funnyGames.FunnyGamesManager;   import funnyGames.cubeGame.data.CubeData;   import funnyGames.cubeGame.data.CubeGameInfo;   import funnyGames.cubeGame.data.CubeGameRankData;   import funnyGames.cubeGame.event.CubeGameEvent;   import road7th.comm.PackageOut;   import uiModeManager.bombUI.HappyLittleGameManager;      public class CubeGameManager extends CoreManager   {            private static var _instance:CubeGameManager;            public static var DEBUG:Boolean = false;            private static const EXIT_OPERATION_TYPE:uint = 0;            private static const RESTART_OPERATION_TYPE:uint = 1;                   private var _gameInfo:CubeGameInfo;            private var _todayRankDataList:Vector.<CubeGameRankData>;            private var _totalRankDataList:Vector.<CubeGameRankData>;            private var _status:Boolean = false;            private var _lastCubeId:uint = 0;            public var lock:Boolean = false;            public function CubeGameManager(single:SingleTon) { super(); }
            public static function getInstance() : CubeGameManager { return null; }
            public function setup() : void { }
            private function initData() : void { }
            private function initListeners() : void { }
            public function get gameInfo() : CubeGameInfo { return null; }
            public function startGame() : void { }
            public function checkEnergyEnough() : Boolean { return false; }
            public function endGame() : void { }
            private function enterGame() : void { }
            public function get status() : Boolean { return false; }
            public function addTotalRankData(data:CubeGameRankData) : void { }
            public function addTodayRankData(data:CubeGameRankData) : void { }
            public function clearTotalRankData() : void { }
            public function clearTodayRankData() : void { }
            public function getRankDataList(startIndex:int = 0, endIndex:int = 16777215, isTotal:Boolean = false) : Vector.<CubeGameRankData> { return null; }
            public function getSelfRank(isTotal:Boolean = false) : int { return 0; }
            private function checkNeedRequestRankInfo() : Boolean { return false; }
            public function requestStartCubeGame() : void { }
            private function __onResponseStartCubeGame(pkg:PkgEvent) : void { }
            public function resquestDeleteCube(id:int) : void { }
            private function __onResponseDeleteCube(pkg:PkgEvent) : void { }
            private function __onResponseGenerateCube(pkg:PkgEvent) : void { }
            private function __onResponseRandomCube(pkg:PkgEvent) : void { }
            private function __onResponseGameResult(pkg:PkgEvent) : void { }
            public function requestExitCubeGame() : void { }
            public function requestRestartGame() : void { }
            private function __onResponseGameExit(pkg:PkgEvent) : void { }
   }}class SingleTon{          function SingleTon() { super(); }
}