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
      
      public function setType(type:int) : void
      {
         _type = type;
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
      
      override public function setData(templateId:int, goodsId:int, perPrice:int) : void
      {
         _perPrice = perPrice;
         _shopGoodsId = goodsId;
         var info:InventoryItemInfo = new InventoryItemInfo();
         info.TemplateID = templateId;
         ItemManager.fill(info);
         info.BindType = 4;
         _cell.info = info;
         _cell.setCountNotVisible();
         _cell.setBgVisible(false);
         refreshNumText();
      }
      
      override protected function __buy(event:MouseEvent) : void
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
         var priceStr:String = String(_number.number * _perPrice);
         var tmp:String = LanguageMgr.GetTranslation("ddt.mines.shopView.cell.moneyType");
         totalText.text = priceStr + " " + tmp;
      }
   }
}
