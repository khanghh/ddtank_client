package auctionHouse.view{   import bagAndInfo.cell.BaseCell;   import beadSystem.controls.BeadBagList;   import com.pickgliss.events.InteractiveEvent;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import flash.events.Event;   import flash.utils.Dictionary;      public class AuctionBeadListView extends BeadBagList   {                   public function AuctionBeadListView(bagType:int, startIndex:int = 32, stopIndex:int = 80, columnNum:int = 7) { super(null,null,null,null); }
            override public function setData(bag:BagInfo) : void { }
            override protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override protected function __updateGoods(evt:BagEvent) : void { }
            private function _cellsSort(arr:Array) : void { }
   }}