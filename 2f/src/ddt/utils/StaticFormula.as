package ddt.utils{   import GodSyah.SyahManager;   import bagAndInfo.info.PlayerInfoViewControl;   import cardSystem.CardManager;   import cardSystem.CardTemplateInfoManager;   import cardSystem.data.CardInfo;   import cardSystem.data.CardTemplateInfo;   import ddt.data.BagInfo;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.PlayerInfo;   import ddt.manager.ItemManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.StateManager;   import road7th.data.DictionaryData;   import store.equipGhost.EquipGhostManager;   import store.equipGhost.data.GhostPropertyData;   import totem.TotemManager;      public class StaticFormula   {                   public function StaticFormula() { super(); }
            public static function getHertAddition(baseHert:int, strengthenLevel:int) : Number { return 0; }
            public static function getDefenseAddition(baseDefense:int, strengthenLevel:int) : Number { return 0; }
            public static function getRecoverHPAddition(baseRecover:int, strengthenLevel:int) : Number { return 0; }
            public static function getImmuneHertAddition(allDefense:int) : Number { return 0; }
            public static function isDeputyWeapon($info:ItemTemplateInfo) : Boolean { return false; }
            public static function getActionValue(info:PlayerInfo) : int { return 0; }
            public static function isShield(info:PlayerInfo) : Boolean { return false; }
            public static function getDamage(info:PlayerInfo) : int { return 0; }
            private static function getGhostPropertyData(info:InventoryItemInfo) : GhostPropertyData { return null; }
            public static function getSuitAddition(info:PlayerInfo, key:String) : int { return 0; }
            public static function getCardDamageAddition(info:PlayerInfo) : int { return 0; }
            public static function getRecovery(info:PlayerInfo) : int { return 0; }
            public static function getCardRecoveryAddition(info:PlayerInfo) : int { return 0; }
            public static function getMaxHp(info:PlayerInfo) : int { return 0; }
            public static function getEnergy(info:PlayerInfo) : int { return 0; }
            private static function isDamageJewel(item:ItemTemplateInfo) : Boolean { return false; }
            public static function getBeadDamage(info:PlayerInfo) : int { return 0; }
            public static function getBeadRecovery(info:PlayerInfo) : int { return 0; }
            public static function getJewelDamage(itemInfo:InventoryItemInfo) : int { return 0; }
            public static function getJewelRecovery(itemInfo:InventoryItemInfo) : int { return 0; }
   }}