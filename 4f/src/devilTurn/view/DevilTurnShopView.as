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
      
      public function DevilTurnShopView(){super();}
      
      override protected function initialize() : void{}
      
      private function __onUpdatePersonLimitShop(param1:CEvent) : void{}
      
      private function __onBagUpdate(param1:BagEvent) : void{}
      
      private function onPageSelect(param1:int) : void{}
      
      private function onRenderShopList(param1:Box, param2:int) : void{}
      
      private function onClickCose() : void{}
      
      override public function dispose() : void{}
   }
}
