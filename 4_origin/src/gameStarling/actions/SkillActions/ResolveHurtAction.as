package gameStarling.actions.SkillActions
{
   import gameCommon.GameControl;
   import gameCommon.MirariEffectIconManager;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameStarling.animations.IAnimate;
   import road7th.comm.PackageIn;
   
   public class ResolveHurtAction extends SkillAction
   {
       
      
      private var _pkg:PackageIn;
      
      private var _scr:Living;
      
      public function ResolveHurtAction(animate:IAnimate, src:Living, pkg:PackageIn)
      {
         _pkg = pkg;
         _scr = src;
         super(animate);
      }
      
      override protected function finish() : void
      {
         var player:* = null;
         var effect:* = null;
         var i:int = 0;
         var living:* = null;
         var count:int = _pkg.readInt();
         for(i = 0; i < count; )
         {
            living = GameControl.Instance.Current.findLiving(_pkg.readInt());
            if(living.isPlayer() && living.isLiving)
            {
               player = Player(living);
               player.handleMirariEffect(MirariEffectIconManager.getInstance().createEffectIcon(10));
            }
            i++;
         }
         player = Player(_scr);
         player.handleMirariEffect(MirariEffectIconManager.getInstance().createEffectIcon(10));
         super.finish();
      }
   }
}
