package vipIntegralShop{   import com.pickgliss.loader.BaseLoader;   import com.pickgliss.loader.LoadResourceManager;   import com.pickgliss.loader.LoaderEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import ddt.events.PkgEvent;   import ddt.manager.PathManager;   import ddt.manager.SocketManager;   import ddt.manager.VipIntegralShopManager;   import ddt.utils.AssetModuleLoader;   import flash.events.Event;   import flash.events.EventDispatcher;   import flash.utils.Dictionary;   import road7th.comm.PackageIn;   import vipIntegralShop.data.VipIntegralShopDataAnalyzer;   import vipIntegralShop.data.VipIntegralShopInfo;   import vipIntegralShop.view.VipIntegralShopView;      public class VipIntegralShopController extends EventDispatcher   {            public static var loadComplete:Boolean = false;            public static var useFirst:Boolean = true;            private static var _instance:VipIntegralShopController;                   private var _integralShopView:VipIntegralShopView;            private var _goodsInfoList:Vector.<VipIntegralShopInfo>;            private var _limitDic:Dictionary;            public function VipIntegralShopController() { super(); }
            public static function get instance() : VipIntegralShopController { return null; }
            public function setup() : void { }
            protected function __onUpdateShopView(event:PkgEvent) : void { }
            private function __onOpenView(event:Event) : void { }
            private function initData() : void { }
            protected function __onComplete(event:LoaderEvent) : void { }
            private function getGoodsInfoList(analyzer:VipIntegralShopDataAnalyzer) : void { }
            public function show() : void { }
            public function hide() : void { }
            private function __complainShow() : void { }
            private function showIntegralShopFrame() : void { }
            public function get goodsInfoList() : Vector.<VipIntegralShopInfo> { return null; }
            public function get limitDic() : Dictionary { return null; }
   }}