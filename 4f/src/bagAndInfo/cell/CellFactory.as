package bagAndInfo.cell{   import beadSystem.controls.BeadCell;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import ddt.data.goods.ShopCarItemInfo;   import ddt.data.goods.ShopItemInfo;   import ddt.interfaces.ICell;   import ddt.interfaces.ICellFactory;   import ddt.manager.ItemManager;   import ddt.manager.ShopManager;   import flash.display.DisplayObject;   import flash.display.Sprite;   import magicHouse.treasureHouse.MagicHouseTreasureCell;   import shop.view.ShopItemCell;   import shop.view.ShopPlayerCell;      public class CellFactory implements ICellFactory   {            private static var _instance:CellFactory;                   public function CellFactory() { super(); }
            public static function get instance() : CellFactory { return null; }
            public function createBagCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null) : ICell { return null; }
            public function creteLockableBagCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true, bg:DisplayObject = null) : ICell { return null; }
            public function createBankCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true) : ICell { return null; }
            public function createPersonalInfoCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true) : ICell { return null; }
            public function createTreasureCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true) : ICell { return null; }
            public function createBeadCell(place:int, info:ItemTemplateInfo = null, showLoading:Boolean = true) : ICell { return null; }
            public function createShopPlayerItemCell() : ICell { return null; }
            public function createShopCartItemCell() : ICell { return null; }
            public function createShopColorItemCell() : ICell { return null; }
            public function createShopItemCell(bg:DisplayObject, info:ItemTemplateInfo = null, showLoading:Boolean = true, showTip:Boolean = true) : ICell { return null; }
            public function fillTipProp(cell:ICell) : void { }
            public function createWeeklyItemCell(placeHolder:DisplayObject, templateID:int) : ICell { return null; }
   }}