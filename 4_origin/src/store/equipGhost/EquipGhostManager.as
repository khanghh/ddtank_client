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
      
      public function EquipGhostManager(single:SingleTon)
      {
         super();
         if(!single)
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
      
      public function analyzerCompleteHandler(analyzer:GhostDataAnalyzer) : void
      {
         _model.initModel(analyzer.data);
      }
      
      public function get model() : GhostModel
      {
         return _model;
      }
      
      public function chooseEquip(info:InventoryItemInfo) : void
      {
         _equip = info;
         if(_equip != null)
         {
            calulateRatio();
         }
      }
      
      public function clearEquip() : void
      {
         _equip = null;
      }
      
      public function isGhostEquip(itemID:Number) : Boolean
      {
         if(_equip != null && _equip.ItemID == itemID)
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
         var ghostData:* = null;
         if(_equip != null)
         {
            ghostData = model.getGhostData(_equip.CategoryID,1);
            if(ghostData == null)
            {
               return -1;
            }
            return ghostData.place;
         }
         return -1;
      }
      
      public function chooseLuckyMaterial(luckyMaterial:InventoryItemInfo) : void
      {
         _luckyMaterial = luckyMaterial;
         calulateRatio();
      }
      
      public function chooseStoneMaterial(stoneMaterial:InventoryItemInfo) : void
      {
         _stoneMaterial = stoneMaterial;
         calulateRatio();
      }
      
      private function calulateRatio() : void
      {
         var equipData:* = null;
         var luckyRatio:Number = NaN;
         var raito:* = 0;
         var ghostLv:int = 0;
         if(_stoneMaterial && _equip)
         {
            equipData = PlayerManager.Instance.Self.getGhostDataByCategoryID(_equip.CategoryID);
            ghostLv = equipData == null?0:equipData.level;
            luckyRatio = _luckyMaterial == null?1:Number(1 + parseFloat(_luckyMaterial.Property2) / 100);
            raito = Number(5 * Math.pow(2,Math.pow(2,_stoneMaterial.Level - 1) + 2 - ghostLv) * luckyRatio);
         }
         raito = Number(Math.min(100,raito));
         dispatchEvent(new CEvent("equip_ghost_ratio",uint(raito)));
      }
      
      public function checkEquipGhost() : Boolean
      {
         if(_equip == null)
         {
            return false;
         }
         var data:EquipGhostData = PlayerManager.Instance.Self.getGhostDataByCategoryID(_equip.CategoryID);
         if(!data)
         {
            return _stoneMaterial != null;
         }
         if(data.level < _model.topLvDic[_equip.CategoryID])
         {
            return true;
         }
         MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("equipGhost.upLevel"));
         return false;
      }
      
      public function getPorpertyData(item:InventoryItemInfo, player:PlayerInfo = null) : GhostPropertyData
      {
         var strengthenLevel:* = 0;
         var basePropery:* = 0;
         var addRatio:* = NaN;
         var ghostData:* = null;
         var attack:* = 0;
         var lucky:* = 0;
         var defend:* = 0;
         var agility:* = 0;
         var template:* = null;
         if(item == null)
         {
            return null;
         }
         player = player || PlayerManager.Instance.Self;
         var equipData:EquipGhostData = player.getGhostDataByCategoryID(item.CategoryID);
         var strengthMainProperty:* = 0;
         if(item.StrengthenLevel > 0)
         {
            strengthenLevel = uint(!!item.isGold?item.StrengthenLevel + 1:item.StrengthenLevel);
            strengthMainProperty = Number(StaticFormula.getHertAddition(int(item.Property7),strengthenLevel));
         }
         var playerMainProperty:uint = parseInt(item.Property7) + strengthMainProperty;
         var ghostMainProperty:uint = 0;
         if(equipData)
         {
            basePropery = uint(item.Property7);
            addRatio = 0;
            if(item.CategoryID == 7)
            {
               addRatio = Number(basePropery / 200 * Math.pow(equipData.level,1.2) / 100);
            }
            else if(item.CategoryID == 1 || item.CategoryID == 5)
            {
               addRatio = Number(basePropery / 60 * Math.pow(equipData.level,1.2) / 100);
            }
            ghostMainProperty = addRatio * playerMainProperty;
            ghostData = model.getGhostData(equipData.categoryID,equipData.level);
            attack = uint(0);
            lucky = uint(0);
            defend = uint(0);
            agility = uint(0);
            if(ghostData)
            {
               template = ItemManager.Instance.getTemplateById(item.TemplateID);
               attack = uint(template.templateAttack * ghostData.attackAdd / 1000);
               lucky = uint(template.templateLuck * ghostData.luckAdd / 1000);
               defend = uint(template.templateDefence * ghostData.defendAdd / 1000);
               agility = uint(template.templateAgility * ghostData.agilityAdd / 1000);
            }
            return new GhostPropertyData(ghostMainProperty,attack,lucky,defend,agility);
         }
         return null;
      }
      
      public function getPropertyDataByLv(item:InventoryItemInfo, level:int) : GhostPropertyData
      {
         var strengthenLevel:* = 0;
         var template:* = null;
         if(item == null || level < 0)
         {
            return null;
         }
         if(level == 0)
         {
            return new GhostPropertyData(0,0,0,0,0);
         }
         var strengthMainProperty:* = 0;
         if(item.StrengthenLevel > 0)
         {
            strengthenLevel = uint(!!item.isGold?item.StrengthenLevel + 1:item.StrengthenLevel);
            strengthMainProperty = Number(StaticFormula.getHertAddition(int(item.Property7),strengthenLevel));
         }
         var playerMainProperty:uint = parseInt(item.Property7) + strengthMainProperty;
         var ghostMainProperty:uint = 0;
         var basePropery:uint = item.Property7;
         var addRatio:* = 0;
         if(item.CategoryID == 7)
         {
            addRatio = Number(basePropery / 200 * Math.pow(level,1.2) / 100);
         }
         else if(item.CategoryID == 1 || item.CategoryID == 5)
         {
            addRatio = Number(basePropery / 60 * Math.pow(level,1.2) / 100);
         }
         ghostMainProperty = addRatio * playerMainProperty;
         var ghostData:GhostData = model.getGhostData(item.CategoryID,level);
         var attack:uint = 0;
         var lucky:uint = 0;
         var defend:uint = 0;
         var agility:uint = 0;
         if(ghostData)
         {
            template = ItemManager.Instance.getTemplateById(item.TemplateID);
            attack = template.templateAttack * ghostData.attackAdd / 1000;
            lucky = template.templateLuck * ghostData.luckAdd / 1000;
            defend = template.templateDefence * ghostData.defendAdd / 1000;
            agility = template.templateAgility * ghostData.agilityAdd / 1000;
         }
         return new GhostPropertyData(ghostMainProperty,attack,lucky,defend,agility);
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
      
      private function __equipGhost(pkg:PkgEvent) : void
      {
         var result:Boolean = pkg.pkg.readBoolean();
         dispatchEvent(new CEvent("equip_ghost_result",result));
         if(_equip != null)
         {
            calulateRatio();
         }
      }
      
      private function __syncEquipGhost(pkg:PkgEvent) : void
      {
         var i:int = 0;
         var pkgIn:PackageIn = pkg.pkg;
         var size:int = pkgIn.readInt();
         var equipGhost:EquipGhostData = null;
         var bagType:int = 0;
         var place:int = 0;
         for(i = 0; i < size; )
         {
            bagType = pkgIn.readInt();
            place = pkgIn.readInt();
            equipGhost = new EquipGhostData(bagType,place);
            equipGhost.level = pkgIn.readInt();
            equipGhost.totalGhost = pkgIn.readInt();
            PlayerManager.Instance.Self.addGhostData(equipGhost);
            i++;
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
