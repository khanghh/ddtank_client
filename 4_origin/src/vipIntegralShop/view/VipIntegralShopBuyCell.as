package vipIntegralShop.view
{
   import ddt.command.QuickBuyAlertBase;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class VipIntegralShopBuyCell extends QuickBuyAlertBase
   {
       
      
      private var _buyNum:int;
      
      public function VipIntegralShopBuyCell()
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
         _totalTipText.text = LanguageMgr.GetTranslation("vipIntegralShopView.todayBuyText");
         totalText.x = 272;
         _submitButton.y = 141;
      }
      
      override protected function refreshNumText() : void
      {
         var priceStr:String = String(_number.number * _perPrice);
         totalText.text = priceStr + "\n\n" + _buyNum;
      }
      
      override public function setData(templateId:int, goodsId:int, perPrice:int) : void
      {
         super.setData(templateId,goodsId,perPrice);
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
         dispose();
         SocketManager.Instance.out.buyVipIntegralShopGoods(_shopGoodsId,_number.number);
      }
   }
}
