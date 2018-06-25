package gameStick{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.CoreController;   import ddt.CoreManager;   import gameStick.view.GameStickDetailBoard;   import gameStick.view.GameStickGameOverBoard;   import gameStick.view.GameStickRankFrame;   import gameStick.view.GameStickShareFrame;      public class GameStickManager extends CoreController   {            private static var instance:GameStickManager;                   private var _mgr:CoreManager;            private var _frameDetail:GameStickDetailBoard;            private var _frameGameOver:GameStickGameOverBoard;            private var _frameShare:GameStickShareFrame;            private var _frameRank:GameStickRankFrame;            public function GameStickManager(single:inner) { super(); }
            public static function getInstance() : GameStickManager { return null; }
            public function setup() : void { }
            public function dispose() : void { }
            public function showDetail() : void { }
            public function showGameOver() : void { }
            public function showShare() : void { }
            public function showRank() : void { }
            public function startGame() : void { }
            public function restart() : void { }
            public function exit() : void { }
            public function share() : void { }
   }}class inner{          function inner() { super(); }
}