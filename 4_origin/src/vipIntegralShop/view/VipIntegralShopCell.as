package vipIntegralShop.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.ui.controls.SimpleBitmapButton;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import shop.view.ShopItemCell;
   import vipIntegralShop.VipIntegralShopController;
   import vipIntegralShop.data.VipIntegralShopInfo;
   
   public class VipIntegralShopCell extends Sprite implements Disposeable
   {
       
      
      private var _bg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _needMoneyTxt:FilterFrameText;
      
      private var _integral:FilterFrameText;
      
      private var _vipLimit:FilterFrameText;
      
      private var _buyOver:FilterFrameText;
      
      private var _buyBtn:SimpleBitmapButton;
      
      private var _itemCell:ShopItemCell;
      
      private var _shopItemInfo:ShopItemInfo;
      
      private var _vipIntegralInfo:VipIntegralShopInfo;
      
      public function VipIntegralShopCell()
      {
         super();
         _bg = ComponentFactory.Instance.creatBitmap("asset.vipIntegralShopView.bg");
         addChild(_bg);
         _buyBtn = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.buyBtn");
         addChild(_buyBtn);
         _nameTxt = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.nameTxt");
         addChild(_nameTxt);
         _needMoneyTxt = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.needMoneyTxt");
         addChild(_needMoneyTxt);
         var sp:Sprite = new Sprite();
         sp.graphics.beginFill(16777215,0);
         sp.graphics.drawRect(0,0,70,70);
         sp.graphics.endFill();
         _itemCell = CellFactory.instance.createShopItemCell(sp,null,true,true) as ShopItemCell;
         PositionUtils.setPos(_itemCell,"vipIntegralShopView.itemCell.pos");
         addChild(_itemCell);
         _integral = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.integral");
         _integral.text = LanguageMgr.GetTranslation("ddt.dragonBoat.shopCellMoneyTxt");
         addChild(_integral);
         _vipLimit = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.limitInfo");
         addChild(_vipLimit);
         _vipLimit.visible = false;
         _buyOver = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.buyOver");
         _buyOver.text = LanguageMgr.GetTranslation("vipIntegralShopView.buyShopItem.buyOver");
         addChild(_buyOver);
         _buyOver.visible = false;
         _buyBtn.addEventListener("click",buyHandler,false,0,true);
      }
      
      private function buyHandler(event:MouseEvent) : void
      {
         SoundManager.instance.play("008");
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(PlayerManager.Instance.Self.VipIntegral < _vipIntegralInfo.Price)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("ddt.integral.unenoughIntegralText"),0,true);
            return;
         }
         var buyAlert:VipIntegralShopBuyCell = ComponentFactory.Instance.creatComponentByStylename("vipIntegralShopView.QuickBuyAlert");
         buyAlert.setData(_vipIntegralInfo.GoodsID,_vipIntegralInfo.ID,_vipIntegralInfo.Price);
         buyAlert.setBuyNum(_vipIntegralInfo.LimitNum);
         LayerManager.Instance.addToLayer(buyAlert,2,true,1);
      }
      
      public function refreshShow(value:VipIntegralShopInfo) : void
      {
         var property:* = null;
         var hasBuyNum:int = 0;
         _vipIntegralInfo = value;
         _itemCell.info = ItemManager.Instance.getTemplateById(_vipIntegralInfo.GoodsID);
         _nameTxt.text = _itemCell.info.Name;
         _needMoneyTxt.text = _vipIntegralInfo.Price.toString();
         if(PlayerManager.Instance.Self.IsVIP)
         {
            property = "Vip" + PlayerManager.Instance.Self.VIPLevel + "Quantity";
            if(value[property] > 0)
            {
               hasBuyNum = 0;
               if(VipIntegralShopController.instance.limitDic[_vipIntegralInfo.GoodsID] != null)
               {
                  hasBuyNum = VipIntegralShopController.instance.limitDic[_vipIntegralInfo.GoodsID];
               }
               _vipIntegralInfo.LimitNum = value[property] - hasBuyNum;
               if(_vipIntegralInfo.LimitNum > 0)
               {
                  var _loc4_:Boolean = true;
                  _buyBtn.visible = _loc4_;
                  _buyBtn.enable = _loc4_;
                  _loc4_ = false;
                  _vipLimit.visible = _loc4_;
                  _buyOver.visible = _loc4_;
               }
               else
               {
                  _buyOver.visible = true;
                  _loc4_ = false;
                  _vipLimit.visible = _loc4_;
                  _buyBtn.visible = _loc4_;
               }
            }
            else
            {
               _loc4_ = false;
               _buyOver.visible = _loc4_;
               _buyBtn.visible = _loc4_;
               _vipLimit.visible = true;
               _vipLimit.text = LanguageMgr.GetTranslation("vipIntegralShopView.buyShopItem.limitInfo",getBuyVipLevel());
            }
         }
         else
         {
            _buyBtn.visible = true;
            _buyBtn.enable = false;
         }
      }
      
      private function getBuyVipLevel() : int
      {
         var level:int = PlayerManager.Instance.Self.VIPLevel + 1;
         while(_vipIntegralInfo["Vip" + level + "Quantity"] == 0)
         {
            level++;
         }
         return level;
      }
      
      public function dispose() : void
      {
         ObjectUtils.disposeAllChildren(this);
         _bg = null;
         if(_buyBtn)
         {
            _buyBtn.dispose();
            _buyBtn = null;
         }
         if(_nameTxt)
         {
            _nameTxt.dispose();
            _nameTxt = null;
         }
         if(_needMoneyTxt)
         {
            _needMoneyTxt.dispose();
            _needMoneyTxt = null;
         }
         if(_integral)
         {
            _integral.dispose();
            _integral = null;
         }
         if(_vipLimit)
         {
            _vipLimit.dispose();
            _vipLimit = null;
         }
         if(_buyOver)
         {
            _buyOver.dispose();
            _buyOver = null;
         }
         if(this.parent)
         {
            parent.removeChild(this);
         }
      }
   }
}
