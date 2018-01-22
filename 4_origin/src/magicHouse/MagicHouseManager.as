package magicHouse
{
   import ddt.CoreManager;
   import ddt.data.box.BoxGoodsTempInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import magicHouse.magicBox.MagicBoxItemInfo;
   import road7th.comm.PackageIn;
   
   public class MagicHouseManager extends CoreManager
   {
      
      public static const SHOWMAINVIEW:String = "showMainView";
      
      public static const HIDEMAINVIEW:String = "hideMainView";
      
      public static const MAGICHOUSE_UPDATA:String = "magichouse_updata";
      
      public static const FREEBOX_RETURN:String = "freebox_return";
      
      public static const CHARGEBOX_RETURN:String = "chargebox_return";
      
      public static const MAGICBOX_EXTRACTION_COMPLETE:String = "magicbox_extraction_complete";
      
      public static const MAGICBOX_FUSION_COMPLETE:String = "magicbox_fusion_complete";
      
      public static const LEVEL_LIMIT:int = 17;
      
      private static var _instance:MagicHouseManager;
       
      
      public function MagicHouseManager(param1:MagicHouseInstance)
      {
         super();
      }
      
      public static function get instance() : MagicHouseManager
      {
         if(_instance == null)
         {
            _instance = new MagicHouseManager(new MagicHouseInstance());
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener("magichouse",__magicHouseHandler);
      }
      
      private function __magicHouseHandler(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:PackageIn = param1.pkg;
         var _loc2_:int = _loc3_.readInt();
         if(_loc2_ == 1)
         {
            _loginMessage(_loc3_);
         }
         else if(_loc2_ == 2)
         {
            _updateMessage(_loc3_);
         }
         else if(_loc2_ == 3)
         {
            _isOpen(_loc3_);
         }
         else if(_loc2_ == 4)
         {
            _getFreeBoxMessage(_loc3_);
         }
         else if(_loc2_ == 5)
         {
            _getChargeBoxMessage(_loc3_);
         }
         else if(_loc2_ == 6)
         {
            _extractionComplete(_loc3_);
         }
         else if(_loc2_ == 7)
         {
            _fusionComplete(_loc3_);
         }
      }
      
      private function _loginMessage(param1:PackageIn) : void
      {
         var _loc2_:int = 0;
         MagicHouseModel.instance.activityWeapons = [];
         MagicHouseModel.instance.isMagicRoomShow = param1.readBoolean();
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            MagicHouseModel.instance.activityWeapons[_loc2_] = param1.readInt();
            _loc2_++;
         }
         MagicHouseModel.instance.magicJuniorLv = param1.readInt();
         MagicHouseModel.instance.magicJuniorExp = param1.readInt();
         MagicHouseModel.instance.magicMidLv = param1.readInt();
         MagicHouseModel.instance.magicMidExp = param1.readInt();
         MagicHouseModel.instance.magicSeniorLv = param1.readInt();
         MagicHouseModel.instance.magicSeniorExp = param1.readInt();
         MagicHouseModel.instance.freeGetCount = param1.readInt();
         MagicHouseModel.instance.freeGetTime = param1.readDate();
         MagicHouseModel.instance.chargeGetCount = param1.readInt();
         MagicHouseModel.instance.chargeGetTime = param1.readDate();
         MagicHouseModel.instance.depotCount = param1.readInt();
         PlayerManager.Instance.Self.essence = param1.readInt();
      }
      
      private function _updateMessage(param1:PackageIn) : void
      {
         var _loc2_:int = 0;
         if(MagicHouseModel.instance.activityWeapons == null)
         {
            MagicHouseModel.instance.activityWeapons = [];
         }
         MagicHouseModel.instance.isMagicRoomShow = param1.readBoolean();
         _loc2_ = 0;
         while(_loc2_ < 9)
         {
            MagicHouseModel.instance.activityWeapons[_loc2_] = param1.readInt();
            _loc2_++;
         }
         MagicHouseModel.instance.magicJuniorLv = param1.readInt();
         MagicHouseModel.instance.magicJuniorExp = param1.readInt();
         MagicHouseModel.instance.magicMidLv = param1.readInt();
         MagicHouseModel.instance.magicMidExp = param1.readInt();
         MagicHouseModel.instance.magicSeniorLv = param1.readInt();
         MagicHouseModel.instance.magicSeniorExp = param1.readInt();
         MagicHouseModel.instance.freeGetCount = param1.readInt();
         MagicHouseModel.instance.freeGetTime = param1.readDate();
         MagicHouseModel.instance.chargeGetCount = param1.readInt();
         MagicHouseModel.instance.chargeGetTime = param1.readDate();
         MagicHouseModel.instance.depotCount = param1.readInt();
         PlayerManager.Instance.Self.essence = param1.readInt();
         dispatchEvent(new Event("magichouse_updata"));
      }
      
      private function _isOpen(param1:PackageIn) : void
      {
         MagicHouseModel.instance.isOpen = param1.readBoolean();
         MagicHouseModel.instance.isMagicRoomShow = param1.readBoolean();
      }
      
      private function _getFreeBoxMessage(param1:PackageIn) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = param1.readInt();
         MagicHouseModel.instance.freeGetTime = param1.readDate();
         var _loc3_:int = param1.readInt();
         var _loc2_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = new BoxGoodsTempInfo();
            _loc5_.TemplateId = param1.readInt();
            _loc5_.ItemCount = param1.readInt();
            _loc5_.ItemValid = param1.readInt();
            _loc5_.IsBind = param1.readBoolean();
            _loc5_.StrengthenLevel = param1.readInt();
            _loc5_.AttackCompose = param1.readInt();
            _loc5_.DefendCompose = param1.readInt();
            _loc5_.AgilityCompose = param1.readInt();
            _loc5_.LuckCompose = param1.readInt();
            _loc2_.push(_loc5_);
            _loc6_++;
         }
         MagicHouseModel.instance.freeBoxGoodListInfos = null;
         MagicHouseModel.instance.freeBoxGoodListInfos = _loc2_;
         dispatchEvent(new Event("freebox_return"));
      }
      
      private function _getChargeBoxMessage(param1:PackageIn) : void
      {
         var _loc6_:int = 0;
         var _loc5_:* = null;
         var _loc4_:int = param1.readInt();
         MagicHouseModel.instance.chargeGetCount = MagicHouseModel.instance.chargeGetCount - _loc4_;
         MagicHouseModel.instance.chargeGetTime = param1.readDate();
         var _loc3_:int = param1.readInt();
         var _loc2_:Array = [];
         _loc6_ = 0;
         while(_loc6_ < _loc3_)
         {
            _loc5_ = new BoxGoodsTempInfo();
            _loc5_.TemplateId = param1.readInt();
            _loc5_.ItemCount = param1.readInt();
            _loc5_.ItemValid = param1.readInt();
            _loc5_.IsBind = param1.readBoolean();
            _loc5_.StrengthenLevel = param1.readInt();
            _loc5_.AttackCompose = param1.readInt();
            _loc5_.DefendCompose = param1.readInt();
            _loc5_.AgilityCompose = param1.readInt();
            _loc5_.LuckCompose = param1.readInt();
            _loc2_.push(_loc5_);
            _loc6_++;
         }
         MagicHouseModel.instance.chargeBoxGoodListInfos = null;
         MagicHouseModel.instance.chargeBoxGoodListInfos = _loc2_;
         dispatchEvent(new Event("chargebox_return"));
      }
      
      private function _extractionComplete(param1:PackageIn) : void
      {
         var _loc2_:Boolean = param1.readBoolean();
         if(_loc2_)
         {
            dispatchEvent(new Event("magicbox_extraction_complete"));
         }
      }
      
      private function _fusionComplete(param1:PackageIn) : void
      {
         var _loc2_:Boolean = param1.readBoolean();
         if(_loc2_)
         {
            dispatchEvent(new Event("magicbox_fusion_complete"));
         }
      }
      
      public function setupMagicBoxData(param1:MagicBoxDataAnalyzer) : void
      {
         if(!MagicHouseModel.instance.itemExtrationEnableList)
         {
            MagicHouseModel.instance.itemExtrationEnableList = [];
         }
         if(!MagicHouseModel.instance.itemFusionEnableList)
         {
            MagicHouseModel.instance.itemFusionEnableList = [];
         }
         var _loc2_:Vector.<MagicBoxItemInfo> = param1.list;
         var _loc5_:int = 0;
         var _loc4_:* = _loc2_;
         for each(var _loc3_ in _loc2_)
         {
            if(_loc3_.Type == 1)
            {
               MagicHouseModel.instance.itemFusionEnableList.push(_loc3_);
            }
            else
            {
               MagicHouseModel.instance.itemExtrationEnableList.push(_loc3_);
            }
         }
      }
      
      override protected function start() : void
      {
         _magichouseLoad();
      }
      
      private function _magichouseLoad() : void
      {
         new HelperUIModuleLoad().loadUIModule(["magicHouse","ddtbagandinfo","ddtstore","ddtbead","consortionii"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new Event("showMainView"));
      }
      
      public function hide() : void
      {
         dispatchEvent(new Event("hideMainView"));
      }
   }
}

class MagicHouseInstance
{
    
   
   function MagicHouseInstance()
   {
      super();
   }
}
