package newOldPlayer.newOldPlayerView
{
   import morn.core.handlers.Handler;
   import newOldPlayer.newOldPlayerUI.view.NewOldPlayerTaskUI;
   
   public class NewOldPlayerTaskView extends NewOldPlayerTaskUI
   {
       
      
      public function NewOldPlayerTaskView()
      {
         super();
         initView();
      }
      
      private function initView() : void
      {
         list.renderHandler = new Handler(__listHandler);
      }
      
      public function setArr(arr:Array) : void
      {
         list.array = arr;
      }
      
      private function __listHandler(item:NewOldPlayerTaskItem, index:int) : void
      {
         if(index < list.array.length)
         {
            item.setData(list.array[index]);
         }
         else
         {
            item.visible = false;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
