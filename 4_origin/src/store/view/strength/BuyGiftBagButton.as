package store.view.strength
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.events.ShortcutBuyEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.view.common.BuyItemButton;
   import ddt.view.tips.GoodTipInfo;
   import flash.events.MouseEvent;
   
   public class BuyGiftBagButton extends BuyItemButton
   {
      
      public static const GIFTBAG_PRICE:int = 4599;
       
      
      public function BuyGiftBagButton()
      {
         super();
      }
      
      override protected function initliziItemTemplate() : void
      {
         _itemInfo = new ItemTemplateInfo();
         _itemInfo.Name = LanguageMgr.GetTranslation("tank.view.common.BuyGiftBagButton.initliziItemTemplate.excellent");
         _itemInfo.Quality = 4;
         _itemInfo.TemplateID = 2;
         _itemInfo.CategoryID = 11;
         _itemInfo.Description = LanguageMgr.GetTranslation("tank.view.common.BuyGiftBagButton.initliziItemTemplate.info");
         var goodInfo:GoodTipInfo = new GoodTipInfo();
         goodInfo.itemInfo = _itemInfo;
         goodInfo.isBalanceTip = false;
         goodInfo.typeIsSecond = false;
         tipData = goodInfo;
      }
      
      override protected function __onMouseClick(event:MouseEvent) : void
      {
         var alert1:* = null;
         if(_enable)
         {
            event.stopImmediatePropagation();
            SoundManager.instance.play("008");
            if(PlayerManager.Instance.Self.bagLocked)
            {
               BaglockedManager.Instance.show();
               return;
            }
            if(PlayerManager.Instance.Self.Money < 4599)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("store.view.strength.buyGift"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            alert1.moveEnable = false;
            alert1.addEventListener("response",_responseI);
         }
      }
      
      private function _responseI(e:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (e.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(e.responseCode == 3 || e.responseCode == 2)
         {
            doBuy();
         }
         ObjectUtils.disposeObject(e.target);
      }
      
      private function doBuy() : void
      {
         SocketManager.Instance.out.sendBuyGiftBag(112051100);
         dispatchEvent(new ShortcutBuyEvent(2,5));
      }
   }
}
