package bagAndInfo
{
   import bagAndInfo.amulet.EquipAmuletManager;
   import bagAndInfo.info.PlayerInfoViewControl;
   import ddt.data.EquipType;
   import ddt.data.Experience;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.manager.PlayerManager;
   import ddt.utils.StaticFormula;
   import explorerManual.data.model.PlayerManualProInfo;
   import store.equipGhost.EquipGhostManager;
   import store.equipGhost.data.GhostPropertyData;
   
   public class PlayerProValueAddManager
   {
       
      
      public function PlayerProValueAddManager()
      {
         super();
      }
      
      public static function equipAddProValue(proName:String, info:PlayerInfo) : int
      {
         var item:* = null;
         var i:int = 0;
         var proValue:int = 0;
         for(i = 0; i < 19; )
         {
            item = info.Bag.getItemAt(i);
            if(item && item.hasOwnProperty(proName))
            {
               proValue = proValue + int(item[proName]);
            }
            if(item && item.hasOwnProperty(proName + "Compose"))
            {
               proValue = proValue + int(item[proName + "Compose"]);
            }
            if(item && EquipType.isArm(item) && proName == "AddDamage")
            {
               proValue = proValue + (strengthenAddDamageProValue(item) + getGhostPropertyData(item));
            }
            if(item && (EquipType.isHead(item) || EquipType.isCloth(item)) && proName == "Arm")
            {
               proValue = proValue + (strengthenAddDamageProValue(item) + getGhostPropertyData(item));
            }
            i++;
         }
         return proValue;
      }
      
      private static function getGhostPropertyData(_info:InventoryItemInfo) : int
      {
         var ghostPropertyData:GhostPropertyData = null;
         var ivenInfo:InventoryItemInfo = _info as InventoryItemInfo;
         if(ivenInfo == null)
         {
            return 0;
         }
         var player:PlayerInfo = PlayerInfoViewControl.currentPlayer || PlayerManager.Instance.Self;
         var isOther:* = player.ID != PlayerManager.Instance.Self.ID;
         var isWearedEquip:Boolean = ivenInfo.BagType == 0 && ivenInfo.Place <= 30;
         if(isOther)
         {
            ghostPropertyData = !!isWearedEquip?EquipGhostManager.getInstance().getPorpertyData(ivenInfo,player):null;
         }
         else
         {
            ghostPropertyData = ivenInfo.fromBag && (isWearedEquip || EquipGhostManager.getInstance().isEquipGhosting())?EquipGhostManager.getInstance().getPorpertyData(ivenInfo,player):null;
         }
         return !!ghostPropertyData?int(ghostPropertyData.mainProperty):0;
      }
      
      public static function strengthenAddDamageProValue(gInfo:InventoryItemInfo) : int
      {
         var strengthenLevel:int = !!gInfo.isGold?gInfo.StrengthenLevel + 1:gInfo.StrengthenLevel;
         var strenGold:int = StaticFormula.getHertAddition(int(gInfo.Property7),strengthenLevel);
         return strenGold;
      }
      
      public static function equipAddHPValue(info:PlayerInfo) : int
      {
         var totalHp:int = 0;
         var hp1:int = 0;
         var hp2:int = 0;
         var item1:InventoryItemInfo = info.Bag.getItemAt(18);
         if(item1 && item1.CanUse)
         {
            hp1 = EquipAmuletManager.Instance.getAmuletHpByGrade(item1.StrengthenLevel);
            totalHp = totalHp + hp1;
         }
         var item2:InventoryItemInfo = info.Bag.getItemAt(12);
         if(item2)
         {
            hp2 = Experience.getBasicHP(info.Grade) * int(item2.Property1) / 100;
            totalHp = totalHp + hp2;
         }
         return totalHp;
      }
      
      public static function manualAddProValue(proName:String, info:PlayerInfo) : int
      {
         var total:int = 0;
         var temInfo:PlayerManualProInfo = info.manualProInfo;
         if(temInfo && temInfo.hasOwnProperty(proName))
         {
            total = temInfo[proName];
         }
         return total;
      }
   }
}
