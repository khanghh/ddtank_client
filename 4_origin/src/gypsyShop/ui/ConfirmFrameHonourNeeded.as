package gypsyShop.ui
{
   import ddt.manager.LanguageMgr;
   import gypsyShop.ctrl.GypsyShopManager;
   import gypsyShop.model.GypsyPurchaseModel;
   import gypsyShop.ui.confirmAlertFrame.ConfirmFrameHonourWithNotShowCheckManager;
   
   public class ConfirmFrameHonourNeeded
   {
       
      
      private var _confirmFrameMngr:ConfirmFrameHonourWithNotShowCheckManager;
      
      public function ConfirmFrameHonourNeeded()
      {
         super();
         _confirmFrameMngr = new ConfirmFrameHonourWithNotShowCheckManager();
      }
      
      public function alert() : void
      {
         var detail:String = LanguageMgr.GetTranslation("tank.game.GameView.gypsyHonourConfirm",getPrice());
         var title:String = LanguageMgr.GetTranslation("AlertDialog.Info");
         var frameType:String = "SimpleAlert";
         _confirmFrameMngr.detail = detail;
         _confirmFrameMngr.title = title;
         _confirmFrameMngr.frameType = frameType;
         _confirmFrameMngr.needMoney = getPrice();
         _confirmFrameMngr.onComfirm = onConfirm;
         _confirmFrameMngr.onNotShowAgain = onNotShowAgain;
         _confirmFrameMngr.onComfirm = GypsyShopManager.getInstance().confirmToRefresh;
         _confirmFrameMngr.isBind = isBind;
         _confirmFrameMngr.alert();
      }
      
      protected function onNotShowAgain(bool:Boolean) : void
      {
         GypsyPurchaseModel.getInstance().updateShowAlertHonourRefresh(!bool);
      }
      
      protected function isBind(isBind:Boolean) : void
      {
      }
      
      protected function onConfirm() : void
      {
         GypsyShopManager.getInstance().confirmToRefresh();
      }
      
      protected function getPrice() : int
      {
         return GypsyPurchaseModel.getInstance().getHonourNeeded();
      }
   }
}
