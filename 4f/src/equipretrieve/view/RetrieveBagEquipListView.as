package equipretrieve.view{   import bagAndInfo.bag.BagEquipListView;   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CellEvent;   import ddt.manager.ItemManager;   import equipretrieve.RetrieveModel;   import flash.geom.Point;   import flash.utils.Dictionary;      public class RetrieveBagEquipListView extends BagEquipListView   {                   public function RetrieveBagEquipListView(bagType:int, startIndex:int = 31, stopIndex:int = 80) { super(null,null,null); }
            override protected function createCells() : void { }
            private function _stopDrag(e:CellEvent) : void { }
            override public function setData(bag:BagInfo) : void { }
            override public function setCellInfo(index:int, info:InventoryItemInfo) : void { }
            private function _cellsSort(arr:Array) : void { }
            public function returnNullPoint(_dx:Number, _dy:Number) : Object { return null; }
   }}