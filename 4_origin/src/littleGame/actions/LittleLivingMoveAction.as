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
      
      public function LittleLivingMoveAction(param1:LittleLiving, param2:Array, param3:Scenario)
      {
         _scene = param3;
         _living = param1;
         _path = param2;
         _grid = _scene == null?null:_scene.grid;
         super();
      }
      
      override public function connect(param1:LittleAction) : Boolean
      {
         var _loc2_:* = null;
         if(param1 is InhaleAction)
         {
            cancel();
            return false;
         }
         if(param1 is LittleLivingMoveAction)
         {
            _loc2_ = param1 as LittleLivingMoveAction;
            _scene = _loc2_._scene;
            _living = _loc2_._living;
            _path = _loc2_._path;
            _grid = _loc2_._grid;
            _len = _loc2_._len;
            _idx = 0;
            return true;
         }
         return false;
      }
      
      override public function prepare() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_path)
         {
            _loc2_ = _path[0];
            _loc1_ = new Point(_loc2_.x,_loc2_.y);
            if(_living)
            {
               _living.setNextDirection(_loc1_);
               _living.pos = _loc1_;
            }
         }
         super.prepare();
      }
      
      override public function execute() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_path && _idx < _path.length)
         {
            _idx = Number(_idx) + 1;
            _loc2_ = _path[Number(_idx)];
            if(_loc2_)
            {
               _loc1_ = new Point(_loc2_.x,_loc2_.y);
               _living.setNextDirection(_loc1_);
               _living.pos = _loc1_;
            }
         }
         else
         {
            finish();
         }
      }
      
      override protected function finish() : void
      {
         var _loc1_:* = null;
         _living.doAction("stand");
         var _loc2_:Node = _path[_path.length - 1];
         if(_loc2_)
         {
            _loc1_ = new Point(_loc2_.x,_loc2_.y);
            _living.pos = _loc1_;
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
