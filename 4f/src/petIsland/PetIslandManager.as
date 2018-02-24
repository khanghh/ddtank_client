package petIsland
{
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SocketManager;
   import ddt.manager.StateManager;
   import ddt.utils.HelperUIModuleLoad;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   import petIsland.event.PetIslandEvent;
   import petIsland.model.PetIslandModel;
   import road7th.comm.PackageIn;
   
   public class PetIslandManager extends CoreManager
   {
      
      public static var loadComplete:Boolean = false;
      
      public static var useFirst:Boolean = true;
      
      public static const SHOWMAINVIEW:String = "showMainView";
      
      private static var _instance:PetIslandManager;
       
      
      public var model:PetIslandModel;
      
      private var type:int;
      
      public function PetIslandManager(){super();}
      
      public static function get instance() : PetIslandManager{return null;}
      
      public function setup() : void{}
      
      override protected function start() : void{}
      
      private function onLoaded() : void{}
      
      private function initHandler(param1:CrazyTankSocketEvent) : void{}
      
      public function showEnterIcon() : void{}
      
      public function hideEnterIcon() : void{}
   }
}
