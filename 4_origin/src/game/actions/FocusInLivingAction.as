package game.actions
{
   import game.objects.GameLiving;
   import gameCommon.actions.BaseAction;
   
   public class FocusInLivingAction extends BaseAction
   {
       
      
      private var _gameLiving:GameLiving;
      
      public function FocusInLivingAction(gameLiving:GameLiving)
      {
         super();
         _gameLiving = gameLiving;
      }
      
      override public function execute() : void
      {
         if(_gameLiving)
         {
            _gameLiving.needFocus(0,0,{"priority":3});
         }
         _isFinished = true;
         _gameLiving = null;
      }
      
      override public function executeAtOnce() : void
      {
         super.executeAtOnce();
         execute();
      }
   }
}
