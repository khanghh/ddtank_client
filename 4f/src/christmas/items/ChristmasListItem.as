package christmas.items
{
   import bagAndInfo.cell.CellFactory;
   import christmas.ChristmasCoreController;
   import christmas.ChristmasCoreManager;
   import christmas.info.ChristmasSystemItemsInfo;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.view.ShopItemCell;
   
   public class ChristmasListItem extends Sprite implements Disposeable
   {
      
      public static var isCreate:Boolean;
       
      
      private var _info:ChristmasSystemItemsInfo;
      
      private var _bg:Bitmap;
      
      private var _countTxt:FilterFrameText;
      
      private var _itemCell:ShopItemCell;
      
      private var _receiveBtn:BaseButton;
      
      private var _shopItemInfo:ChristmasSystemItemsInfo;
      
      public var _poorTxt:FilterFrameText;
      
      private var _itemID:int;
      
      private var _snowPackNum:int;
      
      private var _receiveOK:Bitmap;
      
      public function ChristmasListItem(){super();}
      
      public function initView(param1:int = 0) : void{}
      
      private function initEvent() : void{}
      
      public function initText(param1:int, param2:int) : void{}
      
      protected function creatItemCell() : ShopItemCell{return null;}
      
      private function __shopViewItemBtnClick(param1:MouseEvent) : void{}
      
      public function set shopItemInfo(param1:ChristmasSystemItemsInfo) : void{}
      
      private function __updateShopItem(param1:Event) : void{}
      
      public function receiveOK() : void{}
      
      public function grayButton() : void{}
      
      public function recoverButton() : void{}
      
      public function specialButton() : void{}
      
      private function removeEvent() : void{}
      
      public function get itemID() : int{return 0;}
      
      public function set itemID(param1:int) : void{}
      
      public function get snowPackNum() : int{return 0;}
      
      public function dispose() : void{}
   }
}
