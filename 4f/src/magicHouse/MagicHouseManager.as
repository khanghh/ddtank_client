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
       
      
      public function MagicHouseManager(param1:MagicHouseInstance){super();}
      
      public static function get instance() : MagicHouseManager{return null;}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      private function __magicHouseHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function _loginMessage(param1:PackageIn) : void{}
      
      private function _updateMessage(param1:PackageIn) : void{}
      
      private function _isOpen(param1:PackageIn) : void{}
      
      private function _getFreeBoxMessage(param1:PackageIn) : void{}
      
      private function _getChargeBoxMessage(param1:PackageIn) : void{}
      
      private function _extractionComplete(param1:PackageIn) : void{}
      
      private function _fusionComplete(param1:PackageIn) : void{}
      
      public function setupMagicBoxData(param1:MagicBoxDataAnalyzer) : void{}
      
      override protected function start() : void{}
      
      private function _magichouseLoad() : void{}
      
      private function onLoaded() : void{}
      
      public function hide() : void{}
   }
}

class MagicHouseInstance
{
    
   
   function MagicHouseInstance(){super();}
}
