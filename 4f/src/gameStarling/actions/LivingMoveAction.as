package gameStarling.actions{   import gameCommon.actions.BaseAction;   import gameStarling.objects.GameLiving3D;   import gameStarling.objects.GameSmallEnemy3D;      public class LivingMoveAction extends BaseAction   {                   private var _living:GameLiving3D;            private var _path:Array;            private var _currentPathIndex:int = 0;            private var _dir:int;            private var _endAction:String;            public function LivingMoveAction(living:GameLiving3D, path:Array, dir:int, endAction:String = "") { super(); }
            override public function prepare() : void { }
            override public function execute() : void { }
            private function finish() : void { }
            override public function cancel() : void { }
   }}