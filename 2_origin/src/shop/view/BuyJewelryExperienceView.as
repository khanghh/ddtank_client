package shop.view
{
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.Price;
   import ddt.manager.LanguageMgr;
   import ddt.manager.LeavePageManager;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.Helpers;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class BuyJewelryExperienceView extends BuySingleGoodsView
   {
       
      
      private var _moneyPrice:Number;
      
      private var _bindMoneyPrice:Number;
      
      private var _itemName:FilterFrameText;
      
      private var _upToNextLevel:SelectedCheckButton;
      
      private var _upToNextLevelText:FilterFrameText;
      
      private var _group:SelectedButtonGroup;
      
      private var _priceCheck0:SelectedCheckButton;
      
      private var _priceCheck1:SelectedCheckButton;
      
      private var _curExp:int;
      
      private var _NextLvExp:int;
      
      public var onBuy:Function;
      
      private var moneyValue:int;
      
      public function BuyJewelryExperienceView(param1:int = 1)
      {
         _moneyPrice = ServerConfigManager.instance.ItemDevelopPrice;
         _bindMoneyPrice = ServerConfigManager.instance.ItemDevelopPrice;
         super(param1);
      }
      
      override protected function initView() : void
      {
         Price.ONLYMONEY = true;
         super.initView();
      }
      
      public function goodsData(param1:int, param2:int) : void
      {
         var _loc6_:* = null;
         var _loc4_:* = null;
         var _loc5_:* = null;
         var _loc3_:* = null;
         if(_shopCartItem)
         {
            _shopCartItem.removeEventListener("conditionchange",__shopCartItemChange);
            _shopCartItem.dispose();
         }
         _curExp = param1;
         _NextLvExp = param2;
         _loc6_ = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CartItemBg");
         _loc6_.x = _loc6_.x + 29;
         _loc6_.y = _loc6_.y + 51;
         _loc4_ = ComponentFactory.Instance.creat("ddtshop.CartItemCellBg");
         _loc4_.x = _loc4_.x + 29;
         _loc4_.y = _loc4_.y + 51;
         _loc5_ = ComponentFactory.Instance.creatComponentByStylename("ddtshop.VerticalLine");
         _loc5_.x = _loc5_.x + 29;
         _loc5_.y = _loc5_.y + 51;
         _frame.addToContent(_loc6_);
         _frame.addToContent(_loc5_);
         _frame.addToContent(_loc4_);
         _loc3_ = ComponentFactory.Instance.creatBitmap("asset.store.bringup.buyExp.icon");
         PositionUtils.setPos(_loc3_,"ddtshop.shopCartItemPos");
         _loc3_.x = _loc4_.x + 2;
         _loc3_.y = _loc4_.y + 2;
         var _loc7_:int = 66;
         _loc3_.height = _loc7_;
         _loc3_.width = _loc7_;
         _frame.addToContent(_loc3_);
         _itemName = ComponentFactory.Instance.creat("ddtshop.CartItemName");
         _itemName.x = 126;
         _itemName.y = 72;
         _frame.addToContent(_itemName);
         _itemName.text = LanguageMgr.GetTranslation("tank.view.bagII.bringup.buyExpName");
         _group = new SelectedButtonGroup(false,1);
         _priceCheck0 = ComponentFactory.Instance.creat("ddtshop.CartItemSelectBtn");
         _priceCheck0.x = 240;
         _priceCheck0.y = 59;
         _priceCheck0.text = LanguageMgr.GetTranslation("BugJewlryExper.priceCheck",_moneyPrice);
         _frame.addToContent(_priceCheck0);
         _priceCheck1 = ComponentFactory.Instance.creat("ddtshop.CartItemSelectBtn");
         _priceCheck1.x = _priceCheck0.x;
         _priceCheck1.y = _priceCheck0.y + _priceCheck0.height + 2;
         _priceCheck1.text = LanguageMgr.GetTranslation("BugJewlryExper.priceCheck1",_bindMoneyPrice);
         _frame.addToContent(_priceCheck1);
         moneyValue = _moneyPrice * _numberSelecter.currentValue;
         _group.addSelectItem(_priceCheck0);
         _group.addSelectItem(_priceCheck1);
         _group.selectIndex = 0;
         _group.addEventListener("change",__cartItemGroupChange);
         _upToNextLevel = ComponentFactory.Instance.creat("com.quickBuyFrame.selectBtn");
         PositionUtils.setPos(_upToNextLevel,"ddtshop.upToNextLevelPos");
         _upToNextLevel.addEventListener("select",onUpToNxtLvChange);
         _frame.addToContent(_upToNextLevel);
         _upToNextLevelText = ComponentFactory.Instance.creat("core.ddtshop.CommodityPricesText");
         _upToNextLevelText.x = _upToNextLevel.x + 22;
         _upToNextLevelText.y = _upToNextLevel.y + 9;
         _upToNextLevelText.text = LanguageMgr.GetTranslation("tank.view.bagII.bringup.UpToNextLv");
         _frame.addToContent(_upToNextLevelText);
         _numberSelecter.valueLimit = "1,999999";
         _numberSelecter.addEventListener("change",onNumberSelecterChange);
         updateCommodityPrices();
      }
      
      protected function onUpToNxtLvChange(param1:Event) : void
      {
         if(_upToNextLevel.selected)
         {
            Helpers.grey(_numberSelecter.upDisplay);
            Helpers.grey(_numberSelecter.downDisplay);
         }
         else
         {
            Helpers.colorful(_numberSelecter.upDisplay);
            Helpers.colorful(_numberSelecter.downDisplay);
         }
         var _loc2_:* = !_upToNextLevel.selected;
         _numberSelecter.mouseEnabled = _loc2_;
         _numberSelecter.mouseChildren = _loc2_;
         if(_upToNextLevel.selected)
         {
            _numberSelecter.currentValue = _NextLvExp - _curExp;
         }
         else
         {
            _numberSelecter.currentValue = 1;
            (_numberSelecter.upDisplay as BaseButton).enable = false;
            Helpers.grey(_numberSelecter.upDisplay);
         }
         updateCommodityPrices();
      }
      
      protected function onNumberSelecterChange(param1:Event) : void
      {
         updateCommodityPrices();
      }
      
      protected function __cartItemGroupChange(param1:Event) : void
      {
         SoundManager.instance.play("008");
         updateCommodityPrices();
      }
      
      override protected function updateCommodityPrices() : void
      {
         var _loc1_:int = 0;
         if(_upToNextLevel.selected)
         {
            _loc1_ = _NextLvExp - _curExp;
         }
         else
         {
            _loc1_ = _numberSelecter.currentValue;
         }
         switch(int(_group.selectIndex))
         {
            case 0:
               moneyValue = _moneyPrice * _loc1_;
               _commodityPricesText1.text = moneyValue.toString();
               _commodityPricesText2.text = "0";
               break;
            case 1:
               moneyValue = _bindMoneyPrice * _loc1_;
               _commodityPricesText1.text = "0";
               _commodityPricesText2.text = moneyValue.toString();
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
         var _loc2_:int = _group.selectIndex;
         switch(int(_loc2_))
         {
            case 0:
               if(PlayerManager.Instance.Self.Money < moneyValue)
               {
                  LeavePageManager.showFillFrame();
                  return;
               }
               onCheckComplete();
               break;
            case 1:
               if(PlayerManager.Instance.Self.BandMoney < moneyValue)
               {
                  MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("bindMoneyPoorNote"));
                  return;
               }
               onCheckComplete();
               break;
         }
      }
      
      override protected function onCheckComplete() : void
      {
         var _loc2_:int = _group.selectIndex;
         var _loc1_:int = !!_upToNextLevel.selected?_NextLvExp - _curExp:Number(_numberSelecter.currentValue);
         onBuy && onBuy({
            "type":_loc2_,
            "num":_loc1_
         });
         ObjectUtils.disposeObject(this);
         _group = null;
      }
      
      override public function dispose() : void
      {
         if(_numberSelecter)
         {
            _numberSelecter.removeEventListener("change",onNumberSelecterChange);
         }
         if(_upToNextLevel)
         {
            _upToNextLevel.removeEventListener("change",onUpToNxtLvChange);
         }
         if(_group != null)
         {
            _group.removeEventListener("change",__cartItemGroupChange);
            _group.dispose();
            _group = null;
         }
         super.dispose();
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeAllChildren(_frame);
         _frame = null;
         _itemName = null;
         _priceCheck0 = null;
         _priceCheck1 = null;
         _upToNextLevel = null;
         _upToNextLevelText = null;
      }
   }
}
