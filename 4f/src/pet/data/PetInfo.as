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
      
      public function PetInfo(){super();}
      
      public function get equipdSkills() : DictionaryData{return null;}
      
      public function set GP(param1:int) : void{}
      
      public function get GP() : int{return 0;}
      
      public function set Hunger(param1:int) : void{}
      
      public function get Hunger() : int{return 0;}
      
      public function get breakBlood() : uint{return null;}
      
      public function set breakBlood(param1:uint) : void{}
      
      public function get breakAttack() : uint{return null;}
      
      public function set breakAttack(param1:uint) : void{}
      
      public function get breakDefence() : uint{return null;}
      
      public function set breakDefence(param1:uint) : void{}
      
      public function get breakAgility() : uint{return null;}
      
      public function set breakAgility(param1:uint) : void{}
      
      public function get breakLuck() : uint{return null;}
      
      public function set breakLuck(param1:uint) : void{}
      
      public function get skills() : Array{return null;}
      
      public function addSkill(param1:PetSkill) : void{}
      
      public function clearSkills() : void{}
      
      public function clearEquipedSkills() : void{}
      
      public function removeSkillByID(param1:int) : void{}
      
      public function hasSkill(param1:int) : Boolean{return false;}
      
      public function get actionMovieName() : String{return null;}
      
      public function get assetReady() : Boolean{return false;}
   }
}
