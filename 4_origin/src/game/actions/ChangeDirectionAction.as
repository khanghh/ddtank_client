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
      
      public function ChangeDirectionAction(living:GameLiving, $dir:int)
      {
         super();
         _living = living;
         _dir = $dir;
         if(_dir > 0)
         {
            _direction = ActionMovie.RIGHT;
         }
         else
         {
            _direction = ActionMovie.LEFT;
         }
      }
      
      override public function canReplace(action:BaseAction) : Boolean
      {
         var act:ChangeDirectionAction = action as ChangeDirectionAction;
         if(act && _dir == act.dir)
         {
            return true;
         }
         return false;
      }
      
      override public function connect(action:BaseAction) : Boolean
      {
         var act:ChangeDirectionAction = action as ChangeDirectionAction;
         if(act && _dir == act.dir)
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
