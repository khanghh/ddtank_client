package com.pickgliss.ui.text
{
   import com.pickgliss.geom.IntPoint;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.controls.DisplayObjectViewport;
   import com.pickgliss.ui.controls.ScrollPanel;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   import flash.ui.Mouse;
   
   public class TextArea extends ScrollPanel
   {
      
      public static const P_textField:String = "textField";
       
      
      protected var _currentTextHeight:int = 0;
      
      protected var _enable:Boolean = true;
      
      protected var _textField:FilterFrameText;
      
      protected var _textStyle:String;
      
      public function TextArea()
      {
         super();
         _viewSource.addEventListener("click",__onTextAreaClick);
         _viewSource.addEventListener("mouseOver",__onTextAreaOver);
         _viewSource.addEventListener("mouseOut",__onTextAreaOut);
      }
      
      override public function dispose() : void
      {
         Mouse.cursor = "auto";
         _viewSource.removeEventListener("click",__onTextAreaClick);
         _viewSource.removeEventListener("mouseOver",__onTextAreaOver);
         _viewSource.removeEventListener("mouseOut",__onTextAreaOut);
         _textField.removeEventListener("keyDown",__onTextKeyDown);
         _textField.removeEventListener("change",__onTextChanged);
         ObjectUtils.disposeObject(_textField);
         _textField = null;
         super.dispose();
      }
      
      public function get editable() : Boolean
      {
         return _textField.type == "input";
      }
      
      public function set editable(value:Boolean) : void
      {
         if(value)
         {
            _textField.type = "input";
            _viewSource.addEventListener("mouseOver",__onTextAreaOver);
            _viewSource.addEventListener("mouseOut",__onTextAreaOut);
         }
         else
         {
            _textField.type = "dynamic";
            _viewSource.removeEventListener("mouseOver",__onTextAreaOver);
            _viewSource.removeEventListener("mouseOut",__onTextAreaOut);
         }
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(value:Boolean) : void
      {
         _textField.mouseEnabled = _enable;
         if(_enable)
         {
            _viewSource.addEventListener("mouseOver",__onTextAreaOver);
            _viewSource.addEventListener("mouseOut",__onTextAreaOut);
         }
         else
         {
            _viewSource.removeEventListener("mouseOver",__onTextAreaOver);
            _viewSource.removeEventListener("mouseOut",__onTextAreaOut);
         }
      }
      
      public function get maxChars() : int
      {
         return _textField.maxChars;
      }
      
      public function set maxChars(value:int) : void
      {
         _textField.maxChars = value;
      }
      
      public function get text() : String
      {
         return _textField.text;
      }
      
      public function set text(value:String) : void
      {
         _textField.text = value;
         DisplayObjectViewport(_viewSource).invalidateView();
      }
      
      public function set htmlText(value:String) : void
      {
         _textField.htmlText = value;
         DisplayObjectViewport(_viewSource).invalidateView();
      }
      
      public function get htmlText() : String
      {
         return _textField.htmlText;
      }
      
      public function get textField() : FilterFrameText
      {
         return _textField;
      }
      
      public function set textField(tf:FilterFrameText) : void
      {
         if(_textField == tf)
         {
            return;
         }
         if(_textField)
         {
            _textField.removeEventListener("change",__onTextChanged);
            _textField.removeEventListener("keyDown",__onTextKeyDown);
            ObjectUtils.disposeObject(_textField);
         }
         _textField = tf;
         _textField.multiline = true;
         _textField.mouseWheelEnabled = false;
         _textField.addEventListener("keyDown",__onTextKeyDown);
         _textField.addEventListener("change",__onTextChanged);
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
      
      override protected function layoutComponent() : void
      {
         super.layoutComponent();
         var texFieldRect:Rectangle = _viewportInnerRect.getInnerRect(_width,_height);
         _textField.x = texFieldRect.x;
         _textField.y = texFieldRect.y;
         _textField.width = _viewSource.width;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         super.onProppertiesUpdate();
         if(_changedPropeties["textField"])
         {
            DisplayObjectViewport(_viewSource).setView(_textField);
         }
      }
      
      private function __onTextAreaClick(event:MouseEvent) : void
      {
         _textField.setFocus();
      }
      
      private function __onTextAreaOut(event:MouseEvent) : void
      {
         Mouse.cursor = "auto";
      }
      
      private function __onTextAreaOver(event:MouseEvent) : void
      {
         Mouse.cursor = "ibeam";
      }
      
      private function __onTextChanged(event:Event) : void
      {
         upScrollArea();
      }
      
      private function __onTextKeyDown(event:KeyboardEvent) : void
      {
         if(event.keyCode == 13)
         {
            event.stopPropagation();
         }
         else if(event.keyCode == 38)
         {
            upScrollArea();
         }
         else if(event.keyCode == 40)
         {
            upScrollArea();
         }
         else if(event.keyCode == 46)
         {
            upScrollArea();
         }
      }
      
      public function upScrollArea() : void
      {
         var lineHeight:Number = NaN;
         var currentPos:* = null;
         var careX:Number = NaN;
         var careY:Number = NaN;
         var offsetX:Number = NaN;
         var offsetY:Number = NaN;
         var resultX:* = NaN;
         var resultY:* = NaN;
         DisplayObjectViewport(_viewSource).invalidateView();
         if(_textField.caretIndex <= 0)
         {
            viewPort.viewPosition = new IntPoint(0,0);
         }
         else
         {
            lineHeight = DisplayUtils.getTextFieldLineHeight(_textField);
            currentPos = viewPort.viewPosition;
            careX = DisplayUtils.getTextFieldCareLinePosX(_textField);
            careY = DisplayUtils.getTextFieldCareLinePosY(_textField);
            offsetX = careX - currentPos.x;
            offsetY = careY + lineHeight - currentPos.y;
            DisplayObjectViewport(_viewSource).invalidateView();
            resultX = Number(currentPos.x);
            resultY = Number(currentPos.y);
            if(offsetX < 0)
            {
               resultX = careX;
            }
            else if(offsetX > viewPort.getExtentSize().width)
            {
               resultX = Number(careX + viewPort.getExtentSize().width);
            }
            if(offsetY < lineHeight)
            {
               resultY = careY;
            }
            else if(offsetY > viewPort.getExtentSize().height)
            {
               resultY = Number(careY + viewPort.getExtentSize().height);
            }
            if(resultX > 0 || resultY > 0)
            {
               viewPort.viewPosition = new IntPoint(resultX,resultY);
            }
         }
      }
   }
}
