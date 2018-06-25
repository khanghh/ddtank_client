package ddt.manager
{
   import ddt.data.analyze.PetAllSkillAnalyzer;
   import flash.utils.Dictionary;
   import pet.data.PetAllSkillTemplateInfo;
   import pet.data.PetTemplateInfo;
   
   public class PetAllSkillManager
   {
      
      private static var _skills:Dictionary;
       
      
      public function PetAllSkillManager()
      {
         super();
      }
      
      public static function setup(analyzer:PetAllSkillAnalyzer) : void
      {
         _skills = analyzer.list;
      }
      
      public static function getAllSkillByPetTemplateID(petInfo:PetTemplateInfo) : Array
      {
         var resultAllSkills:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _skills;
         for each(var petItem in _skills)
         {
            if(petItem.PetTemplateID == petInfo.TemplateID)
            {
               resultAllSkills.push(PetSkillManager.getSkillByID(petItem.SkillID));
            }
            else if(petItem.PetTemplateID == -1 && petItem.KindID == petInfo.KindID)
            {
               resultAllSkills.push(PetSkillManager.getSkillByID(petItem.SkillID));
            }
         }
         return resultAllSkills;
      }
   }
}
