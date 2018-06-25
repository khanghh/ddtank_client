package ddt.view.bossbox{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.events.Event;   import flash.geom.Point;      public class BoxAwardsCell extends BaseCell implements IListCell   {                   protected var _itemName:FilterFrameText;            protected var count_txt:FilterFrameText;            private var di:ScaleBitmapImage;            public function BoxAwardsCell() { super(null); }
            override protected function createChildren() : void { }
            protected function initII() : void { }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            private function addEvent() : void { }
            public function set count(n:int) : void { }
            public function __setItemName(e:Event) : void { }
            public function set itemName(name:String) : void { }
            override public function get height() : Number { return 0; }
            override public function dispose() : void { }
   }}