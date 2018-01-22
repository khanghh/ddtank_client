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
      
      public function BuySingleGoodsNoShop(param1:int = 1)
      {
         super(param1);
      }
      
      override protected function initView() : void
      {
         Price.ONLYMONEY = true;
         super.initView();
      }
      
      override public function set goodsID(param1:int) : void
      {
         var _loc4_:* = null;
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(_shopCartItem)
         {
            _shopCartItem.removeEventListener("conditionchange",__shopCartItemChange);
            _shopCartItem.dispose();
         }
         var _loc5_:ItemTemplateInfo = ItemManager.Instance.getTemplateById(param1);
         if(_loc5_)
         {
            _loc4_ = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CartItemBg");
            _loc4_.x = _loc4_.x + 29;
            _loc4_.y = _loc4_.y + 51;
            _loc2_ = ComponentFactory.Instance.creat("ddtshop.CartItemCellBg");
            _loc2_.x = _loc2_.x + 29;
            _loc2_.y = _loc2_.y + 51;
            _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ddtshop.VerticalLine");
            _loc3_.x = _loc3_.x + 29;
            _loc3_.y = _loc3_.y + 51;
            _frame.addToContent(_loc4_);
            _frame.addToContent(_loc3_);
            _frame.addToContent(_loc2_);
            _itemCell = new BagCell(0);
            PositionUtils.setPos(_itemCell,"ddtshop.shopCartItemPos");
            _itemCell.x = _loc2_.x + 2;
            _itemCell.y = _loc2_.y + 2;
            var _loc6_:int = 74;
            _itemCell.height = _loc6_;
            _itemCell.width = _loc6_;
            _itemCell.info = _loc5_;
            _frame.addToContent(_itemCell);
            _itemCell.addEventListener("conditionchange",__shopCartItemChange);
            updateCommodityPrices();
            _itemName = ComponentFactory.Instance.creat("ddtshop.CartItemName");
            _itemName.x = 112;
            _itemName.y = 78;
            _frame.addToContent(_itemName);
            _itemName.text = _loc5_.Name;
            _priceCheck = ComponentFactory.Instance.creat("ddtshop.CartItemSelectBtn");
            _priceCheck.selected = true;
            _priceCheck.mouseEnabled = false;
            _priceCheck.x = 243;
            _priceCheck.y = 80;
            _priceCheck.text = _loc5_.Property3 + LanguageMgr.GetTranslation("carnival.buyGiftTypeTxt1");
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
      
      override protected function __purchaseConfirmationBtnClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:int = _itemCell.info.Property3;
         CheckMoneyUtils.instance.checkMoney(_isBand,_loc2_,onCheckComplete);
      }
      
      override protected function onCheckComplete() : void
      {
         onBuy && onBuy();
         ObjectUtils.disposeObject(this);
      }
   }
}
