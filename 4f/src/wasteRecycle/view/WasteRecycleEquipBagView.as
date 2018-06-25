package wasteRecycle.view{   import bagAndInfo.bag.BagEquipListView;   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.CellFactory;   import baglocked.BaglockedManager;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.utils.Dictionary;   import wasteRecycle.WasteRecycleController;      public class WasteRecycleEquipBagView extends BagEquipListView   {                   private var _waitBagUpdate:Array;            public function WasteRecycleEquipBagView(bagType:int, startIndex:int = 31, stopIndex:int = 80, columnNum:int = 7) { super(null,null,null,null); }
            override protected function createCells() : void { }
            override public function setData(bag:BagInfo) : void { }
            override protected function __updateGoods(evt:BagEvent) : void { }
            private function __onWaitUpdate(e:Event) : void { }
            override protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            private function _cellsSort(arr:Array) : void { }
            override public function dispose() : void { }
   }}