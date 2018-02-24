package mark.data
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import flash.utils.Dictionary;
   import mark.MarkMgr;
   
   public class MarkModel
   {
      
      public static const OPERATION_SUIT:int = 0;
      
      public static const EQUIP_LIST:Array = [0,2,3,5,11,4];
      
      public static const TRANSFER_STONE_ID:int = 12200;
       
      
      public var markTipsDic:Dictionary;
      
      public var userId:int;
      
      public var equip:int = -1;
      
      public var chipItemID:int = 0;
      
      public var sellStatus:Boolean = false;
      
      public var sellList:Array;
      
      public var suits:Array = null;
      
      public var markMoney:int = 0;
      
      public var crystalDic:Dictionary = null;
      
      public var transferPro:MarkProData = null;
      
      public var old:Boolean = false;
      
      public var newSuits:Array;
      
      private var _proNumInfoArr:Array;
      
      public var bags:Dictionary;
      
      public var cfgChip:Dictionary = null;
      
      public var cfgSuit:Dictionary = null;
      
      public var cfgSet:Dictionary = null;
      
      public var cfgHammer:Array = null;
      
      public var cfgTransfer:Array = null;
      
      public function MarkModel(){super();}
      
      public static function exchangeMark(param1:ItemTemplateInfo) : MarkChipData{return null;}
      
      public static function exchangeItem(param1:MarkChipData) : InventoryItemInfo{return null;}
      
      public function get proNumInfoArr() : Array{return null;}
      
      public function set proNumInfoArr(param1:Array) : void{}
      
      public function proIsMax(param1:MarkProData) : Boolean{return false;}
      
      public function getChipById(param1:*) : MarkChipData{return null;}
      
      public function getSuitData(param1:int = -1) : Dictionary{return null;}
      
      public function getSuitList(param1:int = -1) : Array{return null;}
      
      public function getSkillList() : Array{return null;}
      
      public function getChipsByEquipType(param1:int) : Vector.<MarkChipData>{return null;}
      
      public function getChipsCount(param1:int) : int{return 0;}
   }
}
