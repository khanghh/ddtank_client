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
       
      
      public function MagicHouseManager($instance:MagicHouseInstance)
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
      
      private function __magicHouseHandler(event:CrazyTankSocketEvent) : void
      {
         var pkg:PackageIn = event.pkg;
         var cmd:int = pkg.readInt();
         if(cmd == 1)
         {
            _loginMessage(pkg);
         }
         else if(cmd == 2)
         {
            _updateMessage(pkg);
         }
         else if(cmd == 3)
         {
            _isOpen(pkg);
         }
         else if(cmd == 4)
         {
            _getFreeBoxMessage(pkg);
         }
         else if(cmd == 5)
         {
            _getChargeBoxMessage(pkg);
         }
         else if(cmd == 6)
         {
            _extractionComplete(pkg);
         }
         else if(cmd == 7)
         {
            _fusionComplete(pkg);
         }
      }
      
      private function _loginMessage(pkg:PackageIn) : void
      {
         var i:int = 0;
         MagicHouseModel.instance.activityWeapons = [];
         MagicHouseModel.instance.isMagicRoomShow = pkg.readBoolean();
         for(i = 0; i < 9; )
         {
            MagicHouseModel.instance.activityWeapons[i] = pkg.readInt();
            i++;
         }
         MagicHouseModel.instance.magicJuniorLv = pkg.readInt();
         MagicHouseModel.instance.magicJuniorExp = pkg.readInt();
         MagicHouseModel.instance.magicMidLv = pkg.readInt();
         MagicHouseModel.instance.magicMidExp = pkg.readInt();
         MagicHouseModel.instance.magicSeniorLv = pkg.readInt();
         MagicHouseModel.instance.magicSeniorExp = pkg.readInt();
         MagicHouseModel.instance.freeGetCount = pkg.readInt();
         MagicHouseModel.instance.freeGetTime = pkg.readDate();
         MagicHouseModel.instance.chargeGetCount = pkg.readInt();
         MagicHouseModel.instance.chargeGetTime = pkg.readDate();
         MagicHouseModel.instance.depotCount = pkg.readInt();
         PlayerManager.Instance.Self.essence = pkg.readInt();
      }
      
      private function _updateMessage(pkg:PackageIn) : void
      {
         var i:int = 0;
         if(MagicHouseModel.instance.activityWeapons == null)
         {
            MagicHouseModel.instance.activityWeapons = [];
         }
         MagicHouseModel.instance.isMagicRoomShow = pkg.readBoolean();
         for(i = 0; i < 9; )
         {
            MagicHouseModel.instance.activityWeapons[i] = pkg.readInt();
            i++;
         }
         MagicHouseModel.instance.magicJuniorLv = pkg.readInt();
         MagicHouseModel.instance.magicJuniorExp = pkg.readInt();
         MagicHouseModel.instance.magicMidLv = pkg.readInt();
         MagicHouseModel.instance.magicMidExp = pkg.readInt();
         MagicHouseModel.instance.magicSeniorLv = pkg.readInt();
         MagicHouseModel.instance.magicSeniorExp = pkg.readInt();
         MagicHouseModel.instance.freeGetCount = pkg.readInt();
         MagicHouseModel.instance.freeGetTime = pkg.readDate();
         MagicHouseModel.instance.chargeGetCount = pkg.readInt();
         MagicHouseModel.instance.chargeGetTime = pkg.readDate();
         MagicHouseModel.instance.depotCount = pkg.readInt();
         PlayerManager.Instance.Self.essence = pkg.readInt();
         dispatchEvent(new Event("magichouse_updata"));
      }
      
      private function _isOpen(pkg:PackageIn) : void
      {
         MagicHouseModel.instance.isOpen = pkg.readBoolean();
         MagicHouseModel.instance.isMagicRoomShow = pkg.readBoolean();
      }
      
      private function _getFreeBoxMessage(pkg:PackageIn) : void
      {
         var i:int = 0;
         var info:* = null;
         var currentCount:int = pkg.readInt();
         MagicHouseModel.instance.freeGetTime = pkg.readDate();
         var count:int = pkg.readInt();
         var infos:Array = [];
         for(i = 0; i < count; )
         {
            info = new BoxGoodsTempInfo();
            info.TemplateId = pkg.readInt();
            info.ItemCount = pkg.readInt();
            info.ItemValid = pkg.readInt();
            info.IsBind = pkg.readBoolean();
            info.StrengthenLevel = pkg.readInt();
            info.AttackCompose = pkg.readInt();
            info.DefendCompose = pkg.readInt();
            info.AgilityCompose = pkg.readInt();
            info.LuckCompose = pkg.readInt();
            infos.push(info);
            i++;
         }
         MagicHouseModel.instance.freeBoxGoodListInfos = null;
         MagicHouseModel.instance.freeBoxGoodListInfos = infos;
         dispatchEvent(new Event("freebox_return"));
      }
      
      private function _getChargeBoxMessage(pkg:PackageIn) : void
      {
         var i:int = 0;
         var info:* = null;
         var currentCount:int = pkg.readInt();
         MagicHouseModel.instance.chargeGetCount = MagicHouseModel.instance.chargeGetCount - currentCount;
         MagicHouseModel.instance.chargeGetTime = pkg.readDate();
         var count:int = pkg.readInt();
         var infos:Array = [];
         for(i = 0; i < count; )
         {
            info = new BoxGoodsTempInfo();
            info.TemplateId = pkg.readInt();
            info.ItemCount = pkg.readInt();
            info.ItemValid = pkg.readInt();
            info.IsBind = pkg.readBoolean();
            info.StrengthenLevel = pkg.readInt();
            info.AttackCompose = pkg.readInt();
            info.DefendCompose = pkg.readInt();
            info.AgilityCompose = pkg.readInt();
            info.LuckCompose = pkg.readInt();
            infos.push(info);
            i++;
         }
         MagicHouseModel.instance.chargeBoxGoodListInfos = null;
         MagicHouseModel.instance.chargeBoxGoodListInfos = infos;
         dispatchEvent(new Event("chargebox_return"));
      }
      
      private function _extractionComplete(pkg:PackageIn) : void
      {
         var value:Boolean = pkg.readBoolean();
         if(value)
         {
            dispatchEvent(new Event("magicbox_extraction_complete"));
         }
      }
      
      private function _fusionComplete(pkg:PackageIn) : void
      {
         var value:Boolean = pkg.readBoolean();
         if(value)
         {
            dispatchEvent(new Event("magicbox_fusion_complete"));
         }
      }
      
      public function setupMagicBoxData(analyzer:MagicBoxDataAnalyzer) : void
      {
         if(!MagicHouseModel.instance.itemExtrationEnableList)
         {
            MagicHouseModel.instance.itemExtrationEnableList = [];
         }
         if(!MagicHouseModel.instance.itemFusionEnableList)
         {
            MagicHouseModel.instance.itemFusionEnableList = [];
         }
         var list:Vector.<MagicBoxItemInfo> = analyzer.list;
         var _loc5_:int = 0;
         var _loc4_:* = list;
         for each(var info in list)
         {
            if(info.Type == 1)
            {
               MagicHouseModel.instance.itemFusionEnableList.push(info);
            }
            else
            {
               MagicHouseModel.instance.itemExtrationEnableList.push(info);
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
