package dreamlandChallenge.view.logicView.shop
{
   import ddt.command.QuickBuyAlertBase;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import dreamlandChallenge.DreamlandChallengeManager;
   import flash.events.MouseEvent;
   
   public class DreamLandShopQuickBuy extends QuickBuyAlertBase
   {
       
      
      private var _buyNum:int;
      
      public function DreamLandShopQuickBuy()
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
         var tmp:String = LanguageMgr.GetTranslation("ddt.dragonBoat.shopCellMoneyTxt");
         totalText.text = priceStr + " " + tmp;
      }
      
      override protected function __buy(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         onCheckComplete();
      }
      
      override protected function submit(isBand:Boolean) : void
      {
         if(checkJampsCurreny(_number.number * _perPrice))
         {
            SocketManager.Instance.out.sendNewBuyGoods(_shopGoodsId,1,_number.number,"",-1,false,"",0,1,isBand);
         }
      }
      
      private function checkJampsCurreny(needMoney:int) : Boolean
      {
         if(DreamlandChallengeManager.instance.mode.selfPoint < needMoney)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.dreamLand.selfPoint.deficiency"));
            return false;
         }
         return true;
      }
   }
}
