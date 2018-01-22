package gypsyShop.ui
{
   import ddt.manager.LanguageMgr;
   import gypsyShop.ctrl.GypsyShopManager;
   import gypsyShop.model.GypsyPurchaseModel;
   import gypsyShop.ui.confirmAlertFrame.ConfirmFrameWithNotShowCheckManager;
   
   public class ConfirmFrameMoneyNeeded
   {
       
      
      private var _confirmFrameMngr:ConfirmFrameWithNotShowCheckManager;
      
      private var _id:int;
      
      public function ConfirmFrameMoneyNeeded()
      {
         super();
         _confirmFrameMngr = new ConfirmFrameWithNotShowCheckManager();
      }
      
      public function setID(param1:int) : void
      {
         _id = param1;
      }
      
      public function alert() : void
      {
         var _loc2_:String = LanguageMgr.GetTranslation("tank.game.GameView.gypsyRMBTicketConfirm",getPrice());
         var _loc1_:String = LanguageMgr.GetTranslation("AlertDialog.Info");
         var _loc3_:String = "gypsy.confirmView";
         _confirmFrameMngr.detail = _loc2_;
         _confirmFrameMngr.title = _loc1_;
         _confirmFrameMngr.frameType = _loc3_;
         _confirmFrameMngr.needMoney = getPrice();
         _confirmFrameMngr.onNotShowAgain = onNotShowAgain;
         _confirmFrameMngr.onComfirm = onConfirm;
         _confirmFrameMngr.isBind = isBind;
         _confirmFrameMngr.alert();
      }
      
      protected function onNotShowAgain(param1:Boolean) : void
      {
         GypsyPurchaseModel.getInstance().updateShowAlertRmbTicketBuy(!param1);
      }
      
      protected function isBind(param1:Boolean) : void
      {
         GypsyPurchaseModel.getInstance().updateIsUseBindRmbTicket(param1);
      }
      
      protected function onConfirm() : void
      {
         GypsyShopManager.getInstance().confirmToBuy(_id);
      }
      
      protected function getPrice() : int
      {
         return GypsyPurchaseModel.getInstance().getRmbTicketNeeded(_id);
      }
   }
}
