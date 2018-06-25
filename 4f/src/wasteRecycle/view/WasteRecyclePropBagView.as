package wasteRecycle.view{   import bagAndInfo.bag.BagListView;   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.utils.Dictionary;   import wasteRecycle.WasteRecycleController;      public class WasteRecyclePropBagView extends BagListView   {                   private var _waitBagUpdate:Array;            public function WasteRecyclePropBagView(bagType:int, columnNum:int = 7, cellNun:int = 49) { super(null,null,null); }
            override protected function createCells() : void { }
            override protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override public function setData(bag:BagInfo) : void { }
            override protected function __updateGoods(evt:BagEvent) : void { }
            private function __onWaitUpdate(e:Event) : void { }
            private function _cellsSort(arr:Array) : void { }
            override public function dispose() : void { }
   }}