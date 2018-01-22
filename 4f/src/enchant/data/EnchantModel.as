package enchant.data
{
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.SelfInfo;
   import ddt.events.BagEvent;
   import ddt.manager.PlayerManager;
   import flash.events.EventDispatcher;
   import flash.utils.Dictionary;
   import road7th.data.DictionaryData;
   import store.events.StoreBagEvent;
   import store.events.UpdateItemEvent;
   
   public class EnchantModel extends EventDispatcher
   {
       
      
      private var _canEnchantEquipList:DictionaryData;
      
      private var _canEnchantPropList:DictionaryData;
      
      private var _info:SelfInfo;
      
      private var _equipmentBag:DictionaryData;
      
      private var _propBag:DictionaryData;
      
      public function EnchantModel(){super();}
      
      public function get canEnchantEquipList() : DictionaryData{return null;}
      
      public function get canEnchantPropList() : DictionaryData{return null;}
      
      private function initData() : void{}
      
      private function initEquipProData(param1:DictionaryData, param2:Boolean) : void{}
      
      private function initEvent() : void{}
      
      private function updateBag(param1:BagEvent) : void{}
      
      private function __updateEquip(param1:InventoryItemInfo) : void{}
      
      private function updateDic(param1:DictionaryData, param2:InventoryItemInfo) : void{}
      
      private function addItemToTheFirstNullCell(param1:InventoryItemInfo, param2:DictionaryData) : void{}
      
      private function findFirstNullCellID(param1:DictionaryData) : int{return 0;}
      
      private function __updateProp(param1:InventoryItemInfo) : void{}
      
      private function removeFrom(param1:InventoryItemInfo, param2:DictionaryData) : void{}
   }
}
