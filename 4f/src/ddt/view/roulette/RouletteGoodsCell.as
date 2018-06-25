package ddt.view.roulette{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.geom.Point;      public class RouletteGoodsCell extends BaseCell   {                   private var _selected:Boolean;            private var _count:int;            private var _boolCreep:Boolean;            private var _selectMovie:MovieClip;            private var count_txt:FilterFrameText;            private var _text_x:int;            private var _text_y:int;            private var _bgW:int;            private var _bgH:int;            private var _stop:Bitmap;            public function RouletteGoodsCell(bg:DisplayObject, text_x:int, text_y:int) { super(null); }
            override protected function createChildren() : void { }
            protected function initII() : void { }
            public function setSparkle() : void { }
            public function set count(n:int) : void { }
            public function get count() : int { return 0; }
            public function setGreep() : void { }
            public function set selected(value:Boolean) : void { }
            public function get selected() : Boolean { return false; }
            public function addCellBg(value:DisplayObject) : void { }
            public function out() : void { }
            override public function dispose() : void { }
   }}