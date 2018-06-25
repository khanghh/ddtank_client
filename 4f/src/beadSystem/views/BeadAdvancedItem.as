package beadSystem.views{   import bagAndInfo.cell.BagCell;   import beadSystem.model.AdvanceBeadInfo;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.manager.ItemManager;   import flash.display.Bitmap;   import flash.display.Sprite;      public class BeadAdvancedItem extends Sprite implements Disposeable   {                   private var _info:AdvanceBeadInfo;            private var _noSelectBg:Bitmap;            private var _selectBg:Bitmap;            private var _selectLight:Bitmap;            private var _itemName:FilterFrameText;            private var _itemDesc:FilterFrameText;            private var _itemCell:BagCell;            private var _selectState:Boolean = false;            private var _selectTextStyle:String = "beadSystem.advanceBeadItem.nameTxt";            private var _noSelectStyle:String = "beadSystem.advanceBeadItem.noSelect.nameTxt";            private var _index:int;            public function BeadAdvancedItem(index:int) { super(); }
            protected function initView() : void { }
            public function get index() : int { return 0; }
            public function set isSelect(value:Boolean) : void { }
            public function get isSelect() : Boolean { return false; }
            public function get info() : AdvanceBeadInfo { return null; }
            public function set info(info:AdvanceBeadInfo) : void { }
            protected function updateView() : void { }
            private function createBagCellInfo(templeteId:int) : InventoryItemInfo { return null; }
            public function dispose() : void { }
   }}