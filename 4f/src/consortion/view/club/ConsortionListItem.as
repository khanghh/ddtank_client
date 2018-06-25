package consortion.view.club{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.MutipleImage;   import com.pickgliss.ui.image.Scale9CornerImage;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import consortion.view.selfConsortia.Badge;   import ddt.data.ConsortiaInfo;   import ddt.utils.PositionUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class ConsortionListItem extends Sprite implements Disposeable   {                   private var _itemBG:ScaleFrameImage;            private var _vline:MutipleImage;            private var _index:int;            private var _info:ConsortiaInfo;            private var _selected:Boolean;            private var _consortionName:FilterFrameText;            private var _chairMan:FilterFrameText;            private var _count:FilterFrameText;            private var _level:FilterFrameText;            private var _exploit:FilterFrameText;            private var _light:Scale9CornerImage;            private var _badge:Badge;            public function ConsortionListItem(index:int) { super(); }
            private function init() : void { }
            public function set info(info:ConsortiaInfo) : void { }
            public function get info() : ConsortiaInfo { return null; }
            public function set selected(value:Boolean) : void { }
            public function get selected() : Boolean { return false; }
            public function set light(value:Boolean) : void { }
            override public function get height() : Number { return 0; }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function set isApply(value:Boolean) : void { }
            public function dispose() : void { }
   }}