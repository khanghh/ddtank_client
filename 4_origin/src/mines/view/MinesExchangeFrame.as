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
      
      public function MinesExchangeFrame()
      {
         super();
      }
      
      override protected function initView() : void
      {
         super.initView();
         _sprite.visible = false;
      }
      
      public function setType(param1:int) : void
      {
         _type = param1;
         if(_type == 1)
         {
            _totalTipText.text = LanguageMgr.GetTranslation("ddt.mines.shopView.cell.exchange");
            titleText = LanguageMgr.GetTranslation("ddt.mines.shopView.sellTitle");
         }
         else
         {
            _totalTipText.text = LanguageMgr.GetTranslation("ddt.mines.shopView.cell.cost");
            titleText = LanguageMgr.GetTranslation("ddt.mines.shopView.buyTitle");
         }
      }
      
      override public function setData(param1:int, param2:int, param3:int) : void
      {
         _perPrice = param3;
         _shopGoodsId = param2;
         var _loc4_:InventoryItemInfo = new InventoryItemInfo();
         _loc4_.TemplateID = param1;
         ItemManager.fill(_loc4_);
         _loc4_.BindType = 4;
         _cell.info = _loc4_;
         _cell.setCountNotVisible();
         _cell.setBgVisible(false);
         refreshNumText();
      }
      
      override protected function __buy(param1:MouseEvent) : void
      {
         if(_type == 1)
         {
            SocketManager.Instance.out.sendExchangeHandler(_cell.info.TemplateID,_number.number);
         }
         else
         {
            SocketManager.Instance.out.sendBuyHandler(_shopGoodsId,_number.number);
         }
      }
      
      override protected function refreshNumText() : void
      {
         var _loc1_:String = String(_number.number * _perPrice);
         var _loc2_:String = LanguageMgr.GetTranslation("ddt.mines.shopView.cell.moneyType");
         totalText.text = _loc1_ + " " + _loc2_;
      }
   }
}
