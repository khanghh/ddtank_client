package ddt.data
{
   import cardSystem.CardManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.SetsInfo;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.BagEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.manager.StateManager;
   import flash.events.EventDispatcher;
   import flash.utils.ByteArray;
   import flash.utils.Dictionary;
   import horse.HorseAmuletManager;
   import horse.data.HorseAmuletVo;
   import road7th.data.DictionaryData;
   
   [Event(name="update",type="ddt.events.BagEvent")]
   public class BagInfo extends EventDispatcher
   {
      
      public static const EQUIPBAG:int = 0;
      
      public static const PROPBAG:int = 1;
      
      public static const TASKBAG:int = 2;
      
      public static const FIGHTBAG:int = 3;
      
      public static const TEMPBAG:int = 4;
      
      public static const CADDYBAG:int = 5;
      
      public static const CONSORTIA:int = 11;
      
      public static const FARM:int = 13;
      
      public static const VEGETABLE:int = 14;
      
      public static const FOOD_OLD:int = 32;
      
      public static const FOOD:int = 34;
      
      public static const PETEGG:int = 35;
      
      public static const BEADBAG:int = 21;
      
      public static const MAGICSTONE:int = 41;
      
      public static const MAXPROPCOUNT:int = 48;
      
      public static const STOREBAG:int = 12;
      
      public static const HOMEBANK:int = 511;
      
      public static const MAGICHOUSE:int = 51;
      
      public static const HORSE_AMULET:int = 42;
      
      public static const ROOMBORDEN:int = 43;
      
      public static const MINES:int = 52;
      
      public static const PERSONAL_EQUIP_COUNT:int = 30;
       
      
      private var _isBatch:Boolean = false;
      
      private var _type:int;
      
      private var _capability:int;
      
      private var _items:DictionaryData;
      
      private var _changedCount:int = 0;
      
      private var _changedSlots:Dictionary;
      
      public const NUMBER:Number = 1.0;
      
      public function BagInfo(param1:int, param2:int){super();}
      
      public static function parseCategoryID(param1:int, param2:int) : int{return 0;}
      
      public function get BagType() : int{return 0;}
      
      public function getItemAt(param1:int) : InventoryItemInfo{return null;}
      
      public function get items() : DictionaryData{return null;}
      
      public function get itemNumber() : int{return 0;}
      
      public function getBagFullByIndex(param1:int, param2:int) : Boolean{return false;}
      
      public function set items(param1:DictionaryData) : void{}
      
      public function addItem(param1:InventoryItemInfo) : void{}
      
      public function addItemIntoFightBag(param1:int, param2:int = 1) : void{}
      
      private function findFirstPlace() : int{return 0;}
      
      public function removeItemAt(param1:int) : void{}
      
      public function updateItem(param1:InventoryItemInfo) : void{}
      
      public function beginChanges() : void{}
      
      public function commiteChanges() : void{}
      
      protected function onItemChanged(param1:int, param2:InventoryItemInfo) : void{}
      
      protected function updateChanged() : void{}
      
      public function findItems(param1:int, param2:Boolean = true) : Array{return null;}
      
      public function findFirstItem(param1:int, param2:Boolean = true) : InventoryItemInfo{return null;}
      
      public function getItemByTemplateId(param1:int) : InventoryItemInfo{return null;}
      
      public function findEquipedItemByTemplateId(param1:int, param2:Boolean = true) : InventoryItemInfo{return null;}
      
      public function findIsEquipedByPlace(param1:Array) : Array{return null;}
      
      public function findOvertimeItems(param1:Number = 0) : Array{return null;}
      
      public function findOvertimeItemsByBody() : Array{return null;}
      
      public function findOvertimeItemsByBodyII() : Array{return null;}
      
      public function findItemsForEach(param1:int, param2:Boolean = true) : Array{return null;}
      
      public function findFistItemByTemplateId(param1:int, param2:Boolean = true, param3:Boolean = false) : InventoryItemInfo{return null;}
      
      public function findBodyThingByCategory(param1:int) : Array{return null;}
      
      public function getItemCountByTemplateIdBindType(param1:int, param2:int) : int{return 0;}
      
      public function getItemCountByTemplateId(param1:int, param2:Boolean = true) : int{return 0;}
      
      public function getLimitSLItemCountByTemplateId(param1:int, param2:int = -1, param3:Boolean = true) : int{return 0;}
      
      public function getBagItemCountByTemplateIdBindType(param1:int, param2:int) : int{return 0;}
      
      public function getBagItemCountByTemplateId(param1:int, param2:Boolean = true) : int{return 0;}
      
      public function findItemsByTempleteID(param1:int, param2:Boolean = true) : Array{return null;}
      
      public function findItemsByTempleteIDNoValidate(param1:int) : Array{return null;}
      
      public function findCellsByTempleteID(param1:int, param2:Boolean = true) : Array{return null;}
      
      public function clearnAll() : void{}
      
      public function unlockItem(param1:InventoryItemInfo) : void{}
      
      public function unLockAll() : void{}
      
      public function sortBag(param1:int, param2:BagInfo, param3:int, param4:int, param5:Boolean = false) : void{}
      
      public function foldPetEquips(param1:int, param2:BagInfo, param3:int, param4:int) : void{}
      
      private function sortMagicStone(param1:BagInfo, param2:int, param3:int) : void{}
      
      private function propertyAssort(param1:InventoryItemInfo) : int{return 0;}
      
      private function sortBead(param1:BagInfo, param2:int, param3:int, param4:Boolean) : void{}
      
      private function sortAmulet(param1:BagInfo, param2:int, param3:int, param4:Boolean = false) : void{}
      
      private function showPetsMergerInfo(param1:Array) : Boolean{return false;}
      
      private function sortCard() : void{}
      
      public function getBagGoodsCategoryIDSort(param1:uint) : int{return 0;}
      
      private function bagComparisonType(param1:Array, param2:Array, param3:int) : Boolean{return false;}
      
      private function bagComparison(param1:Array, param2:Array, param3:int) : Boolean{return false;}
      
      public function itemBgNumber(param1:int, param2:int) : int{return 0;}
      
      public function getItemByItemId(param1:int) : InventoryItemInfo{return null;}
      
      private function isPetsEquip(param1:int) : Boolean{return false;}
      
      public function get isBatch() : Boolean{return false;}
      
      public function set isBatch(param1:Boolean) : void{}
   }
}
