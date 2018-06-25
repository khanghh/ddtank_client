package mysteriousRoullete.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.AlertManager;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.controls.alert.BaseAlerFrame;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.LeavePageManager;   import ddt.manager.PlayerManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import flash.events.MouseEvent;   import shop.view.ShopGoodItem;      public class MysteriousShopItem extends ShopGoodItem   {            public static const TYPE_FREE:int = 0;            public static const TYPE_DISCOUNT:int = 1;                   private var _itemCount:FilterFrameText;            private var _getBtn:SimpleBitmapButton;            private var _buyBtn:SimpleBitmapButton;            private var type:int = 1;            private var _alertFrame:BaseAlerFrame;            private var price:int;            public function MysteriousShopItem(type:int) { super(); }
            override protected function initContent() : void { }
            override public function set shopItemInfo(value:ShopItemInfo) : void { }
            private function __getBtnClick(event:MouseEvent) : void { }
            private function __buyBtnClick(event:MouseEvent) : void { }
            protected function __alertBuyGoods(event:FrameEvent) : void { }
            private function onResponseHander(e:FrameEvent) : void { }
            private function _response(evt:FrameEvent) : void { }
            private function __alertResponseHandler(event:FrameEvent) : void { }
            private function buy(isbind:Boolean = false) : void { }
            public function turnGray(flag:Boolean = false) : void { }
            override protected function removeEvent() : void { }
            override public function dispose() : void { }
   }}