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
      
      public function EntertainmentModeManager()
      {
         super();
      }
      
      public static function get instance() : EntertainmentModeManager
      {
         if(!_instance)
         {
            _instance = new EntertainmentModeManager();
         }
         return _instance;
      }
      
      public function setup() : void
      {
         initEvent();
      }
      
      private function initEvent() : void
      {
         SocketManager.Instance.addEventListener("entertainment",__handler);
      }
      
      private function __handler(e:CrazyTankSocketEvent) : void
      {
         var beginTime:* = null;
         var endTime:* = null;
         var day:* = null;
         var pkg:PackageIn = e.pkg;
         switch(int(e._cmd) - 71)
         {
            case 0:
               isopen = pkg.readBoolean();
               beginTime = pkg.readDate();
               endTime = pkg.readDate();
               day = String(beginTime.fullYear) + "-" + (String(beginTime.month + 1)) + "-" + String(beginTime.date);
               openTime = day + " " + beginTime.hours + ":" + (beginTime.minutes < 10?"0" + String(beginTime.minutes):beginTime.minutes) + "-" + endTime.hours + ":" + (endTime.minutes < 10?"0" + String(endTime.minutes):endTime.minutes);
               showHideIcon(isopen);
               break;
            case 1:
               EntertainmentModel.instance.score = pkg.readInt();
         }
      }
      
      public function showHideIcon(bol:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("entertainment",bol);
      }
      
      public function hide() : void
      {
         dispatchEvent(new Event("hideMainView"));
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["entertainmentMode"],onLoaded);
      }
      
      private function onLoaded() : void
      {
         dispatchEvent(new Event("showMainView"));
      }
   }
}
