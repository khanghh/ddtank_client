package beadSystem.controls{   import bagAndInfo.bag.BagListView;   import bagAndInfo.cell.CellFactory;   import baglocked.BaglockedManager;   import beadSystem.beadSystemManager;   import beadSystem.model.BeadModel;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.events.CellEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import flash.events.Event;   import flash.utils.Dictionary;      public class BeadBagList extends BagListView   {                   public var _startIndex:int;            public var _stopIndex:int;            private var _toPlace:int;            private var _beadInfo:InventoryItemInfo;            public function BeadBagList(bagType:int, startIndex:int = 32, stopIndex:int = 80, columnNum:int = 7) { super(null,null); }
            override protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            private function doBeadEquip() : void { }
            protected function __onBindRespones(pEvent:FrameEvent) : void { }
            public function get BeadCells() : Dictionary { return null; }
            override protected function createCells() : void { }
            override public function setData(bag:BagInfo) : void { }
            override protected function __updateGoods(evt:BagEvent) : void { }
            override protected function __clickHandler(evt:InteractiveEvent) : void { }
            override public function setCellInfo(index:int, info:InventoryItemInfo) : void { }
            override public function dispose() : void { }
   }}