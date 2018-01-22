package defendisland
{
   import ddt.CoreManager;
   import ddt.events.CrazyTankSocketEvent;
   import ddt.manager.SocketManager;
   import ddt.utils.HelperUIModuleLoad;
   import defendisland.model.DefendislandModel;
   import flash.events.Event;
   import flash.events.IEventDispatcher;
   import hallIcon.HallIconManager;
   import road7th.comm.PackageIn;
   import road7th.utils.DateUtils;
   
   public class DefendislandManager extends CoreManager
   {
      
      public static const SHOWMAINVIEW:String = "showMainView";
      
      public static const HIDEMAINVIEW:String = "hideMainView";
      
      private static var _instance:DefendislandManager;
       
      
      public var model:DefendislandModel;
      
      public function DefendislandManager(param1:IEventDispatcher = null)
      {
         super(param1);
      }
      
      public static function get instance() : DefendislandManager
      {
         if(_instance == null)
         {
            _instance = new DefendislandManager();
         }
         return _instance;
      }
      
      override protected function start() : void
      {
         new HelperUIModuleLoad().loadUIModule(["defendisland"],onComplete);
      }
      
      private function onComplete() : void
      {
         dispatchEvent(new Event("showMainView"));
      }
      
      public function setup() : void
      {
         model = new DefendislandModel();
         SocketManager.Instance.addEventListener("islandInfo",_islandInfoHanlder);
      }
      
      public function templateDataSetup(param1:Array) : void
      {
         model.itemInfoList = param1;
      }
      
      private function _islandInfoHanlder(param1:CrazyTankSocketEvent) : void
      {
         var _loc3_:int = 0;
         var _loc5_:int = 0;
         var _loc4_:PackageIn = param1.pkg;
         var _loc2_:int = _loc4_.readInt();
         switch(int(_loc2_) - 1)
         {
            case 0:
               model.remainCountList = [];
               model.countList = [];
               _loc3_ = _loc4_.readInt();
               _loc5_ = 0;
               while(_loc5_ < _loc3_)
               {
                  model.remainCountList.push(_loc4_.readInt());
                  model.countList.push(_loc4_.readInt());
                  _loc5_++;
               }
               show();
               break;
            case 1:
               model.isOpen = _loc4_.readBoolean();
               model.beginTime = DateUtils.dateFormat(_loc4_.readDate());
               model.endTime = DateUtils.dateFormat(_loc4_.readDate());
               showIcon();
         }
      }
      
      public function showIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("defend_island",model.isOpen);
      }
   }
}
