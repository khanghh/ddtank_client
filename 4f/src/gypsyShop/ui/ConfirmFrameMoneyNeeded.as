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
      
      public function ConfirmFrameMoneyNeeded(){super();}
      
      public function setID(param1:int) : void{}
      
      public function alert() : void{}
      
      protected function onNotShowAgain(param1:Boolean) : void{}
      
      protected function isBind(param1:Boolean) : void{}
      
      protected function onConfirm() : void{}
      
      protected function getPrice() : int{return 0;}
   }
}
