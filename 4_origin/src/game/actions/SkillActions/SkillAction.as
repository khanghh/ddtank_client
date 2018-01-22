package game.actions.SkillActions
{
   import game.animations.IAnimate;
   import gameCommon.actions.BaseAction;
   
   public class SkillAction extends BaseAction
   {
       
      
      private var _animate:IAnimate;
      
      private var _onComplete:Function;
      
      private var _onCompleteParams:Array;
      
      public function SkillAction(param1:IAnimate, param2:Function = null, param3:Array = null)
      {
         super();
         _animate = param1;
         _onComplete = param2;
         _onCompleteParams = param3;
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
