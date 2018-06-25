package gameCommon
{
   import gameCommon.model.Living;
   import gameCommon.model.Player;
   import gameCommon.view.effects.BaseMirariEffectIcon;
   import gameCommon.view.effects.LimitMaxForceEffectIcon;
   import gameCommon.view.effects.ReduceStrengthEffect;
   import road7th.comm.PackageIn;
   
   public class SkillManager
   {
       
      
      public function SkillManager()
      {
         super();
      }
      
      public static function applySkillToLiving(skill:int, livingID:int, ... arg) : void
      {
         switch(int(skill) - 1)
         {
            case 0:
               applyForbidFly(livingID);
               break;
            case 1:
               applyReduceDander(livingID,arg[0]);
               break;
            case 2:
               applyChangeTurnTime(livingID,arg[0],arg[1]);
               break;
            case 3:
               applyLimitMaxForce(livingID,arg[0]);
               break;
            case 4:
               applyReduceStrength(livingID,arg[0]);
               break;
            case 5:
               applyResolveHurt(livingID,arg[0]);
               break;
            case 6:
               applyRevert(livingID,arg[0]);
         }
      }
      
      public static function removeSkillFromLiving(skill:int, livingID:int, ... arg) : void
      {
         if(!(int(skill) - 6))
         {
            removeResolveHurt(livingID,arg[0]);
         }
      }
      
      private static function applyReduceStrength(livingid:int, strength:int) : void
      {
         var effect:* = null;
         var living:Living = GameControl.Instance.Current.findLiving(livingid);
         if(living.isPlayer() && living.isLiving)
         {
            effect = MirariEffectIconManager.getInstance().createEffectIcon(12) as ReduceStrengthEffect;
            effect.strength = strength;
            if(effect != null)
            {
            }
         }
      }
      
      private static function applyLimitMaxForce(livingid:int, maxForce:int) : void
      {
         var effect:* = null;
         var living:Living = GameControl.Instance.Current.findLiving(livingid);
         if(living.isPlayer() && living.isLiving)
         {
            effect = MirariEffectIconManager.getInstance().createEffectIcon(9) as LimitMaxForceEffectIcon;
            effect.force = maxForce;
            if(effect != null)
            {
            }
         }
      }
      
      private static function applyChangeTurnTime(livingid:int, time:int, reverse:int) : void
      {
         var player:* = null;
         var living:Living = GameControl.Instance.Current.findLiving(livingid);
         if(living.isPlayer() && living.isLiving)
         {
            player = living as Player;
         }
      }
      
      private static function applyReduceDander(livingid:int, dander:int) : void
      {
         var player:* = null;
         var living:Living = GameControl.Instance.Current.findLiving(livingid);
         if(living.isPlayer() && living.isLiving)
         {
            player = living as Player;
            player.dander = dander;
         }
      }
      
      private static function applyForbidFly(livingid:int) : void
      {
         var living:Living = GameControl.Instance.Current.findLiving(livingid);
         var baseEffect:BaseMirariEffectIcon = MirariEffectIconManager.getInstance().createEffectIcon(8);
         if(baseEffect != null && living.isLiving)
         {
         }
      }
      
      private static function applyResolveHurt(livingid:int, pkg:PackageIn) : void
      {
         var living:Living = GameControl.Instance.Current.findLiving(livingid);
         if(living.isLiving)
         {
            living.applySkill(6,pkg);
         }
      }
      
      private static function removeResolveHurt(livingid:int, pkg:PackageIn) : void
      {
         var player:* = null;
         var i:int = 0;
         var living:Living = GameControl.Instance.Current.findLiving(livingid);
         if(living && living.isPlayer() && living.isLiving)
         {
            player = Player(living);
            player.removeSkillMovie(2);
            player.removeMirariEffect(MirariEffectIconManager.getInstance().createEffectIcon(10));
         }
         var count:int = pkg.readInt();
         for(i = 0; i < count; )
         {
            living = GameControl.Instance.Current.findLiving(pkg.readInt());
            if(living.isPlayer() && living.isLiving)
            {
               player = Player(living);
               player.removeSkillMovie(2);
               player.removeMirariEffect(MirariEffectIconManager.getInstance().createEffectIcon(10));
            }
            i++;
         }
      }
      
      private static function applyRevert(livingid:int, pkg:PackageIn) : void
      {
         var living:Living = GameControl.Instance.Current.findLiving(livingid);
         if(living.isLiving)
         {
            living.applySkill(7,pkg);
         }
      }
   }
}
