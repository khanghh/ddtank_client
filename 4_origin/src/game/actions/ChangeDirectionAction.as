package game.actions
{
   import game.objects.GameLiving;
   import gameCommon.actions.BaseAction;
   import road.game.resource.ActionMovie;
   
   public class ChangeDirectionAction extends BaseAction
   {
       
      
      private var _living:GameLiving;
      
      private var _dir:int;
      
      private var _direction:String;
      
      public function ChangeDirectionAction(param1:GameLiving, param2:int)
      {
         super();
         _living = param1;
         _dir = param2;
         if(_dir > 0)
         {
            _direction = ActionMovie.RIGHT;
         }
         else
         {
            _direction = ActionMovie.LEFT;
         }
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
         if(!_living.actionMovie.shouldReplace)
         {
            _living.actionMovie.direction = _direction;
         }
         _isFinished = true;
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         _living.actionMovie.direction = _direction;
      }
   }
}
