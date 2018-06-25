package store.view.storeBag{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.SimpleTileList;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CellEvent;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import store.FineBringUpController;   import store.FineEvolutionManager;   import store.events.StoreBagEvent;   import store.events.UpdateItemEvent;      public class StoreBagListView extends Sprite implements Disposeable   {            public static const SMALLGRID:int = 21;                   protected var _list:SimpleTileList;            protected var panel:ScrollPanel;            protected var _cells:DictionaryData;            protected var _bagdata:DictionaryData;            protected var _controller:StoreBagController;            protected var _bagType:int;            private var cellNum:int = 70;            private var beginGridNumber:int;            private var _columnNum:int;            private var showlock:Boolean = false;            public function StoreBagListView(_showLock:Boolean = false) { super(); }
            public function setup(bagType:int, controller:StoreBagController, number:int, columnNum:int = 7) : void { }
            private function init() : void { }
            protected function createPanel() : void { }
            protected function createCells() : void { }
            protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            protected function __clickHandler(e:InteractiveEvent) : void { }
            protected function __cellChanged(event:Event) : void { }
            protected function __cellClick(evt:MouseEvent) : void { }
            public function getCellByPlace(place:int) : BagCell { return null; }
            public function setCellInfo(index:int, info:InventoryItemInfo) : void { }
            public function setData(list:DictionaryData) : void { }
            private function addGrid(list:DictionaryData) : void { }
            protected function createCell(index:int) : void { }
            private function _appendCell(sum:int) : void { }
            private function updateScrollBar(updatePosition:Boolean = true) : void { }
            protected function __addGoods(evt:DictionaryEvent) : void { }
            private function checkShouldAutoLink(item:InventoryItemInfo) : Boolean { return false; }
            protected function __removeGoods(evt:StoreBagEvent) : void { }
            private function __updateGoods(evt:UpdateItemEvent) : void { }
            public function getCellByPos(pos:int) : BagCell { return null; }
            private function invalidatePanel() : void { }
            public function dispose() : void { }
            public function get cells() : DictionaryData { return null; }
   }}