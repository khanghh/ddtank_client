package cardCollectAward{   import cardCollectAward.data.CardCollectAwardInfo;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import ddt.utils.HelperUIModuleLoad;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import road7th.comm.PackageIn;      public class CardCollectAwardManager extends EventDispatcher   {            public static const OPEN_VIEW:String = "openView";            private static var awardM:CardCollectAwardManager;                   private var _dataPkg:PackageIn = null;            private var _showAward:Boolean = false;            private var _awardInfo:CardCollectAwardInfo = null;            public function CardCollectAwardManager(target:IEventDispatcher = null) { super(null); }
            public static function get Instance() : CardCollectAwardManager { return null; }
            public function setup() : void { }
            private function initData() : void { }
            protected function openView_Handler(evt:PkgEvent) : void { }
            public function showView() : void { }
            public function get awardInfo() : CardCollectAwardInfo { return null; }
            public function closeAward() : void { }
            public function dataPkg() : PackageIn { return null; }
   }}