package gameStarling.actions
{
   import gameCommon.actions.BaseAction;
   import gameStarling.objects.GameLiving3D;
   
   public class ChangeDirectionAction extends BaseAction
   {
       
      
      private var _living:GameLiving3D;
      
      private var _dir:int;
      
      private var _direction:int;
      
      public function ChangeDirectionAction(param1:GameLiving3D, param2:int){super();}
      
      override public function canReplace(param1:BaseAction) : Boolean{return false;}
      
      override public function connect(param1:BaseAction) : Boolean{return false;}
      
      public function get dir() : int{return 0;}
      
      override public function prepare() : void{}
      
      override public function execute() : void{}
      
      override public function executeAtOnce() : void{}
   }
}
