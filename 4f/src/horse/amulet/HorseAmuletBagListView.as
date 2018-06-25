package horse.amulet{   import bagAndInfo.bag.BagListView;   import bagAndInfo.cell.BagCell;   import bagAndInfo.cell.CellFactory;   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.events.InteractiveEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.DoubleClickManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.Event;   import flash.utils.Dictionary;   import horse.HorseAmuletManager;   import horse.data.HorseAmuletVo;      public class HorseAmuletBagListView extends BagListView   {            public static const MIN_PLACE:int = 20;            public static const MAX_PLACE:int = 167;                   private var _startIndex:int;            private var _endIndex:int;            private var _alertFrame:BaseAlerFrame;            private var _currentPage:int;            private var _place:int;            public function HorseAmuletBagListView(bagType:int, columnNum:int = 7, cellNun:int = 49) { super(null,null,null); }
            public function set currentPage(value:int) : void { }
            override protected function createCells() : void { }
            override public function setData(bag:BagInfo) : void { }
            private function updateBag() : void { }
            override protected function __updateGoods(evt:BagEvent) : void { }
            override public function setCellInfo($index:int, info:InventoryItemInfo) : void { }
            override protected function __doubleClickHandler(evt:InteractiveEvent) : void { }
            private function __onClickFrame(e:FrameEvent) : void { }
            private function disposeAlertFrame() : void { }
            private function _cellsSort(arr:Array) : void { }
            public function getAllEnableSmashPlaceList() : Array { return null; }
            public function lockCellByPlace(lock:Boolean, placeList:Array) : void { }
            override public function dispose() : void { }
   }}