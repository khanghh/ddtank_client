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
      
      public static function setup(param1:PetSkillAnalyzer) : void
      {
         _skills = param1.list;
      }
      
      public static function getSkillByID(param1:int) : PetSkillTemplateInfo
      {
         return _skills[param1];
      }
      
      public static function fillPetSkill(param1:PetSkill) : void
      {
         var _loc3_:PetSkillTemplateInfo = getSkillByID(param1.ID);
         var _loc2_:Boolean = PetsBagManager.instance().isAwakenSkill(param1.ID);
         if(_loc2_)
         {
            _loc3_.exclusiveID = param1.ID;
         }
         if(_loc3_)
         {
            ObjectUtils.copyProperties(param1,_loc3_);
         }
      }
   }
}
