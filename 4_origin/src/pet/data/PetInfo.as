package pet.data
{
   import com.pickgliss.loader.ModuleLoader;
   import flash.events.Event;
   import road7th.data.DictionaryData;
   
   public class PetInfo extends PetTemplateInfo
   {
      
      public static const HUNGER_CHANGED:String = "hunger";
      
      public static const GP_CHANGED:String = "gp";
      
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
      
      public var AttackGrow:int;
      
      public var DefenceGrow:int;
      
      public var LuckGrow:int;
      
      public var AgilityGrow:int;
      
      public var BloodGrow:int;
      
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
      
      public function set GP(param1:int) : void
      {
         if(_gp == param1)
         {
            return;
         }
         _gp = param1;
         dispatchEvent(new Event("gp"));
      }
      
      public function get GP() : int
      {
         return _gp;
      }
      
      public function set Hunger(param1:int) : void
      {
         if(param1 == _hunger)
         {
            return;
         }
         _hunger = param1;
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
      
      public function set breakBlood(param1:uint) : void
      {
         _breakBlood = param1;
      }
      
      public function get breakAttack() : uint
      {
         return _breakAttack;
      }
      
      public function set breakAttack(param1:uint) : void
      {
         _breakAttack = param1;
      }
      
      public function get breakDefence() : uint
      {
         return _breakDefence;
      }
      
      public function set breakDefence(param1:uint) : void
      {
         _breakDefence = param1;
      }
      
      public function get breakAgility() : uint
      {
         return _breakAgility;
      }
      
      public function set breakAgility(param1:uint) : void
      {
         _breakAgility = param1;
      }
      
      public function get breakLuck() : uint
      {
         return _breakLuck;
      }
      
      public function set breakLuck(param1:uint) : void
      {
         _breakLuck = param1;
      }
      
      public function get skills() : Array
      {
         return _skills.list.concat();
      }
      
      public function addSkill(param1:PetSkill) : void
      {
         _skills.add(param1.ID,param1);
      }
      
      public function clearSkills() : void
      {
         _skills.clear();
      }
      
      public function clearEquipedSkills() : void
      {
         _equipedSkills.clear();
      }
      
      public function removeSkillByID(param1:int) : void
      {
         _skills.remove(param1);
      }
      
      public function hasSkill(param1:int) : Boolean
      {
         return Boolean(_skills[param1]);
      }
      
      public function get actionMovieName() : String
      {
         return "pet.asset.game." + GameAssetUrl;
      }
      
      public function get assetReady() : Boolean
      {
         return ModuleLoader.hasDefinition(actionMovieName);
      }
   }
}
