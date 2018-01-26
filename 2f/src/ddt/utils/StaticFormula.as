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
       
      
      public function StaticFormula(){super();}
      
      public static function getHertAddition(param1:int, param2:int) : Number{return 0;}
      
      public static function getDefenseAddition(param1:int, param2:int) : Number{return 0;}
      
      public static function getRecoverHPAddition(param1:int, param2:int) : Number{return 0;}
      
      public static function getImmuneHertAddition(param1:int) : Number{return 0;}
      
      public static function isDeputyWeapon(param1:ItemTemplateInfo) : Boolean{return false;}
      
      public static function getActionValue(param1:PlayerInfo) : int{return 0;}
      
      public static function isShield(param1:PlayerInfo) : Boolean{return false;}
      
      public static function getDamage(param1:PlayerInfo) : int{return 0;}
      
      private static function getGhostPropertyData(param1:InventoryItemInfo) : GhostPropertyData{return null;}
      
      public static function getSuitAddition(param1:PlayerInfo, param2:String) : int{return 0;}
      
      public static function getCardDamageAddition(param1:PlayerInfo) : int{return 0;}
      
      public static function getRecovery(param1:PlayerInfo) : int{return 0;}
      
      public static function getCardRecoveryAddition(param1:PlayerInfo) : int{return 0;}
      
      public static function getMaxHp(param1:PlayerInfo) : int{return 0;}
      
      public static function getEnergy(param1:PlayerInfo) : int{return 0;}
      
      private static function isDamageJewel(param1:ItemTemplateInfo) : Boolean{return false;}
      
      public static function getBeadDamage(param1:PlayerInfo) : int{return 0;}
      
      public static function getBeadRecovery(param1:PlayerInfo) : int{return 0;}
      
      public static function getJewelDamage(param1:InventoryItemInfo) : int{return 0;}
      
      public static function getJewelRecovery(param1:InventoryItemInfo) : int{return 0;}
   }
}
