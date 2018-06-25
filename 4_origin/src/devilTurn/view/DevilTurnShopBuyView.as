package devilTurn.view
{
   import ddt.command.QuickBuyAlertBase;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class DevilTurnShopBuyView extends QuickBuyAlertBase
   {
       
      
      private var _buyNum:int;
      
      private var _priceValue:String;
      
      private var _priceTemplateID:int;
      
      public function DevilTurnShopBuyView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         var _loc1_:* = false;
         _sprite.visible = _loc1_;
         _loc1_ = _loc1_;
         _sprite.mouseChildren = _loc1_;
         _sprite.mouseEnabled = _loc1_;
         _submitButton.y = 141;
      }
      
      override protected function refreshNumText() : void
      {
         var priceStr:String = String(_number.number * _perPrice);
         totalText.text = priceStr + "\n\n" + _buyNum;
         totalText.x = 209;
      }
      
      public function setShopItemInfo(info:ShopItemInfo, priceTemplateID:int) : void
      {
         _priceValue = info.getItemPrice(1).goodsPriceToString;
         _priceTemplateID = priceTemplateID;
         _totalTipText.text = LanguageMgr.GetTranslation("tank.devilTurn.shopBuyText");
         super.setData(info.TemplateID,info.GoodsID,info.getItemPrice(1).goodsPrice);
      }
      
      public function setBuyNum(value:int) : void
      {
         _buyNum = value;
         refreshNumText();
         _number.maximum = _buyNum;
      }
      
      override protected function __buy(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         var totalPrice:int = _number.number * _perPrice;
         var money:int = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_priceTemplateID);
         if(totalPrice > money)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.shopBuyFail",_priceValue));
            return;
         }
         dispose();
         SocketManager.Instance.out.sendNewBuyGoods(_shopGoodsId,1,_number.number,"",-1,false,"",0,1);
      }
   }
}
