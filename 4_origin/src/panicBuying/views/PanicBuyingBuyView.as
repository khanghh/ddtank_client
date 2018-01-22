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
      
      public function PanicBuyingBuyView(param1:int)
      {
         super(param1);
      }
      
      public function set info(param1:PBuyingItemInfo) : void
      {
         _info = param1;
      }
      
      override public function set goodsID(param1:int) : void
      {
         if(_shopCartItem)
         {
            _shopCartItem.removeEventListener("conditionchange",__shopCartItemChange);
            _shopCartItem.dispose();
         }
         _templateId = param1;
         var _loc2_:ShopCarItemInfo = new ShopCarItemInfo(0,_templateId);
         _loc2_.APrice1 = _info.priceType;
         _loc2_.APrice2 = _info.priceType;
         _loc2_.APrice3 = _info.priceType;
         _loc2_.BuyType = _info.buyType;
         _loc2_.AUnit = _info.unitCount;
         _loc2_.AValue1 = _info.price;
         _loc2_.BUnit = -1;
         _loc2_.CUnit = -1;
         _shopCartItem = new ShopCartItem();
         PositionUtils.setPos(_shopCartItem,"ddtshop.shopCartItemPos");
         _shopCartItem.closeBtn.visible = false;
         _shopCartItem.setShopItemInfo(_loc2_);
         _shopCartItem.setColor(_loc2_.Color);
         _frame.addToContent(_shopCartItem);
         _shopCartItem.addEventListener("conditionchange",__shopCartItemChange);
         updateCommodityPrices();
      }
      
      override protected function updateCommodityPrices() : void
      {
         if(_shopCartItem.shopItemInfo.getCurrentPrice().PriceType == -1)
         {
            if(_isBand)
            {
               _commodityPricesText1.text = "0";
               _commodityPricesText2.text = (_shopCartItem.shopItemInfo.getCurrentPrice().bothMoneyValue * _numberSelecter.currentValue).toString();
            }
            else
            {
               _commodityPricesText1.text = (_shopCartItem.shopItemInfo.getCurrentPrice().bothMoneyValue * _numberSelecter.currentValue).toString();
               _commodityPricesText2.text = "0";
            }
            _shopCartItem.setDianquanType(_isBand);
         }
         else if(_shopCartItem.shopItemInfo.getCurrentPrice().PriceType == -8)
         {
            _commodityPricesText1.text = (_shopCartItem.shopItemInfo.getCurrentPrice().moneyValue * _numberSelecter.currentValue).toString();
            _commodityPricesText2.text = "0";
            _shopCartItem.setDianquanType(false);
         }
         else if(_shopCartItem.shopItemInfo.getCurrentPrice().PriceType == -9)
         {
            _commodityPricesText1.text = "0";
            _commodityPricesText2.text = (_shopCartItem.shopItemInfo.getCurrentPrice().bandDdtMoneyValue * _numberSelecter.currentValue).toString();
            _shopCartItem.setDianquanType(true);
         }
      }
      
      override protected function __purchaseConfirmationBtnClick(param1:MouseEvent) : void
      {
         var _loc2_:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc3_:Boolean = true;
         if(_type == -1)
         {
            _loc2_ = _shopCartItem.shopItemInfo.getCurrentPrice().bothMoneyValue;
         }
         else if(_type == -8)
         {
            _loc2_ = _shopCartItem.shopItemInfo.getCurrentPrice().moneyValue;
         }
         else if(_type == -9)
         {
            _loc2_ = _shopCartItem.shopItemInfo.getCurrentPrice().bandDdtMoneyValue;
            _loc3_ = false;
         }
         CheckMoneyUtils.instance.checkMoney(_isBand,_loc2_,onCheckComplete,null,_loc3_);
      }
      
      override protected function onCheckComplete() : void
      {
         _purchaseConfirmationBtn.enable = false;
         buyGift(CheckMoneyUtils.instance.isBind);
         dispose();
      }
      
      protected function buyGift(param1:Boolean) : void
      {
         var _loc5_:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var _loc3_:SendGiftInfo = new SendGiftInfo();
         _loc3_.activityId = _info.activityId;
         var _loc4_:Array = [];
         var _loc2_:GiftChildInfo = new GiftChildInfo();
         _loc2_.giftId = _info.giftbagId + "," + (!!param1?-9:-8);
         _loc4_.push(_loc2_);
         _loc3_.giftIdArr = _loc4_;
         _loc3_.awardCount = _numberSelecter.currentValue;
         _loc5_.push(_loc3_);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(_loc5_);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
