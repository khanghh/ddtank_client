package com.pickgliss.ui.controls.cell
{
   import com.pickgliss.ui.controls.TextButton;
   import com.pickgliss.ui.controls.list.List;
   
   public class TextButtonListCellAdapter extends TextButton implements IListCell
   {
       
      
      public function TextButtonListCellAdapter()
      {
         super();
      }
      
      public function getCellValue() : *
      {
         return _text;
      }
      
      public function setCellValue(value:*) : void
      {
         text = value;
      }
      
      public function setListCellStatus(list:List, isSelected:Boolean, index:int) : void
      {
      }
   }
}
