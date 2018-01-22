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
      
      public function LittleSelfMoveAction(param1:LittleSelf, param2:Array, param3:Scenario, param4:int, param5:int, param6:Boolean = false)
      {
         _scene = param3;
         _self = param1;
         _living = param1;
         _path = param2;
         _grid = _scene.grid;
         _startTime = param4;
         _endTime = param5;
         _len = _path.length;
         _reset = param6;
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
         if(param1 is LittleSelfMoveAction)
         {
            _loc2_ = param1 as LittleSelfMoveAction;
            _scene = _loc2_._scene;
            _self = _loc2_._self;
            _path = _loc2_._path;
            _grid = _loc2_._grid;
            _startTime = _loc2_._startTime;
            _len = _loc2_._len;
            _idx = 0;
            return true;
         }
         return false;
      }
      
      override public function prepare() : void
      {
         LittleGameManager.Instance.Current.startSysnPos();
         var _loc2_:Node = _path[0];
         var _loc1_:Point = new Point(_loc2_.x,_loc2_.y);
         _self.setNextDirection(_loc1_);
         _self.pos = _loc1_;
         super.prepare();
         _last = getTimer();
      }
      
      override public function execute() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         if(_idx < _path.length)
         {
            _idx = Number(_idx) + 1;
            _loc2_ = _path[Number(_idx)];
            if(_loc2_)
            {
               _loc1_ = new Point(_loc2_.x,_loc2_.y);
               _self.setNextDirection(_loc1_);
               _self.pos = _loc1_;
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
