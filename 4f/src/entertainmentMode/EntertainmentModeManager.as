package entertainmentMode
{
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import entertainmentMode.model.EntertainmentModel;
   import flash.events.Event;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   
   public class EntertainmentModeManager extends CoreManager
   {
      
      public static const SHOWMAINVIEW:String = "showMainView";
      
      public static const HIDEMAINVIEW:String = "hideMainView";
      
      private static var _instance:EntertainmentModeManager;
       
      
      public var isopen:Boolean = false;
      
      public var openTime:String;
      
      public function EntertainmentModeManager(){super();}
      
      public static function get instance() : EntertainmentModeManager{return null;}
      
      public function setup() : void{}
      
      private function initEvent() : void{}
      
      private function __handler(param1:CrazyTankSocketEvent) : void{}
      
      public function showHideIcon(param1:Boolean) : void{}
      
      public function hide() : void{}
      
      override protected function start() : void{}
      
      private function onLoaded() : void{}
   }
}
