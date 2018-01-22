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
      
      public function initialize(param1:Array) : void
      {
         var _loc2_:int = 0;
         _controller = new ShopController();
         _model = new ShopModel();
         _tempList = param1;
         _type = 1;
         init();
         initEvent();
         _loc2_ = 0;
         while(_loc2_ < param1.length)
         {
            _model.addToShoppingCar(param1[_loc2_] as ShopCarItemInfo);
            _loc2_++;
         }
         setList(param1);
         ChangeCloseButtonState(false);
      }
      
      private function ChangeCloseButtonState(param1:Boolean = true) : void
      {
         var _loc2_:* = null;
         var _loc3_:int = 0;
         _loc3_ = 0;
         while(_loc3_ < _cartList.numChildren)
         {
            _loc2_ = _cartList.getChildAt(_loc3_) as ShopCartItem;
            if(_loc2_)
            {
               _loc2_.showCloseButton = param1;
            }
            _loc3_++;
         }
      }
      
      public function setType(param1:Boolean = false) : void
      {
         if(param1)
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
         var _loc2_:int = 0;
         var _loc4_:int = 0;
         var _loc1_:* = null;
         var _loc3_:int = 0;
         _totalPrice = 0;
         _loc4_ = 0;
         while(_loc4_ < _cartList.numChildren)
         {
            _loc1_ = (_cartList.getChildAt(_loc4_) as ShopCartItem).shopItemInfo;
            if(_loc1_)
            {
               _loc2_++;
               _totalPrice = _totalPrice + _loc1_.AValue1;
               _loc3_ = _loc3_ + _loc1_.AValue2;
            }
            _loc4_++;
         }
         _commodityNumberText.text = _loc2_.toString();
         _commodityPricesText1.text = _totalPrice.toString();
         _commodityPricesText2.text = _loc3_.toString();
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
