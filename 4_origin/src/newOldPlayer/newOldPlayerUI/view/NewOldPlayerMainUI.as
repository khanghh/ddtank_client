package newOldPlayer.newOldPlayerUI.view
{
   import morn.core.components.Box;
   import morn.core.components.Button;
   import morn.core.components.Image;
   import morn.core.components.Label;
   import morn.core.components.List;
   import morn.core.components.View;
   import morn.core.ex.NumberImageEx;
   import newOldPlayer.newOldPlayerView.NewOldPlayerDesView;
   import newOldPlayer.newOldPlayerView.NewOldPlayerTaskView;
   
   public class NewOldPlayerMainUI extends View
   {
       
      
      public var closeBtn:Button = null;
      
      public var hourImg:Image = null;
      
      public var remainCount:NumberImageEx = null;
      
      public var dayImg:Image = null;
      
      public var desView:NewOldPlayerDesView = null;
      
      public var taskView:NewOldPlayerTaskView = null;
      
      public var list_select:List = null;
      
      public var paopaoBox:Box = null;
      
      public var activeNum:Label = null;
      
      public function NewOldPlayerMainUI()
      {
         super();
      }
      
      override protected function createChildren() : void
      {
         viewClassMap["newOldPlayer.newOldPlayerView.NewOldPlayerDesView"] = NewOldPlayerDesView;
         viewClassMap["newOldPlayer.newOldPlayerView.NewOldPlayerTaskView"] = NewOldPlayerTaskView;
         super.createChildren();
         loadUI("view/NewOldPlayerMain.xml");
      }
   }
}