package com.pickgliss.ui.controls.cell
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.ui.image.ScaleFrameImage;
   import com.pickgliss.ui.text.FilterFrameText;
   
   public class SimpleDropListCell extends Component implements IDropListCell
   {
       
      
      protected var _data:String;
      
      protected var _textField:FilterFrameText;
      
      private var _selected:Boolean;
      
      protected var _bg:ScaleFrameImage;
      
      public function SimpleDropListCell(){super();}
      
      override protected function init() : void{}
      
      override protected function addChildren() : void{}
      
      public function get selected() : Boolean{return false;}
      
      public function set selected(param1:Boolean) : void{}
      
      public function getCellValue() : *{return null;}
      
      public function setCellValue(param1:*) : void{}
   }
}
