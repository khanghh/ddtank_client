package mark.mornUI.items
{
   import morn.core.components.View;
   
   public class MarkEquipItemUI extends View
   {
       
      
      public function MarkEquipItemUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("items/MarkEquipItem.xml");
      }
   }
}
