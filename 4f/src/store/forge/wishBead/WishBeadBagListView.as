package store.forge.wishBead{   import bagAndInfo.bag.BagListView;   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.interfaces.ICell;   import flash.utils.Dictionary;      public class WishBeadBagListView extends BagListView   {                   public function WishBeadBagListView(bagType:int, columnNum:int = 7, cellNun:int = 49) { super(null,null,null); }
            override protected function createCells() : void { }
            private function createBagCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true) : WishBeadEquipListCell { return null; }
            private function fillTipProp(cell:ICell) : void { }
            private function equipMoveHandler(event:WishBeadEvent) : void { }
            private function equipMoveHandler2(event:WishBeadEvent) : void { }
            override public function setData(bag:BagInfo) : void { }
            override public function dispose() : void { }
   }}