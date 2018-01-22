package armShell
{
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import store.view.storeBag.StoreBagCell;
   import store.view.storeBag.StoreBagListView;
   
   public class ArmShellBagListView extends StoreBagListView
   {
       
      
      public function ArmShellBagListView()
      {
         super();
      }
      
      override protected function createPanel() : void
      {
         panel = ComponentFactory.Instance.creat("ddtstore.ArmShellFrame.BagEquipScrollPanel");
         addChild(panel);
         panel.hScrollProxy = 2;
         panel.vScrollProxy = 0;
      }
      
      override protected function __clickHandler(param1:InteractiveEvent) : void
      {
      }
      
      override protected function createCell(param1:int) : void
      {
         var _loc2_:StoreBagCell = new StoreBagCell(param1);
         _loc2_.allowDrag = false;
         _loc2_.bagType = _bagType;
         _loc2_.tipDirctions = "7,5,2,6,4,1";
         _loc2_.addEventListener("interactive_click",__clickHandler);
         _loc2_.addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(_loc2_);
         _loc2_.addEventListener("click",__cellClick);
         _loc2_.addEventListener("lockChanged",__cellChanged);
         _cells.add(_loc2_.place,_loc2_);
         _list.addChild(_loc2_);
      }
   }
}
