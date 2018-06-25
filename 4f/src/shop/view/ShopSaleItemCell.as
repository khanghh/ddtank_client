package shop.view{   import bagAndInfo.cell.CellFactory;   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.BaseButton;   import com.pickgliss.ui.controls.ISelectable;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.image.TiledImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ShopItemInfo;   import ddt.manager.LanguageMgr;   import ddt.manager.MessageTipManager;   import ddt.utils.PositionUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.MouseEvent;   import shop.manager.ShopBuyManager;   import shop.manager.ShopSaleManager;      public class ShopSaleItemCell extends Sprite implements Disposeable, ISelectable   {                   private var _bg:ScaleFrameImage;            private var _info:ShopItemInfo;            private var _sheng:Bitmap;            private var _oneMoneyLabel:ScaleFrameImage;            private var _twoMoneyLabel:ScaleFrameImage;            private var _buyBtn:BaseButton;            private var _cellPrice:FilterFrameText;            private var _cellName:FilterFrameText;            private var _cellOldPrice:FilterFrameText;            private var _savePrice:int = 3000;            private var _itemCell:ShopItemCell;            private var _itemCellBg:Image;            private var _selected:Boolean;            private var _deleteLine:Shape;            private var _line:TiledImage;            private var _priceImageCon:Sprite;            private var _priceImage:Vector.<ScaleFrameImage>;            private var _countText:FilterFrameText;            private var _limitNum:int = -1;            private var _icon:ScaleFrameImage;            public function ShopSaleItemCell() { super(); }
            public function get itemCell() : ShopItemCell { return null; }
            private function init() : void { }
            public function set info(data:ShopItemInfo) : void { }
            public function get info() : ShopItemInfo { return null; }
            public function set limitNum(value:int) : void { }
            private function updateinfo() : void { }
            private function __onClickBuy(e:MouseEvent) : void { }
            public function set autoSelect(value:Boolean) : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            private function get selectType() : int { return 0; }
            public function get enableBuy() : Boolean { return false; }
            public function get isLimitGoods() : Boolean { return false; }
            public function asDisplayObject() : DisplayObject { return null; }
            private function resetPrice() : void { }
            private function clearAndCreateDeleteLine(lenght:int) : void { }
            private function createItemCell() : ShopItemCell { return null; }
            public function dispose() : void { }
   }}