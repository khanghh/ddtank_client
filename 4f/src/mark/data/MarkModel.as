package mark.data{   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import flash.utils.Dictionary;   import mark.MarkMgr;      public class MarkModel   {            public static const OPERATION_SUIT:int = 0;            public static const EQUIP_LIST:Array = [0,2,3,5,11,4];            public static const TRANSFER_STONE_ID:int = 12200;                   public var markTipsDic:Dictionary;            public var userId:int;            public var equip:int = -1;            public var chipItemID:int = 0;            public var sellStatus:Boolean = false;            public var sellList:Array;            public var suits:Array = null;            public var markMoney:int = 0;            public var crystalDic:Dictionary = null;            public var transferPro:MarkProData = null;            public var old:Boolean = false;            public var newSuits:Array;            private var _proNumInfoArr:Array;            public var bags:Dictionary;            public var cfgChip:Dictionary = null;            public var cfgSuit:Dictionary = null;            public var cfgSet:Dictionary = null;            public var cfgHammer:Array = null;            public var cfgTransfer:Array = null;            public function MarkModel() { super(); }
            public static function exchangeMark(info:ItemTemplateInfo) : MarkChipData { return null; }
            public static function exchangeItem(chip:MarkChipData) : InventoryItemInfo { return null; }
            public function get proNumInfoArr() : Array { return null; }
            public function set proNumInfoArr(value:Array) : void { }
            public function proIsMax(pro:MarkProData) : Boolean { return false; }
            public function getChipById(itemId:int) : MarkChipData { return null; }
            public function getSetById(itemId:int) : int { return 0; }
            public function getSuitData(equipType:int = -1) : Dictionary { return null; }
            public function getSuitList(equipType:int = -1) : Array { return null; }
            public function getSkillList() : Array { return null; }
            public function getChipsByEquipType(equipType:int) : Vector.<MarkChipData> { return null; }
            public function getChipsJoinById() : String { return null; }
            public function getChipsCount(equipType:int) : int { return 0; }
   }}