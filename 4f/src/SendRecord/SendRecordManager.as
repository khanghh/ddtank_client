package SendRecord{   import ddt.manager.DesktopManager;   import ddt.manager.PathManager;   import ddt.manager.PlayerManager;   import ddt.manager.StatisticManager;   import flash.external.ExternalInterface;   import flash.net.URLLoader;   import flash.net.URLRequest;   import flash.net.URLVariables;   import flash.system.Capabilities;   import flash.system.fscommand;   import flash.utils.Dictionary;      public class SendRecordManager   {            private static var _instance:SendRecordManager;                   private var _browserInfo:String = "";            public function SendRecordManager() { super(); }
            public static function get Instance() : SendRecordManager { return null; }
            private function sendRecordUserVersion(paramStr:String = "") : void { }
            private function browserInfo(msg:String) : void { }
            public function setUp() : void { }
   }}