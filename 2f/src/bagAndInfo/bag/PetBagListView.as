package bagAndInfo.bag{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.BaseCell;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import flash.events.Event;   import flash.utils.Dictionary;   import road7th.data.DictionaryData;      public class PetBagListView extends BagListView   {            public static const PET_BAG_CAPABILITY:int = 49;                   private var _allBagData:BagInfo;            public function PetBagListView(bagType:int, columnNum:int = 7) { super(null,null,null); }
            override public function setData(bag:BagInfo) : void { }
            private function sortItems() : void { }
            override protected function __updateGoods(evt:BagEvent) : void { }
            private function updateFoodBagList() : void { }
            private function getItemIndex(i:InventoryItemInfo) : int { return 0; }
            private function _cellsSort(arr:Array) : void { }
   }}