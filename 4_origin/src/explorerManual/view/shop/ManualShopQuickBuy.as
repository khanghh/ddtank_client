package explorerManual.view.shop
{
   import ddt.command.QuickBuyAlertBase;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import flash.events.MouseEvent;
   
   public class ManualShopQuickBuy extends QuickBuyAlertBase
   {
       
      
      private var _buyNum:int;
      
      public function ManualShopQuickBuy()
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
         _isBand = false;
         refreshNumText();
      }
      
      override protected function refreshNumText() : void
      {
         var priceStr:String = String(_number.number * _perPrice);
         var tmp:String = LanguageMgr.GetTranslation("explorerManual.shop.point");
         totalText.text = priceStr + " " + tmp;
      }
      
      override protected function __buy(event:MouseEvent) : void
      {
         if(checkJampsCurreny(_number.number * _perPrice))
         {
            SocketManager.Instance.out.sendNewBuyGoods(_shopGoodsId,1,_number.number,"",-1,false,"",0,1,_isBand);
         }
         dispose();
      }
      
      private function checkJampsCurreny(needMoney:int) : Boolean
      {
         if(PlayerManager.Instance.Self.jampsCurrency < needMoney)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("explorerManual.explorerPoint.deficiency"));
            return false;
         }
         return true;
      }
   }
}
