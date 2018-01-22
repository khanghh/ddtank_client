package explorerManual.view.shop
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import shop.view.ShopItemCell;
   
   public class ManualShopCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _needMoneyTxt:FilterFrameText;
      
      private var _integral:FilterFrameText;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _confirmFrame:BaseAlerFrame;
      
      private var _itemCell:ShopItemCell;
      
      private var _shopItemInfo:ShopItemInfo;
      
      public function ManualShopCell()
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.manualShopView.bg");
         addChild(_bg);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("explorerManual.shop.buyBtn");
         addChild(_buyBtn);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("explorerManual.shop.nameTxt");
         addChild(_nameTxt);
         _needMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("explorerManual.needMoneyTxt");
         addChild(_needMoneyTxt);
         var _loc1_:Sprite = new Sprite();
         _loc1_.graphics.beginFill(16777215,0);
         _loc1_.graphics.drawRect(0,0,70,70);
         _loc1_.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(_loc1_,null,true,true) as ShopItemCell;
         PositionUtils.setPos(_itemCell,"explorerManual.itemCell.pos");
         addChild(_itemCell);
         _integral = ComponentFactory.Instance.creatComponentByStylename("explorerManual.integral");
         _integral.text = LanguageMgr.GetTranslation("explorerManual.shop.point");
         addChild(_integral);
         _buyBtn.addEventListener("click",buyHandler,false,0,true);
      }
      
      private function buyHandler(param1:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var _loc2_:ManualShopQuickBuy = ComponentFactory.Instance.creatComponentByStylename("explorerManual.shop.QuickBuyAlert");
         _loc2_.setData(_shopItemInfo.TemplateID,_shopItemInfo.GoodsID,_shopItemInfo.AValue1);
         LayerManager.Instance.addToLayer(_loc2_,2,true,1);
      }
      
      public function refreshShow(param1:ShopItemInfo) : void
      {
         _shopItemInfo = param1;
         _itemCell.info = _shopItemInfo.TemplateInfo;
         _itemCell.tipInfo = _shopItemInfo;
         _nameTxt.text = _itemCell.info.Name;
         _needMoneyTxt.text = _shopItemInfo.AValue1.toString();
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _shopItemInfo = null;
         ObjectUtils.disposeObject(_bg);
         _bg = null;
         if(_buyBtn)
         {
            _buyBtn.removeEventListener("click",buyHandler);
         }
         ObjectUtils.disposeObject(_buyBtn);
         _buyBtn = null;
         ObjectUtils.disposeObject(_nameTxt);
         _nameTxt = null;
         ObjectUtils.disposeObject(_needMoneyTxt);
         _needMoneyTxt = null;
         ObjectUtils.disposeObject(_integral);
         _integral = null;
         ObjectUtils.disposeObject(_itemCell);
         _itemCell = null;
         if(this.parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
