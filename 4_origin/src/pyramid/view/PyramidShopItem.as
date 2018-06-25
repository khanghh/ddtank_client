package pyramid.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.PyramidManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.filters.ColorMatrixFilter;
   import pyramid.PyramidControl;
   import shop.view.ShopItemCell;
   
   public class PyramidShopItem extends Sprite implements Disposeable
   {
       
      
      private var _bg:ScaleFrameImage;
      
      protected var _itemCell:ShopItemCell;
      
      protected var _itemNameTxt:FilterFrameText;
      
      protected var _itemPriceTxt:FilterFrameText;
      
      protected var _itemPriceTitle:FilterFrameText;
      
      protected var _dotLine:Image;
      
      protected var _shopViewItemBtn:BaseButton;
      
      private var _shopItemInfo:ShopItemInfo;
      
      public function PyramidShopItem()
      {
         super();
         initView();
         initEvent();
      }
      
      private function initView() : void
      {
         _bg = ComponentFactory.Instance.creatComponentByStylename("assets.pyramid.shopViewItemBg");
         _bg.setFrame(1);
         addChild(_bg);
         _itemCell = creatItemCell();
         _itemCell.buttonMode = true;
         _itemCell.width = 55;
         _itemCell.height = 55;
         PositionUtils.setPos(_itemCell,"pyramid.shopGoodItemCellPos");
         addChild(_itemCell);
         _dotLine = ComponentFactory.Instance.creatComponentByStylename("pyramid.view.shopItemDotLine");
         addChild(_dotLine);
         _itemNameTxt = ComponentFactory.Instance.creatComponentByStylename("pyramid.view.shopItemNameTxt");
         _itemPriceTxt = ComponentFactory.Instance.creatComponentByStylename("pyramid.view.shopItemPriceTxt");
         _itemPriceTitle = ComponentFactory.Instance.creatComponentByStylename("pyramid.view.shopItemPriceTitle");
         _itemPriceTitle.text = LanguageMgr.GetTranslation("ddt.pyramid.shopItemPriceTitle");
         addChild(_itemNameTxt);
         addChild(_itemPriceTxt);
         addChild(_itemPriceTitle);
         _shopViewItemBtn = ComponentFactory.Instance.creatComponentByStylename("pyramid.view.shopViewItemBtn");
         addChild(_shopViewItemBtn);
      }
      
      private function initEvent() : void
      {
         this.addEventListener("mouseOver",__shopItemOver);
         this.addEventListener("mouseOut",__shopItemOut);
         _shopViewItemBtn.addEventListener("click",__shopViewItemBtnClick);
      }
      
      public function set shopItemInfo(value:ShopItemInfo) : void
      {
         if(_shopItemInfo)
         {
            _shopItemInfo.removeEventListener("change",__updateShopItem);
         }
         _shopItemInfo = value;
         if(_shopItemInfo)
         {
            _itemCell.info = _shopItemInfo.TemplateInfo;
            _itemCell.tipInfo = _shopItemInfo;
            _itemNameTxt.text = String(_itemCell.info.Name);
            initPrice();
            _itemPriceTitle.visible = true;
            _shopViewItemBtn.visible = true;
            _itemCell.buttonMode = true;
            _shopItemInfo.addEventListener("change",__updateShopItem);
         }
         else
         {
            _itemCell.info = null;
            _itemCell.tipInfo = null;
            _itemNameTxt.text = "";
            _itemPriceTxt.text = "";
            _itemPriceTitle.visible = false;
            _shopViewItemBtn.visible = false;
            _itemCell.buttonMode = false;
         }
      }
      
      protected function initPrice() : void
      {
         _itemPriceTxt.text = String(_shopItemInfo.AValue1);
         updateGreyState();
      }
      
      public function updateGreyState() : void
      {
         if(_shopItemInfo && PyramidManager.instance.model.totalPoint < _shopItemInfo.AValue1)
         {
            isButtonGrey(true);
         }
         else
         {
            isButtonGrey(false);
         }
      }
      
      public function get shopItemInfo() : ShopItemInfo
      {
         return _shopItemInfo;
      }
      
      private function __updateShopItem(event:Event) : void
      {
         _itemCell.info = _shopItemInfo.TemplateInfo;
         _itemCell.tipInfo = _shopItemInfo;
         _itemNameTxt.text = String(_itemCell.info.Name);
         initPrice();
      }
      
      protected function creatItemCell() : ShopItemCell
      {
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,60,60);
         sp.graphics.endFill();
         return CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
      }
      
      private function __shopViewItemBtnClick(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PyramidManager.instance.model.isPyramidStart)
         {
            PyramidControl.instance.showFrame(4);
         }
         else
         {
            SocketManager.Instance.out.sendButTransnationalGoods(_shopItemInfo.GoodsID);
         }
      }
      
      private function isButtonGrey(bool:Boolean) : void
      {
         if(bool)
         {
            _shopViewItemBtn.mouseChildren = false;
            _shopViewItemBtn.mouseEnabled = false;
            _shopViewItemBtn.filters = [new ColorMatrixFilter([0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0.3086,0.6094,0.082,0,0,0,0,0,1,0])];
         }
         else
         {
            _shopViewItemBtn.mouseChildren = true;
            _shopViewItemBtn.mouseEnabled = true;
            _shopViewItemBtn.filters = null;
         }
      }
      
      private function __shopItemOver(event:MouseEvent) : void
      {
         if(_shopItemInfo)
         {
            _bg.setFrame(2);
         }
      }
      
      private function __shopItemOut(event:MouseEvent) : void
      {
         _bg.setFrame(1);
      }
      
      private function removeEvent() : void
      {
         this.removeEventListener("mouseOver",__shopItemOver);
         this.removeEventListener("mouseOut",__shopItemOut);
         _shopViewItemBtn.removeEventListener("click",__shopViewItemBtnClick);
         if(_shopItemInfo)
         {
            _shopItemInfo.removeEventListener("change",__updateShopItem);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         ObjectUtils.disposeObject(_itemCell);
         _itemCell = null;
         ObjectUtils.disposeObject(_itemNameTxt);
         _itemNameTxt = null;
         ObjectUtils.disposeObject(_itemPriceTxt);
         _itemPriceTxt = null;
         ObjectUtils.disposeObject(_itemPriceTitle);
         _itemPriceTitle = null;
         ObjectUtils.disposeObject(_dotLine);
         _dotLine = null;
         ObjectUtils.disposeObject(_shopViewItemBtn);
         _shopViewItemBtn = null;
         _shopItemInfo = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
