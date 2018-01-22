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
      
      public function set backgoundInnerRectString(param1:String) : void
      {
         if(_backgoundInnerRectString == param1)
         {
            return;
         }
         _backgoundInnerRectString = param1;
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
      
      public function set text(param1:String) : void
      {
         if(_text == param1)
         {
            return;
         }
         _text = param1;
         onPropertiesChanged("text");
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
      
      public function set textStyle(param1:String) : void
      {
         if(_textStyle == param1)
         {
            return;
         }
         _textStyle = param1;
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
         var _loc1_:* = null;
         super.onProppertiesUpdate();
         if(_textField == null)
         {
            return;
         }
         _textField.text = _text;
         if(_autoSizeAble)
         {
            _loc1_ = _backgoundInnerRect.getInnerRect(_textField.textWidth,_textField.textHeight);
            var _loc2_:* = _loc1_.width;
            _back.width = _loc2_;
            _width = _loc2_;
            _loc2_ = _loc1_.height;
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
      
      override public function setFrame(param1:int) : void
      {
         super.setFrame(param1);
         DisplayUtils.setFrame(_textField,param1);
      }
   }
}
