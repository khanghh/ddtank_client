package game.actions.newHand{   import game.view.map.MapView;   import gameCommon.GameControl;   import gameCommon.model.Bomb;   import gameCommon.model.Living;   import gameCommon.model.LocalPlayer;   import gameCommon.model.Player;      public class NewHandFightHelpAction extends BaseNewHandFightHelpAction   {                   private var _player:LocalPlayer;            private var _enemyPlayer:Player;            private var _bombs:Array;            private var _shootOverCount:int;            private var _map:MapView;            public function NewHandFightHelpAction(player:LocalPlayer, shootOverCount:int, map:MapView) { super(); }
            override public function prepare() : void { }
            override public function executeAtOnce() : void { }
            override public function execute() : void { }
            private function getNewHandEnemy() : Player { return null; }
            private function checkShootDirection() : Boolean { return false; }
            private function checkShootOutMap() : Boolean { return false; }
            private function checkHurtSelf() : Boolean { return false; }
            private function getRecentBomb() : Bomb { return null; }
            private function checkHurtEnemy(showTip:Boolean = true) : Boolean { return false; }
   }}