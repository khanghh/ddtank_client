package com.pickgliss.ui.controls
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.toplevel.StageReferance;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.ui.core.Component;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.display.DisplayObject;
   import flash.events.Event;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class TextInput extends Component
   {
      
      public static const P_back:String = "back";
      
      public static const P_focusBack:String = "focusBack";
      
      public static const P_focusBackgoundInnerRect:String = "focusBackOuterRect";
      
      public static const P_textField:String = "textField";
      
      public static const P_textInnerRect:String = "textInnerRect";
      
      public static const P_backgroundColor:String = "backgroundColor";
      
      public static const P_enable:String = "enable";
       
      
      protected var _back:DisplayObject;
      
      protected var _backStyle:String;
      
      protected var _focusBack:DisplayObject;
      
      protected var _focusBackgoundInnerRect:InnerRectangle;
      
      protected var _focusBackgoundInnerRectString:String;
      
      protected var _focusBackStyle:String;
      
      protected var _textField:TextField;
      
      protected var _textInnerRect:InnerRectangle;
      
      protected var _textInnerRectString:String;
      
      protected var _textStyle:String;
      
      protected var _backgroundColor:uint;
      
      protected var _filterString:String;
      
      protected var _frameFilter:Array;
      
      protected var _enable:Boolean = true;
      
      protected var _currentFrameIndex:int = 1;
      
      public function TextInput()
      {
         super();
      }
      
      public function set back(display:DisplayObject) : void
      {
         if(_back == display)
         {
            return;
         }
         ObjectUtils.disposeObject(_back);
         _back = display;
         onPropertiesChanged("back");
      }
      
      public function set backStyle(stylename:String) : void
      {
         if(_backStyle == stylename)
         {
            return;
         }
         _backStyle = stylename;
         back = ComponentFactory.Instance.creat(_backStyle);
      }
      
      public function set backgroundColor(color:uint) : void
      {
         if(_back || !color)
         {
            return;
         }
         _backgroundColor = color;
         onPropertiesChanged("backgroundColor");
      }
      
      public function get backgroundColor() : uint
      {
         return _backgroundColor;
      }
      
      public function set filterString(value:String) : void
      {
         if(_filterString == value)
         {
            return;
         }
         _filterString = value;
         _frameFilter = ComponentFactory.Instance.creatFrameFilters(_filterString);
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(value:Boolean) : void
      {
         if(_enable == value)
         {
            return;
         }
         _enable = value;
         onPropertiesChanged("enable");
      }
      
      protected function setFrame(frameIndex:int) : void
      {
         _currentFrameIndex = frameIndex;
         DisplayUtils.setFrame(_back,_currentFrameIndex);
         if(_frameFilter == null || frameIndex <= 0 || frameIndex > _frameFilter.length)
         {
            return;
         }
         filters = _frameFilter[frameIndex - 1];
      }
      
      override public function dispose() : void
      {
         ObjectUtils.disposeObject(_back);
         _back = null;
         ObjectUtils.disposeObject(_focusBack);
         _focusBack = null;
         if(_textField)
         {
            _textField.removeEventListener("focusIn",__onFocusText);
            _textField.removeEventListener("focusOut",__onFocusText);
         }
         ObjectUtils.disposeObject(_textField);
         _textField = null;
         graphics.clear();
         super.dispose();
      }
      
      public function set focusBack(display:DisplayObject) : void
      {
         if(_focusBack == display)
         {
            return;
         }
         ObjectUtils.disposeObject(_focusBack);
         _focusBack = display;
         _focusBack.visible = false;
         onPropertiesChanged();
      }
      
      public function set focusBackgoundInnerRectString(value:String) : void
      {
         if(_focusBackgoundInnerRectString == value)
         {
            return;
         }
         _focusBackgoundInnerRectString = value;
         _focusBackgoundInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_focusBackgoundInnerRectString));
         onPropertiesChanged("focusBackOuterRect");
      }
      
      public function set focusBackStyle(value:String) : void
      {
         if(_focusBackStyle == value)
         {
            return;
         }
         _focusBackStyle = value;
         focusBack = ComponentFactory.Instance.creat(_focusBackStyle);
      }
      
      public function get textField() : TextField
      {
         return _textField;
      }
      
      public function set textField(field:TextField) : void
      {
         if(_textField == field)
         {
            return;
         }
         ObjectUtils.disposeObject(_textField);
         _textField = field;
         onPropertiesChanged("textField");
      }
      
      public function set textInnerRectString(value:String) : void
      {
         if(_textInnerRectString == value)
         {
            return;
         }
         _textInnerRectString = value;
         _textInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_textInnerRectString));
         onPropertiesChanged("textInnerRect");
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
      
      protected function __onFocusText(event:Event) : void
      {
         if(_focusBack)
         {
            _focusBack.visible = event.type == "focusIn";
         }
      }
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_back)
         {
            addChild(_back);
         }
         if(_focusBack)
         {
            addChild(_focusBack);
         }
         if(_textField)
         {
            addChild(_textField);
         }
      }
      
      public function set displayAsPassword(value:Boolean) : void
      {
         _textField.displayAsPassword = value;
      }
      
      public function get displayAsPassword() : Boolean
      {
         return _textField.displayAsPassword;
      }
      
      public function set multiline(value:Boolean) : void
      {
         _textField.multiline = value;
      }
      
      public function get multiline() : Boolean
      {
         return _textField.multiline;
      }
      
      public function set maxChars(value:int) : void
      {
         _textField.maxChars = value;
      }
      
      public function get maxChars() : int
      {
         return _textField.maxChars;
      }
      
      public function set autoSize(value:String) : void
      {
         _textField.autoSize = value;
      }
      
      public function get autoSize() : String
      {
         return _textField.autoSize;
      }
      
      public function set text(value:String) : void
      {
         _textField.text = value;
      }
      
      public function get text() : String
      {
         return _textField.text;
      }
      
      public function appendText(newText:String) : void
      {
         _textField.appendText(newText);
      }
      
      public function setFocus() : void
      {
         StageReferance.stage.focus = _textField;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         var textInnerRect:* = null;
         super.onProppertiesUpdate();
         if(_changedPropeties["textField"])
         {
            _textField.type = "input";
            _textField.wordWrap = true;
            _textField.addEventListener("focusIn",__onFocusText);
            _textField.addEventListener("focusOut",__onFocusText);
         }
         if(_back)
         {
            _back.width = _width;
            _back.height = _height;
            textInnerRect = _textInnerRect.getInnerRect(_width,_height);
            _textField.width = textInnerRect.width;
            _textField.height = textInnerRect.height;
            _textField.x = textInnerRect.x;
            _textField.y = textInnerRect.y;
            if(_focusBack)
            {
               DisplayUtils.layoutDisplayWithInnerRect(_focusBack,_focusBackgoundInnerRect,_width,_height);
            }
         }
         else
         {
            _textField.width = _width;
            _textField.height = _height;
         }
         if(_changedPropeties["backgroundColor"])
         {
            graphics.beginFill(_backgroundColor);
            graphics.drawRect(0,0,_width,_height);
            graphics.endFill();
         }
         if(_changedPropeties["enable"])
         {
            mouseEnabled = _enable;
            mouseChildren = _enable;
            if(_enable)
            {
               setFrame(1);
            }
            else
            {
               setFrame(2);
            }
         }
      }
   }
}
