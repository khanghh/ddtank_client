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
      
      override protected function __clickHandler(e:InteractiveEvent) : void
      {
      }
      
      override protected function createCell(index:int) : void
      {
         var cell:StoreBagCell = new StoreBagCell(index);
         cell.allowDrag = false;
         cell.bagType = _bagType;
         cell.tipDirctions = "7,5,2,6,4,1";
         cell.addEventListener("interactive_click",__clickHandler);
         cell.addEventListener("interactive_double_click",__doubleClickHandler);
         DoubleClickManager.Instance.enableDoubleClick(cell);
         cell.addEventListener("click",__cellClick);
         cell.addEventListener("lockChanged",__cellChanged);
         _cells.add(cell.place,cell);
         _list.addChild(cell);
      }
   }
}
