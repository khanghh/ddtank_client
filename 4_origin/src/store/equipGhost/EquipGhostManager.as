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
      
      public function EquipGhostManager(param1:SingleTon)
      {
         super();
         if(!param1)
         {
            throw new Error("this is a single instance");
         }
         init();
      }
      
      public static function getInstance() : EquipGhostManager
      {
         _instance = _instance || new EquipGhostManager(new SingleTon());
         return _instance;
      }
      
      private function init() : void
      {
         initData();
         initEvent();
      }
      
      private function initData() : void
      {
         _model = new GhostModel();
      }
      
      public function initEvent() : void
      {
         SocketManager.Instance.addEventListener(PkgEvent.format(391),__equipGhost);
         SocketManager.Instance.addEventListener(PkgEvent.format(392),__syncEquipGhost);
      }
      
      public function analyzerCompleteHandler(param1:GhostDataAnalyzer) : void
      {
         _model.initModel(param1.data);
      }
      
      public function get model() : GhostModel
      {
         return _model;
      }
      
      public function chooseEquip(param1:InventoryItemInfo) : void
      {
         _equip = param1;
         if(_equip != null)
         {
            calulateRatio();
         }
      }
      
      public function clearEquip() : void
      {
         _equip = null;
      }
      
      public function isGhostEquip(param1:Number) : Boolean
      {
         if(_equip != null && _equip.ItemID == param1)
         {
            return true;
         }
         return false;
      }
      
      public function isEquipGhosting() : Boolean
      {
         return _equip != null;
      }
      
      public function getGhostEquipPlace() : int
      {
         var _loc1_:* = null;
         if(_equip != null)
         {
            _loc1_ = model.getGhostData(_equip.CategoryID,1);
            if(_loc1_ == null)
            {
               return -1;
            }
            return _loc1_.place;
         }
         return -1;
      }
      
      public function chooseLuckyMaterial(param1:InventoryItemInfo) : void
      {
         _luckyMaterial = param1;
         calulateRatio();
      }
      
      public function chooseStoneMaterial(param1:InventoryItemInfo) : void
      {
         _stoneMaterial = param1;
         calulateRatio();
      }
      
      private function calulateRatio() : void
      {
         var _loc4_:* = null;
         var _loc2_:Number = NaN;
         var _loc3_:* = 0;
         var _loc1_:int = 0;
         if(_stoneMaterial && _equip)
         {
            _loc4_ = PlayerManager.Instance.Self.getGhostDataByCategoryID(_equip.CategoryID);
            _loc1_ = _loc4_ == null?0:_loc4_.level;
            _loc2_ = _luckyMaterial == null?1:Number(1 + parseFloat(_luckyMaterial.Property2) / 100);
            _loc3_ = Number(5 * Math.pow(2,Math.pow(2,_stoneMaterial.Level - 1) + 2 - _loc1_) * _loc2_);
         }
         _loc3_ = Number(Math.min(100,_loc3_));
         dispatchEvent(new CEvent("equip_ghost_ratio",uint(_loc3_)));
      }
      
      public function checkEquipGhost() : Boolean
      {
         if(_equip == null)
         {
            return false;
         }
         var _loc1_:EquipGhostData = PlayerManager.Instance.Self.getGhostDataByCategoryID(_equip.CategoryID);
         if(!_loc1_)
         {
            return _stoneMaterial != null;
         }
         if(_loc1_.level < _model.topLvDic[_equip.CategoryID])
         {
            return true;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("equipGhost.upLevel"));
         return false;
      }
      
      public function getPorpertyData(param1:InventoryItemInfo, param2:PlayerInfo = null) : GhostPropertyData
      {
         var _loc5_:* = 0;
         var _loc10_:* = 0;
         var _loc15_:* = NaN;
         var _loc14_:* = null;
         var _loc12_:* = 0;
         var _loc9_:* = 0;
         var _loc13_:* = 0;
         var _loc7_:* = 0;
         var _loc3_:* = null;
         if(param1 == null)
         {
            return null;
         }
         param2 = param2 || PlayerManager.Instance.Self;
         var _loc8_:EquipGhostData = param2.getGhostDataByCategoryID(param1.CategoryID);
         var _loc11_:* = 0;
         if(param1.StrengthenLevel > 0)
         {
            _loc5_ = uint(!!param1.isGold?param1.StrengthenLevel + 1:param1.StrengthenLevel);
            _loc11_ = Number(StaticFormula.getHertAddition(int(param1.Property7),_loc5_));
         }
         var _loc6_:uint = parseInt(param1.Property7) + _loc11_;
         var _loc4_:uint = 0;
         if(_loc8_)
         {
            _loc10_ = uint(param1.Property7);
            _loc15_ = 0;
            if(param1.CategoryID == 7)
            {
               _loc15_ = Number(_loc10_ / 200 * Math.pow(_loc8_.level,1.2) / 100);
            }
            else if(param1.CategoryID == 1 || param1.CategoryID == 5)
            {
               _loc15_ = Number(_loc10_ / 60 * Math.pow(_loc8_.level,1.2) / 100);
            }
            _loc4_ = _loc15_ * _loc6_;
            _loc14_ = model.getGhostData(_loc8_.categoryID,_loc8_.level);
            _loc12_ = uint(0);
            _loc9_ = uint(0);
            _loc13_ = uint(0);
            _loc7_ = uint(0);
            if(_loc14_)
            {
               _loc3_ = ItemManager.Instance.getTemplateById(param1.TemplateID);
               _loc12_ = uint(_loc3_.templateAttack * _loc14_.attackAdd / 1000);
               _loc9_ = uint(_loc3_.templateLuck * _loc14_.luckAdd / 1000);
               _loc13_ = uint(_loc3_.templateDefence * _loc14_.defendAdd / 1000);
               _loc7_ = uint(_loc3_.templateAgility * _loc14_.agilityAdd / 1000);
            }
            return new GhostPropertyData(_loc4_,_loc12_,_loc9_,_loc13_,_loc7_);
         }
         return null;
      }
      
      public function getPropertyDataByLv(param1:InventoryItemInfo, param2:int) : GhostPropertyData
      {
         var _loc5_:* = 0;
         var _loc3_:* = null;
         if(param1 == null || param2 < 0)
         {
            return null;
         }
         if(param2 == 0)
         {
            return new GhostPropertyData(0,0,0,0,0);
         }
         var _loc10_:* = 0;
         if(param1.StrengthenLevel > 0)
         {
            _loc5_ = uint(!!param1.isGold?param1.StrengthenLevel + 1:param1.StrengthenLevel);
            _loc10_ = Number(StaticFormula.getHertAddition(int(param1.Property7),_loc5_));
         }
         var _loc6_:uint = parseInt(param1.Property7) + _loc10_;
         var _loc4_:uint = 0;
         var _loc9_:uint = param1.Property7;
         var _loc14_:* = 0;
         if(param1.CategoryID == 7)
         {
            _loc14_ = Number(_loc9_ / 200 * Math.pow(param2,1.2) / 100);
         }
         else if(param1.CategoryID == 1 || param1.CategoryID == 5)
         {
            _loc14_ = Number(_loc9_ / 60 * Math.pow(param2,1.2) / 100);
         }
         _loc4_ = _loc14_ * _loc6_;
         var _loc13_:GhostData = model.getGhostData(param1.CategoryID,param2);
         var _loc11_:uint = 0;
         var _loc8_:uint = 0;
         var _loc12_:uint = 0;
         var _loc7_:uint = 0;
         if(_loc13_)
         {
            _loc3_ = ItemManager.Instance.getTemplateById(param1.TemplateID);
            _loc11_ = _loc3_.templateAttack * _loc13_.attackAdd / 1000;
            _loc8_ = _loc3_.templateLuck * _loc13_.luckAdd / 1000;
            _loc12_ = _loc3_.templateDefence * _loc13_.defendAdd / 1000;
            _loc7_ = _loc3_.templateAgility * _loc13_.agilityAdd / 1000;
         }
         return new GhostPropertyData(_loc4_,_loc11_,_loc8_,_loc12_,_loc7_);
      }
      
      public function requestEquipGhost() : void
      {
         if(getTimer() - _lastTime < 1000)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.storeIIStrength.startStrengthClickTimerMsg"));
         }
         else if(checkEquipGhost())
         {
            SocketManager.Instance.out.sendEquipGhost();
            _lastTime = getTimer();
         }
      }
      
      private function __equipGhost(param1:PkgEvent) : void
      {
         var _loc2_:Boolean = param1.pkg.readBoolean();
         dispatchEvent(new CEvent("equip_ghost_result",_loc2_));
         if(_equip != null)
         {
            calulateRatio();
         }
      }
      
      private function __syncEquipGhost(param1:PkgEvent) : void
      {
         var _loc5_:int = 0;
         var _loc3_:PackageIn = param1.pkg;
         var _loc7_:int = _loc3_.readInt();
         var _loc6_:EquipGhostData = null;
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         _loc5_ = 0;
         while(_loc5_ < _loc7_)
         {
            _loc2_ = _loc3_.readInt();
            _loc4_ = _loc3_.readInt();
            _loc6_ = new EquipGhostData(_loc2_,_loc4_);
            _loc6_.level = _loc3_.readInt();
            _loc6_.totalGhost = _loc3_.readInt();
            PlayerManager.Instance.Self.addGhostData(_loc6_);
            _loc5_++;
         }
      }
   }
}

class SingleTon
{
    
   
   function SingleTon()
   {
      super();
   }
}
