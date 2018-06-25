package littleGame.actions{   import ddt.ddt_internal;   import flash.geom.Point;   import flash.utils.getTimer;   import littleGame.LittleGameManager;   import littleGame.data.Grid;   import littleGame.data.Node;   import littleGame.model.LittleSelf;   import littleGame.model.Scenario;      use namespace ddt_internal;      public class LittleSelfMoveAction extends LittleAction   {                   private var _self:LittleSelf;            private var _path:Array;            private var _grid:Grid;            private var _idx:int = 0;            private var _elapsed:int = 0;            private var _last:int;            private var _startTime:int;            private var _endTime:int;            private var _scene:Scenario;            private var _len:int;            private var _reset:Boolean;            public function LittleSelfMoveAction(self:LittleSelf, path:Array, scene:Scenario, startTime:int, endTime:int, reset:Boolean = false) { super(); }
            override public function connect(action:LittleAction) : Boolean { return false; }
            override public function prepare() : void { }
            override public function execute() : void { }
            override protected function finish() : void { }
            private function synchronous() : void { }
            override public function cancel() : void { }
   }}