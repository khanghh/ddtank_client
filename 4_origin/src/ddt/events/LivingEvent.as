package ddt.events
{
   import flash.events.Event;
   
   public class LivingEvent extends Event
   {
      
      public static const SPECIAL_DO_ACTION:String = "special_do_action";
      
      public static const POS_CHANGED:String = "posChanged";
      
      public static const DIR_CHANGED:String = "dirChanged";
      
      public static const FORZEN_CHANGED:String = "forzenChanged";
      
      public static const BACK_EFFECT_CHANGE:String = "backEffectChange";
      
      public static const SOLIDICE_STATECHANGED:String = "solidiceStateChanged";
      
      public static const TARGET_STEALTH_STATECHANGED:String = "targetStealthStateChanged";
      
      public static const DISTURB_STATECHANGED:String = "DisturbStateChanged";
      
      public static const ENABLE_SPELLKILL:String = "enableSpellKill";
      
      public static const NOTUSE_BATTLESKILL:String = "notUseBattleSkill";
      
      public static const ADD_SKILLBUFF_BAR:String = "addSkillBuffBar";
      
      public static const GEM_DEFENSE_CHANGED:String = "gemDefenseChanged";
      
      public static const GEM_GLOW_CHANGED:String = "gemGlowChanged";
      
      public static const HIDDEN_CHANGED:String = "hiddenChanged";
      
      public static const MARK_ME_HIDE_DEST:String = "mark_me_hide_dest";
      
      public static const NOHOLE_CHANGED:String = "noholeChanged";
      
      public static const DIE:String = "die";
      
      public static const ANGLE_CHANGED:String = "angleChanged";
      
      public static const BLOOD_CHANGED:String = "bloodChanged";
      
      public static const BEGIN_NEW_TURN:String = "beginNewTurn";
      
      public static const SHOOT:String = "shoot";
      
      public static const BEAT:String = "beat";
      
      public static const TRANSMIT:String = "transmit";
      
      public static const SHOW_ATTACK_EFFECT:String = "showAttackEffect";
      
      public static const MOVE_TO:String = "moveTo";
      
      public static const FALL:String = "fall";
      
      public static const JUMP:String = "jump";
      
      public static const SAY:String = "say";
      
      public static const START_MOVING:String = "startMoving";
      
      public static const LOCK_STATE:String = "lockState";
      
      public static const CHANGE_POS:String = "changePosition";
      
      public static const ATTACKING_CHANGED:String = "attackingChanged";
      
      public static const LOADING_PROGRESS:String = "loadingProgress";
      
      public static const BEGIN_SHOOT:String = "beginShoot";
      
      public static const ADD_STATE:String = "addState";
      
      public static const USING_ITEM:String = "usingItem";
      
      public static const USING_SPECIAL_SKILL:String = "usingSpecialSkill";
      
      public static const DANDER_CHANGED:String = "danderChanged";
      
      public static const BOMB_CHANGED:String = "bombChanged";
      
      public static const THREEKILL_CHANGED:String = "threekillChanged";
      
      public static const SPELLKILL_CHANGED:String = "spellkillChanged";
      
      public static const PROPENABLED_CHANGED:String = "propenabledChanged";
      
      public static const PETSKILL_ENABLED_CHANGED:String = "petSkillenabledChanged";
      
      public static const SOUL_PROP_ENABEL_CHANGED:String = "soulPropEnableChanged";
      
      public static const ENERGY_CHANGED:String = "energyChanged";
      
      public static const CUSTOMENABLED_CHANGED:String = "customenabledChanged";
      
      public static const RIGHTENABLED_CHANGED:String = "rightenabledChanged";
      
      public static const SETCENTER:String = "setCenter";
      
      public static const PETSKILL_USED_FAIL:String = "petSkillUsedFail";
      
      public static const PSYCHIC_CHANGED:String = "psychicChanged";
      
      public static const GUNANGLE_CHANGED:String = "gunangleChanged";
      
      public static const FORCE_CHANGED:String = "forceChanged";
      
      public static const SKIP:String = "skip";
      
      public static const SEND_SHOOT_ACTION:String = "sendShootAction";
      
      public static const PLAY_MOVIE:String = "playmovie";
      
      public static const TURN_ROTATION:String = "turnrotation";
      
      public static const MODEL_CHANGED:String = "modelChanged";
      
      public static const DEFAULT_ACTION_CHANGED:String = "defaultActionChanged";
      
      public static const PLAYER_MOVETO:String = "playerMoveto";
      
      public static const CHANGE_STATE:String = "changeState";
      
      public static const ACT_ACTION:String = "actAction";
      
      public static const LOCKFLY_CHANGED:String = "lockFlyChanged";
      
      public static const FLY_CHANGED:String = "flyChanged";
      
      public static const DEPUTYWEAPON_CHANGED:String = "deputyweapin_Changed";
      
      public static const REVERSE_CHANGED:String = "reverseChanged";
      
      public static const PLAYSKILLANIMATE:String = "playSkillAnimate";
      
      public static const PLAYSKILLMOVIE:String = "playskillMovie";
      
      public static const REMOVESKILLMOVIE:String = "removeSkillMovie";
      
      public static const PLAY_CONTINUOUS_EFFECT:String = "playContinuousEffect";
      
      public static const REMOVE_CONTINUOUS_EFFECT:String = "removeContinuousEffect";
      
      public static const SHOW_MARK:String = "showMark";
      
      public static const APPLY_SKILL:String = "applySkill";
      
      public static const MAX_HP_CHANGED:String = "maxHpChanged";
      
      public static const BUFF_CHANGED:String = "buffChanged";
      
      public static const BOX_PICK:String = "boxPick";
      
      public static const LOCKANGLE_CHANGE:String = "lockAngleChange";
      
      public static const BOMBED:String = "bombed";
      
      public static const MAXFORCE_CHANGED:String = "maxforceChanged";
      
      public static const USE_PET_SKILL:String = "usePetSkill";
      
      public static const PET_MP_CHANGE:String = "petEnergyChange";
      
      public static const PET_BEAT:String = "petBeat";
      
      public static const IS_CALCFORCE_CHANGE:String = "isCalcForceChange";
      
      public static const PLAYER_DO_ACTION:String = "playerDoAction";
      
      public static const FIGHTPOWER_CHANGE:String = "fightPowerChange";
      
      public static const WISHSELECT_CHANGE:String = "wishSelectChange";
      
      public static const REVIVE:String = "livingRevive";
      
      public static const HORSE_SKILL_USE:String = "horseSkillUse";
      
      public static const PLAY_DEAD_EFFECT:String = "playDeadEffect";
      
      public static const ISREDSKULL_CHANGE:String = "isRedSkullChange";
      
      public static const CHECK_COLLIDE:String = "checkCollide";
      
      public static const VISIABLE_DYNAMISMBAR:String = "visiableDynamismBar";
      
      public static const UPDATE_FLAG_NUM:String = "updateFlagNum";
      
      public static const UPDATE_FEIGN_DEATH_STATE:String = "updateFeignDeathState";
       
      
      private var _value:Number;
      
      private var _old:Number;
      
      private var _paras:Array;
      
      public function LivingEvent(type:String, value:Number = 0, old:Number = 0, ... arg)
      {
         super(type);
         _value = value;
         _old = old;
         _paras = arg;
      }
      
      public function get value() : Number
      {
         return _value;
      }
      
      public function get old() : Number
      {
         return _old;
      }
      
      public function get paras() : Array
      {
         return _paras;
      }
   }
}
