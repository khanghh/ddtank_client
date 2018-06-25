package newOldPlayer.newOldPlayerUI.view
{
   import morn.core.components.List;
   import morn.core.components.View;
   import newOldPlayer.newOldPlayerView.NewOldPlayerTaskItem;
   
   public class NewOldPlayerTaskUI extends View
   {
       
      
      public var list:List = null;
      
      public function NewOldPlayerTaskUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["newOldPlayer.newOldPlayerView.NewOldPlayerTaskItem"] = NewOldPlayerTaskItem;
         super.createChildren();
         loadUI("view/NewOldPlayerTask.xml");
      }
   }
}
