package consortionBattle.view{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class ConsBatScoreViewListCell extends Sprite implements Disposeable, IListCell   {                   private var _data:Object;            private var _nameTxt:FilterFrameText;            private var _scoreTxt:FilterFrameText;            public function ConsBatScoreViewListCell() { super(); }
            private function update() : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            public function dispose() : void { }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}