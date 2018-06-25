package devilTurn.view
{
   import bagAndInfo.cell.BagCell;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.BagEvent;
   import ddt.events.CEvent;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.PlayerManager;
   import ddt.manager.ServerConfigManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import devilTurn.view.mornui.DevilTurnShopViewUI;
   import flash.display.Shape;
   import morn.core.components.Box;
   import morn.core.handlers.Handler;
   
   public class DevilTurnShopView extends DevilTurnShopViewUI
   {
       
      
      private var _moneyIcon:BagCell;
      
      private var _templateID:int;
      
      public function DevilTurnShopView()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         text8.text = LanguageMgr.GetTranslation("devilTurn.mornUI.label8");
         closeBtn.clickHandler = new Handler(onClickCose);
         shopList.renderHandler = new Handler(onRenderShopList);
         selectPage.selectHandler = new Handler(onPageSelect);
         shopList.array = ShopManager.Instance.getValidGoodsArrayByType(120);
         shopList.page = 1;
         selectPage.maxPage = shopList.totalPage;
         var cellBg:Shape = new Shape();
         cellBg.graphics.beginFill(0,0);
         cellBg.graphics.drawRect(0,0,24,24);
         cellBg.graphics.endFill();
         _templateID = ServerConfigManager.instance.devilTurnTemplateID;
         _moneyIcon = new BagCell(0,ItemManager.Instance.getTemplateById(_templateID),false,cellBg);
         __onBagUpdate(null);
         PositionUtils.setPos(_moneyIcon,"devilTurn.diceView.shopIconPos");
         addChild(_moneyIcon);
         PlayerManager.Instance.Self.PropBag.addEventListener("update",__onBagUpdate);
         ShopManager.Instance.addEventListener("updatePersonalLimitShop",__onUpdatePersonLimitShop);
      }
      
      private function __onUpdatePersonLimitShop(event:CEvent) : void
      {
         if(event && int(event.data) == 19)
         {
            shopList.refresh();
         }
      }
      
      private function __onBagUpdate(e:BagEvent) : void
      {
         myMoneyText.text = PlayerManager.Instance.Self.PropBag.getItemCountByTemplateId(_templateID).toString();
      }
      
      private function onPageSelect(index:int) : void
      {
         SoundManager.instance.playButtonSound();
         shopList.page = index - 1;
      }
      
      private function onRenderShopList(item:Box, index:int) : void
      {
         var view:DevilTurnShopItem = item as DevilTurnShopItem;
         if(index < shopList.array.length)
         {
            view.info = shopList.array[index] as ShopItemInfo;
         }
         else
         {
            view.info = null;
         }
      }
      
      private function onClickCose() : void
      {
         SoundManager.instance.playButtonSound();
         dispose();
      }
      
      override public function dispose() : void
      {
         PlayerManager.Instance.Self.PropBag.removeEventListener("update",__onBagUpdate);
         ShopManager.Instance.removeEventListener("updatePersonalLimitShop",__onUpdatePersonLimitShop);
         ObjectUtils.disposeObject(_moneyIcon);
         _moneyIcon = null;
         super.dispose();
      }
   }
}
