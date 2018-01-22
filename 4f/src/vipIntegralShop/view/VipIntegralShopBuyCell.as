package vipIntegralShop.view
{
   import ddt.command.QuickBuyAlertBase;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class VipIntegralShopBuyCell extends QuickBuyAlertBase
   {
       
      
      private var _buyNum:int;
      
      public function VipIntegralShopBuyCell(){super();}
      
      override protected function initView() : void{}
      
      override protected function refreshNumText() : void{}
      
      override public function setData(param1:int, param2:int, param3:int) : void{}
      
      public function setBuyNum(param1:int) : void{}
      
      override protected function __buy(param1:MouseEvent) : void{}
   }
}
