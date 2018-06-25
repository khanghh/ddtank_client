package ddt.view.caddyII.bead{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.command.NumberSelecter;   import ddt.data.goods.ItemTemplateInfo;   import ddt.manager.ItemManager;   import flash.display.Shape;   import flash.display.Sprite;   import flash.events.Event;   import flash.geom.Point;      public class QuickBuyItem extends Sprite implements Disposeable   {            private static const HammerJumpStep:int = 5;            private static const PotJumpStep:int = 1;            private static const HammerTemplateID:int = 11456;            private static const PotTemplateID:int = 112047;                   private var _bg:ScaleFrameImage;            private var _cell:BaseCell;            private var _selectNumber:NumberSelecter;            private var _count:int;            private var _countField:FilterFrameText;            private var _countPos:Point;            private var _selsected:Boolean = false;            private var _selectedBitmap:Scale9CornerImage;            public function QuickBuyItem() { super(); }
            private function initView() : void { }
            private function initEvents() : void { }
            private function removeEvents() : void { }
            private function _numberChange(e:Event) : void { }
            private function _numberClose(e:Event) : void { }
            public function setFocus() : void { }
            public function set itemID(id:int) : void { }
            public function get info() : ItemTemplateInfo { return null; }
            public function set count(value:int) : void { }
            public function get count() : int { return 0; }
            public function get selected() : Boolean { return false; }
            public function set selected(val:Boolean) : void { }
            public function get selectNumber() : NumberSelecter { return null; }
            public function set selectNumber(value:NumberSelecter) : void { }
            public function dispose() : void { }
   }}