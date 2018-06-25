package store.fineStore.view.pageBringUp{   import bagAndInfo.bag.BagListView;   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.CellFactory;   import bagAndInfo.cell.LockableBagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CEvent;   import ddt.manager.SocketManager;   import ddt.utils.PositionUtils;   import flash.utils.Dictionary;   import latentEnergy.LatentEnergyEvent;   import store.FineBringUpController;      public class FineBringUpBagListView extends BagListView   {                   public function FineBringUpBagListView(bagType:int, columnNum:int = 7, cellNun:int = 49) { super(null,null,null); }
            protected function onItemLockStatusUpdate(e:CEvent) : void { }
            override protected function createCells() : void { }
            override protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override protected function __clickHandler(evt:InteractiveEvent) : void { }
            private function equipMoveHandler(event:LatentEnergyEvent) : void { }
            private function equipMoveHandler2(event:LatentEnergyEvent) : void { }
            override public function setData(bag:BagInfo) : void { }
            override public function dispose() : void { }
   }}