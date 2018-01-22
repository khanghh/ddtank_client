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
       
      
      public function BuyGiftBagButton(){super();}
      
      override protected function initliziItemTemplate() : void{}
      
      override protected function __onMouseClick(param1:MouseEvent) : void{}
      
      private function _responseI(param1:FrameEvent) : void{}
      
      private function doBuy() : void{}
   }
}
