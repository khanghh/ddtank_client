package shop.view{   import bagAndInfo.cell.CellFactory;   import com.greensock.TimelineMax;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.ISelectable;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.events.Event;      public class ShopRankingCellItem extends Sprite implements ISelectable, Disposeable   {            public static const PAYTYPE_DDT_MONEY:uint = 1;            public static const PAYTYPE_MONEY:uint = 2;            private static const LIMIT_LABEL:uint = 6;                   private var _payPaneGivingBtn:BaseButton;            private var _payPaneBuyBtn:BaseButton;            private var _itemCellBtn:Sprite;            private var _itemBg:ScaleFrameImage;            private var _itemCell:ShopItemCell;            private var _itemCountTxt:FilterFrameText;            private var _itemNameTxt:FilterFrameText;            private var _itemPriceTxt:FilterFrameText;            private var _payType:ScaleFrameImage;            private var _selected:Boolean;            private var _shopItemInfo:ShopItemInfo;            private var _shopItemCellBg:Bitmap;            private var _shopItemCellTypeBg:ScaleFrameImage;            private var _timeline:TimelineMax;            private var _itemDotLine:Image;            private var _limitNum:int;            public var LimitFlag:Boolean;            private var _isMouseOver:Boolean;            private var _lightMc:MovieClip;            private var _payPaneAskBtn:BaseButton;            public function ShopRankingCellItem() { super(); }
            public function get payPaneGivingBtn() : BaseButton { return null; }
            public function get payPaneBuyBtn() : BaseButton { return null; }
            public function get itemCellBtn() : Sprite { return null; }
            public function get itemBg() : ScaleFrameImage { return null; }
            public function get itemCell() : ShopItemCell { return null; }
            private function initContent() : void { }
            public function get shopItemInfo() : ShopItemInfo { return null; }
            public function set shopItemInfo(value:ShopItemInfo) : void { }
            private function __updateShopItem(evt:Event) : void { }
            private function initPrice() : void { }
            private function updateCount() : void { }
            public function mouseOver() : void { }
            public function get payPaneAskBtn() : BaseButton { return null; }
            public function setItemLight($lightMc:MovieClip) : void { }
            public function mouseOut() : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function set autoSelect(value:Boolean) : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            private function checkType() : int { return 0; }
            public function dispose() : void { }
            public function get limitNum() : int { return 0; }
            public function set limitNum(value:int) : void { }
   }}