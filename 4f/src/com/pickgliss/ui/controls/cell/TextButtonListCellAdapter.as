package com.pickgliss.ui.controls.cell{   import com.pickgliss.ui.controls.TextButton;   import com.pickgliss.ui.controls.list.List;      public class TextButtonListCellAdapter extends TextButton implements IListCell   {                   public function TextButtonListCellAdapter() { super(); }
            public function getCellValue() : * { return null; }
            public function setCellValue(value:*) : void { }
            public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void { }
   }}