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
       
      
      public function SkillManager(){super();}
      
      public static function applySkillToLiving(param1:int, param2:int, ... rest) : void{}
      
      public static function removeSkillFromLiving(param1:int, param2:int, ... rest) : void{}
      
      private static function applyReduceStrength(param1:int, param2:int) : void{}
      
      private static function applyLimitMaxForce(param1:int, param2:int) : void{}
      
      private static function applyChangeTurnTime(param1:int, param2:int, param3:int) : void{}
      
      private static function applyReduceDander(param1:int, param2:int) : void{}
      
      private static function applyForbidFly(param1:int) : void{}
      
      private static function applyResolveHurt(param1:int, param2:PackageIn) : void{}
      
      private static function removeResolveHurt(param1:int, param2:PackageIn) : void{}
      
      private static function applyRevert(param1:int, param2:PackageIn) : void{}
   }
}
