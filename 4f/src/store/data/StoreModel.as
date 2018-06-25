package store.data{   import com.pickgliss.ui.ComponentFactory;   import ddt.data.BagInfo;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.player.PlayerInfo;   import ddt.data.player.SelfInfo;   import ddt.events.BagEvent;   import ddt.manager.PlayerManager;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import road7th.data.DictionaryData;   import road7th.data.DictionaryEvent;   import store.events.StoreBagEvent;   import store.events.UpdateItemEvent;      public class StoreModel extends EventDispatcher   {            private static const FORMULA_FLOCCULANT:int = 11301;            private static const FORMULA_BIRD:int = 11201;            private static const FORMULA_SNAKE:int = 11202;            private static const FORMULA_DRAGON:int = 11203;            private static const FORMULA_TIGER:int = 11204;            private static const FORMULA_RING:int = 11302;            private static const FORMULA_BANGLE:int = 11303;            private static const RING_TIANYU:int = 9002;            private static const RIN_GZHUFU:int = 8002;            private static var _holeExpModel:HoleExpModel;            public static var STORE_BAG:int = 1;            public static var EVOLUTION_BAG:int = 2;                   private var _info:SelfInfo;            private var _equipmentBag:DictionaryData;            private var _propBag:DictionaryData;            private var _canCpsEquipmentList:DictionaryData;            private var _canStrthEqpmtList:DictionaryData;            private var _canExaltEqpmtList:DictionaryData;            private var _canExaltAssistantList:DictionaryData;            private var _assistantEvolutionList:DictionaryData;            private var _strthList:DictionaryData;            private var _cpsAndANchList:DictionaryData;            private var _cpsAndStrthAndformula:DictionaryData;            private var _exaltRock:DictionaryData;            private var _canRongLiangPropList:DictionaryData;            private var _canTransEquipmengtList:DictionaryData;            private var _canNotTransEquipmengtList:DictionaryData;            private var _canRongLiangEquipmengtList:DictionaryData;            private var _canLianhuaEquipList:DictionaryData;            private var _canLianhuaPropList:DictionaryData;            private var _canEmbedEquipList:DictionaryData;            private var _canEmbedPropList:DictionaryData;            private var _canGhostEquipList:DictionaryData;            private var _canGhostPropList:DictionaryData;            private var _currentPanel:int;            private var _needAutoLink:int = 0;            public function StoreModel(info:PlayerInfo) { super(); }
            public static function getHoleMaxLv() : int { return 0; }
            public static function getHoleMaxOpLv() : int { return 0; }
            public static function getHoleExpByLv(lv:int) : int { return 0; }
            private function initData() : void { }
            private function pickValidItemsOutOf(bag:DictionaryData, isEquip:Boolean) : void { }
            private function isProperTo_canRongLiangProperList(item:InventoryItemInfo) : Boolean { return false; }
            private function initEvent() : void { }
            private function updateBag(evt:BagEvent) : void { }
            private function __updateEquip(item:InventoryItemInfo) : void { }
            private function __updateProp(item:InventoryItemInfo) : void { }
            private function isProperTo_CanCpsEquipmentList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_CanStrthEqpmtList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_CanExaltEqpmtList(item:InventoryItemInfo) : Boolean { return false; }
            private function isPropreTo_CanExaltAssistantList(item:InventoryItemInfo) : Boolean { return false; }
            private function isEvolutionMaterial(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_StrthList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_ExaltList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_CpsAndANchList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_CpsAndStrthAndformula(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_CanRongLiangEquipmengtList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_canLianhuaEquipList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_canLianhuaPropList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_CanTransEquipmengtList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_NotCanTransEquipmengtList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_CanEmbedEquipList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_CanGhostEquipList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_CanEmbedPropList(item:InventoryItemInfo) : Boolean { return false; }
            private function isProperTo_CanGhostPropList(item:InventoryItemInfo) : Boolean { return false; }
            private function updateDic(dic:DictionaryData, item:InventoryItemInfo) : void { }
            private function __removeEquip(evt:DictionaryEvent) : void { }
            private function addItemToTheFirstNullCell(item:InventoryItemInfo, dic:DictionaryData) : void { }
            private function findFirstNullCellID(dic:DictionaryData) : int { return 0; }
            private function removeFrom(item:InventoryItemInfo, dic:DictionaryData) : void { }
            public function sortEquipList(equipList:DictionaryData) : DictionaryData { return null; }
            private function sortByIsUsed(source:DictionaryData) : DictionaryData { return null; }
            public function sortRoogEquipList(equipList:DictionaryData) : DictionaryData { return null; }
            private function fillByCategoryID(source:DictionaryData, target:DictionaryData, categoryID:int) : void { }
            private function rongLiangFill(source:DictionaryData, target:DictionaryData, CategoryID:int) : void { }
            private function rongLiangFunFill(source:DictionaryData, target:DictionaryData) : void { }
            private function fillByTemplateID(source:DictionaryData, target:DictionaryData, templateID:int) : void { }
            private function fillByProperty1AndProperty3(source:DictionaryData, target:DictionaryData, property1:String, property3:String) : void { }
            private function fillByProperty1(source:DictionaryData, target:DictionaryData, property1:String) : void { }
            private function findByTemplateID(source:DictionaryData, target:DictionaryData, templateId:int) : void { }
            public function sortOffHandList(propList:DictionaryData) : DictionaryData { return null; }
            private function fillOffHand(source:DictionaryData, target:DictionaryData, categoryID:int) : void { }
            public function sortEvolutionMaterialList(propList:DictionaryData) : DictionaryData { return null; }
            public function sortPropList(propList:DictionaryData, isCompose:Boolean = false) : DictionaryData { return null; }
            public function sortPropStrthList(propList:DictionaryData, isCompose:Boolean = false) : DictionaryData { return null; }
            private function bubbleSort(dic:Array) : void { }
            public function get info() : PlayerInfo { return null; }
            public function set currentPanel(currentPanel:int) : void { }
            public function get currentPanel() : int { return 0; }
            public function get canCpsEquipmentList() : DictionaryData { return null; }
            public function get canExaltEqpmtList() : DictionaryData { return null; }
            public function get canExaltAssistEqpmtList() : DictionaryData { return null; }
            public function get evolutionMaterialList() : DictionaryData { return null; }
            public function get canLianhuaEquipList() : DictionaryData { return null; }
            public function get canLianhuaPropList() : DictionaryData { return null; }
            public function get canStrthEqpmtList() : DictionaryData { return null; }
            public function get strthList() : DictionaryData { return null; }
            public function get exaltRock() : DictionaryData { return null; }
            public function get cpsAndANchList() : DictionaryData { return null; }
            public function get cpsAndStrthAndformula() : DictionaryData { return null; }
            public function get canRongLiangPropList() : DictionaryData { return null; }
            public function get canTransEquipmengtList() : DictionaryData { return null; }
            public function get canNotTransEquipmengtList() : DictionaryData { return null; }
            public function get canRongLiangEquipmengtList() : DictionaryData { return null; }
            public function get canEmbedEquipList() : DictionaryData { return null; }
            public function get canEmbedPropList() : DictionaryData { return null; }
            public function get canGhostEquipList() : DictionaryData { return null; }
            public function get canGhostPropList() : DictionaryData { return null; }
            public function set NeedAutoLink(value:int) : void { }
            public function get NeedAutoLink() : int { return 0; }
            public function checkEmbeded() : Boolean { return false; }
            public function loadBagData() : void { }
            public function clear() : void { }
   }}