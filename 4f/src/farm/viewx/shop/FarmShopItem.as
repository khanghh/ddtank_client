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
      
      public function FarmShopItem(){super();}
      
      protected function initContent() : void{}
      
      protected function addEvent() : void{}
      
      protected function __payPaneOut(param1:MouseEvent) : void{}
      
      protected function __payPaneOver(param1:MouseEvent) : void{}
      
      protected function __overHandler(param1:MouseEvent) : void{}
      
      protected function __outhandler(param1:MouseEvent) : void{}
      
      protected function removeEvent() : void{}
      
      public function set shopItemInfo(param1:ShopItemInfo) : void{}
      
      private function invalidateItemCell() : void{}
      
      private function canBuyFert() : Boolean{return false;}
      
      private function updateBtn() : void{}
      
      protected function __payPanelClick(param1:MouseEvent) : void{}
      
      public function dispose() : void{}
   }
}
