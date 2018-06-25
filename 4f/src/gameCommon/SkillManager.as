package gameCommon{   import gameCommon.model.Living;   import gameCommon.model.Player;   import gameCommon.view.effects.BaseMirariEffectIcon;   import gameCommon.view.effects.LimitMaxForceEffectIcon;   import gameCommon.view.effects.ReduceStrengthEffect;   import road7th.comm.PackageIn;      public class SkillManager   {                   public function SkillManager() { super(); }
            public static function applySkillToLiving(skill:int, livingID:int, ... arg) : void { }
            public static function removeSkillFromLiving(skill:int, livingID:int, ... arg) : void { }
            private static function applyReduceStrength(livingid:int, strength:int) : void { }
            private static function applyLimitMaxForce(livingid:int, maxForce:int) : void { }
            private static function applyChangeTurnTime(livingid:int, time:int, reverse:int) : void { }
            private static function applyReduceDander(livingid:int, dander:int) : void { }
            private static function applyForbidFly(livingid:int) : void { }
            private static function applyResolveHurt(livingid:int, pkg:PackageIn) : void { }
            private static function removeResolveHurt(livingid:int, pkg:PackageIn) : void { }
            private static function applyRevert(livingid:int, pkg:PackageIn) : void { }
   }}