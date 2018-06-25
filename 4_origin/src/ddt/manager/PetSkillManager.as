package ddt.manager
{
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.analyze.PetSkillAnalyzer;
   import flash.utils.Dictionary;
   import pet.data.PetSkill;
   import pet.data.PetSkillTemplateInfo;
   import petsBag.PetsBagManager;
   
   public class PetSkillManager
   {
      
      private static var _skills:Dictionary;
       
      
      public function PetSkillManager()
      {
         super();
      }
      
      public static function setup(analyzer:PetSkillAnalyzer) : void
      {
         _skills = analyzer.list;
      }
      
      public static function getSkillByID(skillID:int) : PetSkillTemplateInfo
      {
         return _skills[skillID];
      }
      
      public static function fillPetSkill(skill:PetSkill) : void
      {
         var s:PetSkillTemplateInfo = getSkillByID(skill.ID);
         var isAwakenSkill:Boolean = PetsBagManager.instance().isAwakenSkill(skill.ID);
         if(isAwakenSkill)
         {
            s.exclusiveID = skill.ID;
         }
         if(s)
         {
            ObjectUtils.copyProperties(skill,s);
         }
      }
   }
}
