package shop.view
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.UICreatShortcut;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.image.TiledImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.Shape;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import shop.manager.ShopBuyManager;
   import shop.manager.ShopSaleManager;
   
   public class ShopSaleItemCell extends Sprite implements Disposeable, ISelectable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      private var _info:ShopItemInfo;
      
      private var _sheng:Bitmap;
      
      private var _oneMoneyLabel:ScaleFrameImage;
      
      private var _twoMoneyLabel:ScaleFrameImage;
      
      private var _buyBtn:BaseButton;
      
      private var _cellPrice:FilterFrameText;
      
      private var _cellName:FilterFrameText;
      
      private var _cellOldPrice:FilterFrameText;
      
      private var _savePrice:int = 3000;
      
      private var _itemCell:ShopItemCell;
      
      private var _itemCellBg:Image;
      
      private var _selected:Boolean;
      
      private var _deleteLine:Shape;
      
      private var _line:TiledImage;
      
      private var _priceImageCon:Sprite;
      
      private var _priceImage:Vector.<ScaleFrameImage>;
      
      private var _countText:FilterFrameText;
      
      private var _limitNum:int = -1;
      
      private var _icon:ScaleFrameImage;
      
      public function ShopSaleItemCell()
      {
         super();
         init();
      }
      
      public function get itemCell() : ShopItemCell
      {
         return _itemCell;
      }
      
      private function init() : void
      {
         this.visible = false;
         _bg = UICreatShortcut.creatAndAdd("ddtshop.view.seleteSaleCellBg",this);
         _bg.setFrame(1);
         _sheng = UICreatShortcut.creatAndAdd("asset.ddtshop.SaleSave",this);
         _cellPrice = UICreatShortcut.creatAndAdd("ddtshop.view.saleCellPrice",this);
         _cellName = UICreatShortcut.creatAndAdd("ddtshop.view.saleCellName",this);
         _cellOldPrice = UICreatShortcut.creatAndAdd("ddtshop.view.saleCellOldPrice",this);
         _deleteLine = new Shape();
         addChild(_deleteLine);
         _oneMoneyLabel = UICreatShortcut.creatAndAdd("ddtshop.GoodPayTypeLabel",this);
         PositionUtils.setPos(_oneMoneyLabel,"ddtshop.oneMoneyLabel");
         _twoMoneyLabel = UICreatShortcut.creatAndAdd("ddtshop.GoodPayTypeLabel",this);
         PositionUtils.setPos(_twoMoneyLabel,"ddtshop.twoMoneyLabel");
         _oneMoneyLabel.setFrame(2);
         _twoMoneyLabel.setFrame(2);
         _line = UICreatShortcut.creatAndAdd("ddtshop.saleCellLine",this);
         _itemCellBg = UICreatShortcut.creatAndAdd("ddtshop.GoodItemCellBg",this);
         _itemCellBg.setFrame(1);
         PositionUtils.setPos(_itemCellBg,"ddtshop.saleItmeCellBgPos");
         _itemCell = createItemCell();
         addChild(_itemCell);
         _countText = UICreatShortcut.creatAndAdd("ddtshop.saleCellCount",this);
         PositionUtils.setPos(_itemCell,"ddtshop.saleItmeCellPos");
         _icon = UICreatShortcut.creatAndAdd("ddtshop.view.goodsCellIcon",this);
         _buyBtn = UICreatShortcut.creatAndAdd("ddtshop.view.saleCellBuyBtn",this);
         _buyBtn.addEventListener("click",__onClickBuy);
         _priceImage = new Vector.<ScaleFrameImage>();
         _priceImageCon = new Sprite();
         PositionUtils.setPos(_priceImageCon,"ddtshop.priceImageConPos");
         addChild(_priceImageCon);
      }
      
      public function set info(data:ShopItemInfo) : void
      {
         _info = data;
         if(_info)
         {
            _itemCell.info = _info.TemplateInfo;
            _itemCell.tipInfo = _info;
            updateinfo();
            this.visible = true;
         }
         else
         {
            _itemCell.info = null;
            this.visible = false;
         }
      }
      
      public function get info() : ShopItemInfo
      {
         return _info;
      }
      
      public function set limitNum(value:int) : void
      {
         if(_limitNum == value)
         {
            return;
         }
         _limitNum = value;
         _countText.text = _limitNum.toString();
         if(_countText.text == "-1")
         {
            _countText.visible = false;
         }
         else
         {
            _countText.visible = true;
         }
         _buyBtn.enable = enableBuy;
      }
      
      private function updateinfo() : void
      {
         limitNum = !!isLimitGoods?_info.LimitPersonalCount:int(_info.LimitAreaCount);
         _icon.setFrame(!!isLimitGoods?2:1);
         _cellName.text = _info.TemplateInfo.Name;
         var newPrice:int = _info.getItemPrice(1).bothMoneyValue;
         var oldPrice:* = int(ShopSaleManager.Instance.getGoodsOldPriceByID(_info.TemplateID));
         if(oldPrice <= 0)
         {
            oldPrice = newPrice;
         }
         _savePrice = oldPrice - newPrice;
         _cellPrice.text = LanguageMgr.GetTranslation("asset.ddtshop.newPrice",newPrice);
         _cellOldPrice.text = LanguageMgr.GetTranslation("asset.ddtshop.oldPrice",oldPrice);
         _deleteLine.x = _cellOldPrice.x + 2;
         _deleteLine.y = _cellOldPrice.y + _cellOldPrice.textHeight / 2 + 2;
         clearAndCreateDeleteLine(_cellOldPrice.textWidth);
         resetPrice();
      }
      
      private function __onClickBuy(e:MouseEvent) : void
      {
         if(enableBuy)
         {
            if(_limitNum <= 0 && _info.GoodsID != 201453110)
            {
               MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("asset.ddtshop.notBuySaleGoods"));
               return;
            }
            ShopSaleManager.Instance.goodsBuyMaxNum = _limitNum;
            ShopBuyManager.Instance.buy(_info.GoodsID,_info.isDiscount,_info.getItemPrice(1).PriceType,true);
         }
         else
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("asset.ddtshop.sellFinish"));
         }
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
         _itemCellBg.setFrame(!!_selected?3:1);
         _cellName.setFrame(selectType);
         _cellPrice.setFrame(selectType);
         _bg.setFrame(selectType);
      }
      
      private function get selectType() : int
      {
         return !!_selected?2:1;
      }
      
      public function get enableBuy() : Boolean
      {
         return _limitNum != 0;
      }
      
      public function get isLimitGoods() : Boolean
      {
         return _info.LimitPersonalCount != -1;
      }
      
      public function asDisplayObject() : DisplayObject
      {
         return this;
      }
      
      private function resetPrice() : void
      {
         var num:* = null;
         var index:int = 0;
         var len:Array = _savePrice.toString().split("");
         while(_priceImage.length)
         {
            ObjectUtils.disposeObject(_priceImage.pop());
         }
         while(_priceImage.length < len.length)
         {
            num = UICreatShortcut.creatAndAdd("ddtshop.view.SaleCoins",_priceImageCon);
            index = len[_priceImage.length];
            num.setFrame(index == 0?10:index);
            num.x = (num.width - 5) * _priceImage.length;
            _priceImage.push(num);
         }
      }
      
      private function clearAndCreateDeleteLine(lenght:int) : void
      {
         _deleteLine.graphics.clear();
         _deleteLine.graphics.lineStyle(1,11053223);
         _deleteLine.graphics.moveTo(0,0);
         _deleteLine.graphics.lineTo(lenght,0);
         _deleteLine.graphics.endFill();
      }
      
      private function createItemCell() : ShopItemCell
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,49,49);
         sp.graphics.endFill();
         return CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
      }
      
      public function dispose() : void
      {
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",__onClickBuy);
         }
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_itemCell);
         _itemCell = null;
         ObjectUtils.disposeObject(_countText);
         _countText = null;
         ObjectUtils.disposeObject(_itemCellBg);
         _itemCellBg = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_sheng);
         _sheng = null;
         ObjectUtils.disposeObject(_oneMoneyLabel);
         _oneMoneyLabel = null;
         ObjectUtils.disposeObject(_twoMoneyLabel);
         _twoMoneyLabel = null;
         ObjectUtils.disposeObject(_line);
         _line = null;
         ObjectUtils.disposeObject(_icon);
         _icon = null;
         _deleteLine.graphics.clear();
         ObjectUtils.disposeObject(_deleteLine);
         _deleteLine = null;
         _cellPrice = null;
         _cellName = null;
         _cellOldPrice = null;
      }
   }
}
