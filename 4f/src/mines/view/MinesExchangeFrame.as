package mines.view
{
   import ddt.command.QuickBuyAlertBase;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SocketManager;
   import flash.events.MouseEvent;
   
   public class MinesExchangeFrame extends QuickBuyAlertBase
   {
       
      
      private var _type:int;
      
      public function MinesExchangeFrame(){super();}
      
      override protected function initView() : void{}
      
      public function setType(param1:int) : void{}
      
      override public function setData(param1:int, param2:int, param3:int) : void{}
      
      override protected function __buy(param1:MouseEvent) : void{}
      
      override protected function refreshNumText() : void{}
   }
}
