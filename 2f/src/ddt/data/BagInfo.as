package ddt.data{   import cardSystem.CardManager;   import cardSystem.data.CardInfo;   import cardSystem.data.SetsInfo;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.BagEvent;   import ddt.manager.ItemManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.StateManager;   import flash.events.EventDispatcher;   import flash.utils.ByteArray;   import flash.utils.Dictionary;   import horse.HorseAmuletManager;   import horse.data.HorseAmuletVo;   import road7th.data.DictionaryData;      [Event(name="update",type="ddt.events.BagEvent")]   public class BagInfo extends EventDispatcher   {            public static const EQUIPBAG:int = 0;            public static const PROPBAG:int = 1;            public static const TASKBAG:int = 2;            public static const FIGHTBAG:int = 3;            public static const TEMPBAG:int = 4;            public static const CADDYBAG:int = 5;            public static const CONSORTIA:int = 11;            public static const FARM:int = 13;            public static const VEGETABLE:int = 14;            public static const FOOD_OLD:int = 32;            public static const FOOD:int = 34;            public static const PETEGG:int = 35;            public static const BEADBAG:int = 21;            public static const MAGICSTONE:int = 41;            public static const MAXPROPCOUNT:int = 48;            public static const STOREBAG:int = 12;            public static const HOMEBANK:int = 511;            public static const MAGICHOUSE:int = 51;            public static const HORSE_AMULET:int = 42;            public static const ROOMBORDEN:int = 43;            public static const MINES:int = 52;            public static const PERSONAL_EQUIP_COUNT:int = 30;                   private var _isBatch:Boolean = false;            private var _type:int;            private var _capability:int;            private var _items:DictionaryData;            private var _changedCount:int = 0;            private var _changedSlots:Dictionary;            public const NUMBER:Number = 1.0;            public function BagInfo(type:int, capability:int) { super(); }
            public static function parseCategoryID(bagType:int, place:int) : int { return 0; }
            public function get BagType() : int { return 0; }
            public function getItemAt(slot:int) : InventoryItemInfo { return null; }
            public function get items() : DictionaryData { return null; }
            public function get itemNumber() : int { return 0; }
            public function getBagFullByIndex(startIndex:int, endIndex:int) : Boolean { return false; }
            public function set items(dic:DictionaryData) : void { }
            public function addItem(item:InventoryItemInfo) : void { }
            public function addItemIntoFightBag(itemID:int, count:int = 1) : void { }
            private function findFirstPlace() : int { return 0; }
            public function removeItemAt(slot:int) : void { }
            public function updateItem(item:InventoryItemInfo) : void { }
            public function beginChanges() : void { }
            public function commiteChanges() : void { }
            protected function onItemChanged(slot:int, value:InventoryItemInfo) : void { }
            protected function updateChanged() : void { }
            public function findItems(categoryId:int, validate:Boolean = true) : Array { return null; }
            public function findFirstItem(categoryId:int, validate:Boolean = true) : InventoryItemInfo { return null; }
            public function getItemByTemplateId(TemplateID:int) : InventoryItemInfo { return null; }
            public function findEquipedItemByTemplateId(TemplateID:int, validate:Boolean = true) : InventoryItemInfo { return null; }
            public function findIsEquipedByPlace(placeArr:Array) : Array { return null; }
            public function findOvertimeItems(lefttime:Number = 0) : Array { return null; }
            public function findOvertimeItemsByBody() : Array { return null; }
            public function findOvertimeItemsByBodyII() : Array { return null; }
            public function findItemsForEach(categoryId:int, validate:Boolean = true) : Array { return null; }
            public function findFistItemByTemplateId(templateId:int, validate:Boolean = true, usedFirst:Boolean = false) : InventoryItemInfo { return null; }
            public function findBodyThingByCategory(id:int) : Array { return null; }
            public function getItemCountByTemplateIdBindType(templateId:int, bindType:int) : int { return 0; }
            public function getItemCountByTemplateId(templateId:int, validate:Boolean = true) : int { return 0; }
            public function getLimitSLItemCountByTemplateId(templateId:int, LimitValue:int = -1, validate:Boolean = true) : int { return 0; }
            public function getBagItemCountByTemplateIdBindType(templateId:int, bindType:int) : int { return 0; }
            public function getBagItemCountByTemplateId(templateId:int, validate:Boolean = true) : int { return 0; }
            public function findItemsByTempleteID(templeteID:int, validate:Boolean = true) : Array { return null; }
            public function findItemsByTempleteIDNoValidate(templeteID:int) : Array { return null; }
            public function findCellsByTempleteID(templeteID:int, validate:Boolean = true) : Array { return null; }
            public function clearnAll() : void { }
            public function unlockItem(item:InventoryItemInfo) : void { }
            public function unLockAll() : void { }
            public function sortBag(type:int, bagInfo:BagInfo, startPlace:int, endPlace:int, isSegistration:Boolean = false) : void { }
            public function foldPetEquips(type:int, bagInfo:BagInfo, startPlace:int, endPlace:int) : void { }
            private function sortMagicStone(bagInfo:BagInfo, startPlace:int, endPlace:int) : void { }
            private function propertyAssort(item:InventoryItemInfo) : int { return 0; }
            private function sortBead(bagInfo:BagInfo, startPlace:int, endPlace:int, isSegistration:Boolean) : void { }
            private function sortAmulet(bagInfo:BagInfo, startPlace:int, endPlace:int, isSegistration:Boolean = false) : void { }
            private function showPetsMergerInfo(arrayBag:Array) : Boolean { return false; }
            private function sortCard() : void { }
            public function getBagGoodsCategoryIDSort(CategoryID:uint) : int { return 0; }
            private function bagComparisonType(bagArray1:Array, bagArray2:Array, startPlace:int) : Boolean { return false; }
            private function bagComparison(bagArray1:Array, bagArray2:Array, startPlace:int) : Boolean { return false; }
            public function itemBgNumber(startPlace:int, endPlace:int) : int { return 0; }
            public function getItemByItemId(itemId:int) : InventoryItemInfo { return null; }
            private function isPetsEquip(id:int) : Boolean { return false; }
            public function get isBatch() : Boolean { return false; }
            public function set isBatch(value:Boolean) : void { }
   }}