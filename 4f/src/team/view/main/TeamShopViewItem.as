package team.view.main
{
   import bagAndInfo.cell.BagCell;
   import baglocked.BaglockedManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.LayerManager;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.data.goods.ShopItemInfo;
   import ddt.manager.ItemManager;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Shape;
   import morn.core.handlers.Handler;
   import team.TeamManager;
   import team.model.TeamShopInfo;
   import team.view.mornui.item.TeamShopViewItemUI;
   
   public class TeamShopViewItem extends TeamShopViewItemUI
   {
       
      
      private var _info:TeamShopInfo;
      
      private var _cell:BagCell;
      
      public function TeamShopViewItem(){super();}
      
      override protected function initialize() : void{}
      
      private function __onClickBuy() : void{}
      
      public function set info(param1:TeamShopInfo) : void{}
      
      override public function dispose() : void{}
   }
}
