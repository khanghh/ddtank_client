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
      
      private function __handler(param1:CrazyTankSocketEvent) : void
      {
         var _loc2_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         var _loc3_:PackageIn = param1.pkg;
         switch(int(param1._cmd) - 71)
         {
            case 0:
               isopen = _loc3_.readBoolean();
               _loc2_ = _loc3_.readDate();
               _loc5_ = _loc3_.readDate();
               _loc4_ = String(_loc2_.fullYear) + "-" + (String(_loc2_.month + 1)) + "-" + String(_loc2_.date);
               openTime = _loc4_ + " " + _loc2_.hours + ":" + (_loc2_.minutes < 10?"0" + String(_loc2_.minutes):_loc2_.minutes) + "-" + _loc5_.hours + ":" + (_loc5_.minutes < 10?"0" + String(_loc5_.minutes):_loc5_.minutes);
               showHideIcon(isopen);
               break;
            case 1:
               EntertainmentModel.instance.score = _loc3_.readInt();
         }
      }
      
      public function showHideIcon(param1:Boolean) : void
      {
         HallIconManager.instance.updateSwitchHandler("entertainment",param1);
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
