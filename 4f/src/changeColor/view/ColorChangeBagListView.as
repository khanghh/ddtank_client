package changeColor.view{   import bagAndInfo.bag.BagListView;   import bagAndInfo.cell.BagCell;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.events.ChangeColorCellEvent;   import ddt.manager.PlayerManager;   import flash.events.MouseEvent;   import flash.utils.Dictionary;      public class ColorChangeBagListView extends BagListView   {                   public function ColorChangeBagListView() { super(null); }
            override protected function createCells() : void { }
            override public function setData(bag:BagInfo) : void { }
            private function __updateGoodsII(evt:BagEvent) : void { }
            public function updateItem(item:InventoryItemInfo) : void { }
            public function removeBagItem(item:InventoryItemInfo) : void { }
            private function __cellClick(evt:MouseEvent) : void { }
            override public function dispose() : void { }
   }}