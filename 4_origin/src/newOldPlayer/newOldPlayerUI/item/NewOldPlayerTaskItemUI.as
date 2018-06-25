package newOldPlayer.newOldPlayerUI.item
{
   import morn.core.components.Box;
   import morn.core.components.Button;
   import morn.core.components.Label;
   import morn.core.components.View;
   
   public class NewOldPlayerTaskItemUI extends View
   {
       
      
      public var condition:Label = null;
      
      public var rewardBox:Box = null;
      
      public var getBtn:Button = null;
      
      public function NewOldPlayerTaskItemUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         super.createChildren();
         loadUI("item/NewOldPlayerTaskItem.xml");
      }
   }
}
