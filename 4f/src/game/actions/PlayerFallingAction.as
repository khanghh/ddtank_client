package game.actions{   import flash.geom.Point;   import game.objects.GameLiving;   import gameCommon.GameControl;   import gameCommon.actions.BaseAction;   import gameCommon.model.Living;   import gameCommon.model.Player;      public class PlayerFallingAction extends BaseAction   {                   protected var _player:GameLiving;            private var _info:Living;            private var _target:Point;            private var _isLiving:Boolean;            private var _canIgnore:Boolean;            private var _finishedFun:Function;            public function PlayerFallingAction(player:GameLiving, target:Point, isLiving:Boolean, canIgnore:Boolean, finishedFun:Function = null) { super(); }
            override public function connect(action:BaseAction) : Boolean { return false; }
            override public function canReplace(action:BaseAction) : Boolean { return false; }
            override public function prepare() : void { }
            override public function execute() : void { }
            override public function executeAtOnce() : void { }
            private function finish() : void { }
   }}