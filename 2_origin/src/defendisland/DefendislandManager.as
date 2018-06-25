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
      
      public function DefendislandManager(target:IEventDispatcher = null)
      {
         super(target);
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
      
      public function templateDataSetup(dataList:Array) : void
      {
         model.itemInfoList = dataList;
      }
      
      private function _islandInfoHanlder(e:CrazyTankSocketEvent) : void
      {
         var count:int = 0;
         var i:int = 0;
         var pkg:PackageIn = e.pkg;
         var cmd:int = pkg.readInt();
         switch(int(cmd) - 1)
         {
            case 0:
               model.remainCountList = [];
               model.countList = [];
               count = pkg.readInt();
               for(i = 0; i < count; )
               {
                  model.remainCountList.push(pkg.readInt());
                  model.countList.push(pkg.readInt());
                  i++;
               }
               show();
               break;
            case 1:
               model.isOpen = pkg.readBoolean();
               model.beginTime = DateUtils.dateFormat(pkg.readDate());
               model.endTime = DateUtils.dateFormat(pkg.readDate());
               showIcon();
         }
      }
      
      public function showIcon() : void
      {
         HallIconManager.instance.updateSwitchHandler("defend_island",model.isOpen);
      }
   }
}
