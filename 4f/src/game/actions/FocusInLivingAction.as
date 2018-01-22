package game.actions
{
   import game.objects.GameLiving;
   import gameCommon.actions.BaseAction;
   
   public class FocusInLivingAction extends BaseAction
   {
       
      
      private var _gameLiving:GameLiving;
      
      public function FocusInLivingAction(param1:GameLiving){super();}
      
      override public function execute() : void{}
      
      override public function executeAtOnce() : void{}
   }
}
