package ddt.utils{   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.core.Disposeable;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class CoreScrollPanelCell extends Sprite implements Disposeable, IListCell   {            public static var content:Sprite;                   private var _data:Object;            public function CoreScrollPanelCell() { super(); }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
            public function dispose() : void { }
   }}