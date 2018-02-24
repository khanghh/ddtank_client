package anotherDimension.controller
{
   import anotherDimension.model.AnotherDimensionInfo;
   import anotherDimension.model.AnotherDimensionMsgInfo;
   import anotherDimension.model.AnotherDimensionResourceInfo;
   import ddt.CoreManager;
   import ddt.data.player.PlayerInfo;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class AnotherDimensionManager extends CoreManager
   {
      
      private static var _instance:AnotherDimensionManager;
      
      public static const SHOWMAINVIEW:String = "showMainView";
      
      public static const UPDATEVIEW:String = "updateView";
      
      public static const UPDATE_RESOURCEDATA:String = "updateResourceData";
      
      public static const ADDMSG:String = "addMsg";
       
      
      public var resourceList:Array;
      
      public var haveResourceList:Array;
      
      public var gameOver:Boolean;
      
      public var isOpen:Boolean;
      
      public var anotherDimensionInfo:AnotherDimensionInfo;
      
      public var msgArr:Array;
      
      public var showBuyCountFram:Boolean = true;
      
      private var refreshOnly:int;
      
      public function AnotherDimensionManager(){super();}
      
      public static function get Instance() : AnotherDimensionManager{return null;}
      
      public function setup() : void{}
      
      override protected function start() : void{}
      
      private function onLoaded() : void{}
      
      private function pkgHandler(param1:CrazyTankSocketEvent) : void{}
      
      private function receiveMsg(param1:PackageIn) : void{}
      
      private function openMainView(param1:PackageIn) : void{}
      
      private function updateInfo(param1:PackageIn) : void{}
      
      private function openOrClose(param1:PackageIn) : void{}
      
      private function updateResource(param1:PackageIn) : void{}
      
      public function checkShowIcon() : void{}
   }
}
