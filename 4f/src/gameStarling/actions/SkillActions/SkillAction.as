package gameStarling.actions.SkillActions
{
   import gameCommon.actions.BaseAction;
   import gameStarling.animations.IAnimate;
   
   public class SkillAction extends BaseAction
   {
       
      
      private var _animate:IAnimate;
      
      private var _onComplete:Function;
      
      private var _onCompleteParams:Array;
      
      public function SkillAction(param1:IAnimate, param2:Function = null, param3:Array = null){super();}
      
      override public function execute() : void{}
      
      protected function finish() : void{}
   }
}
