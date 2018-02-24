package panicBuying.views
{
   import baglocked.BaglockedManager;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.events.MouseEvent;
   import panicBuying.data.PBuyingItemInfo;
   import shop.view.BuySingleGoodsView;
   import shop.view.ShopCartItem;
   import wonderfulActivity.data.GiftChildInfo;
   import wonderfulActivity.data.SendGiftInfo;
   
   public class PanicBuyingBuyView extends BuySingleGoodsView
   {
       
      
      private var _templateId:int;
      
      private var _info:PBuyingItemInfo;
      
      public function PanicBuyingBuyView(param1:int){super(null);}
      
      public function set info(param1:PBuyingItemInfo) : void{}
      
      override public function set goodsID(param1:int) : void{}
      
      override protected function updateCommodityPrices() : void{}
      
      override protected function __purchaseConfirmationBtnClick(param1:MouseEvent) : void{}
      
      override protected function onCheckComplete() : void{}
      
      protected function buyGift(param1:Boolean) : void{}
      
      override public function dispose() : void{}
   }
}
