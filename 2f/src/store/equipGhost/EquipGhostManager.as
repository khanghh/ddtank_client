package store.equipGhost
{
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.StaticFormula;
   import flash.events.EventDispatcher;
   import flash.utils.getTimer;
   import road7th.comm.PackageIn;
   import store.equipGhost.data.EquipGhostData;
   import store.equipGhost.data.GhostData;
   import store.equipGhost.data.GhostDataAnalyzer;
   import store.equipGhost.data.GhostModel;
   import store.equipGhost.data.GhostPropertyData;
   
   public class EquipGhostManager extends EventDispatcher
   {
      
      private static const _TIME:uint = 1;
      
      private static const _WAIT_TIME:Number = 1000;
      
      private static var _instance:EquipGhostManager;
       
      
      private var _model:GhostModel;
      
      private var _equip:InventoryItemInfo;
      
      private var _luckyMaterial:InventoryItemInfo;
      
      private var _stoneMaterial:InventoryItemInfo;
      
      private var _protectedID:uint;
      
      private var _lastTime:Number = 0;
      
      public function EquipGhostManager(param1:SingleTon){super();}
      
      public static function getInstance() : EquipGhostManager{return null;}
      
      private function init() : void{}
      
      private function initData() : void{}
      
      public function initEvent() : void{}
      
      public function analyzerCompleteHandler(param1:GhostDataAnalyzer) : void{}
      
      public function get model() : GhostModel{return null;}
      
      public function chooseEquip(param1:InventoryItemInfo) : void{}
      
      public function clearEquip() : void{}
      
      public function isGhostEquip(param1:Number) : Boolean{return false;}
      
      public function isEquipGhosting() : Boolean{return false;}
      
      public function getGhostEquipPlace() : int{return 0;}
      
      public function chooseLuckyMaterial(param1:InventoryItemInfo) : void{}
      
      public function chooseStoneMaterial(param1:InventoryItemInfo) : void{}
      
      private function calulateRatio() : void{}
      
      public function checkEquipGhost() : Boolean{return false;}
      
      public function getPorpertyData(param1:InventoryItemInfo, param2:PlayerInfo = null) : GhostPropertyData{return null;}
      
      public function getPropertyDataByLv(param1:InventoryItemInfo, param2:int) : GhostPropertyData{return null;}
      
      public function requestEquipGhost() : void{}
      
      private function __equipGhost(param1:PkgEvent) : void{}
      
      private function __syncEquipGhost(param1:PkgEvent) : void{}
   }
}

class SingleTon
{
    
   
   function SingleTon(){super();}
}
