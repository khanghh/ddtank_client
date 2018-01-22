package littleGame.actions
{
   import littleGame.LittleGameManager;
   import littleGame.model.LittlePlayer;
   import littleGame.model.LittleSelf;
   import littleGame.model.Scenario;
   import road7th.comm.PackageIn;
   
   public class InhaleAction extends LittleLivingMoveAction
   {
       
      
      private var _life:int = 0;
      
      private var _lifeTime:int = 0;
      
      private var _x:int;
      
      private var _y:int;
      
      private var _dx:int;
      
      private var _dy:int;
      
      private var _endAction:String;
      
      private var _direction:String;
      
      private var _headType:int;
      
      public function InhaleAction()
      {
         super(null,null,null);
      }
      
      override public function parsePackege(param1:Scenario, param2:PackageIn = null) : void
      {
         _scene = param1;
         _grid = _scene != null?_scene.grid:null;
         var _loc3_:int = param2.readInt();
         _endAction = param2.readUTF();
         _direction = param2.readUTF();
         _life = param2.readInt();
         _dx = param2.readInt();
         _dy = param2.readInt();
         _living = _scene != null?_scene.findLiving(_loc3_):null;
         if(_living != null)
         {
            _living.act(this);
            if(_living)
            {
               _living.dx = _dx;
               _living.dy = _dy;
            }
         }
      }
      
      override public function prepare() : void
      {
         if(_living)
         {
            _path = LittleGameManager.Instance.fillPath(_living,_grid,_living.pos.x,_living.pos.y,_dx,_dy);
            _living.dx = _dx;
            _living.dy = _dy;
            if(_path == null)
            {
               finish();
               return;
            }
            _living.MotionState = 1;
            if(_living.isSelf)
            {
               LittleSelf(_living).inhaled = true;
            }
            if(_living.isSelf)
            {
               LittleGameManager.Instance.Current.startSysnPos();
            }
         }
         _headType = Math.random() * 10000 % 3;
         super.prepare();
      }
      
      public function toString() : String
      {
         return "[InhaleAction_" + _living + ":(dx:" + _dx + ";dy:" + _dy + ";len:" + (_path == null?"":_path.length) + ";life:" + _life + ";endAction:" + _endAction + ")]";
      }
      
      override public function execute() : void
      {
         if(_living && _living.lock)
         {
            finish();
         }
         else if(_living && _life > 0)
         {
            _living.direction = _direction;
            if(_living.isPlayer)
            {
               LittlePlayer(_living).headType = _headType;
            }
            _living.doAction(_endAction);
            _lifeTime = Number(_lifeTime) + 1;
            if(_lifeTime >= _life)
            {
               finish();
            }
         }
         else if(_living)
         {
            super.execute();
         }
      }
      
      override protected function finish() : void
      {
         _isFinished = true;
         if(_life > 0)
         {
            _living.MotionState = 2;
            _living.doAction("stand");
         }
         else
         {
            _living.direction = _direction;
            if(_living.isPlayer)
            {
               LittlePlayer(_living).headType = _headType;
            }
            _living.doAction(_endAction);
         }
         if(_living.isSelf)
         {
            synchronous();
            LittleGameManager.Instance.Current.stopSysnPos();
         }
         _living = null;
      }
      
      private function synchronous() : void
      {
         LittleGameManager.Instance.synchronousLivingPos(_living.pos.x,_living.pos.y);
      }
   }
}
