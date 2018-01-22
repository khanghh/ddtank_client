package armShell
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import store.view.storeBag.StoreBagCell;
   import store.view.storeBag.StoreBagListView;
   
   public class ArmShellBagListView extends StoreBagListView
   {
       
      
      public function ArmShellBagListView(){super();}
      
      override protected function createPanel() : void{}
      
      override protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      override protected function createCell(param1:int) : void{}
   }
}
