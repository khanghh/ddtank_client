package funnyGames{   import ddt.CoreManager;   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import funnyGames.cubeGame.CubeGameManager;   import funnyGames.cubeGame.data.CubeGameRankData;   import funnyGames.event.FunnyGamesEvent;   import uiModeManager.bombUI.HappyLittleGameManager;   import uiModeManager.bombUI.model.bomb.BombRankInfo;      public class FunnyGamesManager extends CoreManager   {            private static var _instance:FunnyGamesManager;                   private var _status:Boolean;            public function FunnyGamesManager(single:SingleTon) { super(); }
            public static function getInstance() : FunnyGamesManager { return null; }
            public function setup() : void { }
            public function enterFunnyGames() : void { }
            public function exitFunnyGames() : void { }
            public function get status() : Boolean { return false; }
            public function requestRankInfo(gameType:uint, rankType:uint) : void { }
            public function __onRankHandler(pkg:PkgEvent) : void { }
   }}class SingleTon{          function SingleTon() { super(); }
}