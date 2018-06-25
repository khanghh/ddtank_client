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
      
      public function PanicBuyingBuyView(type:int)
      {
         super(type);
      }
      
      public function set info(info:PBuyingItemInfo) : void
      {
         _info = info;
      }
      
      override public function set goodsID(value:int) : void
      {
         if(_shopCartItem)
         {
            _shopCartItem.removeEventListener("conditionchange",__shopCartItemChange);
            _shopCartItem.dispose();
         }
         _templateId = value;
         var shopItem:ShopCarItemInfo = new ShopCarItemInfo(0,_templateId);
         shopItem.APrice1 = _info.priceType;
         shopItem.APrice2 = _info.priceType;
         shopItem.APrice3 = _info.priceType;
         shopItem.BuyType = _info.buyType;
         shopItem.AUnit = _info.unitCount;
         shopItem.AValue1 = _info.price;
         shopItem.BUnit = -1;
         shopItem.CUnit = -1;
         _shopCartItem = new ShopCartItem();
         PositionUtils.setPos(_shopCartItem,"ddtshop.shopCartItemPos");
         _shopCartItem.closeBtn.visible = false;
         _shopCartItem.setShopItemInfo(shopItem);
         _shopCartItem.setColor(shopItem.Color);
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
      
      override protected function __purchaseConfirmationBtnClick(event:MouseEvent) : void
      {
         var moneyValue:int = 0;
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var isChangeMoney:Boolean = true;
         if(_type == -1)
         {
            moneyValue = _shopCartItem.shopItemInfo.getCurrentPrice().bothMoneyValue;
         }
         else if(_type == -8)
         {
            moneyValue = _shopCartItem.shopItemInfo.getCurrentPrice().moneyValue;
         }
         else if(_type == -9)
         {
            moneyValue = _shopCartItem.shopItemInfo.getCurrentPrice().bandDdtMoneyValue;
            isChangeMoney = false;
         }
         CheckMoneyUtils.instance.checkMoney(_isBand,moneyValue,onCheckComplete,null,isChangeMoney);
      }
      
      override protected function onCheckComplete() : void
      {
         _purchaseConfirmationBtn.enable = false;
         buyGift(CheckMoneyUtils.instance.isBind);
         dispose();
      }
      
      protected function buyGift(isBand:Boolean) : void
      {
         var sendInfoVec:Vector.<SendGiftInfo> = new Vector.<SendGiftInfo>();
         var sendInfo:SendGiftInfo = new SendGiftInfo();
         sendInfo.activityId = _info.activityId;
         var temp:Array = [];
         var childInfo:GiftChildInfo = new GiftChildInfo();
         childInfo.giftId = _info.giftbagId + "," + (!!isBand?-9:-8);
         temp.push(childInfo);
         sendInfo.giftIdArr = temp;
         sendInfo.awardCount = _numberSelecter.currentValue;
         sendInfoVec.push(sendInfo);
         SocketManager.Instance.out.sendWonderfulActivityGetReward(sendInfoVec);
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
   }
}
