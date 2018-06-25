package shop
{
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopCarItemInfo;
   import shop.view.ShopCartItem;
   import shop.view.ShopCheckOutView;
   
   public class ShopTicketView extends ShopCheckOutView implements Disposeable
   {
       
      
      private var _totalPrice:int;
      
      public function ShopTicketView()
      {
         super();
      }
      
      public function initialize(list:Array) : void
      {
         var i:int = 0;
         _controller = new ShopController();
         _model = new ShopModel();
         _tempList = list;
         _type = 1;
         init();
         initEvent();
         for(i = 0; i < list.length; )
         {
            _model.addToShoppingCar(list[i] as ShopCarItemInfo);
            i++;
         }
         setList(list);
         ChangeCloseButtonState(false);
      }
      
      private function ChangeCloseButtonState(value:Boolean = true) : void
      {
         var item:* = null;
         var i:int = 0;
         for(i = 0; i < _cartList.numChildren; )
         {
            item = _cartList.getChildAt(i) as ShopCartItem;
            if(item)
            {
               item.showCloseButton = value;
            }
            i++;
         }
      }
      
      public function setType(value:Boolean = false) : void
      {
         if(value)
         {
            _type = 1;
            _purchaseConfirmationBtn.visible = true;
            _giftsBtn.visible = false;
         }
         else
         {
            _type = 2;
            _purchaseConfirmationBtn.visible = false;
            _giftsBtn.visible = true;
         }
      }
      
      override protected function updateTxt() : void
      {
         var itemCount:int = 0;
         var i:int = 0;
         var item:* = null;
         var _totalPrice1:int = 0;
         _totalPrice = 0;
         for(i = 0; i < _cartList.numChildren; )
         {
            item = (_cartList.getChildAt(i) as ShopCartItem).shopItemInfo;
            if(item)
            {
               itemCount++;
               _totalPrice = _totalPrice + item.AValue1;
               _totalPrice1 = _totalPrice1 + item.AValue2;
            }
            i++;
         }
         _commodityNumberText.text = itemCount.toString();
         _commodityPricesText1.text = _totalPrice.toString();
         _commodityPricesText2.text = _totalPrice1.toString();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
