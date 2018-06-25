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
      
      public static function exchangeMark(info:ItemTemplateInfo) : MarkChipData
      {
         var item:InventoryItemInfo = info as InventoryItemInfo;
         var chip:MarkChipData = new MarkChipData();
         if(!item)
         {
            return chip;
         }
         chip.itemID = item.ItemID;
         chip.isbind = item.IsBinds;
         chip.isShowBind = item.isShowBind;
         chip.templateId = item.TemplateID;
         chip.bornLv = item.StrengthenLevel;
         chip.hammerLv = item.StrengthenExp;
         chip.hLv = item.AttackCompose;
         var pro1:MarkProData = new MarkProData();
         pro1.type = item.DefendCompose;
         pro1.value = item.AgilityCompose;
         pro1.attachValue = item.LuckCompose;
         chip.mainPro = pro1;
         var pro2:MarkProData = new MarkProData();
         pro2.type = item.Hole1;
         pro2.value = item.Hole2;
         pro2.attachValue = item.Hole3;
         pro2.hummerCount = item.Hole5Exp;
         chip.props.push(pro2);
         var pro3:MarkProData = new MarkProData();
         pro3.type = item.Hole4;
         pro3.value = item.Hole5;
         pro3.attachValue = item.Hole6;
         pro3.hummerCount = item.Hole6Exp;
         chip.props.push(pro3);
         var pro4:MarkProData = new MarkProData();
         pro4.type = item.ValidDate;
         pro4.value = item.RefineryLevel;
         pro4.attachValue = item.StrengthenTimes;
         pro4.hummerCount = item.Hole5Exp;
         chip.props.push(pro4);
         var pro5:MarkProData = new MarkProData();
         if(item.Skin != null && item.Skin.split("|").length >= 3)
         {
            pro5.type = parseInt(item.Skin.split("|")[0]);
            pro5.value = parseInt(item.Skin.split("|")[1]);
            pro5.attachValue = parseInt(item.Skin.split("|")[2]);
         }
         pro5.hummerCount = item.Hole6Level;
         chip.props.push(pro5);
         return chip;
      }
      
      public static function exchangeItem(chip:MarkChipData) : InventoryItemInfo
      {
         var item:InventoryItemInfo = new InventoryItemInfo();
         item.IsBinds = chip.isbind;
         item.isShowBind = chip.isShowBind;
         item.ItemID = chip.itemID;
         item.BagType = 74;
         item.TemplateID = chip.templateId;
         item.StrengthenLevel = chip.bornLv;
         item.StrengthenExp = chip.hammerLv;
         item.AttackCompose = chip.hLv;
         item.DefendCompose = chip.mainPro.type;
         item.AgilityCompose = chip.mainPro.value;
         item.LuckCompose = chip.mainPro.attachValue;
         item.Hole1 = chip.props[0].type;
         item.Hole2 = chip.props[0].value;
         item.Hole3 = chip.props[0].attachValue;
         item.Hole5Exp = chip.props[0].hummerCount;
         item.Hole4 = chip.props[1].type;
         item.Hole5 = chip.props[1].value;
         item.Hole6 = chip.props[1].attachValue;
         item.Hole6Exp = chip.props[1].hummerCount;
         item.ValidDate = Number(chip.props[2].type);
         item.RefineryLevel = chip.props[2].value;
         item.StrengthenTimes = chip.props[2].attachValue;
         item.Hole5Exp = chip.props[2].hummerCount;
         item.Skin = String(chip.props[3].type) + "|" + String(chip.props[3].value) + "|" + String(chip.props[3].attachValue);
         item.Hole6Level = chip.props[3].hummerCount;
         return item;
      }
      
      public function get proNumInfoArr() : Array
      {
         return _proNumInfoArr;
      }
      
      public function set proNumInfoArr(value:Array) : void
      {
         _proNumInfoArr = value;
      }
      
      public function proIsMax(pro:MarkProData) : Boolean
      {
         var i:int = 0;
         var boo:Boolean = false;
         var totol:int = pro.value + pro.attachValue;
         var chip:MarkChipData = getChipById(MarkMgr.inst.model.chipItemID);
         var templeteId:int = chip.templateId;
         var type:int = pro.type;
         var maxValue:int = 0;
         for(i = 0; i < _proNumInfoArr.length; )
         {
            if((_proNumInfoArr[i] as MarkProNumData).ID == templeteId && (_proNumInfoArr[i] as MarkProNumData).AttributeType == pro.type)
            {
               maxValue = (_proNumInfoArr[i] as MarkProNumData).MaxValue;
            }
            i++;
         }
         boo = totol >= maxValue * (pro.hummerCount + 1)?true:false;
         return boo;
      }
      
      public function getChipById(itemId:int) : MarkChipData
      {
         var _loc4_:int = 0;
         var _loc3_:* = bags;
         for each(var bag in bags)
         {
            if(bag.chips[itemId])
            {
               return bag.chips[itemId];
            }
         }
         return null;
      }
      
      public function getSetById(itemId:int) : int
      {
         var chip:* = null;
         var _loc5_:int = 0;
         var _loc4_:* = bags;
         for each(var bag in bags)
         {
            if(bag.chips[itemId])
            {
               chip = bag.chips[itemId];
               return cfgChip[chip.templateId].SetID;
            }
         }
         return 0;
      }
      
      public function getSuitData(equipType:int = -1) : Dictionary
      {
         equipType = equipType < 0?equip:int(equipType);
         var dic:Dictionary = new Dictionary();
         var _loc5_:int = 0;
         var _loc4_:* = bags[1].chips;
         for each(var chip in bags[1].chips)
         {
            if(chip && chip.equipType == equipType)
            {
               if(!dic[cfgChip[chip.templateId].SetID])
               {
                  dic[cfgChip[chip.templateId].SetID] = [];
               }
               dic[cfgChip[chip.templateId].SetID].push(chip);
            }
         }
         return dic;
      }
      
      public function getSuitList(equipType:int = -1) : Array
      {
         equipType = equipType < 0?equip:int(equipType);
         var dic:Dictionary = getSuitData(equipType);
         var result:Array = [];
         var _loc6_:int = 0;
         var _loc5_:* = cfgSuit;
         for each(var it in cfgSuit)
         {
            if(dic[it.SetId] && it.Demand <= dic[it.SetId].length)
            {
               result.push({
                  "id":it.Id,
                  "cnt":dic[it.SetId].length
               });
            }
         }
         return result;
      }
      
      public function getSkillList() : Array
      {
         var i:int = 0;
         var skill:* = null;
         var arr:Array = [];
         for(i = 0; i < getSuitList().length; )
         {
            skill = new MarkSuitTemplateData();
            skill.Id = getSuitList()[i].id;
            i++;
         }
         return arr;
      }
      
      public function getChipsByEquipType(equipType:int) : Vector.<MarkChipData>
      {
         var list:Vector.<MarkChipData> = new Vector.<MarkChipData>();
         var _loc5_:int = 0;
         var _loc4_:* = bags[1].chips;
         for each(var chip in bags[1].chips)
         {
            if(chip && chip.equipType == equipType)
            {
               list.push(chip);
            }
         }
         return list;
      }
      
      public function getChipsJoinById() : String
      {
         var i:int = 0;
         var arr:Array = [];
         for(i = 0; i < 36; )
         {
            arr[i] = 0;
            var _loc5_:int = 0;
            var _loc4_:* = bags[1].chips;
            for each(var chip in bags[1].chips)
            {
               if(chip && chip.position == i + 1)
               {
                  arr[i] = chip.itemID;
                  break;
               }
            }
            i++;
         }
         return arr.join(",");
      }
      
      public function getChipsCount(equipType:int) : int
      {
         var i:int = 0;
         var _loc5_:int = 0;
         var _loc4_:* = bags[1].chips;
         for each(var chip in bags[1].chips)
         {
            if(chip && chip.equipType == equipType)
            {
               i++;
            }
         }
         return i;
      }
   }
}
