package ddt.manager{   import ddt.CoreManager;   import ddt.data.HotSpringRoomInfo;   import ddt.events.PkgEvent;   import ddt.view.UIModuleSmallLoading;   import flash.events.Event;   import road7th.comm.PackageIn;      public class HotSpringManager extends CoreManager   {            private static var _instance:HotSpringManager;                   private var _roomCurrently:HotSpringRoomInfo;            private var _playerEffectiveTime:int;            private var _playerEnterRoomTime:Date;            private var _energyTotal:int;            public var messageTip:String;            private var _isRemoveLoading:Boolean = true;            public function HotSpringManager() { super(); }
            public static function get instance() : HotSpringManager { return null; }
            public function setup() : void { }
            public function roomPlayerRemove(event:PkgEvent = null) : void { }
            public function showStateView() : void { }
            public function get roomCurrently() : HotSpringRoomInfo { return null; }
            public function set roomCurrently(value:HotSpringRoomInfo) : void { }
            private function roomEnterSucceed(event:PkgEvent) : void { }
            private function roomEnter() : void { }
            private function __loadingIsClose(event:Event) : void { }
            public function removeLoadingEvent() : void { }
            public function get energyTotal() : int { return 0; }
            public function set energyTotal(value:int) : void { }
            public function get playerEffectiveTime() : int { return 0; }
            public function set playerEffectiveTime(value:int) : void { }
            public function get playerEnterRoomTime() : Date { return null; }
            public function set playerEnterRoomTime(value:Date) : void { }
   }}