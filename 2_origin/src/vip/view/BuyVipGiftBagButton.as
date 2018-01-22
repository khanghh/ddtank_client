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
      
      private function __onbuyMouseCilck(param1:MouseEvent) : void
      {
         var _loc2_:* = null;
         if(_enable)
         {
            param1.stopImmediatePropagation();
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
            _loc2_ = AlertManager.Instance.simpleAlert(LanguageMgr.GetTranslation("AlertDialog.Info"),LanguageMgr.GetTranslation("tank.vip.view.buyVipGift"),LanguageMgr.GetTranslation("ok"),LanguageMgr.GetTranslation("cancel"),false,true,false,2);
            _loc2_.mouseEnabled = false;
            _loc2_.addEventListener("response",_responseI);
         }
      }
      
      private function _responseI(param1:FrameEvent) : void
      {
         SoundManager.instance.play("008");
         (param1.currentTarget as BaseAlerFrame).removeEventListener("response",_responseI);
         if(param1.responseCode == 3 || param1.responseCode == 2)
         {
            dobuy();
         }
         ObjectUtils.disposeObject(param1.target);
      }
      
      private function dobuy() : void
      {
      }
   }
}
