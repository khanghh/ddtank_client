package shop{   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopCarItemInfo;   import shop.view.ShopCartItem;   import shop.view.ShopCheckOutView;      public class ShopTicketView extends ShopCheckOutView implements Disposeable   {                   private var _totalPrice:int;            public function ShopTicketView() { super(); }
            public function initialize(list:Array) : void { }
            private function ChangeCloseButtonState(value:Boolean = true) : void { }
            public function setType(value:Boolean = false) : void { }
            override protected function updateTxt() : void { }
            override public function dispose() : void { }
   }}