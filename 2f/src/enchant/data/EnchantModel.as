package enchant.data{   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.player.SelfInfo;   import ddt.events.BagEvent;   import ddt.manager.PlayerManager;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import road7th.data.DictionaryData;   import store.events.StoreBagEvent;   import store.events.UpdateItemEvent;      public class EnchantModel extends EventDispatcher   {                   private var _canEnchantEquipList:DictionaryData;            private var _canEnchantPropList:DictionaryData;            private var _info:SelfInfo;            private var _equipmentBag:DictionaryData;            private var _propBag:DictionaryData;            public function EnchantModel() { super(); }
            public function get canEnchantEquipList() : DictionaryData { return null; }
            public function get canEnchantPropList() : DictionaryData { return null; }
            private function initData() : void { }
            private function initEquipProData(bag:DictionaryData, isEquip:Boolean) : void { }
            private function initEvent() : void { }
            private function updateBag(evt:BagEvent) : void { }
            private function __updateEquip(item:InventoryItemInfo) : void { }
            private function updateDic(dic:DictionaryData, item:InventoryItemInfo) : void { }
            private function addItemToTheFirstNullCell(item:InventoryItemInfo, dic:DictionaryData) : void { }
            private function findFirstNullCellID(dic:DictionaryData) : int { return 0; }
            private function __updateProp(item:InventoryItemInfo) : void { }
            private function removeFrom(item:InventoryItemInfo, dic:DictionaryData) : void { }
   }}