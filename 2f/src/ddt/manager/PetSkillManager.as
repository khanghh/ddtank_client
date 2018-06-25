package ddt.manager{   import com.pickgliss.utils.ObjectUtils;   import ddt.data.analyze.PetSkillAnalyzer;   import flash.utils.Dictionary;   import pet.data.PetSkill;   import pet.data.PetSkillTemplateInfo;   import petsBag.PetsBagManager;      public class PetSkillManager   {            private static var _skills:Dictionary;                   public function PetSkillManager() { super(); }
            public static function setup(analyzer:PetSkillAnalyzer) : void { }
            public static function getSkillByID(skillID:int) : PetSkillTemplateInfo { return null; }
            public static function fillPetSkill(skill:PetSkill) : void { }
   }}