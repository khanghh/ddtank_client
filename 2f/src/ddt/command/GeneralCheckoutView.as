package ddt.command{   import com.pickgliss.events.FrameEvent;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.Frame;   import com.pickgliss.ui.controls.ScrollPanel;   import com.pickgliss.ui.controls.container.VBox;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.SoundManager;   import flash.display.Sprite;   import flash.events.Event;   import flash.events.MouseEvent;   import shop.manager.ShopBuyManager;   import shop.view.ShopCartItem;      public class GeneralCheckoutView extends Sprite implements Disposeable   {                   protected var _frame:Frame;            protected var _cartList:VBox;            private var _castList2:Sprite;            protected var _purchaseConfirmationBtn:BaseButton;            private var _cartScroll:ScrollPanel;            protected var _innerBg1:Image;            protected var _needToPayTip:FilterFrameText;            protected var _commodityNumberText:FilterFrameText;            protected var _commodityNumberTip:FilterFrameText;            protected var _commodityPricesText1:FilterFrameText;            protected var _commodityPricesText2:FilterFrameText;            protected var _commodityPricesText3:FilterFrameText;            protected var _commodityPricesText1Label:FilterFrameText;            protected var _commodityPricesText2Label:FilterFrameText;            protected var _commodityPricesText3Label:FilterFrameText;            private var _commodityPricesText1Bg:Scale9CornerImage;            private var _commodityPricesText2Bg:Scale9CornerImage;            private var _commodityPricesText3Bg:Scale9CornerImage;            private var _innerBg:Image;            protected var _cartItemList:Vector.<ShopCartItem>;            protected var _infoArr:Array;            protected var _isBandList:Array;            public function GeneralCheckoutView() { super(); }
            private function initView() : void { }
            private function addEvents() : void { }
            public function initList(arr:Array) : void { }
            private function update() : void { }
            private function upDataBtnState() : void { }
            private function seleBand(id:int, num:int, bool:Boolean) : void { }
            private function updateList() : void { }
            protected function updateTxt() : void { }
            protected function addItemEvent(item:ShopCartItem) : void { }
            private function clearList() : void { }
            protected function addLength(event:Event) : void { }
            private function __conditionChange(evt:Event) : void { }
            private function __deleteItem(evt:Event) : void { }
            private function deleteInfo(id:int) : void { }
            protected function removeItemEvent(item:ShopCartItem) : void { }
            private function __frameEventHandler(evt:FrameEvent) : void { }
            protected function __purchaseConfirmationBtnClick(event:MouseEvent = null) : void { }
            private function removeEvents() : void { }
            public function dispose() : void { }
   }}