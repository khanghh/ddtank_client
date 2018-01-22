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
      
      public function PyramidShopItem(){super();}
      
      private function initView() : void{}
      
      private function initEvent() : void{}
      
      public function set shopItemInfo(param1:ShopItemInfo) : void{}
      
      protected function initPrice() : void{}
      
      public function updateGreyState() : void{}
      
      public function get shopItemInfo() : ShopItemInfo{return null;}
      
      private function __updateShopItem(param1:Event) : void{}
      
      protected function creatItemCell() : ShopItemCell{return null;}
      
      private function __shopViewItemBtnClick(param1:MouseEvent) : void{}
      
      private function isButtonGrey(param1:Boolean) : void{}
      
      private function __shopItemOver(param1:MouseEvent) : void{}
      
      private function __shopItemOut(param1:MouseEvent) : void{}
      
      private function removeEvent() : void{}
      
      public function dispose() : void{}
   }
}
