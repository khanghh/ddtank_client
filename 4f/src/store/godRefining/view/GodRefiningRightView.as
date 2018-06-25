package store.godRefining.view{   import bagAndInfo.cell.BagCell;   import baglocked.BaglockedManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.BagInfo;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CEvent;   import ddt.events.CellEvent;   import ddt.manager.PlayerManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.utils.Dictionary;   import road7th.data.DictionaryData;   import store.events.StoreBagEvent;   import store.events.StoreDargEvent;   import store.events.UpdateItemEvent;   import store.forge.ForgeRightBgView;   import store.godRefining.GodRefiningManager;      public class GodRefiningRightView extends ForgeRightBgView   {                   private var _bagList:GodRefiningBagListView;            private var _proBagList:GodRefiningBagListView;            private var _equipBagInfo:DictionaryData;            private var _propBagInfo:DictionaryData;            private var _selectIndex:int;            public function GodRefiningRightView() { super(); }
            private function initView() : void { }
            private function initEvent() : void { }
            public function updateView(selectIndex:int) : void { }
            private function __startDargHandler(event:StoreDargEvent) : void { }
            private function __stopDargHandler(event:StoreDargEvent) : void { }
            private function cellClickHandler(event:CellEvent) : void { }
            protected function __cellDoubleClick(evt:CellEvent) : void { }
            private function refreshBagList() : void { }
            private function refreshPropBagList() : void { }
            private function getEquipProData(bag:DictionaryData, isEquip:Boolean) : DictionaryData { return null; }
            public function refreshData(items:Dictionary, bag:BagInfo) : void { }
            private function updateEquip(item:InventoryItemInfo) : void { }
            private function updateProp(item:InventoryItemInfo) : void { }
            private function isProperTo_CanEquipList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_CanPropList(item:InventoryItemInfo) : Boolean { return false; }
            private function removeFrom(item:InventoryItemInfo, dic:DictionaryData) : void { }
            private function updateDic(dic:DictionaryData, item:InventoryItemInfo) : void { }
            private function addItemToTheFirstNullCell(item:InventoryItemInfo, dic:DictionaryData) : void { }
            private function findFirstNullCellID(dic:DictionaryData) : int { return 0; }
            private function removeEvent() : void { }
            override public function dispose() : void { }
   }}