package catchInsect.componets
{
   import ddt.command.QuickBuyAlertBase;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class InsectQuickBuyAlert extends QuickBuyAlertBase
   {
       
      
      public function InsectQuickBuyAlert(){super();}
      
      override protected function initView() : void{}
      
      override protected function __buy(param1:MouseEvent) : void{}
      
      override protected function refreshNumText() : void{}
   }
}
