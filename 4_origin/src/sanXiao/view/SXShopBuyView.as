package sanXiao.view
{
   import ddt.command.QuickBuyAlertBase;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class SXShopBuyView extends QuickBuyAlertBase
   {
       
      
      private var _buyNum:int;
      
      private var _ShopID:int;
      
      public function SXShopBuyView()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         titleText = LanguageMgr.GetTranslation("store.view.shortcutBuy.exchangeBtn");
         _submitButton.text = LanguageMgr.GetTranslation("store.view.shortcutBuy.exchangeBtn");
         var _loc1_:* = false;
         _sprite.visible = _loc1_;
         _loc1_ = _loc1_;
         _sprite.mouseChildren = _loc1_;
         _sprite.mouseEnabled = _loc1_;
         _totalTipText.text = LanguageMgr.GetTranslation("sanxiao.buyStore");
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
      
      public function setID(id:int) : void
      {
         _ShopID = id;
      }
      
      public function setBuyNum(value:int) : void
      {
         _buyNum = value;
         refreshNumText();
         _number.maximum = _buyNum;
         _submitButton.enable = _buyNum > 0;
      }
      
      override protected function __buy(event:MouseEvent) : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
         GameInSocketOut.sendSXBuyItem(_ShopID,_number.number);
      }
   }
}
