package shop.view{   import bagAndInfo.cell.BaseCell;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.ShopCarItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.utils.PositionUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class ShopItemCell extends BaseCell   {                   private var _shopItemInfo:ShopCarItemInfo;            protected var _cellSize:uint = 60;            public function ShopItemCell(bg:DisplayObject, info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true) { super(null,null,null,null); }
            public function get shopItemInfo() : ShopCarItemInfo { return null; }
            public function set shopItemInfo(value:ShopCarItemInfo) : void { }
            public function set cellSize(value:uint) : void { }
            override protected function updateSize(sp:Sprite) : void { }
            override protected function updateSizeII(sp:Sprite) : void { }
            override protected function createLoading() : void { }
            public function set tipInfo(value:ShopItemInfo) : void { }
            override public function dispose() : void { }
   }}