package consortiaDomain.view{   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import ddt.utils.PositionUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class KillRankCell extends Sprite implements Disposeable, IListCell   {                   private var _data:Object;            private var _rankTf:FilterFrameText;            private var _playerNameTf:FilterFrameText;            private var _killNumTf:FilterFrameText;            public function KillRankCell() { super(); }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            private function update() : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}