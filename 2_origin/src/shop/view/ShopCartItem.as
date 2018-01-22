package shop.view
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.SelectedButtonGroup;
   import com.pickgliss.ui.controls.SelectedCheckButton;
   import com.pickgliss.ui.controls.container.VBox;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemTemplateInfo;
   import ddt.data.goods.Price;
   import ddt.data.goods.ShopCarItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextFormat;
   import shop.manager.ShopBuyManager;
   
   public class ShopCartItem extends Sprite implements Disposeable
   {
      
      public static const DELETE_ITEM:String = "deleteitem";
      
      public static const CONDITION_CHANGE:String = "conditionchange";
      
      public static const ADD_LENGTH:String = "add_length";
       
      
      protected var _bg:DisplayObject;
      
      protected var _itemCellBg:DisplayObject;
      
      protected var _verticalLine:Image;
      
      protected var _cartItemGroup:SelectedButtonGroup;
      
      protected var _cartItemSelectVBox:VBox;
      
      protected var _closeBtn:BaseButton;
      
      public var id:int;
      
      public var type:int;
      
      public var upDataBtnState:Function;
      
      protected var _itemName:FilterFrameText;
      
      protected var _cell:ShopPlayerCell;
      
      protected var _shopItemInfo:ShopCarItemInfo;
      
      protected var _blueTF:TextFormat;
      
      protected var _yellowTF:TextFormat;
      
      public var seleBand:Function;
      
      private var _items:Vector.<SelectedCheckButton>;
      
      protected var _isBand:Boolean;
      
      private var _selectedBandBtn:SelectedCheckButton;
      
      private var _bandMoneyTxt:FilterFrameText;
      
      private var _moneyTxt:FilterFrameText;
      
      private var _selectedBtn:SelectedCheckButton;
      
      private var _movieBack:MovieClip;
      
      public function ShopCartItem()
      {
         super();
         drawBackground();
         drawNameField();
         drawCellField();
         _closeBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CartItemCloseBtn");
         _cartItemSelectVBox = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CartItemSelectVBox");
         _cartItemGroup = new SelectedButtonGroup();
         addChild(_closeBtn);
         addChild(_cartItemSelectVBox);
         initListener();
      }
      
      public function get closeBtn() : BaseButton
      {
         return _closeBtn;
      }
      
      protected function drawBackground(param1:Boolean = false) : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CartItemBg");
         _itemCellBg = ComponentFactory.Instance.creat("ddtshop.CartItemCellBg");
         _verticalLine = ComponentFactory.Instance.creatComponentByStylename("ddtshop.VerticalLine");
         addChild(_bg);
         addChild(_verticalLine);
         addChild(_itemCellBg);
      }
      
      protected function drawNameField() : void
      {
         _itemName = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CartItemName");
         addChild(_itemName);
      }
      
      protected function drawCellField() : void
      {
         _cell = CellFactory.instance.createShopCartItemCell() as ShopPlayerCell;
         PositionUtils.setPos(_cell,"ddtshop.CartItemCellPoint");
         addChild(_cell);
      }
      
      public function get isBand() : Boolean
      {
         return _isBand;
      }
      
      public function set isBand(param1:Boolean) : void
      {
         _isBand = param1;
      }
      
      protected function initListener() : void
      {
         _closeBtn.addEventListener("click",__closeClick);
         addEventListener("click",clickHander);
      }
      
      public function addItem(param1:Boolean = false) : void
      {
         if(_shopItemInfo.getCurrentPrice().PriceType == -2)
         {
            return;
         }
         if(type == 2)
         {
            return;
         }
         _bg.height = 114;
         _movieBack = ComponentFactory.Instance.creat("asset.core.stranDown");
         _movieBack.x = 177;
         _movieBack.y = 94;
         addChild(_movieBack);
         _isBand = param1;
         if(Price.ONLYDDT_MONEY)
         {
            addSelectedBandBtn();
            _selectedBandBtn.x = 139;
            _selectedBandBtn.selected = true;
            _selectedBandBtn.enable = false;
            _bandMoneyTxt.x = 125;
         }
         else if(Price.ONLYMONEY)
         {
            addSelectedBtn();
            _selectedBtn.x = 140;
            _moneyTxt.x = 113;
            _selectedBtn.selected = true;
            _selectedBtn.enable = false;
         }
         else
         {
            addSelectedBtn();
            addSelectedBandBtn();
            _moneyTxt.x = 70;
            _bandMoneyTxt.x = 180;
            _selectedBtn.x = 97;
            _selectedBtn.selected = !_isBand;
            _selectedBtn.enable = _isBand;
            _selectedBandBtn.x = 199;
            _selectedBandBtn.selected = _isBand;
            _selectedBandBtn.enable = !_isBand;
         }
      }
      
      private function addSelectedBtn() : void
      {
         _selectedBtn = ComponentFactory.Instance.creatComponentByStylename("vip.core.selectBtn");
         _selectedBtn.addEventListener("click",selectedHander);
         addChild(_selectedBtn);
         _selectedBtn.y = 77;
         _moneyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _moneyTxt.text = LanguageMgr.GetTranslation("money");
         addChild(_moneyTxt);
         _moneyTxt.y = 84;
      }
      
      private function addSelectedBandBtn() : void
      {
         _selectedBandBtn = ComponentFactory.Instance.creatComponentByStylename("vip.core.selectBtn");
         addChild(_selectedBandBtn);
         _selectedBandBtn.y = 77;
         _selectedBandBtn.addEventListener("click",selectedBandHander);
         _bandMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("vip.core.bandMoney");
         _bandMoneyTxt.text = LanguageMgr.GetTranslation("ddtMoney");
         addChild(_bandMoneyTxt);
         _bandMoneyTxt.y = 84;
      }
      
      private function selectedHander(param1:MouseEvent) : void
      {
         if(_selectedBtn.selected)
         {
            _isBand = false;
            _selectedBtn.enable = false;
            _selectedBandBtn.enable = true;
            _selectedBandBtn.selected = false;
         }
         else
         {
            _isBand = true;
         }
         setDianquanType(_isBand);
      }
      
      private function selectedBandHander(param1:MouseEvent) : void
      {
         if(_selectedBandBtn.selected)
         {
            _isBand = true;
            _selectedBtn.enable = true;
            _selectedBtn.selected = false;
            _selectedBandBtn.enable = false;
         }
         else
         {
            _isBand = false;
         }
         setDianquanType(_isBand);
      }
      
      public function setDianquanType(param1:Boolean = false) : void
      {
         var _loc4_:* = null;
         var _loc3_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:int = 0;
         var _loc5_:int = _items.length;
         _loc6_ = 0;
         while(_loc6_ < _loc5_)
         {
            _loc2_ = _loc6_ + 1;
            if(param1)
            {
               _loc4_ = _shopItemInfo.getTimeToString(_loc2_) != LanguageMgr.GetTranslation("ddt.shop.buyTime1")?_shopItemInfo.getTimeToString(_loc2_):LanguageMgr.GetTranslation("ddt.shop.buyTime2");
               _items[_loc6_].text = _shopItemInfo.getItemPrice(_loc2_).toString(true) + "/" + _loc4_;
               _loc3_ = rigthValue(_loc2_);
            }
            else
            {
               _loc4_ = _shopItemInfo.getTimeToString(_loc2_) != LanguageMgr.GetTranslation("ddt.shop.buyTime1")?_shopItemInfo.getTimeToString(_loc2_):LanguageMgr.GetTranslation("ddt.shop.buyTime2");
               _items[_loc6_].text = _shopItemInfo.getItemPrice(_loc2_).toString() + "/" + _loc4_;
               _loc3_ = rigthValue(_loc2_);
            }
            _loc6_++;
         }
         if(parent && seleBand != null)
         {
            seleBand(id,_loc3_,param1);
         }
      }
      
      private function rigthValue(param1:int) : int
      {
         if(param1 == _shopItemInfo.currentBuyType)
         {
            return _shopItemInfo.getItemPrice(param1).bothMoneyValue;
         }
         return 0;
      }
      
      protected function clickHander(param1:Event) : void
      {
         if(type == 2 || type == 4)
         {
            return;
         }
         if(_shopItemInfo.getCurrentPrice().PriceType == -2)
         {
            return;
         }
         if(param1.currentTarget.id == ShopBuyManager.crrItemId)
         {
            return;
         }
         if(param1.target is SelectedCheckButton)
         {
            return;
         }
         if(param1.target is FilterFrameText)
         {
            return;
         }
         dispatchEvent(new Event("add_length"));
      }
      
      protected function removeEvent() : void
      {
         if(_cartItemGroup)
         {
            _cartItemGroup.removeEventListener("change",__cartItemGroupChange);
            _cartItemGroup = null;
         }
         if(_closeBtn)
         {
            _closeBtn.removeEventListener("click",__closeClick);
         }
         removeEventListener("click",clickHander);
         if(_selectedBandBtn)
         {
            _selectedBandBtn.removeEventListener("click",clickHander);
         }
         if(_selectedBtn)
         {
            _selectedBtn.removeEventListener("click",selectedHander);
         }
      }
      
      protected function __closeClick(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         dispatchEvent(new Event("deleteitem"));
      }
      
      protected function __cartItemGroupChange(param1:Event) : void
      {
         _shopItemInfo.currentBuyType = _cartItemGroup.selectIndex + 1;
         dispatchEvent(new Event("conditionchange"));
      }
      
      public function setShopItemInfo(param1:ShopCarItemInfo, param2:int = -10, param3:Boolean = false) : void
      {
         if(_shopItemInfo != param1)
         {
            _cell.info = param1.TemplateInfo;
            _shopItemInfo = param1;
            if(id == param2)
            {
               addItem(param3);
            }
            if(param1 == null)
            {
               _itemName.text = "";
            }
            else
            {
               _itemName.text = String(param1.TemplateInfo.Name);
               cartItemSelectVBoxInit();
               setDianquanType(param3);
            }
         }
      }
      
      public function set showCloseButton(param1:Boolean) : void
      {
         _closeBtn.visible = param1;
      }
      
      protected function cartItemSelectVBoxInit() : void
      {
         var _loc4_:int = 0;
         var _loc3_:* = null;
         var _loc2_:* = null;
         var _loc1_:* = null;
         clearitem();
         _cartItemGroup = new SelectedButtonGroup();
         _cartItemGroup.addEventListener("change",__cartItemGroupChange);
         _items = new Vector.<SelectedCheckButton>();
         _loc4_ = 1;
         while(_loc4_ < 4)
         {
            if(_shopItemInfo.getItemPrice(_loc4_).IsValid)
            {
               _loc3_ = ComponentFactory.Instance.creatComponentByStylename("ddtshop.CartItemSelectBtn");
               _loc2_ = _shopItemInfo.getTimeToString(_loc4_) != LanguageMgr.GetTranslation("ddt.shop.buyTime1")?_shopItemInfo.getTimeToString(_loc4_):LanguageMgr.GetTranslation("ddt.shop.buyTime2");
               _loc1_ = _shopItemInfo.getItemPrice(_loc4_).toString();
               _loc3_.text = _shopItemInfo.getItemPrice(_loc4_).toString() + "/" + _loc2_;
               _cartItemSelectVBox.addChild(_loc3_);
               _loc3_.addEventListener("click",__soundPlay);
               _items.push(_loc3_);
               _cartItemGroup.addSelectItem(_loc3_);
            }
            _loc4_++;
         }
         _cartItemGroup.selectIndex = _shopItemInfo.currentBuyType - 1 < 1?0:Number(_shopItemInfo.currentBuyType - 1);
         if(_cartItemSelectVBox.numChildren == 2)
         {
            _cartItemSelectVBox.y = 18;
         }
         else if(_cartItemSelectVBox.numChildren == 1)
         {
            _cartItemSelectVBox.y = 33;
         }
      }
      
      private function clearitem() : void
      {
         var _loc1_:int = 0;
         if(_cartItemGroup)
         {
            _cartItemGroup.removeEventListener("change",__cartItemGroupChange);
            _cartItemGroup = null;
         }
         if(_items)
         {
            _loc1_ = 0;
            while(_loc1_ < _items.length)
            {
               if(_items[_loc1_])
               {
                  ObjectUtils.disposeObject(_items[_loc1_]);
                  _items[_loc1_].removeEventListener("click",__soundPlay);
               }
               _items[_loc1_] = null;
               _loc1_++;
            }
         }
         if(_cartItemSelectVBox)
         {
            _cartItemSelectVBox.disposeAllChildren();
         }
      }
      
      protected function __soundPlay(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
      }
      
      public function get shopItemInfo() : ShopCarItemInfo
      {
         return _shopItemInfo;
      }
      
      public function get info() : ItemTemplateInfo
      {
         return _cell.info;
      }
      
      public function get TemplateID() : int
      {
         if(_cell.info == null)
         {
            return -1;
         }
         return _cell.info.TemplateID;
      }
      
      public function setColor(param1:*) : void
      {
         _cell.setColor(param1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         clearitem();
         ObjectUtils.disposeAllChildren(this);
         _cartItemSelectVBox = null;
         _cartItemGroup = null;
         _bg = null;
         _itemCellBg = null;
         _verticalLine = null;
         _closeBtn = null;
         _itemName = null;
         _cell = null;
         _shopItemInfo = null;
         _blueTF = null;
         _yellowTF = null;
         _selectedBandBtn = null;
         _bandMoneyTxt = null;
         _moneyTxt = null;
         _selectedBtn = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
