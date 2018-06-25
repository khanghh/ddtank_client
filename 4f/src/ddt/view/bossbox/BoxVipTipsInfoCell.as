package ddt.view.bossbox{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleBitmapImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.events.CellEvent;   import flash.events.MouseEvent;   import flash.geom.Point;      public class BoxVipTipsInfoCell extends BaseCell   {                   protected var _itemName:FilterFrameText;            private var _di:ScaleBitmapImage;            private var _isSelect:Boolean = false;            private var _sunShinBg:Scale9CornerImage;            public function BoxVipTipsInfoCell() { super(null); }
            public function set isSelect(value:Boolean) : void { }
            override protected function createChildren() : void { }
            protected function initView() : void { }
            override protected function onMouseClick(evt:MouseEvent) : void { }
            public function set itemName(name:String) : void { }
            override public function dispose() : void { }
   }}