package game.actions{   import game.objects.GameLiving;   import game.objects.GameSmallEnemy;   import gameCommon.actions.BaseAction;      public class LivingMoveAction extends BaseAction   {                   private var _living:GameLiving;            private var _path:Array;            private var _currentPathIndex:int = 0;            private var _dir:int;            private var _endAction:String;            public function LivingMoveAction(living:GameLiving, path:Array, dir:int, endAction:String = "") { super(); }
            override public function prepare() : void { }
            override public function execute() : void { }
            private function finish() : void { }
            override public function cancel() : void { }
   }}