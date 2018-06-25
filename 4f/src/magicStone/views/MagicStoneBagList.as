package magicStone.views{   import bagAndInfo.bag.BagListView;   import bagAndInfo.cell.CellFactory;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import flash.events.Event;   import flash.utils.Dictionary;   import magicStone.components.MgStoneCell;      public class MagicStoneBagList extends BagListView   {                   private var _curPage:int;            private var _startIndex:int;            private var _endIndex:int;            public function MagicStoneBagList(bagType:int, columnNum:int = 7, cellNun:int = 49) { super(null,null,null); }
            override protected function createCells() : void { }
            override public function setData(bag:BagInfo) : void { }
            override protected function __updateGoods(evt:BagEvent) : void { }
            override public function setCellInfo(index:int, info:InventoryItemInfo) : void { }
            public function updateBagList() : void { }
            public function set curPage(value:int) : void { }
            override public function dispose() : void { }
   }}