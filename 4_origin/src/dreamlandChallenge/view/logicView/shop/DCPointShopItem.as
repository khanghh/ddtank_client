package dreamlandChallenge.view.logicView.shop
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemPrice;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import dreamlandChallenge.view.mornui.shop.DCPointSHopItemUI;
   import flash.display.Shape;
   import morn.core.handlers.Handler;
   
   public class DCPointShopItem extends DCPointSHopItemUI
   {
       
      
      private var _info:ShopItemInfo;
      
      private var _bagCell:BagCell;
      
      public function DCPointShopItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         lbl_point.text = LanguageMgr.GetTranslation("ddt.dreamLand.view.text18");
         _bagCell = new BagCell(0,null,false,getCellBg());
         PositionUtils.setPos(_bagCell,"dreamLand.shopBuy.cellItem.pos");
         addChild(_bagCell);
         btn_buy.clickHandler = new Handler(onClickBuyGoods);
      }
      
      private function onClickBuyGoods() : void
      {
         if(_info == null)
         {
            return;
         }
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         var quickBuyFrame:DreamLandShopQuickBuy = ComponentFactory.Instance.creatComponentByStylename("dreamLand.shop.QuickBuyAlert");
         quickBuyFrame.setData(_info.TemplateID,_info.GoodsID,_info.AValue1);
         LayerManager.Instance.addToLayer(quickBuyFrame,3,true,1);
      }
      
      public function set info(value:ShopItemInfo) : void
      {
         var itemPrice:* = null;
         _info = value;
         if(_info)
         {
            _bagCell.info = _info.TemplateInfo;
            lbl_goodName.text = _bagCell.info.Name;
            itemPrice = _info.getItemPrice(1);
            lbl_goodCost.text = itemPrice.goodsPrice.toString();
            if(!btn_buy.visible)
            {
               btn_buy.visible = true;
            }
            if(!lbl_point.visible)
            {
               lbl_point.visible = true;
            }
         }
         else
         {
            _bagCell.info = null;
            var _loc3_:String = "";
            lbl_goodCost.text = _loc3_;
            lbl_goodName.text = _loc3_;
            btn_buy.visible = false;
            lbl_point.visible = false;
         }
      }
      
      private function getCellBg() : Shape
      {
         var cellBg:Shape = new Shape();
         cellBg.graphics.beginFill(0,0);
         cellBg.graphics.drawRect(0,0,64,64);
         cellBg.graphics.endFill();
         return cellBg;
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bagCell);
         _bagCell = null;
         super.dispose();
      }
   }
}
