package shop.view
{
   import bagAndInfo.cell.CellFactory;
   import baglocked.BaglockedManager;
   import com.greensock.TimelineMax;
   import com.greensock.TweenLite;
   import com.greensock.TweenMax;
   import com.greensock.events.TweenEvent;
   import com.pickgliss.events.FrameEvent;
   import com.pickgliss.ui.AlertManager;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.ShowTipManager;
   import com.pickgliss.ui.controls.BaseButton;
   import com.pickgliss.ui.controls.ISelectable;
   import com.pickgliss.ui.controls.alert.BaseAlerFrame;
   import com.pickgliss.ui.core.Disposeable;
   import com.pickgliss.ui.image.Image;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   import com.pickgliss.utils.ObjectUtils;
   import ddt.data.EquipType;
   import ddt.data.goods.ShopItemInfo;
   import ddt.events.ItemEvent;
   import ddt.manager.LanguageMgr;
   import ddt.manager.MessageTipManager;
   import ddt.manager.PlayerManager;
   import ddt.manager.ShopManager;
   import ddt.manager.SocketManager;
   import ddt.manager.SoundManager;
   import ddt.utils.FilterWordManager;
   import ddt.utils.PositionUtils;
   import flash.display.Bitmap;
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import shop.manager.ShopBuyManager;
   import shop.manager.ShopGiftsManager;
   
   public class ShopGoodItem extends Sprite implements ISelectable, Disposeable
   {
      
      public static const PAYTYPE_DDT_MONEY:uint = 1;
      
      public static const PAYTYPE_MONEY:uint = 2;
      
      public static const YELLOW_BOY:uint = 3;
      
      public static const BURIED_STONE:uint = 4;
      
      public static const MEDAL:uint = 6;
      
      private static const LIMIT_LABEL:uint = 6;
       
      
      protected var _payPaneGivingBtn:BaseButton;
      
      protected var _payPaneBuyBtn:BaseButton;
      
      protected var _itemBg:ScaleFrameImage;
      
      protected var _itemCellBg:Image;
      
      private var _shopItemCellBg:Bitmap;
      
      protected var _itemCell:ShopItemCell;
      
      protected var _itemCellBtn:Sprite;
      
      protected var _itemCountTxt:FilterFrameText;
      
      protected var _itemNameTxt:FilterFrameText;
      
      protected var _itemPriceTxt:FilterFrameText;
      
      protected var _labelIcon:ScaleFrameImage;
      
      protected var _payType:ScaleFrameImage;
      
      protected var _selected:Boolean;
      
      protected var _shopItemInfo:ShopItemInfo;
      
      protected var _shopItemCellTypeBg:ScaleFrameImage;
      
      private var _payPaneBuyBtnHotArea:Sprite;
      
      protected var _dotLine:Image;
      
      protected var _timeline:TimelineMax;
      
      protected var _isMouseOver:Boolean;
      
      protected var _lightMc:MovieClip;
      
      protected var _payPaneaskBtn:BaseButton;
      
      private var _shopPresentClearingFrame:ShopPresentClearingFrame;
      
      public function ShopGoodItem(){super();}
      
      public function get payPaneGivingBtn() : BaseButton{return null;}
      
      public function get payPaneBuyBtn() : BaseButton{return null;}
      
      public function get payPaneaskBtn() : BaseButton{return null;}
      
      public function get itemBg() : ScaleFrameImage{return null;}
      
      public function get itemCell() : ShopItemCell{return null;}
      
      public function get itemCellBtn() : Sprite{return null;}
      
      public function get dotLine() : Image{return null;}
      
      protected function initContent() : void{}
      
      protected function creatItemCell() : ShopItemCell{return null;}
      
      public function get shopItemInfo() : ShopItemInfo{return null;}
      
      public function set shopItemInfo(param1:ShopItemInfo) : void{}
      
      private function updateBtn() : void{}
      
      private function __updateShopItem(param1:Event) : void{}
      
      private function checkType() : int{return 0;}
      
      protected function initPrice() : void{}
      
      private function updateCount() : void{}
      
      protected function addEvent() : void{}
      
      protected function removeEvent() : void{}
      
      private function payPanAskHander(param1:MouseEvent) : void{}
      
      protected function shopPresentClearingFrameResponseHandler(param1:FrameEvent) : void{}
      
      protected function presentBtnClick(param1:MouseEvent) : void{}
      
      protected function __payPaneBuyBtnOver(param1:MouseEvent) : void{}
      
      protected function __payPaneBuyBtnOut(param1:MouseEvent) : void{}
      
      protected function __payPanelClick(param1:MouseEvent) : void{}
      
      protected function __payPaneGetBtnClick(param1:MouseEvent) : void{}
      
      private function __onResponse(param1:FrameEvent) : void{}
      
      protected function __itemClick(param1:MouseEvent) : void{}
      
      protected function __itemMouseOver(param1:MouseEvent) : void{}
      
      protected function __itemMouseOut(param1:MouseEvent) : void{}
      
      public function setItemLight(param1:MovieClip) : void{}
      
      protected function __timelineComplete(param1:TweenEvent = null) : void{}
      
      public function asDisplayObject() : DisplayObject{return null;}
      
      public function set autoSelect(param1:Boolean) : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function dispose() : void{}
   }
}
