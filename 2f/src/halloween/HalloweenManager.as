package halloween{   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import hall.HallStateView;   import road7th.comm.PackageIn;      public class HalloweenManager extends EventDispatcher   {            public static const OPENVIEW:String = "openView";            private static var _instance:HalloweenManager;                   private var _open:Boolean;            private var _hallView:HallStateView;            public function HalloweenManager(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : HalloweenManager { return null; }
            public function setup() : void { }
            protected function __onHalloweenOpen(event:PkgEvent) : void { }
            public function creatHalloweenNpc(hall:HallStateView) : void { }
            private function showHalloweenNpc() : void { }
            public function show() : void { }
            public function deleteHallView() : void { }
   }}