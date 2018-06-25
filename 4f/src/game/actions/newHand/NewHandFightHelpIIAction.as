package game.actions.newHand{   import ddt.manager.PlayerManager;   import gameCommon.GameControl;   import gameCommon.actions.BaseAction;   import gameCommon.model.Living;   import gameCommon.model.LocalPlayer;   import gameCommon.model.Player;      public class NewHandFightHelpIIAction extends BaseNewHandFightHelpAction   {                   private var _player:LocalPlayer;            private var _diffBlood:int;            public function NewHandFightHelpIIAction(player:LocalPlayer, diffBlood:Number) { super(); }
            override public function prepare() : void { }
            override public function connect(action:BaseAction) : Boolean { return false; }
            override public function executeAtOnce() : void { }
            override public function execute() : void { }
            private function getNewHandEnemy() : Player { return null; }
            private function checkBeEnemyHurt() : Boolean { return false; }
            private function checkSelfBlood() : Boolean { return false; }
            private function getPropNum() : int { return 0; }
   }}