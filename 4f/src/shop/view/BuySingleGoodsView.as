package shop.view{   import baglocked.BaglockedManager;   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.NumberSelecter;   import com.pickgliss.ui.controls.SelectedCheckButton;   import com.pickgliss.ui.controls.SimpleBitmapButton;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopCarItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.events.PkgEvent;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.manager.PlayerManager;   import ddt.manager.ShopManager;   import ddt.manager.SocketManager;   import ddt.manager.SoundManager;   import ddt.utils.CheckMoneyUtils;   import ddt.utils.FilterWordManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import shop.manager.ShopSaleManager;      public class BuySingleGoodsView extends Sprite implements Disposeable   {            public static const SHOP_CANNOT_FIND:String = "shopCannotfind";                   protected var _frame:Frame;            protected var _shopCartItem:ShopCartItem;            protected var _commodityPricesText1:FilterFrameText;            protected var _commodityPricesText2:FilterFrameText;            private var _commodityPricesText1Label:FilterFrameText;            protected var _commodityPricesText2Label:FilterFrameText;            private var _needToPayTip:FilterFrameText;            protected var _purchaseConfirmationBtn:BaseButton;            protected var _numberSelecter:NumberSelecter;            private var _goodsID:int;            private var _isDisCount:Boolean = false;            public var isSale:Boolean = false;            private var _selectedBtn:SelectedCheckButton;            private var _selectedBandBtn:SelectedCheckButton;            private var _moneyTxt:FilterFrameText;            private var _bandMoneyTxt:FilterFrameText;            protected var _isBand:Boolean;            private var _movie:MovieClip;            protected var _type:int;            private var _commodityPricesText3Label:FilterFrameText;            private var _commodityPricesText3:FilterFrameText;            protected var _askBtn:SimpleBitmapButton;            private var _shopPresentClearingFrame:ShopPresentClearingFrame;            public function BuySingleGoodsView(type:int = 1) { super(); }
            protected function initView() : void { }
            private function askBtnHander(e:MouseEvent) : void { }
            private function payPanl() : void { }
            protected function shopPresentClearingFrameResponseHandler(event:FrameEvent) : void { }
            protected function presentBtnClick(event:MouseEvent) : void { }
            private function sendAsk() : void { }
            protected function selectedBandHander(event:MouseEvent) : void { }
            protected function seletedHander(event:MouseEvent) : void { }
            public function set isDisCount(value:Boolean) : void { }
            public function set goodsID(value:int) : void { }
            private function addEvent() : void { }
            private function removeEvent() : void { }
            protected function updateCommodityPrices() : void { }
            protected function __purchaseConfirmationBtnClick(event:MouseEvent) : void { }
            protected function onCheckComplete() : void { }
            protected function onBuyedGoods(event:PkgEvent) : void { }
            protected function __numberSelecterChange(event:Event) : void { }
            protected function __shopCartItemChange(event:Event) : void { }
            protected function __framePesponse(event:FrameEvent) : void { }
            public function dispose() : void { }
            public function get numberSelecter() : NumberSelecter { return null; }
   }}