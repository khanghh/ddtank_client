package auctionHouse.view{   import bagAndInfo.bag.BagEquipListView;   import bagAndInfo.cell.BagCell;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import flash.events.Event;   import flash.utils.Dictionary;      public class AuctionBagEquipListView extends BagEquipListView   {                   public function AuctionBagEquipListView(bagType:int, startIndex:int = 31, stopIndex:int = 80) { super(null,null,null); }
            override public function setData(bag:BagInfo) : void { }
            override protected function __updateGoods(evt:BagEvent) : void { }
            private function _cellsSort(arr:Array) : void { }
   }}