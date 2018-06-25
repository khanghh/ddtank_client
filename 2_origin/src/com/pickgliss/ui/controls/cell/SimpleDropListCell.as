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
      
      public function SimpleDropListCell()
      {
         super();
      }
      
      override protected function init() : void
      {
         super.init();
         _bg = ComponentFactory.Instance.creatComponentByStylename("droplist.CellBg");
         _textField = ComponentFactory.Instance.creatComponentByStylename("droplist.CellText");
         _bg.setFrame(1);
         width = _bg.width;
         height = _bg.height;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_bg)
         {
            addChild(_bg);
         }
         if(_textField)
         {
            addChild(_textField);
         }
      }
      
      public function get selected() : Boolean
      {
         return _selected;
      }
      
      public function set selected(value:Boolean) : void
      {
         _selected = value;
         if(_selected)
         {
            _bg.setFrame(2);
         }
         else
         {
            _bg.setFrame(1);
         }
      }
      
      public function getCellValue() : *
      {
         if(_data)
         {
            return _data;
         }
         return "";
      }
      
      public function setCellValue(value:*) : void
      {
         if(value)
         {
            _data = String(value);
            _textField.text = _data;
         }
      }
   }
}
