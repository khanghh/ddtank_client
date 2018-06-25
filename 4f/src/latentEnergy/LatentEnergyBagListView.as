package latentEnergy{   import bagAndInfo.bag.BagListView;   import bagAndInfo.cell.BagCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.interfaces.ICell;   import flash.utils.Dictionary;      public class LatentEnergyBagListView extends BagListView   {                   private var _autoExpandV:Boolean;            public function LatentEnergyBagListView(bagType:int, columnNum:int = 7, cellNun:int = 49, autoExpandV:Boolean = false) { super(null,null,null); }
            override protected function createCells() : void { }
            private function addCell(place:int) : void { }
            private function createBagCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true) : LatentEnergyEquipListCell { return null; }
            private function fillTipProp(cell:ICell) : void { }
            private function equipMoveHandler(event:LatentEnergyEvent) : void { }
            private function equipMoveHandler2(event:LatentEnergyEvent) : void { }
            override public function setData(bag:BagInfo) : void { }
            public function get autoExpandV() : Boolean { return false; }
            public function set autoExpandV(value:Boolean) : void { }
            override public function dispose() : void { }
   }}