package shop.view
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   
   public class ShopRechargeEquipViewItem extends ShopCartItem implements Disposeable
   {
      
      public static const DELETE_ITEM:String = "deleteitem";
      
      public static const CONDITION_CHANGE:String = "conditionchange";
       
      
      private var _moneyRadioBtn:SelectedCheckButton;
      
      private var _orderRadioBtn:SelectedCheckButton;
      
      private var _isDelete:Boolean = false;
      
      private var _radioGroup:SelectedButtonGroup;
      
      private var _shopItems:Array;
      
      private var fileterArr:Array;
      
      public var clieckHander:Function;
      
      public var moneType:int = 1;
      
      public function ShopRechargeEquipViewItem()
      {
         fileterArr = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
         super();
         init();
         initEventListener();
      }
      
      private function init() : void
      {
         _radioGroup = new SelectedButtonGroup();
         _moneyRadioBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.TicketSelectedCheckBtn");
         _moneyRadioBtn.text = LanguageMgr.GetTranslation("shop.RechargeView.TicketText");
         _orderRadioBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.GiftSelectedCheckBtn");
         _orderRadioBtn.text = LanguageMgr.GetTranslation("shop.RechargeView.GiftText");
         PositionUtils.setPos(_itemName,"ddtshop.RechargeViewItemNamePos");
         PositionUtils.setPos(_closeBtn,"ddtshop.RechargeViewCloseBtnPos");
         PositionUtils.setPos(_cartItemSelectVBox,"ddtshop.RechargeViewSelectVBoxPos");
         _radioGroup.addSelectItem(_moneyRadioBtn);
         _radioGroup.addSelectItem(_orderRadioBtn);
         _radioGroup.selectIndex = 0;
         addChild(_moneyRadioBtn);
         addChild(_orderRadioBtn);
      }
      
      override protected function drawBackground(param1:Boolean = false) : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.CartItemBg");
         _itemCellBg = ComponentFactory.Instance.creat("ddtshop.CartItemCellBg");
         _verticalLine = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RechargeView.VerticalLine");
         addChild(_bg);
         addChild(_verticalLine);
         addChild(_itemCellBg);
      }
      
      private function initEventListener() : void
      {
         _moneyRadioBtn.addEventListener("click",__selectRadioBtn);
         _orderRadioBtn.addEventListener("click",__selectRadioBtn);
      }
      
      public function set itemInfo(param1:InventoryItemInfo) : void
      {
         var _loc2_:int = 0;
         _cell.info = param1;
         _shopItems = ShopManager.Instance.getShopRechargeItemByTemplateId(param1.TemplateID);
         _shopItemInfo = null;
         _loc2_ = 0;
         while(_loc2_ < _shopItems.length)
         {
            if(_shopItems[_loc2_].getItemPrice(1).IsBothMoneyType)
            {
               _shopItemInfo = fillToShopCarInfo(_shopItems[_loc2_]);
               break;
            }
            _loc2_++;
         }
         if(_shopItemInfo == null)
         {
            _shopItemInfo = fillToShopCarInfo(_shopItems[0]);
         }
         resetRadioBtn(param1.IsBinds);
         cartItemSelectVBoxInit();
         _cartItemGroup.selectIndex = _cartItemSelectVBox.numChildren - 1;
         _itemName.text = param1.Name;
      }
      
      override protected function cartItemSelectVBoxInit() : void
      {
         super.cartItemSelectVBoxInit();
         if(_cartItemSelectVBox.numChildren == 2)
         {
            _cartItemSelectVBox.y = 15;
         }
         else if(_cartItemSelectVBox.numChildren == 1)
         {
            _cartItemSelectVBox.y = 21;
         }
         else if(_cartItemSelectVBox.numChildren == 3)
         {
            _cartItemSelectVBox.y = 9;
         }
      }
      
      private function __selectRadioBtn(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(param1.currentTarget == _moneyRadioBtn)
         {
            updateCurrentShopItem(-1);
            moneType = 1;
            _orderRadioBtn.selected = false;
         }
         else if(param1.currentTarget == _orderRadioBtn)
         {
            updateCurrentShopItem(-2);
            moneType = 2;
            _moneyRadioBtn.selected = false;
         }
         clieckHander(id,moneType);
         cartItemSelectVBoxInit();
         _cartItemGroup.selectIndex = _cartItemSelectVBox.numChildren - 1;
         dispatchEvent(new Event("conditionchange"));
      }
      
      public function get currentShopItem() : ShopCarItemInfo
      {
         return _shopItemInfo;
      }
      
      public function get isDelete() : Boolean
      {
         return _isDelete;
      }
      
      private function updateCurrentShopItem(param1:int) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < _shopItems.length)
         {
            if(_shopItems[_loc2_].getItemPrice(1).PriceType == param1)
            {
               _shopItemInfo = fillToShopCarInfo(_shopItems[_loc2_]);
               break;
            }
            _loc2_++;
         }
      }
      
      private function resetRadioBtn(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         var _loc3_:Boolean = false;
         _moneyRadioBtn.selected = _loc3_;
         _moneyRadioBtn.enable = _loc3_;
         _loc3_ = false;
         _orderRadioBtn.selected = _loc3_;
         _orderRadioBtn.enable = _loc3_;
         _orderRadioBtn.visible = false;
         _moneyRadioBtn.filters = fileterArr;
         _orderRadioBtn.filters = fileterArr;
         _loc2_ = 0;
         while(_loc2_ < _shopItems.length)
         {
            if(_shopItems[_loc2_].getItemPrice(1).IsMixed || _shopItems[_loc2_].getItemPrice(2).IsMixed)
            {
               throw new Error("续费价格填错了！！！");
            }
            if(_shopItems[_loc2_].getItemPrice(1).IsBothMoneyType)
            {
               _moneyRadioBtn.enable = true;
               _moneyRadioBtn.filters = null;
            }
            else if(_shopItems[_loc2_].getItemPrice(1).IsBandDDTMoneyType && (_cell.info as InventoryItemInfo).IsBinds)
            {
               if(_shopItems.length == 1 || !_shopItems[0].getItemPrice(1).isArmShellClipType)
               {
                  _orderRadioBtn.enable = true;
                  _orderRadioBtn.filters = null;
               }
               _orderRadioBtn.visible = true;
               _orderRadioBtn.selected = true;
               updateCurrentShopItem(-2);
               moneType = 2;
            }
            else
            {
               _orderRadioBtn.visible = true;
            }
            _loc2_++;
         }
         if(_shopItemInfo.getItemPrice(1).IsMoneyType)
         {
            _moneyRadioBtn.selected = true;
            _orderRadioBtn.selected = false;
         }
      }
      
      override protected function __closeClick(param1:MouseEvent) : void
      {
         evt = param1;
         SoundManager.instance.play("008");
         filters = fileterArr;
         _isDelete = true;
         mouseChildren = false;
         evt.stopPropagation();
         addEventListener("click",function(param1:Event):void
         {
            SoundManager.instance.play("008");
            mouseChildren = true;
            _isDelete = false;
            filters = null;
            dispatchEvent(new Event("conditionchange"));
            removeEventListener("click",arguments.callee);
         });
         dispatchEvent(new Event("conditionchange"));
      }
      
      private function fillToShopCarInfo(param1:ShopItemInfo) : ShopCarItemInfo
      {
         if(!param1)
         {
            return null;
         }
         var _loc2_:ShopCarItemInfo = new ShopCarItemInfo(param1.GoodsID,param1.TemplateID,_cell.info.CategoryID);
         ObjectUtils.copyProperties(_loc2_,param1);
         return _loc2_;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _moneyRadioBtn.removeEventListener("click",__selectRadioBtn);
         _orderRadioBtn.removeEventListener("click",__selectRadioBtn);
         ObjectUtils.disposeAllChildren(this);
         _moneyRadioBtn = null;
         _orderRadioBtn = null;
         _shopItems = null;
      }
   }
}
