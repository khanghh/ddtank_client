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
      
      public function MarkModel()
      {
         markTipsDic = new Dictionary();
         sellList = [];
         newSuits = [];
         _proNumInfoArr = [];
         bags = new Dictionary();
         super();
      }
      
      public static function exchangeMark(param1:ItemTemplateInfo) : MarkChipData
      {
         var _loc4_:InventoryItemInfo = param1 as InventoryItemInfo;
         var _loc2_:MarkChipData = new MarkChipData();
         if(!_loc4_)
         {
            return _loc2_;
         }
         _loc2_.itemID = _loc4_.ItemID;
         _loc2_.isbind = _loc4_.IsBinds;
         _loc2_.templateId = _loc4_.TemplateID;
         _loc2_.bornLv = _loc4_.StrengthenLevel;
         _loc2_.hammerLv = _loc4_.StrengthenExp;
         _loc2_.hLv = _loc4_.AttackCompose;
         var _loc8_:MarkProData = new MarkProData();
         _loc8_.type = _loc4_.DefendCompose;
         _loc8_.value = _loc4_.AgilityCompose;
         _loc8_.attachValue = _loc4_.LuckCompose;
         _loc2_.mainPro = _loc8_;
         var _loc7_:MarkProData = new MarkProData();
         _loc7_.type = _loc4_.Hole1;
         _loc7_.value = _loc4_.Hole2;
         _loc7_.attachValue = _loc4_.Hole3;
         _loc7_.hummerCount = _loc4_.Hole5Exp;
         _loc2_.props.push(_loc7_);
         var _loc6_:MarkProData = new MarkProData();
         _loc6_.type = _loc4_.Hole4;
         _loc6_.value = _loc4_.Hole5;
         _loc6_.attachValue = _loc4_.Hole6;
         _loc6_.hummerCount = _loc4_.Hole6Exp;
         _loc2_.props.push(_loc6_);
         var _loc5_:MarkProData = new MarkProData();
         _loc5_.type = _loc4_.ValidDate;
         _loc5_.value = _loc4_.RefineryLevel;
         _loc5_.attachValue = _loc4_.StrengthenTimes;
         _loc5_.hummerCount = _loc4_.Hole5Exp;
         _loc2_.props.push(_loc5_);
         var _loc3_:MarkProData = new MarkProData();
         if(_loc4_.Skin != null && _loc4_.Skin.split("|").length >= 3)
         {
            _loc3_.type = parseInt(_loc4_.Skin.split("|")[0]);
            _loc3_.value = parseInt(_loc4_.Skin.split("|")[1]);
            _loc3_.attachValue = parseInt(_loc4_.Skin.split("|")[2]);
         }
         _loc3_.hummerCount = _loc4_.Hole6Level;
         _loc2_.props.push(_loc3_);
         return _loc2_;
      }
      
      public static function exchangeItem(param1:MarkChipData) : InventoryItemInfo
      {
         var _loc2_:InventoryItemInfo = new InventoryItemInfo();
         _loc2_.IsBinds = param1.isbind;
         _loc2_.ItemID = param1.itemID;
         _loc2_.BagType = 74;
         _loc2_.TemplateID = param1.templateId;
         _loc2_.StrengthenLevel = param1.bornLv;
         _loc2_.StrengthenExp = param1.hammerLv;
         _loc2_.AttackCompose = param1.hLv;
         _loc2_.DefendCompose = param1.mainPro.type;
         _loc2_.AgilityCompose = param1.mainPro.value;
         _loc2_.LuckCompose = param1.mainPro.attachValue;
         _loc2_.Hole1 = param1.props[0].type;
         _loc2_.Hole2 = param1.props[0].value;
         _loc2_.Hole3 = param1.props[0].attachValue;
         _loc2_.Hole5Exp = param1.props[0].hummerCount;
         _loc2_.Hole4 = param1.props[1].type;
         _loc2_.Hole5 = param1.props[1].value;
         _loc2_.Hole6 = param1.props[1].attachValue;
         _loc2_.Hole6Exp = param1.props[1].hummerCount;
         _loc2_.ValidDate = Number(param1.props[2].type);
         _loc2_.RefineryLevel = param1.props[2].value;
         _loc2_.StrengthenTimes = param1.props[2].attachValue;
         _loc2_.Hole5Exp = param1.props[2].hummerCount;
         _loc2_.Skin = String(param1.props[3].type) + "|" + String(param1.props[3].value) + "|" + String(param1.props[3].attachValue);
         _loc2_.Hole6Level = param1.props[3].hummerCount;
         return _loc2_;
      }
      
      public function get proNumInfoArr() : Array
      {
         return _proNumInfoArr;
      }
      
      public function set proNumInfoArr(param1:Array) : void
      {
         _proNumInfoArr = param1;
      }
      
      public function proIsMax(param1:MarkProData) : Boolean
      {
         var _loc7_:int = 0;
         var _loc3_:Boolean = false;
         var _loc4_:int = param1.value + param1.attachValue;
         var _loc2_:MarkChipData = getChipById(MarkMgr.inst.model.chipItemID);
         var _loc5_:int = _loc2_.templateId;
         var _loc6_:int = param1.type;
         var _loc8_:int = 0;
         _loc7_ = 0;
         while(_loc7_ < _proNumInfoArr.length)
         {
            if((_proNumInfoArr[_loc7_] as MarkProNumData).ID == _loc5_ && (_proNumInfoArr[_loc7_] as MarkProNumData).AttributeType == param1.type)
            {
               _loc8_ = (_proNumInfoArr[_loc7_] as MarkProNumData).MaxValue;
            }
            _loc7_++;
         }
         _loc3_ = _loc4_ >= _loc8_ * (param1.hummerCount + 1)?true:false;
         return _loc3_;
      }
      
      public function getChipById(param1:*) : MarkChipData
      {
         var _loc4_:int = 0;
         var _loc3_:* = bags;
         for each(var _loc2_ in bags)
         {
            if(_loc2_.chips[param1])
            {
               return _loc2_.chips[param1];
            }
         }
         return null;
      }
      
      public function getSuitData(param1:int = -1) : Dictionary
      {
         param1 = param1 < 0?equip:int(param1);
         var _loc3_:Dictionary = new Dictionary();
         var _loc5_:int = 0;
         var _loc4_:* = bags[1].chips;
         for each(var _loc2_ in bags[1].chips)
         {
            if(_loc2_ && _loc2_.equipType == param1)
            {
               if(!_loc3_[cfgChip[_loc2_.templateId].SetID])
               {
                  _loc3_[cfgChip[_loc2_.templateId].SetID] = [];
               }
               _loc3_[cfgChip[_loc2_.templateId].SetID].push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getSuitList(param1:int = -1) : Array
      {
         param1 = param1 < 0?equip:int(param1);
         var _loc4_:Dictionary = getSuitData(param1);
         var _loc2_:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = cfgSuit;
         for each(var _loc3_ in cfgSuit)
         {
            if(_loc4_[_loc3_.SetId] && _loc3_.Demand <= _loc4_[_loc3_.SetId].length)
            {
               _loc2_.push({
                  "id":_loc3_.Id,
                  "cnt":_loc4_[_loc3_.SetId].length
               });
            }
         }
         return _loc2_;
      }
      
      public function getSkillList() : Array
      {
         var _loc3_:int = 0;
         var _loc1_:* = null;
         var _loc2_:Array = [];
         _loc3_ = 0;
         while(_loc3_ < getSuitList().length)
         {
            _loc1_ = new MarkSuitTemplateData();
            _loc1_.Id = getSuitList()[_loc3_].id;
            _loc3_++;
         }
         return _loc2_;
      }
      
      public function getChipsByEquipType(param1:int) : Vector.<MarkChipData>
      {
         var _loc3_:Vector.<MarkChipData> = new Vector.<MarkChipData>();
         var _loc5_:int = 0;
         var _loc4_:* = bags[1].chips;
         for each(var _loc2_ in bags[1].chips)
         {
            if(_loc2_ && _loc2_.equipType == param1)
            {
               _loc3_.push(_loc2_);
            }
         }
         return _loc3_;
      }
      
      public function getChipsCount(param1:int) : int
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = bags[1].chips;
         for each(var _loc2_ in bags[1].chips)
         {
            if(_loc2_ && _loc2_.equipType == param1)
            {
               _loc3_++;
            }
         }
         return _loc3_;
      }
   }
}
