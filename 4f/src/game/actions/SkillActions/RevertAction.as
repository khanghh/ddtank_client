package game.actions.SkillActions
{
   import game.animations.IAnimate;
   import gameCommon.GameControl;
   import gameCommon.model.Living;
   import road7th.comm.PackageIn;
   
   public class RevertAction extends SkillAction
   {
       
      
      private var _pkg:PackageIn;
      
      private var _src:Living;
      
      public function RevertAction(param1:IAnimate, param2:Living, param3:PackageIn){super(null);}
      
      override protected function finish() : void{}
   }
}
