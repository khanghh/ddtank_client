package cloudBuyLottery.view
{
   import bagAndInfo.cell.CellFactory;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.goods.InventoryItemInfo;
   import ddt.manager.LanguageMgr;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import shop.view.ShopItemCell;
   
   public class WinningLogListItem extends Sprite implements Disposeable
   {
       
      
      private var _itemCell:ShopItemCell;
      
      private var _shopItemInfo:WinningLogItemInfo;
      
      private var _itemID:int;
      
      private var _bg:Bitmap;
      
      private var _cellImg:Bitmap;
      
      private var _nameTxt:FilterFrameText;
      
      private var _txt:FilterFrameText;
      
      public function WinningLogListItem(){super();}
      
      public function initView(param1:String, param2:int = 0) : void{}
      
      protected function creatItemCell() : ShopItemCell{return null;}
      
      public function set shopItemInfo(param1:WinningLogItemInfo) : void{}
      
      private function __updateShopItem(param1:Event) : void{}
      
      public function get itemID() : int{return 0;}
      
      public function set itemID(param1:int) : void{}
      
      public function dispose() : void{}
   }
}
