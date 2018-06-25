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
      
      public function setID(id:int) : void
      {
         _id = id;
      }
      
      public function alert() : void
      {
         var detail:String = LanguageMgr.GetTranslation("tank.game.GameView.gypsyRMBTicketConfirm",getPrice());
         var title:String = LanguageMgr.GetTranslation("AlertDialog.Info");
         var frameType:String = "gypsy.confirmView";
         _confirmFrameMngr.detail = detail;
         _confirmFrameMngr.title = title;
         _confirmFrameMngr.frameType = frameType;
         _confirmFrameMngr.needMoney = getPrice();
         _confirmFrameMngr.onNotShowAgain = onNotShowAgain;
         _confirmFrameMngr.onComfirm = onConfirm;
         _confirmFrameMngr.isBind = isBind;
         _confirmFrameMngr.alert();
      }
      
      protected function onNotShowAgain(bool:Boolean) : void
      {
         GypsyPurchaseModel.getInstance().updateShowAlertRmbTicketBuy(!bool);
      }
      
      protected function isBind(isBind:Boolean) : void
      {
         GypsyPurchaseModel.getInstance().updateIsUseBindRmbTicket(isBind);
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
