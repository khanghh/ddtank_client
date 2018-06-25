package vipCoupons{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CEvent;   import ddt.events.PkgEvent;   import ddt.manager.ItemManager;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.manager.TimeManager;   import ddt.utils.AssetModuleLoader;   import ddt.utils.FilterWordManager;   import flash.events.EventDispatcher;   import flash.events.IEventDispatcher;   import flash.events.MouseEvent;   import road7th.comm.PackageIn;   import road7th.utils.StringHelper;   import vip.VipController;   import vipCoupons.view.VIPCouponsFrame;      public class VIPCouponsControl extends EventDispatcher   {            private static var _instance:VIPCouponsControl;                   private var _frame:VIPCouponsFrame;            private var _baseAlerFrame:BaseAlerFrame;            private var _bagType:int;            private var _place:int;            public function VIPCouponsControl(target:IEventDispatcher = null) { super(null); }
            public static function get instance() : VIPCouponsControl { return null; }
            public function setup() : void { }
            private function __openViewHandler(evt:CEvent) : void { }
            private function openFrame() : void { }
            protected function _responseHandle(event:FrameEvent) : void { }
            protected function __sendHandler(event:MouseEvent) : void { }
            private function getItemCount(temId:int) : int { return 0; }
            private function __useVipCouponsHandler(evt:CEvent) : void { }
            private function __frameEvent(evt:FrameEvent) : void { }
            private function __tasteVipCouponsHandler(evt:PkgEvent) : void { }
            private function __tasteVipHandler(evt:FrameEvent) : void { }
            public function dispose() : void { }
   }}