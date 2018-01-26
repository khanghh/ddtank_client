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
      
      public function ShopTicketView(){super();}
      
      public function initialize(param1:Array) : void{}
      
      private function ChangeCloseButtonState(param1:Boolean = true) : void{}
      
      public function setType(param1:Boolean = false) : void{}
      
      override protected function updateTxt() : void{}
      
      override public function dispose() : void{}
   }
}
