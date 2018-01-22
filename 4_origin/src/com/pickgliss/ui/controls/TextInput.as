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
      
      public function set back(param1:DisplayObject) : void
      {
         if(_back == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_back);
         _back = param1;
         onPropertiesChanged("back");
      }
      
      public function set backStyle(param1:String) : void
      {
         if(_backStyle == param1)
         {
            return;
         }
         _backStyle = param1;
         back = ComponentFactory.Instance.creat(_backStyle);
      }
      
      public function set backgroundColor(param1:uint) : void
      {
         if(_back || !param1)
         {
            return;
         }
         _backgroundColor = param1;
         onPropertiesChanged("backgroundColor");
      }
      
      public function get backgroundColor() : uint
      {
         return _backgroundColor;
      }
      
      public function set filterString(param1:String) : void
      {
         if(_filterString == param1)
         {
            return;
         }
         _filterString = param1;
         _frameFilter = ComponentFactory.Instance.creatFrameFilters(_filterString);
      }
      
      public function get enable() : Boolean
      {
         return _enable;
      }
      
      public function set enable(param1:Boolean) : void
      {
         if(_enable == param1)
         {
            return;
         }
         _enable = param1;
         onPropertiesChanged("enable");
      }
      
      protected function setFrame(param1:int) : void
      {
         _currentFrameIndex = param1;
         DisplayUtils.setFrame(_back,_currentFrameIndex);
         if(_frameFilter == null || param1 <= 0 || param1 > _frameFilter.length)
         {
            return;
         }
         filters = _frameFilter[param1 - 1];
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
      
      public function set focusBack(param1:DisplayObject) : void
      {
         if(_focusBack == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_focusBack);
         _focusBack = param1;
         _focusBack.visible = false;
         onPropertiesChanged();
      }
      
      public function set focusBackgoundInnerRectString(param1:String) : void
      {
         if(_focusBackgoundInnerRectString == param1)
         {
            return;
         }
         _focusBackgoundInnerRectString = param1;
         _focusBackgoundInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_focusBackgoundInnerRectString));
         onPropertiesChanged("focusBackOuterRect");
      }
      
      public function set focusBackStyle(param1:String) : void
      {
         if(_focusBackStyle == param1)
         {
            return;
         }
         _focusBackStyle = param1;
         focusBack = ComponentFactory.Instance.creat(_focusBackStyle);
      }
      
      public function get textField() : TextField
      {
         return _textField;
      }
      
      public function set textField(param1:TextField) : void
      {
         if(_textField == param1)
         {
            return;
         }
         ObjectUtils.disposeObject(_textField);
         _textField = param1;
         onPropertiesChanged("textField");
      }
      
      public function set textInnerRectString(param1:String) : void
      {
         if(_textInnerRectString == param1)
         {
            return;
         }
         _textInnerRectString = param1;
         _textInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_textInnerRectString));
         onPropertiesChanged("textInnerRect");
      }
      
      public function set textStyle(param1:String) : void
      {
         if(_textStyle == param1)
         {
            return;
         }
         _textStyle = param1;
         textField = ComponentFactory.Instance.creat(_textStyle);
      }
      
      protected function __onFocusText(param1:Event) : void
      {
         if(_focusBack)
         {
            _focusBack.visible = param1.type == "focusIn";
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
      
      public function set displayAsPassword(param1:Boolean) : void
      {
         _textField.displayAsPassword = param1;
      }
      
      public function get displayAsPassword() : Boolean
      {
         return _textField.displayAsPassword;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         _textField.multiline = param1;
      }
      
      public function get multiline() : Boolean
      {
         return _textField.multiline;
      }
      
      public function set maxChars(param1:int) : void
      {
         _textField.maxChars = param1;
      }
      
      public function get maxChars() : int
      {
         return _textField.maxChars;
      }
      
      public function set autoSize(param1:String) : void
      {
         _textField.autoSize = param1;
      }
      
      public function get autoSize() : String
      {
         return _textField.autoSize;
      }
      
      public function set text(param1:String) : void
      {
         _textField.text = param1;
      }
      
      public function get text() : String
      {
         return _textField.text;
      }
      
      public function appendText(param1:String) : void
      {
         _textField.appendText(param1);
      }
      
      public function setFocus() : void
      {
         StageReferance.stage.focus = _textField;
      }
      
      override protected function onProppertiesUpdate() : void
      {
         var _loc1_:* = null;
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
            _loc1_ = _textInnerRect.getInnerRect(_width,_height);
            _textField.width = _loc1_.width;
            _textField.height = _loc1_.height;
            _textField.x = _loc1_.x;
            _textField.y = _loc1_.y;
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
