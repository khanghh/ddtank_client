package armShell{   import bagAndInfo.cell.BagCell;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.Frame;   import ddt.data.BagInfo;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.events.CellEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.utils.Dictionary;   import road7th.data.DictionaryData;   import store.events.StoreBagEvent;   import store.events.StoreDargEvent;   import store.events.UpdateItemEvent;      public class ArmShellFrame extends Frame   {                   private var _bg:Bitmap;            private var _preItemCell:ArmShellItemCell;            private var _bagListView:ArmShellBagListView;            private var _equipBagInfo:DictionaryData;            private var _itemPlace:int;            public function ArmShellFrame() { super(); }
            override protected function init() : void { }
            private function initView() : void { }
            private function addEvents() : void { }
            private function updateBag(evt:BagEvent) : void { }
            public function refreshData(items:Dictionary, bag:BagInfo) : void { }
            private function updateDic(dic:DictionaryData, item:InventoryItemInfo) : void { }
            private function addItemToTheFirstNullCell(item:InventoryItemInfo, dic:DictionaryData) : void { }
            private function findFirstNullCellID(dic:DictionaryData) : int { return 0; }
            private function removeFrom(item:InventoryItemInfo, dic:DictionaryData) : void { }
            private function refreshBagList() : void { }
            private function getEquipProData(bag:DictionaryData) : DictionaryData { return null; }
            private function __responseHandler(event:FrameEvent) : void { }
            private function cellClickHandler(event:CellEvent) : void { }
            protected function __cellDoubleClick(evt:CellEvent) : void { }
            private function __startDargHandler(event:StoreDargEvent) : void { }
            private function __stopDargHandler(event:StoreDargEvent) : void { }
            private function removeEvents() : void { }
            override public function dispose() : void { }
   }}