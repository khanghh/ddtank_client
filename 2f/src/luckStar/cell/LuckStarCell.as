package luckStar.cell{   import bagAndInfo.cell.BaseCell;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.data.goods.ItemTemplateInfo;   import flash.display.Bitmap;   import flash.display.DisplayObject;   import flash.display.MovieClip;   import flash.display.Sprite;   import flash.geom.Point;   import luckStar.event.LuckStarEvent;   import luckStar.view.LuckStarAwardAction;      public class LuckStarCell extends BaseCell   {                   private var _maxAward:Bitmap;            private var _cellFrame:Bitmap;            private var _txtCount:FilterFrameText;            private var _selectMovie:MovieClip;            public var _isMaxAward:Boolean;            private var _awardAction:LuckStarAwardAction;            private var _selected:Boolean;            private var _boolCreep:Boolean;            public function LuckStarCell(bg:DisplayObject = null) { super(null); }
            private function initView() : void { }
            override public function set info(value:ItemTemplateInfo) : void { }
            override protected function updateSize(sp:Sprite) : void { }
            public function get isMaxAward() : Boolean { return false; }
            public function set count(value:int) : void { }
            public function playAction() : void { }
            private function getMove() : Point { return null; }
            private function cell() : void { }
            public function setSparkle() : void { }
            public function setGreep() : void { }
            public function set selected(value:Boolean) : void { }
            public function get selected() : Boolean { return false; }
            override public function dispose() : void { }
   }}