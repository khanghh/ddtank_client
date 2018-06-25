package shop.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.Price;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.CheckMoneyUtils;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.events.MouseEvent;
   
   public class BuySingleGoodsNoShop extends BuySingleGoodsView
   {
       
      
      private var _itemCell:BagCell;
      
      private var _itemName:FilterFrameText;
      
      private var _priceCheck:SelectedCheckButton;
      
      public var onBuy:Function;
      
      public function BuySingleGoodsNoShop(type:int = 1)
      {
         super(type);
      }
      
      override protected function initView() : void
      {
         Price.ONLYMONEY = true;
         super.initView();
      }
      
      override public function set goodsID(value:int) : void
      {
         var _bg:* = null;
         var _itemCellBg:* = null;
         var _verticalLine:* = null;
         if(_shopCartItem)
         {
            _shopCartItem.removeEventListener("conditionchange",__shopCartItemChange);
            _shopCartItem.dispose();
         }
         var shopItemInfo:ItemTemplateInfo = ItemManager.Instance.getTemplateById(value);
         if(shopItemInfo)
         {
            _bg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CartItemBg");
            _bg.x = _bg.x + 29;
            _bg.y = _bg.y + 51;
            _itemCellBg = ComponentFactory.Instance.creat("ddtshop.CartItemCellBg");
            _itemCellBg.x = _itemCellBg.x + 29;
            _itemCellBg.y = _itemCellBg.y + 51;
            _verticalLine = ComponentFactory.Instance.creatComponentByStylename("ddtshop.VerticalLine");
            _verticalLine.x = _verticalLine.x + 29;
            _verticalLine.y = _verticalLine.y + 51;
            _frame.addToContent(_bg);
            _frame.addToContent(_verticalLine);
            _frame.addToContent(_itemCellBg);
            _itemCell = new BagCell(0);
            PositionUtils.setPos(_itemCell,"ddtshop.shopCartItemPos");
            _itemCell.x = _itemCellBg.x + 2;
            _itemCell.y = _itemCellBg.y + 2;
            var _loc6_:int = 74;
            _itemCell.height = _loc6_;
            _itemCell.width = _loc6_;
            _itemCell.info = shopItemInfo;
            _frame.addToContent(_itemCell);
            _itemCell.addEventListener("conditionchange",__shopCartItemChange);
            updateCommodityPrices();
            _itemName = ComponentFactory.Instance.creat("ddtshop.CartItemName");
            _itemName.x = 112;
            _itemName.y = 78;
            _frame.addToContent(_itemName);
            _itemName.text = shopItemInfo.Name;
            _priceCheck = ComponentFactory.Instance.creat("ddtshop.CartItemSelectBtn");
            _priceCheck.selected = true;
            _priceCheck.mouseEnabled = false;
            _priceCheck.x = 243;
            _priceCheck.y = 80;
            _priceCheck.text = shopItemInfo.Property3 + LanguageMgr.GetTranslation("carnival.buyGiftTypeTxt1");
            _frame.addToContent(_priceCheck);
            _commodityPricesText2.text = "0";
         }
      }
      
      override protected function updateCommodityPrices() : void
      {
         if(_isBand)
         {
            _commodityPricesText1.text = (int(_itemCell.info.Property3) * _numberSelecter.currentValue).toString();
         }
         else
         {
            _commodityPricesText1.text = (int(_itemCell.info.Property3) * _numberSelecter.currentValue).toString();
         }
      }
      
      override protected function __purchaseConfirmationBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var moneyValue:int = _itemCell.info.Property3;
         CheckMoneyUtils.instance.checkMoney(_isBand,moneyValue,onCheckComplete);
      }
      
      override protected function onCheckComplete() : void
      {
         onBuy && onBuy();
         ObjectUtils.disposeObject(this);
      }
   }
}
