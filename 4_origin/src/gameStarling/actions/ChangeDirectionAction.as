package gameStarling.actions
{
   import gameCommon.actions.BaseAction;
   import gameStarling.objects.GameLiving3D;
   
   public class ChangeDirectionAction extends BaseAction
   {
       
      
      private var _living:GameLiving3D;
      
      private var _dir:int;
      
      private var _direction:int;
      
      public function ChangeDirectionAction(param1:GameLiving3D, param2:int)
      {
         super();
         _living = param1;
         _dir = param2;
         _direction = _dir > 0?1:-1;
      }
      
      override public function canReplace(param1:BaseAction) : Boolean
      {
         var _loc2_:ChangeDirectionAction = param1 as ChangeDirectionAction;
         if(_loc2_ && _dir == _loc2_.dir)
         {
            return true;
         }
         return false;
      }
      
      override public function connect(param1:BaseAction) : Boolean
      {
         var _loc2_:ChangeDirectionAction = param1 as ChangeDirectionAction;
         if(_loc2_ && _dir == _loc2_.dir)
         {
            return true;
         }
         return false;
      }
      
      public function get dir() : int
      {
         return _dir;
      }
      
      override public function prepare() : void
      {
         if(_isPrepare)
         {
            return;
         }
         _isPrepare = true;
         if(!_living.isLiving)
         {
            _isFinished = true;
         }
      }
      
      override public function execute() : void
      {
         _living.info.direction = _direction;
         _isFinished = true;
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         _living.info.direction = _direction;
      }
   }
}
