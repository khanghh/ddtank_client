package mines.view{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.DoubleClickManager;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.events.CellEvent;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.utils.Dictionary;   import mines.mornui.view.MinesBagViewUI;   import morn.core.handlers.Handler;      public class MinesBagView extends MinesBagViewUI   {            public static const BAG_CAPABILITY:int = 16;                   private var _currentPage:int = 1;            private var _cells:Dictionary;            private var _cellVec:Vector.<BagCell>;            protected var _bagdata:BagInfo;            public function MinesBagView() { super(); }
            public function get currentPage() : int { return 0; }
            public function set currentPage(value:int) : void { }
            override protected function initialize() : void { }
            private function __doubleClickHandler(evt:InteractiveEvent) : void { }
            private function arrangeHandler() : void { }
            private function updateBag() : void { }
            public function setData(bag:BagInfo) : void { }
            public function __updateGoods(evt:BagEvent) : void { }
            public function setCellInfo(place:int, info:InventoryItemInfo) : void { }
            private function changePage(type:int) : void { }
            protected function __clickHandler(evt:InteractiveEvent) : void { }
            override public function dispose() : void { }
   }}