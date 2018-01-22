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
         var _loc1_:String = String(_number.number * _perPrice);
         totalText.text = _loc1_ + "\n\n" + _buyNum;
      }
      
      override public function setData(param1:int, param2:int, param3:int) : void
      {
         super.setData(param1,param2,param3);
      }
      
      public function setBuyNum(param1:int) : void
      {
         _buyNum = param1;
         refreshNumText();
         _number.maximum = _buyNum;
      }
      
      override protected function __buy(param1:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
         SocketManager.Instance.out.buyVipIntegralShopGoods(_shopGoodsId,_number.number);
      }
   }
}
