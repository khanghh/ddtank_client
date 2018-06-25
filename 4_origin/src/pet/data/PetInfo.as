package pet.data
{
   import com.pickgliss.loader.ModuleLoader;
   import ddt.events.CEvent;
   import flash.events.Event;
   import road7th.data.DictionaryData;
   
   public class PetInfo extends PetTemplateInfo
   {
      
      public static const HUNGER_CHANGED:String = "hunger";
      
      public static const GP_CHANGED:String = "gp";
      
      public static const PET_GROW_CHANGE:String = "petGrowChange";
      
      public static const FULL_MAX_VALUE:int = 10000;
       
      
      public var ID:int;
      
      public var UserID:int;
      
      public var equipList:DictionaryData;
      
      private var _skills:DictionaryData;
      
      private var _equipedSkills:DictionaryData;
      
      public var Attack:int;
      
      public var Defence:int;
      
      public var Luck:int;
      
      public var Agility:int;
      
      public var Blood:int;
      
      public var Damage:int;
      
      public var Guard:int;
      
      private var _attackGrow:int;
      
      private var _defenceGrow:int;
      
      private var _luckGrow:int;
      
      private var _agilityGrow:int;
      
      private var _bloodGrow:int;
      
      public var DamageGrow:int;
      
      public var GuardGrow:int;
      
      public var currentStarExp:int;
      
      public var Level:int;
      
      public var breakGrade:int;
      
      private var _gp:int;
      
      public var MaxGP:int;
      
      private var _hunger:int;
      
      private var _breakBlood:uint;
      
      private var _breakAttack:uint;
      
      private var _breakDefence:uint;
      
      private var _breakAgility:uint;
      
      private var _breakLuck:uint;
      
      public var MaxActiveSkillCount:int;
      
      public var MaxStaticSkillCount:int;
      
      public var MaxSkillCount:int;
      
      public var PaySkillCount:int;
      
      public var Place:int;
      
      public var FightPower:int = 100;
      
      public var IsEquip:Boolean;
      
      public var PetHappyStar:int;
      
      public function PetInfo()
      {
         super();
         equipList = new DictionaryData();
         _skills = new DictionaryData();
         _equipedSkills = new DictionaryData();
      }
      
      public function get equipdSkills() : DictionaryData
      {
         return _equipedSkills;
      }
      
      public function get AttackGrow() : int
      {
         return _attackGrow;
      }
      
      public function set AttackGrow(value:int) : void
      {
         if(_attackGrow == value)
         {
            return;
         }
         _attackGrow = value;
         this.dispatchEvent(new CEvent("petGrowChange","AttackGrow"));
      }
      
      public function get DefenceGrow() : int
      {
         return _defenceGrow;
      }
      
      public function set DefenceGrow(value:int) : void
      {
         if(_defenceGrow == value)
         {
            return;
         }
         _defenceGrow = value;
         this.dispatchEvent(new CEvent("petGrowChange","DefenceGrow"));
      }
      
      public function get LuckGrow() : int
      {
         return _luckGrow;
      }
      
      public function set LuckGrow(value:int) : void
      {
         if(_luckGrow == value)
         {
            return;
         }
         _luckGrow = value;
         this.dispatchEvent(new CEvent("petGrowChange","LuckGrow"));
      }
      
      public function get AgilityGrow() : int
      {
         return _agilityGrow;
      }
      
      public function set AgilityGrow(value:int) : void
      {
         if(_agilityGrow == value)
         {
            return;
         }
         _agilityGrow = value;
         this.dispatchEvent(new CEvent("petGrowChange","AgilityGrow"));
      }
      
      public function get BloodGrow() : int
      {
         return _bloodGrow;
      }
      
      public function set BloodGrow(value:int) : void
      {
         if(_bloodGrow == value)
         {
            return;
         }
         _bloodGrow = value;
         this.dispatchEvent(new CEvent("petGrowChange","BloodGrow"));
      }
      
      public function set GP(val:int) : void
      {
         if(_gp == val)
         {
            return;
         }
         _gp = val;
         dispatchEvent(new Event("gp"));
      }
      
      public function get GP() : int
      {
         return _gp;
      }
      
      public function set Hunger(val:int) : void
      {
         if(val == _hunger)
         {
            return;
         }
         _hunger = val;
         dispatchEvent(new Event("hunger"));
      }
      
      public function get Hunger() : int
      {
         return _hunger;
      }
      
      public function get breakBlood() : uint
      {
         return _breakBlood;
      }
      
      public function set breakBlood(value:uint) : void
      {
         _breakBlood = value;
      }
      
      public function get breakAttack() : uint
      {
         return _breakAttack;
      }
      
      public function set breakAttack(value:uint) : void
      {
         _breakAttack = value;
      }
      
      public function get breakDefence() : uint
      {
         return _breakDefence;
      }
      
      public function set breakDefence(value:uint) : void
      {
         _breakDefence = value;
      }
      
      public function get breakAgility() : uint
      {
         return _breakAgility;
      }
      
      public function set breakAgility(value:uint) : void
      {
         _breakAgility = value;
      }
      
      public function get breakLuck() : uint
      {
         return _breakLuck;
      }
      
      public function set breakLuck(value:uint) : void
      {
         _breakLuck = value;
      }
      
      public function get skills() : Array
      {
         return _skills.list.concat();
      }
      
      public function addSkill(skill:PetSkill) : void
      {
         _skills.add(skill.ID,skill);
      }
      
      public function clearSkills() : void
      {
         _skills.clear();
      }
      
      public function clearEquipedSkills() : void
      {
         _equipedSkills.clear();
      }
      
      public function removeSkillByID(skillID:int) : void
      {
         _skills.remove(skillID);
      }
      
      public function hasSkill(skillID:int) : Boolean
      {
         return Boolean(_skills[skillID]);
      }
      
      public function get actionMovieName() : String
      {
         return "pet.asset.game." + GameAssetUrl;
      }
      
      public function get assetReady() : Boolean
      {
         return ModuleLoader.hasDefinition(actionMovieName);
      }
      
      public function get BloodGrowDatum() : int
      {
         var hpdatum:int = Number((BloodGrow - LowBloodGrow) * 100) / (Number(HighBloodGrow - LowBloodGrow));
         return hpdatum;
      }
      
      public function get AttackGrowDatum() : int
      {
         var attack:int = Number((AttackGrow - LowAttackGrow) * 100) / (Number(HighAttackGrow - LowAttackGrow));
         return attack;
      }
      
      public function get DefenceGrowDatum() : int
      {
         var defence:int = Number((DefenceGrow - LowDefenceGrow) * 100) / (Number(HighDefenceGrow - LowDefenceGrow));
         return defence;
      }
      
      public function get AgilityGrowDatum() : int
      {
         var agility:int = Number((AgilityGrow - LowAgilityGrow) * 100) / (Number(HighAgilityGrow - LowAgilityGrow));
         return agility;
      }
      
      public function get LuckGrowDatum() : int
      {
         var luck:int = Number((LuckGrow - LowLuckGrow) * 100) / (Number(HighLuckGrow - LowLuckGrow));
         return luck;
      }
      
      public function get petGraded() : Number
      {
         var hpdatum:Number = Number((BloodGrow - LowBloodGrow) * 100) / (Number(HighBloodGrow - LowBloodGrow));
         var attack:Number = Number((AttackGrow - LowAttackGrow) * 100) / (Number(HighAttackGrow - LowAttackGrow));
         var defence:Number = Number((DefenceGrow - LowDefenceGrow) * 100) / (Number(HighDefenceGrow - LowDefenceGrow));
         var agility:Number = Number((AgilityGrow - LowAgilityGrow) * 100) / (Number(HighAgilityGrow - LowAgilityGrow));
         var luck:Number = Number((LuckGrow - LowLuckGrow) * 100) / (Number(HighLuckGrow - LowLuckGrow));
         return (hpdatum + attack + defence + agility + luck) / 5;
      }
   }
}
