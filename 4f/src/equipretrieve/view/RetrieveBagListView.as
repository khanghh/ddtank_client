package equipretrieve.view{   import bagAndInfo.bag.BagListView;   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CellEvent;   import ddt.manager.ItemManager;   import ddt.manager.SoundManager;   import equipretrieve.RetrieveModel;   import flash.geom.Point;   import flash.utils.Dictionary;      public class RetrieveBagListView extends BagListView   {                   public function RetrieveBagListView(bagType:int, columnNum:int = 7) { super(null,null); }
            override protected function createCells() : void { }
            private function _stopDrag(e:CellEvent) : void { }
            override protected function __clickHandler(evt:InteractiveEvent) : void { }
            override protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override public function setData(bag:BagInfo) : void { }
            override public function setCellInfo(index:int, info:InventoryItemInfo) : void { }
            private function _cellsSort(arr:Array) : void { }
            public function returnNullPoint(_dx:Number, _dy:Number) : Object { return null; }
            override public function dispose() : void { }
   }}