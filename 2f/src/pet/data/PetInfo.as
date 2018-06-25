package pet.data{   import com.pickgliss.loader.ModuleLoader;   import ddt.events.CEvent;   import flash.events.Event;   import road7th.data.DictionaryData;      public class PetInfo extends PetTemplateInfo   {            public static const HUNGER_CHANGED:String = "hunger";            public static const GP_CHANGED:String = "gp";            public static const PET_GROW_CHANGE:String = "petGrowChange";            public static const FULL_MAX_VALUE:int = 10000;                   public var ID:int;            public var UserID:int;            public var equipList:DictionaryData;            private var _skills:DictionaryData;            private var _equipedSkills:DictionaryData;            public var Attack:int;            public var Defence:int;            public var Luck:int;            public var Agility:int;            public var Blood:int;            public var Damage:int;            public var Guard:int;            private var _attackGrow:int;            private var _defenceGrow:int;            private var _luckGrow:int;            private var _agilityGrow:int;            private var _bloodGrow:int;            public var DamageGrow:int;            public var GuardGrow:int;            public var currentStarExp:int;            public var Level:int;            public var breakGrade:int;            private var _gp:int;            public var MaxGP:int;            private var _hunger:int;            private var _breakBlood:uint;            private var _breakAttack:uint;            private var _breakDefence:uint;            private var _breakAgility:uint;            private var _breakLuck:uint;            public var MaxActiveSkillCount:int;            public var MaxStaticSkillCount:int;            public var MaxSkillCount:int;            public var PaySkillCount:int;            public var Place:int;            public var FightPower:int = 100;            public var IsEquip:Boolean;            public var PetHappyStar:int;            public function PetInfo() { super(); }
            public function get equipdSkills() : DictionaryData { return null; }
            public function get AttackGrow() : int { return 0; }
            public function set AttackGrow(value:int) : void { }
            public function get DefenceGrow() : int { return 0; }
            public function set DefenceGrow(value:int) : void { }
            public function get LuckGrow() : int { return 0; }
            public function set LuckGrow(value:int) : void { }
            public function get AgilityGrow() : int { return 0; }
            public function set AgilityGrow(value:int) : void { }
            public function get BloodGrow() : int { return 0; }
            public function set BloodGrow(value:int) : void { }
            public function set GP(val:int) : void { }
            public function get GP() : int { return 0; }
            public function set Hunger(val:int) : void { }
            public function get Hunger() : int { return 0; }
            public function get breakBlood() : uint { return null; }
            public function set breakBlood(value:uint) : void { }
            public function get breakAttack() : uint { return null; }
            public function set breakAttack(value:uint) : void { }
            public function get breakDefence() : uint { return null; }
            public function set breakDefence(value:uint) : void { }
            public function get breakAgility() : uint { return null; }
            public function set breakAgility(value:uint) : void { }
            public function get breakLuck() : uint { return null; }
            public function set breakLuck(value:uint) : void { }
            public function get skills() : Array { return null; }
            public function addSkill(skill:PetSkill) : void { }
            public function clearSkills() : void { }
            public function clearEquipedSkills() : void { }
            public function removeSkillByID(skillID:int) : void { }
            public function hasSkill(skillID:int) : Boolean { return false; }
            public function get actionMovieName() : String { return null; }
            public function get assetReady() : Boolean { return false; }
            public function get BloodGrowDatum() : int { return 0; }
            public function get AttackGrowDatum() : int { return 0; }
            public function get DefenceGrowDatum() : int { return 0; }
            public function get AgilityGrowDatum() : int { return 0; }
            public function get LuckGrowDatum() : int { return 0; }
            public function get petGraded() : Number { return 0; }
   }}