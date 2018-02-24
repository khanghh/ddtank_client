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
      
      public function ChangeDirectionAction(param1:GameLiving, param2:int){super();}
      
      override public function canReplace(param1:BaseAction) : Boolean{return false;}
      
      override public function connect(param1:BaseAction) : Boolean{return false;}
      
      public function get dir() : int{return 0;}
      
      override public function prepare() : void{}
      
      override public function execute() : void{}
      
      override public function executeAtOnce() : void{}
   }
}
