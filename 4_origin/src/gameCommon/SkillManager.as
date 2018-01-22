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
      
      public static function applySkillToLiving(param1:int, param2:int, ... rest) : void
      {
         switch(int(param1) - 1)
         {
            case 0:
               applyForbidFly(param2);
               break;
            case 1:
               applyReduceDander(param2,rest[0]);
               break;
            case 2:
               applyChangeTurnTime(param2,rest[0],rest[1]);
               break;
            case 3:
               applyLimitMaxForce(param2,rest[0]);
               break;
            case 4:
               applyReduceStrength(param2,rest[0]);
               break;
            case 5:
               applyResolveHurt(param2,rest[0]);
               break;
            case 6:
               applyRevert(param2,rest[0]);
         }
      }
      
      public static function removeSkillFromLiving(param1:int, param2:int, ... rest) : void
      {
         if(!(int(param1) - 6))
         {
            removeResolveHurt(param2,rest[0]);
         }
      }
      
      private static function applyReduceStrength(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:Living = GameControl.Instance.Current.findLiving(param1);
         if(_loc4_.isPlayer() && _loc4_.isLiving)
         {
            _loc3_ = MirariEffectIconManager.getInstance().createEffectIcon(12) as ReduceStrengthEffect;
            _loc3_.strength = param2;
            if(_loc3_ != null)
            {
            }
         }
      }
      
      private static function applyLimitMaxForce(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:Living = GameControl.Instance.Current.findLiving(param1);
         if(_loc4_.isPlayer() && _loc4_.isLiving)
         {
            _loc3_ = MirariEffectIconManager.getInstance().createEffectIcon(9) as LimitMaxForceEffectIcon;
            _loc3_.force = param2;
            if(_loc3_ != null)
            {
            }
         }
      }
      
      private static function applyChangeTurnTime(param1:int, param2:int, param3:int) : void
      {
         var _loc4_:* = null;
         var _loc5_:Living = GameControl.Instance.Current.findLiving(param1);
         if(_loc5_.isPlayer() && _loc5_.isLiving)
         {
            _loc4_ = _loc5_ as Player;
         }
      }
      
      private static function applyReduceDander(param1:int, param2:int) : void
      {
         var _loc3_:* = null;
         var _loc4_:Living = GameControl.Instance.Current.findLiving(param1);
         if(_loc4_.isPlayer() && _loc4_.isLiving)
         {
            _loc3_ = _loc4_ as Player;
            _loc3_.dander = param2;
         }
      }
      
      private static function applyForbidFly(param1:int) : void
      {
         var _loc3_:Living = GameControl.Instance.Current.findLiving(param1);
         var _loc2_:BaseMirariEffectIcon = MirariEffectIconManager.getInstance().createEffectIcon(8);
         if(_loc2_ != null && _loc3_.isLiving)
         {
         }
      }
      
      private static function applyResolveHurt(param1:int, param2:PackageIn) : void
      {
         var _loc3_:Living = GameControl.Instance.Current.findLiving(param1);
         if(_loc3_.isLiving)
         {
            _loc3_.applySkill(6,param2);
         }
      }
      
      private static function removeResolveHurt(param1:int, param2:PackageIn) : void
      {
         var _loc4_:* = null;
         var _loc6_:int = 0;
         var _loc5_:Living = GameControl.Instance.Current.findLiving(param1);
         if(_loc5_ && _loc5_.isPlayer() && _loc5_.isLiving)
         {
            _loc4_ = Player(_loc5_);
            _loc4_.removeSkillMovie(2);
            _loc4_.removeMirariEffect(MirariEffectIconManager.getInstance().createEffectIcon(10));
         }
         var _loc3_:int = param2.readInt();
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = GameControl.Instance.Current.findLiving(param2.readInt());
            if(_loc5_.isPlayer() && _loc5_.isLiving)
            {
               _loc4_ = Player(_loc5_);
               _loc4_.removeSkillMovie(2);
               _loc4_.removeMirariEffect(MirariEffectIconManager.getInstance().createEffectIcon(10));
            }
            _loc6_++;
         }
      }
      
      private static function applyRevert(param1:int, param2:PackageIn) : void
      {
         var _loc3_:Living = GameControl.Instance.Current.findLiving(param1);
         if(_loc3_.isLiving)
         {
            _loc3_.applySkill(7,param2);
         }
      }
   }
}
