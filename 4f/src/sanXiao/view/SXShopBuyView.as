package sanXiao.view
{
   import ddt.command.QuickBuyAlertBase;
   import ddt.manager.GameInSocketOut;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import flash.events.MouseEvent;
   
   public class SXShopBuyView extends QuickBuyAlertBase
   {
       
      
      private var _buyNum:int;
      
      private var _ShopID:int;
      
      public function SXShopBuyView(){super();}
      
      override protected function initView() : void{}
      
      override protected function refreshNumText() : void{}
      
      override public function setData(param1:int, param2:int, param3:int) : void{}
      
      public function setID(param1:int) : void{}
      
      public function setBuyNum(param1:int) : void{}
      
      override protected function __buy(param1:MouseEvent) : void{}
   }
}
