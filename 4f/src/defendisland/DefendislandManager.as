package defendisland{   import ddt.CoreManager;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.SocketManager;   import ddt.utils.HelperUIModuleLoad;   import defendisland.model.DefendislandModel;   import flash.events.Event;   import flash.events.IEventDispatcher;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;   import road7th.utils.DateUtils;      public class DefendislandManager extends CoreManager   {            public static const SHOWMAINVIEW:String = "showMainView";            public static const HIDEMAINVIEW:String = "hideMainView";            private static var _instance:DefendislandManager;                   public var model:DefendislandModel;            public function DefendislandManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : DefendislandManager { return null; }
            override protected function start() : void { }
            private function onComplete() : void { }
            public function setup() : void { }
            public function templateDataSetup(dataList:Array) : void { }
            private function _islandInfoHanlder(e:CrazyTankSocketEvent) : void { }
            public function showIcon() : void { }
   }}