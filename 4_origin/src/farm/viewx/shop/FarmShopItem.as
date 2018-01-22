package farm.viewx.shop
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import shop.manager.ShopBuyManager;
   import shop.view.ShopItemCell;
   
   public class FarmShopItem extends Sprite implements Disposeable
   {
       
      
      private var _payPaneBuyBtn:BaseButton;
      
      private var _payPaneBuyBtnHotArea:Sprite;
      
      private var _itemBg:Bitmap;
      
      private var _itemCell:ShopItemCell;
      
      private var _shopItemInfo:ShopItemInfo;
      
      private var _canBuy:Boolean = true;
      
      public function FarmShopItem()
      {
         super();
         initContent();
         addEvent();
      }
      
      protected function initContent() : void
      {
         buttonMode = true;
         _itemBg = ComponentFactory.Instance.creatBitmap("assets.farmShop.goodItemBg");
         _payPaneBuyBtn = ComponentFactory.Instance.creatComponentByStylename("farmshop.PayPaneBuyBtn");
         _payPaneBuyBtnHotArea = new Sprite();
         _payPaneBuyBtnHotArea.graphics.beginFill(0,0);
         _payPaneBuyBtnHotArea.graphics.drawRect(0,0,78,96);
         _payPaneBuyBtnHotArea.mouseEnabled = false;
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,60,60);
         _loc1_.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
         _itemCell.cellSize = 50;
         PositionUtils.setPos(_itemCell,"farm.shopItem.pos");
         addChild(_itemBg);
         addChild(_itemCell);
         addChild(_payPaneBuyBtn);
         addChild(_payPaneBuyBtnHotArea);
      }
      
      protected function addEvent() : void
      {
         this.addEventListener("click",__payPanelClick);
         addEventListener("mouseOver",__overHandler);
         addEventListener("mouseOut",__outhandler);
         _payPaneBuyBtn.addEventListener("click",__payPanelClick);
         _payPaneBuyBtnHotArea.addEventListener("mouseOver",__payPaneOver);
         _payPaneBuyBtnHotArea.addEventListener("mouseOut",__payPaneOut);
      }
      
      protected function __payPaneOut(param1:MouseEvent) : void
      {
         ShowTipManager.Instance.removeTip(_payPaneBuyBtn);
      }
      
      protected function __payPaneOver(param1:MouseEvent) : void
      {
         if(_shopItemInfo && _shopItemInfo.LimitGrade > PlayerManager.Instance.Self.Grade)
         {
            _payPaneBuyBtn.tipStyle = "ddt.view.tips.OneLineTip";
            _payPaneBuyBtn.tipData = LanguageMgr.GetTranslation("ddt.shop.LimitGradeBuy",_shopItemInfo.LimitGrade);
            _payPaneBuyBtn.tipDirctions = "3,7,6";
            ShowTipManager.Instance.showTip(_payPaneBuyBtn);
         }
         else if(!canBuyFert())
         {
            _payPaneBuyBtn.tipStyle = "ddt.view.tips.OneLineTip";
            _payPaneBuyBtn.tipData = LanguageMgr.GetTranslation("ddt.shop.MinBuyFertLevel",ServerConfigManager.instance.getPrivilegeMinLevel("8"));
            _payPaneBuyBtn.tipDirctions = "3,7,6";
            ShowTipManager.Instance.showTip(_payPaneBuyBtn);
         }
      }
      
      protected function __overHandler(param1:MouseEvent) : void
      {
         if(!_canBuy)
         {
            return;
         }
         filters = null;
      }
      
      protected function __outhandler(param1:MouseEvent) : void
      {
         if(!_canBuy)
         {
            return;
         }
         filters = ComponentFactory.Instance.creatFilters("lightFilter");
      }
      
      protected function removeEvent() : void
      {
         _payPaneBuyBtn.removeEventListener("click",__payPanelClick);
         this.removeEventListener("click",__payPanelClick);
         _payPaneBuyBtnHotArea.removeEventListener("mouseOver",__payPaneOver);
         _payPaneBuyBtnHotArea.removeEventListener("mouseOut",__payPaneOut);
      }
      
      public function set shopItemInfo(param1:ShopItemInfo) : void
      {
         if(_shopItemInfo == param1)
         {
            return;
         }
         _shopItemInfo = param1;
         if(param1)
         {
            _itemCell.info = param1.TemplateInfo;
         }
         else
         {
            _itemCell.info = null;
         }
         updateBtn();
      }
      
      private function invalidateItemCell() : void
      {
         _payPaneBuyBtn.enable = false;
         _payPaneBuyBtnHotArea.mouseEnabled = true;
         this.mouseEnabled = false;
         this.buttonMode = false;
         this.filters = ComponentFactory.Instance.creatFilters("grayFilter");
         _canBuy = false;
      }
      
      private function canBuyFert() : Boolean
      {
         return PlayerManager.Instance.Self.VIPLevel >= ServerConfigManager.instance.getPrivilegeMinLevel("8") && PlayerManager.Instance.Self.IsVIP;
      }
      
      private function updateBtn() : void
      {
         if(_shopItemInfo && PlayerManager.Instance.Self.Grade < _shopItemInfo.LimitGrade)
         {
            invalidateItemCell();
         }
         else if(_shopItemInfo && _shopItemInfo.TemplateInfo.CategoryID == 32 && _shopItemInfo.TemplateInfo.Property7 == "1")
         {
            if(!canBuyFert())
            {
               invalidateItemCell();
            }
         }
         else
         {
            _payPaneBuyBtn.enable = true;
            _payPaneBuyBtnHotArea.mouseEnabled = false;
            this.mouseEnabled = true;
            this.buttonMode = true;
            this.filters = null;
            _canBuy = true;
         }
      }
      
      protected function __payPanelClick(param1:MouseEvent) : void
      {
         param1.stopImmediatePropagation();
         if(!_canBuy)
         {
            return;
         }
         if(_shopItemInfo != null)
         {
            SoundManager.instance.play("008");
            ShopBuyManager.Instance.buyFarmShop(_shopItemInfo.GoodsID);
         }
      }
      
      public function dispose() : void
      {
         removeEvent();
         if(_payPaneBuyBtn)
         {
            ObjectUtils.disposeObject(_payPaneBuyBtn);
         }
         _payPaneBuyBtn = null;
         if(_payPaneBuyBtnHotArea)
         {
            ObjectUtils.disposeObject(_payPaneBuyBtnHotArea);
         }
         _payPaneBuyBtnHotArea = null;
         if(_itemBg)
         {
            ObjectUtils.disposeObject(_itemBg);
         }
         _itemBg = null;
         if(_itemCell)
         {
            ObjectUtils.disposeObject(_itemCell);
         }
         _itemCell = null;
         if(parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
