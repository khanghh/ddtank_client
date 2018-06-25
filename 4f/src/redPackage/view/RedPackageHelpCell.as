package redPackage.view{   import com.pickgliss.ui.controls.cell.IListCell;   import com.pickgliss.ui.controls.list.List;   import com.pickgliss.ui.core.Disposeable;   import flash.display.DisplayObject;   import flash.display.Sprite;      public class RedPackageHelpCell extends Sprite implements Disposeable, IListCell   {                   private var _data:Object;            private var redPkgHelpContent:Sprite;            public function RedPackageHelpCell() { super(); }
            public function dispose() : void { }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
            public function asDisplayObject() : DisplayObject { return null; }
   }}