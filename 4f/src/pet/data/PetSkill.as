package pet.data
{
   import ddt.manager.PetSkillManager;
   
   public class PetSkill extends PetSkillTemplateInfo
   {
       
      
      private var _equiped:Boolean;
      
      public function PetSkill(param1:int){super();}
      
      public function get Equiped() : Boolean{return false;}
      
      public function set Equiped(param1:Boolean) : void{}
   }
}
