package totem{   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.SocketManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import road7th.comm.PackageIn;   import totem.data.HonorUpDataAnalyz;      public class HonorUpManager extends EventDispatcher   {            public static const UP_COUNT_UPDATE:String = "up_count_update";            private static var _instance:HonorUpManager;                   public var upCount:int = -1;            private var _dataList:Array;            public function HonorUpManager() { super(); }
            public static function get instance() : HonorUpManager { return null; }
            public function get dataList() : Array { return null; }
            private function updateUpCount(event:PkgEvent) : void { }
            public function setup(analyzer:HonorUpDataAnalyz) : void { }
   }}