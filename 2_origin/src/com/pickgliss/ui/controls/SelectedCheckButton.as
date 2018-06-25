package com.pickgliss.ui.controls
{
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.text.TextField;
   
   public class SelectedCheckButton extends SelectedButton
   {
      
      public static const P_fieldX:String = "fieldX";
      
      public static const P_fieldY:String = "fieldY";
      
      public static const P_text:String = "text";
      
      public static const P_textField:String = "textField";
       
      
      protected var _field:DisplayObject;
      
      protected var _fieldX:Number;
      
      protected var _fieldY:Number;
      
      protected var _text:String = "";
      
      protected var _textStyle:String;
      
      public function SelectedCheckButton()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(_field)
         {
            ObjectUtils.disposeObject(_field);
         }
         _field = null;
         graphics.clear();
         super.dispose();
      }
      
      public function set fieldX(value:Number) : void
      {
         if(_fieldX == value)
         {
            return;
         }
         _fieldX = value;
         onPropertiesChanged("fieldX");
      }
      
      public function set fieldY(value:Number) : void
      {
         if(_fieldY == value)
         {
            return;
         }
         _fieldY = value;
         onPropertiesChanged("fieldY");
      }
      
      public function set text(value:String) : void
      {
         if(_text == value)
         {
            return;
         }
         _text = value;
         onPropertiesChanged("text");
      }
      
      public function set textField(field:DisplayObject) : void
      {
         if(_field == field)
         {
            return;
         }
         ObjectUtils.disposeObject(_field);
         _field = field;
         onPropertiesChanged("textField");
      }
      
      public function set textStyle(stylename:String) : void
      {
         if(_textStyle == stylename)
         {
            return;
         }
         _textStyle = stylename;
         textField = ComponentFactory.Instance.creat(_textStyle);
      }
      
      public function get textWidth() : int
      {
         return TextField(_field).textWidth;
      }
      
      public function get field() : TextField
      {
         return _field as TextField;
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_field)
         {
            addChild(_field);
         }
      }
      
      protected function drawClickArea() : void
      {
         graphics.beginFill(16711935,0);
         graphics.drawRect(0,0,_width,_height);
         graphics.endFill();
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["fieldX"] || _changedPropeties["fieldY"])
         {
            if(_field)
            {
               _field.x = _fieldX;
               _field.y = _fieldY;
            }
         }
         if(_changedPropeties["text"])
         {
            if(_field)
            {
               if(_field is TextField)
               {
                  TextField(_field).text = _text;
               }
               _width = _field.x + _field.width;
               _height = Math.max(_field.height,_selectedButton.height);
               drawClickArea();
            }
         }
         if(_changedPropeties["height"] || _changedPropeties["width"])
         {
            drawClickArea();
         }
      }
   }
}
