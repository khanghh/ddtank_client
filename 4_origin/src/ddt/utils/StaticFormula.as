package ddt.utils
{
   import GodSyah.SyahManager;
   import bagAndInfo.info.PlayerInfoViewControl;
   import cardSystem.CardManager;
   import cardSystem.CardTemplateInfoManager;
   import cardSystem.data.CardInfo;
   import cardSystem.data.CardTemplateInfo;
   import ddt.data.BagInfo;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.PathManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.StateManager;
   import road7th.data.DictionaryData;
   import store.equipGhost.EquipGhostManager;
   import store.equipGhost.data.GhostPropertyData;
   import totem.TotemManager;
   
   public class StaticFormula
   {
       
      
      public function StaticFormula()
      {
         super();
      }
      
      public static function getHertAddition(param1:int, param2:int) : Number
      {
         var _loc3_:Number = param1 * Math.pow(1.1,param2) - param1;
         return Math.round(_loc3_);
      }
      
      public static function getDefenseAddition(param1:int, param2:int) : Number
      {
         var _loc3_:Number = param1 * Math.pow(1.1,param2) - param1;
         return Math.round(_loc3_);
      }
      
      public static function getRecoverHPAddition(param1:int, param2:int) : Number
      {
         var _loc3_:Number = param1 * Math.pow(1.1,param2) - param1;
         return Math.floor(_loc3_);
      }
      
      public static function getImmuneHertAddition(param1:int) : Number
      {
         var _loc2_:Number = 0.95 * param1 / (param1 + 500);
         _loc2_ = _loc2_ * 100;
         return Number(_loc2_.toFixed(1));
      }
      
      public static function isDeputyWeapon(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.TemplateID >= 17000 && param1.TemplateID <= 17020)
         {
            return true;
         }
         return false;
      }
      
      public static function getActionValue(param1:PlayerInfo) : int
      {
         var _loc2_:int = 0;
         _loc2_ = (param1.Attack + param1.Agility + param1.Luck + param1.Defence + 1000) * (Math.pow(getDamage(param1),3) + Math.pow(getRecovery(param1),3) * 3.5) / 100000000 + getMaxHp(param1) * 0.95 - 950;
         return _loc2_;
      }
      
      public static function isShield(param1:PlayerInfo) : Boolean
      {
         return false;
      }
      
      public static function getDamage(param1:PlayerInfo) : int
      {
         var _loc3_:int = 0;
         var _loc2_:* = null;
         if(param1.ZoneID != 0 && StateManager.currentStateType == "fighting" && param1.ZoneID != PlayerManager.Instance.Self.ZoneID)
         {
            return -1;
         }
         var _loc4_:InventoryItemInfo = param1.Bag.items[6] as InventoryItemInfo;
         if(_loc4_)
         {
            _loc3_ = getHertAddition(int(_loc4_.Property7),_loc4_.StrengthenLevel + (!!_loc4_.isGold?1:0)) + int(_loc4_.Property7);
            _loc2_ = getGhostPropertyData(_loc4_);
            if(_loc2_)
            {
               _loc3_ = _loc3_ + _loc2_.mainProperty;
            }
         }
         if(param1.propertyAddition && param1.propertyAddition["Damage"])
         {
            _loc3_ = _loc3_ + (!!param1.propertyAddition["Damage"]["Bead"]?param1.propertyAddition["Damage"]["Bead"]:0);
            _loc3_ = _loc3_ + (!!param1.propertyAddition["Damage"]["Avatar"]?param1.propertyAddition["Damage"]["Avatar"]:0);
            _loc3_ = _loc3_ + param1.manualProInfo.pro_Damage;
            _loc3_ = _loc3_ + (!!param1.propertyAddition["Damage"]["Horse"]?param1.propertyAddition["Damage"]["Horse"]:0);
            _loc3_ = _loc3_ + (!!param1.propertyAddition["Damage"]["HorsePicCherish"]?param1.propertyAddition["Damage"]["HorsePicCherish"]:0);
            _loc3_ = _loc3_ + (!!param1.propertyAddition["Damage"]["Temple"]?param1.propertyAddition["Damage"]["Temple"]:0);
            _loc3_ = _loc3_ + (!!param1.propertyAddition["Damage"]["mark"]?param1.propertyAddition["Damage"]["mark"]:0);
         }
         _loc3_ = _loc3_ + getCardDamageAddition(param1);
         if(PathManager.suitEnable)
         {
            _loc3_ = _loc3_ + getSuitAddition(param1,"Damage");
         }
         _loc3_ = _loc3_ + TotemManager.instance.getAddInfo(TotemManager.instance.getTotemPointLevel(param1.totemId)).Damage;
         _loc3_ = _loc3_ + SyahManager.Instance.totalDamage;
         return _loc3_;
      }
      
      private static function getGhostPropertyData(param1:InventoryItemInfo) : GhostPropertyData
      {
         var _loc5_:GhostPropertyData = null;
         var _loc3_:* = param1;
         if(_loc3_ == null)
         {
            return null;
         }
         var _loc4_:PlayerInfo = PlayerInfoViewControl.currentPlayer || PlayerManager.Instance.Self;
         var _loc6_:* = _loc4_.ID != PlayerManager.Instance.Self.ID;
         var _loc2_:Boolean = _loc3_.BagType == 0 && _loc3_.Place <= 30;
         _loc5_ = !!_loc2_?EquipGhostManager.getInstance().getPorpertyData(_loc3_,_loc4_):null;
         return _loc5_;
      }
      
      public static function getSuitAddition(param1:PlayerInfo, param2:String) : int
      {
         if(param1.propertyAddition == null)
         {
            return 0;
         }
         var _loc4_:int = 0;
         var _loc3_:DictionaryData = param1.getPropertyAdditionByType(param2);
         if(_loc3_ && _loc3_["Suit"])
         {
            _loc4_ = _loc3_["Suit"];
         }
         return _loc4_;
      }
      
      public static function getCardDamageAddition(param1:PlayerInfo) : int
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = param1.cardEquipDic.list;
         for each(var _loc4_ in param1.cardEquipDic.list)
         {
            _loc2_ = CardTemplateInfoManager.instance.getInfoByCardId(String(_loc4_.TemplateID),String(_loc4_.CardType));
            _loc3_ = _loc3_ + (int(_loc2_.AddDamage) + _loc4_.Damage);
         }
         _loc3_ = _loc3_ + CardManager.Instance.model.achievementProperty[5];
         return _loc3_;
      }
      
      public static function getRecovery(param1:PlayerInfo) : int
      {
         var _loc4_:int = 0;
         var _loc2_:* = null;
         if(param1.ZoneID != 0 && StateManager.currentStateType == "fighting" && param1.ZoneID != PlayerManager.Instance.Self.ZoneID)
         {
            return -1;
         }
         var _loc3_:InventoryItemInfo = param1.Bag.items[0] as InventoryItemInfo;
         if(_loc3_)
         {
            _loc4_ = getDefenseAddition(int(_loc3_.Property7),_loc3_.StrengthenLevel + (!!_loc3_.isGold?1:0)) + int(_loc3_.Property7);
            _loc2_ = getGhostPropertyData(_loc3_);
            if(_loc2_)
            {
               _loc4_ = _loc4_ + _loc2_.mainProperty;
            }
         }
         _loc3_ = param1.Bag.items[4] as InventoryItemInfo;
         if(_loc3_)
         {
            _loc4_ = _loc4_ + (getDefenseAddition(int(_loc3_.Property7),_loc3_.StrengthenLevel + (!!_loc3_.isGold?1:0)) + int(_loc3_.Property7));
            _loc2_ = getGhostPropertyData(_loc3_);
            if(_loc2_)
            {
               _loc4_ = _loc4_ + _loc2_.mainProperty;
            }
         }
         if(param1.propertyAddition && param1.propertyAddition["Armor"])
         {
            _loc4_ = _loc4_ + (!!param1.propertyAddition["Armor"]["FineSuit"]?param1.propertyAddition["Armor"]["FineSuit"]:0);
            _loc4_ = _loc4_ + param1.manualProInfo.pro_Armor;
            _loc4_ = _loc4_ + (!!param1.propertyAddition["Armor"]["Bead"]?param1.propertyAddition["Armor"]["Bead"]:0);
            _loc4_ = _loc4_ + (!!param1.propertyAddition["Armor"]["Avatar"]?param1.propertyAddition["Armor"]["Avatar"]:0);
            _loc4_ = _loc4_ + (!!param1.propertyAddition["Armor"]["Horse"]?param1.propertyAddition["Armor"]["Horse"]:0);
            _loc4_ = _loc4_ + (!!param1.propertyAddition["Armor"]["HorsePicCherish"]?param1.propertyAddition["Armor"]["HorsePicCherish"]:0);
            _loc4_ = _loc4_ + (!!param1.propertyAddition["Armor"]["Pet"]?param1.propertyAddition["Armor"]["Pet"]:0);
            _loc4_ = _loc4_ + (!!param1.propertyAddition["Armor"]["Temple"]?param1.propertyAddition["Armor"]["Temple"]:0);
            _loc4_ = _loc4_ + (!!param1.propertyAddition["Armor"]["mark"]?param1.propertyAddition["Armor"]["mark"]:0);
         }
         _loc4_ = _loc4_ + getCardRecoveryAddition(param1);
         if(PathManager.suitEnable)
         {
            _loc4_ = _loc4_ + getSuitAddition(param1,"Guard");
         }
         _loc4_ = _loc4_ + TotemManager.instance.getAddInfo(TotemManager.instance.getTotemPointLevel(param1.totemId)).Guard;
         _loc4_ = _loc4_ + SyahManager.Instance.totalArmor;
         return _loc4_;
      }
      
      public static function getCardRecoveryAddition(param1:PlayerInfo) : int
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc5_:* = param1.cardEquipDic.list;
         for each(var _loc3_ in param1.cardEquipDic.list)
         {
            _loc2_ = CardTemplateInfoManager.instance.getInfoByCardId(String(_loc3_.TemplateID),String(_loc3_.CardType));
            _loc4_ = _loc4_ + (int(_loc2_.AddGuard) + _loc3_.Guard);
         }
         _loc4_ = _loc4_ + CardManager.Instance.model.achievementProperty[3];
         return _loc4_;
      }
      
      public static function getMaxHp(param1:PlayerInfo) : int
      {
         return param1.hp;
      }
      
      public static function getEnergy(param1:PlayerInfo) : int
      {
         if(param1.ZoneID != 0 && StateManager.currentStateType == "fighting" && param1.ZoneID != PlayerManager.Instance.Self.ZoneID)
         {
            return -1;
         }
         var _loc2_:int = 0;
         _loc2_ = 240 + param1.Agility / 30;
         return _loc2_;
      }
      
      private static function isDamageJewel(param1:ItemTemplateInfo) : Boolean
      {
         if(param1.CategoryID == 11 && param1.Property1 == "31" && param1.Property2 == "3")
         {
            return true;
         }
         return false;
      }
      
      public static function getBeadDamage(param1:PlayerInfo) : int
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:BagInfo = param1.BeadBag;
         _loc5_ = 3;
         while(_loc5_ < 12)
         {
            _loc3_ = _loc2_.items[_loc5_];
            if(_loc3_ && isDamageJewel(_loc3_))
            {
               _loc4_ = _loc4_ + int(_loc3_.Property7);
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function getBeadRecovery(param1:PlayerInfo) : int
      {
         var _loc5_:int = 0;
         var _loc3_:* = null;
         var _loc4_:int = 0;
         var _loc2_:BagInfo = param1.BeadBag;
         _loc5_ = 3;
         while(_loc5_ < 12)
         {
            _loc3_ = _loc2_.items[_loc5_];
            if(_loc3_)
            {
               _loc4_ = _loc4_ + int(_loc3_.Property8);
            }
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function getJewelDamage(param1:InventoryItemInfo) : int
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            return 0;
         }
         if(param1.Hole1 != -1 && param1.Hole1 != 0 && int(param1.StrengthenLevel / 3) >= 1)
         {
            if(isDamageJewel(ItemManager.Instance.getTemplateById(param1.Hole1)))
            {
               _loc2_ = _loc2_ + int(ItemManager.Instance.getTemplateById(param1.Hole1).Property7);
            }
         }
         if(param1.Hole2 != -1 && param1.Hole2 != 0 && int(param1.StrengthenLevel / 3) >= 2)
         {
            if(isDamageJewel(ItemManager.Instance.getTemplateById(param1.Hole2)))
            {
               _loc2_ = _loc2_ + int(ItemManager.Instance.getTemplateById(param1.Hole2).Property7);
            }
         }
         if(param1.Hole3 != -1 && param1.Hole3 != 0 && int(param1.StrengthenLevel / 3) >= 3)
         {
            if(isDamageJewel(ItemManager.Instance.getTemplateById(param1.Hole3)))
            {
               _loc2_ = _loc2_ + int(ItemManager.Instance.getTemplateById(param1.Hole3).Property7);
            }
         }
         if(param1.Hole4 != -1 && param1.Hole4 != 0 && int(param1.StrengthenLevel / 3) >= 4)
         {
            if(isDamageJewel(ItemManager.Instance.getTemplateById(param1.Hole4)))
            {
               _loc2_ = _loc2_ + int(ItemManager.Instance.getTemplateById(param1.Hole4).Property7);
            }
         }
         if(param1.Hole5 != -1 && param1.Hole5 != 0 && param1.Hole5Level > 0)
         {
            if(isDamageJewel(ItemManager.Instance.getTemplateById(param1.Hole5)))
            {
               _loc2_ = _loc2_ + int(ItemManager.Instance.getTemplateById(param1.Hole5).Property7);
            }
         }
         if(param1.Hole6 != -1 && param1.Hole6 != 0 && param1.Hole6Level > 0)
         {
            if(isDamageJewel(ItemManager.Instance.getTemplateById(param1.Hole6)))
            {
               _loc2_ = _loc2_ + int(ItemManager.Instance.getTemplateById(param1.Hole6).Property7);
            }
         }
         return _loc2_;
      }
      
      public static function getJewelRecovery(param1:InventoryItemInfo) : int
      {
         var _loc2_:int = 0;
         if(!param1)
         {
            return 0;
         }
         if(param1.Hole1 != -1 && param1.Hole1 != 0 && int(param1.StrengthenLevel / 3) >= 1)
         {
            _loc2_ = _loc2_ + int(ItemManager.Instance.getTemplateById(param1.Hole1).Property8);
         }
         if(param1.Hole2 != -1 && param1.Hole2 != 0 && int(param1.StrengthenLevel / 3) >= 2)
         {
            _loc2_ = _loc2_ + int(ItemManager.Instance.getTemplateById(param1.Hole2).Property8);
         }
         if(param1.Hole3 != -1 && param1.Hole3 != 0 && int(param1.StrengthenLevel / 3) >= 3)
         {
            _loc2_ = _loc2_ + int(ItemManager.Instance.getTemplateById(param1.Hole3).Property8);
         }
         if(param1.Hole4 != -1 && param1.Hole4 != 0 && int(param1.StrengthenLevel / 3) >= 4)
         {
            _loc2_ = _loc2_ + int(ItemManager.Instance.getTemplateById(param1.Hole4).Property8);
         }
         if(param1.Hole5 != -1 && param1.Hole5 != 0 && param1.Hole5Level > 0)
         {
            _loc2_ = _loc2_ + int(ItemManager.Instance.getTemplateById(param1.Hole5).Property8);
         }
         if(param1.Hole6 != -1 && param1.Hole6 != 0 && param1.Hole6Level > 0)
         {
            _loc2_ = _loc2_ + int(ItemManager.Instance.getTemplateById(param1.Hole6).Property8);
         }
         return _loc2_;
      }
   }
}
