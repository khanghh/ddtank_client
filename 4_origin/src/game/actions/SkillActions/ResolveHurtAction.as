package game.actions.SkillActions
{
   import game.animations.IAnimate;
   import gameCommon.GameControl;
   import gameCommon.MirariEffectIconManager;
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import road7th.comm.PackageIn;
   
   public class ResolveHurtAction extends SkillAction
   {
       
      
      private var _pkg:PackageIn;
      
      private var _scr:Living;
      
      public function ResolveHurtAction(param1:IAnimate, param2:Living, param3:PackageIn)
      {
         _pkg = param3;
         _scr = param2;
         super(param1);
      }
      
      override protected function finish() : void
      {
         var _loc2_:* = null;
         var _loc1_:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = null;
         var _loc3_:int = _pkg.readInt();
         _loc5_ = 0;
         while(_loc5_ < _loc3_)
         {
            _loc4_ = GameControl.Instance.Current.findLiving(_pkg.readInt());
            if(_loc4_.isPlayer() && _loc4_.isLiving)
            {
               _loc2_ = Player(_loc4_);
               _loc2_.handleMirariEffect(MirariEffectIconManager.getInstance().createEffectIcon(10));
            }
            _loc5_++;
         }
         _loc2_ = Player(_scr);
         _loc2_.handleMirariEffect(MirariEffectIconManager.getInstance().createEffectIcon(10));
         super.finish();
      }
   }
}
