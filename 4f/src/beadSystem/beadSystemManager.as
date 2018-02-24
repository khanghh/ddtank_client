package beadSystem
{
   import beadSystem.data.BeadEvent;
   import beadSystem.model.BeadModel;
   import ddt.data.EquipType;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.events.CEvent;
   import ddt.events.PkgEvent;
   import ddt.manager.BeadTemplateManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.AssetModuleLoader;
   import flash.events.EventDispatcher;
   import road7th.comm.PackageIn;
   
   public class beadSystemManager extends EventDispatcher
   {
      
      public static const INFO_VIEW:String = "infoview";
      
      public static const MAIN_VIEW:String = "mainView";
      
      public static const INFO_FRAME:String = "infoframe";
      
      public static const CREATE_COMPLETE:String = "createComplete";
      
      private static var _instance:beadSystemManager;
       
      
      private var _isFirstLoadPackage:Boolean = true;
      
      private var cevent:CEvent;
      
      public function beadSystemManager(){super();}
      
      public static function get Instance() : beadSystemManager{return null;}
      
      public function setup() : void{}
      
      public function initEvent() : void{}
      
      private function __onOpenPackage(param1:PkgEvent) : void{}
      
      private function __onOpenHole(param1:PkgEvent) : void{}
      
      public function showFrame(param1:String) : void{}
      
      public function show() : void{}
      
      public function getEquipPlace(param1:InventoryItemInfo) : int{return 0;}
      
      public function getBeadNameTextFormatStyle(param1:int) : String{return null;}
      
      public function judgeLevel(param1:int, param2:int) : Boolean{return false;}
      
      public function getBeadMcIndex(param1:int) : int{return 0;}
      
      public function getBeadName(param1:InventoryItemInfo) : String{return null;}
   }
}
