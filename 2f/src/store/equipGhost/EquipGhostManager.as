package store.equipGhost{   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.player.PlayerInfo;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.utils.StaticFormula;   import flash.events.EventDispatcher;   import flash.utils.getTimer;   import road7th.comm.PackageIn;   import store.equipGhost.data.EquipGhostData;   import store.equipGhost.data.GhostData;   import store.equipGhost.data.GhostDataAnalyzer;   import store.equipGhost.data.GhostModel;   import store.equipGhost.data.GhostPropertyData;      public class EquipGhostManager extends EventDispatcher   {            private static const _TIME:uint = 1;            private static const _WAIT_TIME:Number = 1000;            private static var _instance:EquipGhostManager;                   private var _model:GhostModel;            private var _equip:InventoryItemInfo;            private var _luckyMaterial:InventoryItemInfo;            private var _stoneMaterial:InventoryItemInfo;            private var _protectedID:uint;            private var _lastTime:Number = 0;            public function EquipGhostManager(single:SingleTon) { super(); }
            public static function getInstance() : EquipGhostManager { return null; }
            private function init() : void { }
            private function initData() : void { }
            public function initEvent() : void { }
            public function analyzerCompleteHandler(analyzer:GhostDataAnalyzer) : void { }
            public function get model() : GhostModel { return null; }
            public function chooseEquip(info:InventoryItemInfo) : void { }
            public function clearEquip() : void { }
            public function isGhostEquip(itemID:Number) : Boolean { return false; }
            public function isEquipGhosting() : Boolean { return false; }
            public function getGhostEquipPlace() : int { return 0; }
            public function chooseLuckyMaterial(luckyMaterial:InventoryItemInfo) : void { }
            public function chooseStoneMaterial(stoneMaterial:InventoryItemInfo) : void { }
            private function calulateRatio() : void { }
            public function checkEquipGhost() : Boolean { return false; }
            public function getPorpertyData(item:InventoryItemInfo, player:PlayerInfo = null) : GhostPropertyData { return null; }
            public function getPropertyDataByLv(item:InventoryItemInfo, level:int) : GhostPropertyData { return null; }
            public function requestEquipGhost() : void { }
            private function __equipGhost(pkg:PkgEvent) : void { }
            private function __syncEquipGhost(pkg:PkgEvent) : void { }
   }}class SingleTon{          function SingleTon() { super(); }
}