package ddt.data
{
   public class BuffType
   {
      
      public static const BAR_BUFF:int = 6;
      
      public static const PET_BUFF:int = 5;
      
      public static const CARD_BUFF:int = 4;
      
      public static const CONSORTIA:int = 3;
      
      public static const Pay:int = 2;
      
      public static const Local:int = 1;
      
      public static const Turn:int = 0;
      
      public static const LockState:int = 1000;
      
      public static const Tired:int = 1;
      
      public static const Firing:int = 2;
      
      public static const LockAngel:int = 3;
      
      public static const Weakness:int = 4;
      
      public static const NoHole:int = 5;
      
      public static const Defend:int = 6;
      
      public static const Targeting:int = 7;
      
      public static const DisenableFly:int = 8;
      
      public static const LimitMaxForce:int = 9;
      
      public static const ResolveHurt:int = 10;
      
      public static const CustomAddGuard:int = 11;
      
      public static const AddDamage:int = 12;
      
      public static const TurnAddDander:int = 13;
      
      public static const AddCritical:int = 14;
      
      public static const ExemptEnergy:int = 15;
      
      public static const AddDander:int = 16;
      
      public static const AddProperty:int = 17;
      
      public static const AddMaxBlood:int = 18;
      
      public static const ReduceDamage:int = 19;
      
      public static const AddPercentDamage:int = 20;
      
      public static const SetDefaultDander:int = 21;
      
      public static const ReduceContinueDamage:int = 22;
      
      public static const DoNotMove:int = 23;
      
      public static const AddPercentDefance:int = 24;
      
      public static const ReducePoisoning:int = 25;
      
      public static const AddBloodGunCount:int = 26;
      
      public static const ResistAttack:int = 27;
      
      public static const SACRED_BLESSING:int = 31;
      
      public static const SACRED_SHIELD:int = 32;
      
      public static const NIUTOU:int = 33;
      
      public static const INDIAN:int = 34;
      
      public static const ConsortionAddBloodGunCount:int = 101;
      
      public static const ConsortionAddDamage:int = 102;
      
      public static const ConsortionAddCritical:int = 103;
      
      public static const ConsortionAddMaxBlood:int = 104;
      
      public static const ConsortionAddProperty:int = 105;
      
      public static const ConsortionReduceEnergyUse:int = 106;
      
      public static const ConsortionAddEnergy:int = 107;
      
      public static const ConsortionAddEffectTurn:int = 108;
      
      public static const ConsortionAddOfferRate:int = 109;
      
      public static const ConsortionAddPercentGoldOrGP:int = 110;
      
      public static const ConsortionAddSpellCount:int = 111;
      
      public static const ConsortionReduceDander:int = 112;
      
      public static const ActivityDungeonBubble:int = 114;
      
      public static const ActivityDungeonNet:int = 115;
      
      public static const WorldBossHP:int = 400;
      
      public static const WorldBossHP_MoneyBuff:int = 402;
      
      public static const WorldBossAttrack:int = 401;
      
      public static const WorldBossAttrack_MoneyBuff:int = 403;
      
      public static const WorldBossMetalSlug:int = 404;
      
      public static const WorldBossAncientBlessings:int = 405;
      
      public static const WorldBossAddDamage:int = 406;
      
      public static const BEING_KILLED_ADD_BLOOD:int = 408;
       
      
      public function BuffType(){super();}
      
      public static function isPayBuff(param1:int) : Boolean{return false;}
      
      public static function isLuckyBuff(param1:int) : Boolean{return false;}
      
      public static function isLocalBuffByID(param1:int) : Boolean{return false;}
   }
}
