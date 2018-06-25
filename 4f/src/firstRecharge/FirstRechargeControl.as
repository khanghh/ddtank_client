package firstRecharge{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.events.CrazyTankSocketEvent;   import ddt.manager.ItemManager;   import ddt.manager.SocketManager;   import ddt.utils.AssetModuleLoader;   import firstRecharge.data.RechargeData;   import firstRecharge.event.FirstRechageEvent;   import firstRecharge.view.AccumulationView;   import firstRecharge.view.FirstTouchView;   import road7th.comm.PackageIn;      public class FirstRechargeControl   {            private static var _instance:FirstRechargeControl;                   private var _isShowFirst:Boolean;            private var _firstTouchView:FirstTouchView;            private var _accumulationView:AccumulationView;            public function FirstRechargeControl() { super(); }
            public static function get Instance() : FirstRechargeControl { return null; }
            public function setup() : void { }
            private function initEvent() : void { }
            protected function __onOpenView(event:FirstRechageEvent) : void { }
            protected function __onCloseView(event:FirstRechageEvent) : void { }
            protected function cumlatechargeData(event:CrazyTankSocketEvent) : void { }
            private function closeView() : void { }
            private function showView() : void { }
            private function gemstoneCompHander() : void { }
            public function setGoods(data:RechargeData) : InventoryItemInfo { return null; }
   }}