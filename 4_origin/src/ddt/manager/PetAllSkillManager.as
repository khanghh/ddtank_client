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
      
      public static function setup(param1:PetAllSkillAnalyzer) : void
      {
         _skills = param1.list;
      }
      
      public static function getAllSkillByPetTemplateID(param1:PetTemplateInfo) : Array
      {
         var _loc2_:Array = [];
         var _loc5_:int = 0;
         var _loc4_:* = _skills;
         for each(var _loc3_ in _skills)
         {
            if(_loc3_.PetTemplateID == param1.TemplateID)
            {
               _loc2_.push(PetSkillManager.getSkillByID(_loc3_.SkillID));
            }
            else if(_loc3_.PetTemplateID == -1 && _loc3_.KindID == param1.KindID)
            {
               _loc2_.push(PetSkillManager.getSkillByID(_loc3_.SkillID));
            }
         }
         return _loc2_;
      }
   }
}
