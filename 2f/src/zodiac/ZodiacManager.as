package zodiac{   import ddt.CoreManager;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.SocketManager;   import ddt.utils.HelperUIModuleLoad;   import flash.events.Event;   import hallIcon.HallIconManager;   import road7th.comm.PackageIn;      public class ZodiacManager extends CoreManager   {            public static const SHOWMAINVIEW:String = "showMainView";            public static const HIDEMAINVIEW:String = "hideMainView";            public static const ZODIAC_UPDATA_INDEX:String = "zodiacUpdataIndex";            public static const ZODIAC_UPDATA_MESSAGE:String = "zodiacUpdataMessage";            private static var _instance:ZodiacManager;                   public function ZodiacManager(instanceClass:InstanceClass) { super(); }
            public static function get instance() : ZodiacManager { return null; }
            public function setup() : void { }
            private function initEvent() : void { }
            private function __zodiacHandler(e:CrazyTankSocketEvent) : void { }
            private function setIndexTypeDic(pkg:PackageIn) : void { }
            public function createIcon() : void { }
            public function removeIcon() : void { }
            public function hide() : void { }
            override protected function start() : void { }
            private function _zodiacLoad() : void { }
            private function onLoaded() : void { }
   }}class InstanceClass{          function InstanceClass() { super(); }
}