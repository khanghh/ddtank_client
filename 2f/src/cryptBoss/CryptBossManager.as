package cryptBoss{   import cryptBoss.data.CryptBossItemInfo;   import cryptBoss.event.CryptBossEvent;   import ddt.CoreManager;   import ddt.events.PkgEvent;   import ddt.manager.ServerConfigManager;   import ddt.manager.SocketManager;   import flash.utils.Dictionary;   import road7th.comm.PackageIn;      public class CryptBossManager extends CoreManager   {            private static var _instance:CryptBossManager;            public static var loadComplete:Boolean = false;                   public var RoomType:int = 0;            public var openWeekDaysDic:Dictionary;            public function CryptBossManager() { super(); }
            public static function get instance() : CryptBossManager { return null; }
            public function setUp() : void { }
            protected function pkgHandler(event:PkgEvent) : void { }
            private function updateSingleData(pkg:PackageIn) : void { }
            private function initAllData(pkg:PackageIn) : void { }
            override protected function start() : void { }
   }}