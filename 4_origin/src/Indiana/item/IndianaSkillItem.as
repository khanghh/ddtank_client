package Indiana.item
{
   import pet.data.PetSkillTemplateInfo;
   import petsBag.view.item.SkillItem;
   
   public class IndianaSkillItem extends SkillItem
   {
       
      
      public function IndianaSkillItem(param1:PetSkillTemplateInfo, param2:int, param3:Boolean = false, param4:Boolean = false)
      {
         super(param1,param2,param3,param4);
      }
      
      override protected function addQuictShortKey() : void
      {
      }
   }
}
