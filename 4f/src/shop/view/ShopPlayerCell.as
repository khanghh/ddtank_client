package shop.view{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.MovieImage;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.EquipType;   import ddt.data.goods.InventoryItemInfo;   import ddt.data.goods.ShopCarItemInfo;   import ddt.manager.PlayerManager;   import flash.display.DisplayObject;   import shop.ShopEvent;      public class ShopPlayerCell extends BaseCell   {                   private var _shopItemInfo:ShopCarItemInfo;            private var _light:MovieImage;            public function ShopPlayerCell(bg:DisplayObject) { super(null); }
            public function set shopItemInfo(value:ShopCarItemInfo) : void { }
            public function get shopItemInfo() : ShopCarItemInfo { return null; }
            public function setSkinColor(color:String) : void { }
            override protected function createChildren() : void { }
            public function showLight() : void { }
            public function hideLight() : void { }
            override public function dispose() : void { }
   }}