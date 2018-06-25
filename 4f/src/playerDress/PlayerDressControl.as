package playerDress{   import com.pickgliss.ui.ComponentFactory;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.PkgEvent;   import ddt.manager.SocketManager;   import ddt.utils.HelperUIModuleLoad;   import playerDress.event.PlayerDressEvent;   import playerDress.views.DressBagView;   import playerDress.views.PlayerDressView;      public class PlayerDressControl   {            private static var _instance:PlayerDressControl;                   private var _dressView:PlayerDressView;            private var _dressBag:DressBagView;            public var showBind:Boolean = true;            private var _uiLoader:HelperUIModuleLoad;            public function PlayerDressControl() { super(); }
            public static function get instance() : PlayerDressControl { return null; }
            public function setup() : void { }
            protected function __setBtnStatus(event:PlayerDressEvent) : void { }
            protected function __playerDressViewDispose(event:PlayerDressEvent) : void { }
            protected function __playerDressViewOpen(event:PlayerDressEvent) : void { }
            protected function openPlayerDressView(type:int) : void { }
            protected function unlockDressBag(event:PkgEvent) : void { }
            public function lockDressBag() : void { }
            public function putOnDress(item:InventoryItemInfo) : void { }
            public function get dressView() : PlayerDressView { return null; }
   }}