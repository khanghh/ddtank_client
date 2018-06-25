package oldplayerintegralshop.view{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.LayerManager;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.text.FilterFrameText;   import ddt.data.goods.ShopItemInfo;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.ServerConfigManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.events.MouseEvent;   import oldplayerintegralshop.IntegralShopController;   import road7th.comm.PackageIn;      public class IntegralShopView extends Frame   {            private static const MAXNUM:int = 4;                   private var _bg:Bitmap;            private var _infoText:FilterFrameText;            private var _leaveNumText:FilterFrameText;            private var _pageTxt:FilterFrameText;            private var _integralNum:FilterFrameText;            private var _callText:FilterFrameText;            private var _foreBtn:SimpleBitmapButton;            private var _nextBtn:SimpleBitmapButton;            private var _shopCellList:Vector.<IntegralShopCell>;            private var _currentPage:int;            private var _totlePage:int;            private var _goodsInfoList:Vector.<ShopItemInfo>;            private var _integralCom:Component;            public function IntegralShopView() { super(); }
            private function sendPkg() : void { }
            private function initData() : void { }
            private function initView() : void { }
            private function creatIntegralNum() : void { }
            private function refreshView() : void { }
            private function initEvent() : void { }
            protected function __onUpdateIntegral(event:PkgEvent) : void { }
            private function __changePageHandler(event:MouseEvent) : void { }
            protected function __onAlertResponse(event:FrameEvent) : void { }
            public function show() : void { }
            private function removeEvent() : void { }
            private function __frameEventHandler(event:FrameEvent) : void { }
            override public function dispose() : void { }
   }}