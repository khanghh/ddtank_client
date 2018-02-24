package devilTurn.view
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ItemPrice;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import devilTurn.DevilTurnManager;
   import devilTurn.view.mornui.DevilTurnShopItemUI;
   import flash.display.Shape;
   import morn.core.handlers.Handler;
   
   public class DevilTurnShopItem extends DevilTurnShopItemUI
   {
       
      
      private var _info:ShopItemInfo;
      
      private var _bagCell:BagCell;
      
      public function DevilTurnShopItem()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         buyTipsText.text = LanguageMgr.GetTranslation("devilTurn.mornUI.label7");
         _bagCell = new BagCell(0,null,false,getCellBg());
         PositionUtils.setPos(_bagCell,"devilTurn.diceView.shopCell");
         addChild(_bagCell);
         buyBtn.clickHandler = new Handler(onClickBuyGoods);
      }
      
      public function set info(param1:ShopItemInfo) : void
      {
         var _loc2_:* = null;
         _info = param1;
         if(_info)
         {
            _bagCell.info = _info.TemplateInfo;
            nameText.text = _bagCell.info.Name;
            _loc2_ = _info.getItemPrice(1);
            priceText.text = _loc2_.goodsPrice.toString();
            goodsText.text = _loc2_.goodsPriceToString;
            if(_info.personalBuyCnt > 0)
            {
               buyBtn.visible = true;
               buyTipsText.visible = false;
            }
            else
            {
               buyBtn.visible = false;
               buyTipsText.visible = true;
            }
         }
         else
         {
            _bagCell.info = null;
            var _loc3_:* = "";
            priceText.text = _loc3_;
            _loc3_ = _loc3_;
            goodsText.text = _loc3_;
            nameText.text = _loc3_;
            buyBtn.visible = false;
            buyTipsText.visible = false;
         }
      }
      
      private function getCellBg() : Shape
      {
         var _loc1_:Shape = new Shape();
         _loc1_.graphics.beginFill(0,0);
         _loc1_.graphics.drawRect(0,0,64,64);
         _loc1_.graphics.endFill();
         return _loc1_;
      }
      
      private function onClickBuyGoods() : void
      {
         SoundManager.instance.playButtonSound();
         if(PlayerManager.Instance.Self.bagLocked)
         {
            BaglockedManager.Instance.show();
            return;
         }
         if(DevilTurnManager.instance.activityState == 0)
         {
            MessageTipManager.getInstance().show(LanguageMgr.GetTranslation("tank.devilTurn.activityClose"));
            return;
         }
         var _loc1_:DevilTurnShopBuyView = ComponentFactory.Instance.creatComponentByStylename("devilturn.shop.buyView");
         _loc1_.setShopItemInfo(_info,ServerConfigManager.instance.devilTurnTemplateID);
         _loc1_.setBuyNum(_info.personalBuyCnt);
         LayerManager.Instance.addToLayer(_loc1_,2,true,1);
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_bagCell);
         _bagCell = null;
         super.dispose();
      }
   }
}
