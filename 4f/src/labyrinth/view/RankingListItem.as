package labyrinth.view{   import com.pickgliss.ui.UICreatShortcut;   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.ui.image.ScaleFrameImage;   import com.pickgliss.ui.text.FilterFrameText;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;   import labyrinth.data.RankingInfo;      public class RankingListItem extends Sprite implements Disposeable, IListCell   {                   private var _itemBG:ScaleFrameImage;            private var _ranking:FilterFrameText;            private var _name:FilterFrameText;            private var _number:FilterFrameText;            private var _info:RankingInfo;            public function RankingListItem() { super(); }
            private function init() : void { }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}