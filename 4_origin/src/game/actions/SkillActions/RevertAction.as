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
      
      public function RevertAction(animate:IAnimate, src:Living, pkg:PackageIn)
      {
         _pkg = pkg;
         _src = src;
         super(animate);
      }
      
      override protected function finish() : void
      {
         var i:int = 0;
         var count:int = _pkg.readInt();
         var livings:Vector.<Living> = new Vector.<Living>();
         for(i = 0; i < count; )
         {
            livings.push(GameControl.Instance.Current.findLiving(_pkg.readInt()));
            i++;
         }
         var addValue:int = _pkg.readInt();
         var _loc7_:int = 0;
         var _loc6_:* = livings;
         for each(var living in livings)
         {
            living.updateBlood(living.blood + addValue,0,addValue);
         }
         super.finish();
      }
   }
}
