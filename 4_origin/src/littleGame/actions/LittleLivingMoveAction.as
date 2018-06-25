package littleGame.actions
{
   import ddt.ddt_internal;
   import flash.geom.Point;
   import littleGame.data.Grid;
   import littleGame.data.Node;
   import littleGame.model.LittleLiving;
   import littleGame.model.Scenario;
   
   use namespace ddt_internal;
   
   public class LittleLivingMoveAction extends LittleAction
   {
       
      
      protected var _path:Array;
      
      protected var _grid:Grid;
      
      protected var _idx:int = 0;
      
      protected var _scene:Scenario;
      
      protected var _len:int;
      
      protected var _totalTime:int;
      
      protected var _elapsed:int;
      
      public function LittleLivingMoveAction(living:LittleLiving, path:Array, scene:Scenario)
      {
         _scene = scene;
         _living = living;
         _path = path;
         _grid = _scene == null?null:_scene.grid;
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
         if(action is LittleLivingMoveAction)
         {
            act = action as LittleLivingMoveAction;
            _scene = act._scene;
            _living = act._living;
            _path = act._path;
            _grid = act._grid;
            _len = act._len;
            _idx = 0;
            return true;
         }
         return false;
      }
      
      override public function prepare() : void
      {
         var node:* = null;
         var nextPos:* = null;
         if(_path)
         {
            node = _path[0];
            nextPos = new Point(node.x,node.y);
            if(_living)
            {
               _living.setNextDirection(nextPos);
               _living.pos = nextPos;
            }
         }
         super.prepare();
      }
      
      override public function execute() : void
      {
         var node:* = null;
         var nextPos:* = null;
         if(_path && _idx < _path.length)
         {
            _idx = Number(_idx) + 1;
            node = _path[Number(_idx)];
            if(node)
            {
               nextPos = new Point(node.x,node.y);
               _living.setNextDirection(nextPos);
               _living.pos = nextPos;
            }
         }
         else
         {
            finish();
         }
      }
      
      override protected function finish() : void
      {
         var nextPos:* = null;
         _living.doAction("stand");
         var node:Node = _path[_path.length - 1];
         if(node)
         {
            nextPos = new Point(node.x,node.y);
            _living.pos = nextPos;
         }
         _living = null;
         _grid = null;
         _scene = null;
         _path = null;
         super.finish();
      }
      
      override public function cancel() : void
      {
         _isFinished = true;
         _living = null;
         _grid = null;
         _scene = null;
         _path = null;
      }
   }
}
