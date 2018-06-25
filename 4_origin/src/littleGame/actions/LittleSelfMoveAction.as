package littleGame.actions
{
   import ddt.ddt_internal;
   import flash.geom.Point;
   import flash.utils.getTimer;
   import littleGame.LittleGameManager;
   import littleGame.data.Grid;
   import littleGame.data.Node;
   import littleGame.model.LittleSelf;
   import littleGame.model.Scenario;
   
   use namespace ddt_internal;
   
   public class LittleSelfMoveAction extends LittleAction
   {
       
      
      private var _self:LittleSelf;
      
      private var _path:Array;
      
      private var _grid:Grid;
      
      private var _idx:int = 0;
      
      private var _elapsed:int = 0;
      
      private var _last:int;
      
      private var _startTime:int;
      
      private var _endTime:int;
      
      private var _scene:Scenario;
      
      private var _len:int;
      
      private var _reset:Boolean;
      
      public function LittleSelfMoveAction(self:LittleSelf, path:Array, scene:Scenario, startTime:int, endTime:int, reset:Boolean = false)
      {
         _scene = scene;
         _self = self;
         _living = self;
         _path = path;
         _grid = _scene.grid;
         _startTime = startTime;
         _endTime = endTime;
         _len = _path.length;
         _reset = reset;
         super();
      }
      
      override public function connect(action:LittleAction) : Boolean
      {
         var act:* = null;
         if(action is InhaleAction)
         {
            cancel();
            return false;
         }
         if(action is LittleSelfMoveAction)
         {
            act = action as LittleSelfMoveAction;
            _scene = act._scene;
            _self = act._self;
            _path = act._path;
            _grid = act._grid;
            _startTime = act._startTime;
            _len = act._len;
            _idx = 0;
            return true;
         }
         return false;
      }
      
      override public function prepare() : void
      {
         LittleGameManager.Instance.Current.startSysnPos();
         var node:Node = _path[0];
         var nextPos:Point = new Point(node.x,node.y);
         _self.setNextDirection(nextPos);
         _self.pos = nextPos;
         super.prepare();
         _last = getTimer();
      }
      
      override public function execute() : void
      {
         var node:* = null;
         var nextPos:* = null;
         if(_idx < _path.length)
         {
            _idx = Number(_idx) + 1;
            node = _path[Number(_idx)];
            if(node)
            {
               nextPos = new Point(node.x,node.y);
               _self.setNextDirection(nextPos);
               _self.pos = nextPos;
            }
         }
         else
         {
            finish();
         }
      }
      
      override protected function finish() : void
      {
         if(_self.isBack)
         {
            _self.doAction("backStand");
         }
         else
         {
            _self.doAction("stand");
         }
         synchronous();
         LittleGameManager.Instance.Current.stopSysnPos();
         super.finish();
      }
      
      private function synchronous() : void
      {
         LittleGameManager.Instance.synchronousLivingPos(_self.pos.x,_self.pos.y);
      }
      
      override public function cancel() : void
      {
         _isFinished = true;
         _living = null;
      }
   }
}
