package catchInsect.componets
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import shop.view.ShopItemCell;
   
   public class CatchInsectShopItem extends Sprite implements Disposeable
   {
       
      
      protected var _itemBg:ScaleFrameImage;
      
      protected var _itemCellBg:Image;
      
      protected var _dotLine:Image;
      
      protected var _payType:ScaleFrameImage;
      
      protected var _itemNameTxt:FilterFrameText;
      
      protected var _itemPriceTxt:FilterFrameText;
      
      protected var _itemCell:ShopItemCell;
      
      private var _needScore:FilterFrameText;
      
      private var _canNotBuyTips:FilterFrameText;
      
      private var _covertBtn:SimpleBitmapButton;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _itemCellBtn:Sprite;
      
      protected var _shopItemInfo:ShopItemInfo;
      
      protected var _selected:Boolean;
      
      protected var _isMouseOver:Boolean;
      
      protected var _lightMc:MovieClip;
      
      public function CatchInsectShopItem()
      {
         super();
         initContent();
         addEvent();
      }
      
      protected function initContent() : void
      {
         _itemBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemBg");
         _itemCellBg = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemCellBg");
         _dotLine = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemDotLine");
         _payType = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodPayTypeLabel");
         _payType.mouseChildren = false;
         _payType.mouseEnabled = false;
         _itemNameTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemName");
         _itemPriceTxt = ComponentFactory.Instance.creatComponentByStylename("ddtshop.GoodItemPrice");
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,60,60);
         sp.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
         PositionUtils.setPos(_itemCell,"catchInsect.shopFrame.itemCell.pos");
         _needScore = ComponentFactory.Instance.creatComponentByStylename("catchInsect.shopFrame.needScoreTxt");
         _needScore.text = LanguageMgr.GetTranslation("magicStone.score");
         _canNotBuyTips = ComponentFactory.Instance.creatComponentByStylename("catchInsect.shopFrame.scoreNotEnoughTxt");
         _canNotBuyTips.visible = false;
         _covertBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.ConvertBtn");
         _covertBtn.visible = false;
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("core.ddtshop.BuyBtn");
         _buyBtn.visible = false;
         _itemBg.setFrame(1);
         _itemCellBg.setFrame(1);
         _payType.setFrame(1);
         _itemCellBtn = new Sprite();
         _itemCellBtn.addChild(_itemCell);
         addChild(_itemBg);
         addChild(_itemCellBg);
         addChild(_dotLine);
         addChild(_payType);
         addChild(_itemNameTxt);
         addChild(_itemPriceTxt);
         addChild(_itemCellBtn);
         addChild(_needScore);
         addChild(_canNotBuyTips);
         addChild(_covertBtn);
         addChild(_buyBtn);
         _payType.visible = false;
         _itemPriceTxt.visible = false;
      }
      
      public function set shopItemInfo(value:ShopItemInfo) : void
      {
         if(value)
         {
            _shopItemInfo = value;
            _itemCell.info = value.TemplateInfo;
            _itemCell.visible = true;
            _itemNameTxt.visible = true;
            if(_itemCell.info.Name.length > 6)
            {
               _itemNameTxt.text = _itemCell.info.Name.substr(0,6) + "...";
            }
            else
            {
               _itemNameTxt.text = _itemCell.info.Name;
            }
            _needScore.visible = true;
            _needScore.text = LanguageMgr.GetTranslation("magicStone.score",String(value.AValue1));
            _covertBtn.visible = true;
            _buyBtn.visible = false;
            _canNotBuyTips.visible = false;
         }
         else
         {
            _shopItemInfo = null;
            _itemCell.info = null;
            _itemBg.setFrame(1);
            _itemCellBg.setFrame(1);
            _payType.visible = false;
            _itemPriceTxt.visible = false;
            _itemNameTxt.visible = false;
            _needScore.visible = false;
            _covertBtn.visible = false;
            _buyBtn.visible = false;
            _canNotBuyTips.visible = false;
         }
      }
      
      public function get shopItemInfo() : ShopItemInfo
      {
         return _shopItemInfo;
      }
      
      protected function addEvent() : void
      {
         _covertBtn.addEventListener("click",__covertBtnClick);
         _buyBtn.addEventListener("click",__buyBtnClick);
         _itemBg.addEventListener("mouseOver",__itemMouseOver);
         _itemBg.addEventListener("mouseOut",__itemMouseOut);
         _itemCellBtn.addEventListener("click",__itemClick);
         _itemCellBtn.addEventListener("mouseOver",__itemMouseOver);
         _itemCellBtn.addEventListener("mouseOut",__itemMouseOut);
      }
      
      protected function removeEvent() : void
      {
         _covertBtn.removeEventListener("click",__covertBtnClick);
         _buyBtn.removeEventListener("click",__buyBtnClick);
         _itemBg.removeEventListener("mouseOver",__itemMouseOver);
         _itemBg.removeEventListener("mouseOut",__itemMouseOut);
         _itemCellBtn.removeEventListener("click",__itemClick);
         _itemCellBtn.removeEventListener("mouseOver",__itemMouseOver);
         _itemCellBtn.removeEventListener("mouseOut",__itemMouseOut);
      }
      
      protected function __itemClick(evt:MouseEvent) : void
      {
         if(!_shopItemInfo)
         {
            return;
         }
         SoundManager.instance.play("008");
         dispatchEvent(new ItemEvent("itemClick",_shopItemInfo,1));
      }
      
      protected function __covertBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var quickBuyFrame:InsectQuickBuyAlert = ComponentFactory.Instance.creatComponentByStylename("catchInsect.quickBuyAlert");
         quickBuyFrame.setData(_shopItemInfo.TemplateID,_shopItemInfo.GoodsID,_shopItemInfo.AValue1);
         LayerManager.Instance.addToLayer(quickBuyFrame,3,true,1);
      }
      
      protected function __buyBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
      }
      
      protected function __itemMouseOver(event:MouseEvent) : void
      {
         if(!_itemCell.info)
         {
            return;
         }
         if(_lightMc)
         {
            addChild(_lightMc);
         }
         parent.addChild(this);
         _isMouseOver = true;
      }
      
      protected function __itemMouseOut(event:MouseEvent) : void
      {
         ObjectUtils.disposeObject(_lightMc);
         if(!_shopItemInfo)
         {
            return;
         }
         _isMouseOver = false;
      }
      
      public function setItemLight($lightMc:MovieClip) : void
      {
         if(_lightMc == $lightMc)
         {
            return;
         }
         _lightMc = $lightMc;
         _lightMc.mouseChildren = false;
         _lightMc.mouseEnabled = false;
         _lightMc.gotoAndPlay(1);
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
         _itemNameTxt.setFrame(!!value?2:1);
         _itemPriceTxt.setFrame(!!value?2:1);
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_itemBg);
         _itemBg = null;
         ObjectUtils.disposeObject(_itemCellBg);
         _itemCellBg = null;
         ObjectUtils.disposeObject(_dotLine);
         _dotLine = null;
         ObjectUtils.disposeObject(_payType);
         _payType = null;
         ObjectUtils.disposeObject(_itemNameTxt);
         _itemNameTxt = null;
         ObjectUtils.disposeObject(_itemPriceTxt);
         _itemPriceTxt = null;
         ObjectUtils.disposeObject(_itemCell);
         _itemCell = null;
         ObjectUtils.disposeObject(_itemCellBtn);
         _itemCellBtn = null;
         ObjectUtils.disposeObject(_needScore);
         _needScore = null;
         ObjectUtils.disposeObject(_canNotBuyTips);
         _canNotBuyTips = null;
         ObjectUtils.disposeObject(_covertBtn);
         _covertBtn = null;
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
      }
   }
}
