package com.pickgliss.ui.controls
{
   import com.pickgliss.geom.InnerRectangle;
   import com.pickgliss.ui.ComponentFactory;
   import com.pickgliss.utils.ClassUtils;
   import com.pickgliss.utils.DisplayUtils;
   import com.pickgliss.utils.ObjectUtils;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   
   public class TextButton extends BaseButton
   {
      
      public static const P_backOuterRect:String = "backOuterRect";
      
      public static const P_text:String = "text";
      
      public static const P_textField:String = "textField";
       
      
      protected var _backgoundInnerRect:InnerRectangle;
      
      protected var _backgoundInnerRectString:String;
      
      protected var _text:String = "";
      
      protected var _textField:TextField;
      
      protected var _textStyle:String;
      
      public function TextButton()
      {
         _backgoundInnerRect = new InnerRectangle(0,0,0,0,-1);
         super();
      }
      
      public function set backgoundInnerRectString(value:String) : void
      {
         if(_backgoundInnerRectString == value)
         {
            return;
         }
         _backgoundInnerRectString = value;
         _backgoundInnerRect = ClassUtils.CreatInstance("com.pickgliss.geom.InnerRectangle",ComponentFactory.parasArgs(_backgoundInnerRectString));
         onPropertiesChanged("backOuterRect");
      }
      
      override public function dispose() : void
      {
         if(_textField)
         {
            ObjectUtils.disposeObject(_textField);
         }
         _textField = null;
         super.dispose();
      }
      
      public function get text() : String
      {
         return _text;
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
      
      public function get textField() : TextField
      {
         return _textField;
      }
      
      public function set textField(f:TextField) : void
      {
         if(_textField == f)
         {
            return;
         }
         ObjectUtils.disposeObject(_textField);
         _textField = f;
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
      
      override protected function addChildren() : void
      {
         super.addChildren();
         if(_textField)
         {
            addChild(_textField);
         }
      }
      
      override protected function onProppertiesUpdate() : void
      {
         var rectangle:* = null;
         super.onProppertiesUpdate();
         if(_textField == null)
         {
            return;
         }
         _textField.text = _text;
         if(_autoSizeAble)
         {
            rectangle = _backgoundInnerRect.getInnerRect(_textField.textWidth,_textField.textHeight);
            var _loc2_:* = rectangle.width;
            _back.width = _loc2_;
            _width = _loc2_;
            _loc2_ = rectangle.height;
            _back.height = _loc2_;
            _height = _loc2_;
            _textField.x = _backgoundInnerRect.para1;
            _textField.y = _backgoundInnerRect.para3;
         }
         else
         {
            _back.width = _width;
            _back.height = _height;
            _textField.x = _backgoundInnerRect.para1;
            _textField.y = _backgoundInnerRect.para3;
         }
      }
      
      override public function setFrame(frameIndex:int) : void
      {
         super.setFrame(frameIndex);
         DisplayUtils.setFrame(_textField,frameIndex);
      }
   }
}
