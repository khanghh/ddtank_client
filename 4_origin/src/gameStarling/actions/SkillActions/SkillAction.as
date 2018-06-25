package gameStarling.actions.SkillActions
{
   import gameCommon.actions.BaseAction;
   import gameStarling.animations.IAnimate;
   
   public class SkillAction extends BaseAction
   {
       
      
      private var _animate:IAnimate;
      
      private var _onComplete:Function;
      
      private var _onCompleteParams:Array;
      
      public function SkillAction(animate:IAnimate, onComplete:Function = null, onCompleteParams:Array = null)
      {
         super();
         _animate = animate;
         _onComplete = onComplete;
         _onCompleteParams = onCompleteParams;
      }
      
      override public function execute() : void
      {
         if(_animate != null)
         {
            if(_animate.finish)
            {
               if(_onComplete != null)
               {
                  _onComplete.apply(null,_onCompleteParams);
               }
               finish();
            }
         }
         else
         {
            finish();
         }
      }
      
      protected function finish() : void
      {
         _isFinished = true;
      }
   }
}
