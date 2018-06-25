package bagAndInfo.bag{   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.CellFactory;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CellEvent;   import ddt.manager.SoundManager;   import flash.events.MouseEvent;   import flash.utils.Dictionary;      public class BagEquipListView extends BagListView   {                   public var _startIndex:int;            public var _stopIndex:int;            public function BagEquipListView(bagType:int, startIndex:int = 31, stopIndex:int = 80, columnNum:int = 7) { super(null,null); }
            override protected function createCells() : void { }
            override protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            override protected function __clickHandler(e:InteractiveEvent) : void { }
            protected function __cellClick(evt:MouseEvent) : void { }
            override public function setCellInfo(index:int, info:InventoryItemInfo) : void { }
            override public function dispose() : void { }
   }}