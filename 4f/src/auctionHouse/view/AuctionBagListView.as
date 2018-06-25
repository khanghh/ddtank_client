package auctionHouse.view{   import bagAndInfo.bag.BagListView;   import bagAndInfo.cell.BagCell;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import flash.events.Event;   import flash.utils.Dictionary;      public class AuctionBagListView extends BagListView   {                   public function AuctionBagListView(bagType:int, columnNum:int = 7) { super(null,null); }
            override public function setData(bag:BagInfo) : void { }
            override protected function __updateGoods(evt:BagEvent) : void { }
            private function _cellsSort(arr:Array) : void { }
   }}