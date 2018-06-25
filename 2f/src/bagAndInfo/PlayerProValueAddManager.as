package bagAndInfo{   import bagAndInfo.amulet.EquipAmuletManager;   import bagAndInfo.info.PlayerInfoViewControl;   import ddt.data.EquipType;   import ddt.data.Experience;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.player.PlayerInfo;   import ddt.manager.PlayerManager;   import ddt.utils.StaticFormula;   import explorerManual.data.model.PlayerManualProInfo;   import store.equipGhost.EquipGhostManager;   import store.equipGhost.data.GhostPropertyData;      public class PlayerProValueAddManager   {                   public function PlayerProValueAddManager() { super(); }
            public static function equipAddProValue(proName:String, info:PlayerInfo) : int { return 0; }
            private static function getGhostPropertyData(_info:InventoryItemInfo) : int { return 0; }
            public static function strengthenAddDamageProValue(gInfo:InventoryItemInfo) : int { return 0; }
            public static function equipAddHPValue(info:PlayerInfo) : int { return 0; }
            public static function manualAddProValue(proName:String, info:PlayerInfo) : int { return 0; }
   }}