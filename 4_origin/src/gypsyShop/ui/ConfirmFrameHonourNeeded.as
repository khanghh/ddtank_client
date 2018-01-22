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
         var _loc2_:String = LanguageMgr.GetTranslation("tank.game.GameView.gypsyHonourConfirm",getPrice());
         var _loc1_:String = LanguageMgr.GetTranslation("AlertDialog.Info");
         var _loc3_:String = "SimpleAlert";
         _confirmFrameMngr.detail = _loc2_;
         _confirmFrameMngr.title = _loc1_;
         _confirmFrameMngr.frameType = _loc3_;
         _confirmFrameMngr.needMoney = getPrice();
         _confirmFrameMngr.onComfirm = onConfirm;
         _confirmFrameMngr.onNotShowAgain = onNotShowAgain;
         _confirmFrameMngr.onComfirm = GypsyShopManager.getInstance().confirmToRefresh;
         _confirmFrameMngr.isBind = isBind;
         _confirmFrameMngr.alert();
      }
      
      protected function onNotShowAgain(param1:Boolean) : void
      {
         GypsyPurchaseModel.getInstance().updateShowAlertHonourRefresh(!param1);
      }
      
      protected function isBind(param1:Boolean) : void
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
