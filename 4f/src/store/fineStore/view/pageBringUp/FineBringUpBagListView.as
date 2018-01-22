package store.fineStore.view.pageBringUp
{
   import bagAndInfo.bag.BagListView;
   import bagAndInfo.cell.BagCell;
   import bagAndInfo.cell.CellFactory;
   import bagAndInfo.cell.LockableBagCell;
   import com.pickgliss.events.InteractiveEvent;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.DoubleClickManager;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.PositionUtils;
   import flash.utils.Dictionary;
   import latentEnergy.LatentEnergyEvent;
   import store.FineBringUpController;
   
   public class FineBringUpBagListView extends BagListView
   {
       
      
      public function FineBringUpBagListView(param1:int, param2:int = 7, param3:int = 49){super(null,null,null);}
      
      protected function onItemLockStatusUpdate(param1:CEvent) : void{}
      
      override protected function createCells() : void{}
      
      override protected function __doubleClickHandler(param1:InteractiveEvent) : void{}
      
      override protected function __clickHandler(param1:InteractiveEvent) : void{}
      
      private function equipMoveHandler(param1:LatentEnergyEvent) : void{}
      
      private function equipMoveHandler2(param1:LatentEnergyEvent) : void{}
      
      override public function setData(param1:BagInfo) : void{}
      
      override public function dispose() : void{}
   }
}
