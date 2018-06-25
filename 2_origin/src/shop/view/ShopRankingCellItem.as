package shop.view
{
   import bagAndInfo.cell.CellFactory;
   import com.greensock.TimelineMax;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ShopRankingCellItem extends Sprite implements ISelectable, Disposeable
   {
      
      public static const PAYTYPE_DDT_MONEY:uint = 1;
      
      public static const PAYTYPE_MONEY:uint = 2;
      
      private static const LIMIT_LABEL:uint = 6;
       
      
      private var _payPaneGivingBtn:BaseButton;
      
      private var _payPaneBuyBtn:BaseButton;
      
      private var _itemCellBtn:Sprite;
      
      private var _itemBg:ScaleFrameImage;
      
      private var _itemCell:ShopItemCell;
      
      private var _itemCountTxt:FilterFrameText;
      
      private var _itemNameTxt:FilterFrameText;
      
      private var _itemPriceTxt:FilterFrameText;
      
      private var _payType:ScaleFrameImage;
      
      private var _selected:Boolean;
      
      private var _shopItemInfo:ShopItemInfo;
      
      private var _shopItemCellBg:Bitmap;
      
      private var _shopItemCellTypeBg:ScaleFrameImage;
      
      private var _timeline:TimelineMax;
      
      private var _itemDotLine:Image;
      
      private var _limitNum:int;
      
      public var LimitFlag:Boolean;
      
      private var _isMouseOver:Boolean;
      
      private var _lightMc:MovieClip;
      
      private var _payPaneAskBtn:BaseButton;
      
      public function ShopRankingCellItem()
      {
         super();
         initContent();
      }
      
      public function get payPaneGivingBtn() : BaseButton
      {
         return _payPaneGivingBtn;
      }
      
      public function get payPaneBuyBtn() : BaseButton
      {
         return _payPaneBuyBtn;
      }
      
      public function get itemCellBtn() : Sprite
      {
         return _itemCellBtn;
      }
      
      public function get itemBg() : ScaleFrameImage
      {
         return _itemBg;
      }
      
      public function get itemCell() : ShopItemCell
      {
         return _itemCell;
      }
      
      private function initContent() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RankingGoodItemCellBg");
         _payType = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodPayTypeLabel");
         _payType.mouseChildren = false;
         _payType.mouseEnabled = false;
         PositionUtils.setPos(_payType,"ddtshop.GoodPayTypeLabelPos");
         _payPaneGivingBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PayPaneGivingBtn");
         _payPaneGivingBtn.x = 16;
         _payPaneBuyBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PayPaneBuyBtn");
         _payPaneBuyBtn.x = 100;
         _payPaneAskBtn = ComponentFactory.Instance.creatComponentByStylename("ddtshop.PayPaneAskBtn");
         _payPaneAskBtn.x = 59;
         _itemNameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemName");
         PositionUtils.setPos(_itemNameTxt,"ddtshop.GoodItemNamePos");
         _itemPriceTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemPrice");
         PositionUtils.setPos(_itemPriceTxt,"ddtshop.GoodItemPricePos");
         _itemCountTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodLimitItemCount");
         _itemDotLine = ComponentFactory.Instance.creatComponentByStylename("ddtshop.RankingItemDotLine");
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,75,75);
         sp.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
         var _loc2_:* = 0.7;
         _itemCell.scaleY = _loc2_;
         _itemCell.scaleX = _loc2_;
         _itemCell.x = -1;
         _itemCell.y = -2;
         _itemCellBtn = new Sprite();
         _itemCellBtn.buttonMode = true;
         _itemCellBtn.addChild(_itemCell);
         _itemBg.setFrame(1);
         _payType.setFrame(1);
         addChild(_itemBg);
         addChild(_payType);
         addChild(_payPaneGivingBtn);
         addChild(_payPaneBuyBtn);
         addChild(_payPaneAskBtn);
         addChild(_itemNameTxt);
         addChild(_itemPriceTxt);
         addChild(_itemDotLine);
         addChild(_itemCellBtn);
         addChild(_itemCountTxt);
         shopItemInfo = null;
      }
      
      public function get shopItemInfo() : ShopItemInfo
      {
         return _shopItemInfo;
      }
      
      public function set shopItemInfo(value:ShopItemInfo) : void
      {
         if(value == null)
         {
            _shopItemInfo = null;
            _itemCell.info = null;
         }
         else
         {
            _itemCell.info = value.TemplateInfo;
            if(_shopItemInfo)
            {
               _shopItemInfo.removeEventListener("change",__updateShopItem);
            }
            _shopItemInfo = value;
         }
         if(_itemCell.info != null)
         {
            _payType.visible = true;
            _itemPriceTxt.visible = true;
            _itemNameTxt.visible = true;
            _itemCountTxt.visible = true;
            _payPaneGivingBtn.visible = true;
            _payPaneBuyBtn.visible = true;
            _payPaneAskBtn.visible = true;
            _itemCellBtn.visible = true;
            _itemNameTxt.text = String(_itemCell.info.Name);
            initPrice();
            _shopItemInfo.addEventListener("change",__updateShopItem);
         }
         else
         {
            _payType.visible = false;
            _itemPriceTxt.visible = false;
            _itemNameTxt.visible = false;
            _itemCountTxt.visible = false;
            _payPaneGivingBtn.visible = false;
            _payPaneBuyBtn.visible = false;
            _payPaneAskBtn.visible = false;
            _itemCellBtn.visible = false;
            _itemBg.setFrame(1);
         }
         updateCount();
      }
      
      private function __updateShopItem(evt:Event) : void
      {
         updateCount();
      }
      
      private function initPrice() : void
      {
         switch(int(_shopItemInfo.getItemPrice(1).PriceType) - -2)
         {
            case 0:
               _payType.setFrame(1);
               _itemPriceTxt.text = String(_shopItemInfo.getItemPrice(1).ddtMoneyValue);
               break;
            case 1:
               _payType.setFrame(2);
               _itemPriceTxt.text = String(_shopItemInfo.getItemPrice(1).bothMoneyValue);
         }
      }
      
      private function updateCount() : void
      {
         if(_shopItemInfo)
         {
            if(_shopItemInfo.Label && _shopItemInfo.Label == 6)
            {
               if(_itemBg && _itemCountTxt)
               {
                  _itemCountTxt.text = String(_limitNum);
                  _payPaneBuyBtn.enable = _limitNum == 0?false:true;
               }
            }
            else
            {
               _payPaneBuyBtn.enable = true;
               if(_itemBg && _itemCountTxt)
               {
                  _itemCountTxt.visible = false;
                  _itemCountTxt.text = "0";
               }
            }
         }
      }
      
      public function mouseOver() : void
      {
         if(!_itemCell.info)
         {
            return;
         }
         _isMouseOver = true;
      }
      
      public function get payPaneAskBtn() : BaseButton
      {
         return _payPaneAskBtn;
      }
      
      public function setItemLight($lightMc:MovieClip) : void
      {
         if(_lightMc == $lightMc || !_shopItemInfo)
         {
            return;
         }
         _lightMc = $lightMc;
         _lightMc.mouseChildren = false;
         _lightMc.mouseEnabled = false;
         _lightMc.x = 3;
         _lightMc.y = 2;
         _lightMc.gotoAndPlay(1);
         addChild(_lightMc);
      }
      
      public function mouseOut() : void
      {
         if(!_shopItemInfo)
         {
            return;
         }
         _isMouseOver = false;
         ObjectUtils.disposeObject(_lightMc);
         _lightMc = null;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      public function set autoSelect(value:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         if(_selected == value)
         {
            return;
         }
         _selected = value;
         _itemBg.setFrame(!!_selected?2:checkType());
      }
      
      private function checkType() : int
      {
         if(_shopItemInfo)
         {
            return _shopItemInfo.ShopID == 1?1:2;
         }
         return 1;
      }
      
      public function dispose() : void
      {
         if(_shopItemInfo)
         {
            _shopItemInfo.removeEventListener("change",__updateShopItem);
         }
         ObjectUtils.disposeAllChildren(this);
         ObjectUtils.disposeObject(_lightMc);
         _lightMc = null;
         ObjectUtils.disposeObject(_itemDotLine);
         _itemDotLine = null;
         ObjectUtils.disposeObject(_itemCell);
         _itemCell = null;
         _itemBg = null;
         _itemCountTxt = null;
         _itemNameTxt = null;
         _itemPriceTxt = null;
         _payType = null;
         _shopItemInfo = null;
         _payPaneGivingBtn = null;
         _payPaneBuyBtn = null;
      }
      
      public function get limitNum() : int
      {
         return _limitNum;
      }
      
      public function set limitNum(value:int) : void
      {
         _limitNum = value;
         updateCount();
      }
   }
}
