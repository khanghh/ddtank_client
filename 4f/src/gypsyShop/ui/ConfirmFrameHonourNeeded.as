package gypsyShop.ui
{
   import ddt.manager.LanguageMgr;
   import gypsyShop.ctrl.GypsyShopManager;
   import gypsyShop.model.GypsyPurchaseModel;
   import gypsyShop.ui.confirmAlertFrame.ConfirmFrameHonourWithNotShowCheckManager;
   
   public class ConfirmFrameHonourNeeded
   {
       
      
      private var _confirmFrameMngr:ConfirmFrameHonourWithNotShowCheckManager;
      
      public function ConfirmFrameHonourNeeded(){super();}
      
      public function alert() : void{}
      
      protected function onNotShowAgain(param1:Boolean) : void{}
      
      protected function isBind(param1:Boolean) : void{}
      
      protected function onConfirm() : void{}
      
      protected function getPrice() : int{return 0;}
   }
}
