package gameStarling.actions
{
   import gameCommon.actions.BaseAction;
   import gameStarling.objects.GameLiving3D;
   
   public class FocusInLivingAction extends BaseAction
   {
       
      
      private var _gameLiving:GameLiving3D;
      
      public function FocusInLivingAction(param1:GameLiving3D)
      {
         super();
         _gameLiving = param1;
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
