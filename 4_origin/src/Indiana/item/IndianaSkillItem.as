package Indiana.item
{
   import pet.data.PetSkillTemplateInfo;
   import petsBag.view.item.SkillItem;
   
   public class IndianaSkillItem extends SkillItem
   {
       
      
      public function IndianaSkillItem(info:PetSkillTemplateInfo, $index:int, canDrag:Boolean = false, isWatch:Boolean = false)
      {
         super(info,$index,canDrag,isWatch);
      }
      
      override protected function addQuictShortKey() : void
      {
      }
   }
}
