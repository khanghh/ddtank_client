package vip.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class BuyVipGiftBagButton extends BaseButton
   {
      
      public static const VIPGIFTBAG_PRICE:int = 6680;
       
      
      private var _buyPackageBtn:BaseButton;
      
      public function BuyVipGiftBagButton()
      {
         super();
         _init();
         _addEvent();
      }
      
      private function _init() : void
      {
         _buyPackageBtn = ComponentFactory.Instance.creatComponentByStylename("vip.buyPackageBtn");
         addChild(_buyPackageBtn);
      }
      
      public function _addEvent() : void
      {
         _buyPackageBtn.addEventListener("click",__onbuyMouseCilck);
      }
      
      private function __onbuyMouseCilck(event:MouseEvent) : void
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
            if(PlayerManager.Instance.Self.Money < 6680)
            {
               LeavePageManager.showFillFrame();
               return;
            }
            alert1 = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.vip.view.buyVipGift"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            alert1.mouseEnabled = false;
            alert1.addEventListener("response",_responseI);
         }
      }
      
      private function _responseI(event:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (event.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(event.responseCode == 3 || event.responseCode == 2)
         {
            dobuy();
         }
         ObjectUtils.disposeObject(event.target);
      }
      
      private function dobuy() : void
      {
      }
   }
}
