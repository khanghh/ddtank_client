package gameStarling.actions
{
   import gameCommon.actions.BaseAction;
   import gameStarling.objects.GameLiving3D;
   
   public class ChangeDirectionAction extends BaseAction
   {
       
      
      private var _living:GameLiving3D;
      
      private var _dir:int;
      
      private var _direction:int;
      
      public function ChangeDirectionAction(living:GameLiving3D, $dir:int)
      {
         super();
         _living = living;
         _dir = $dir;
         _direction = _dir > 0?1:-1;
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
