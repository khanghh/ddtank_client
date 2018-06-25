package beadSystem.controls{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.ShowTipManager;   import com.pickgliss.ui.controls.cell.IDropListCell;   import com.pickgliss.ui.core.Component;   import com.pickgliss.ui.image.Image;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.InventoryItemInfo;   import ddt.display.BitmapLoaderProxy;   import ddt.manager.ItemManager;   import ddt.manager.PathManager;   import ddt.utils.PositionUtils;   import ddt.view.tips.GoodTipInfo;   import flash.display.DisplayObject;   import flash.events.MouseEvent;   import flash.geom.Rectangle;      public class DrillItem extends Component implements IDropListCell   {                   private var _itemInfo:DrillItemInfo;            private var _date:InventoryItemInfo;            private var _stateID:int;            private var _icon:DisplayObject;            private var _overBg:Image;            private var _stateName:FilterFrameText;            private var _selected:Boolean;            private var _isInfoChanged:Boolean = false;            public function DrillItem() { super(); }
            private function initView() : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            private function update() : void { }
            private function __out(event:MouseEvent) : void { }
            private function __over(event:MouseEvent) : void { }
            public function get selected() : Boolean { return false; }
            public function set selected(value:Boolean) : void { }
            private function creatIcon() : DisplayObject { return null; }
            override public function get height() : Number { return 0; }
            override public function get width() : Number { return 0; }
            override public function asDisplayObject() : DisplayObject { return null; }
            override public function dispose() : void { }
   }}