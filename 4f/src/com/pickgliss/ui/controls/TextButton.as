package com.pickgliss.ui.controls{   import com.pickgliss.geom.InnerRectangle;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ClassUtils;   import com.pickgliss.utils.DisplayUtils;   import com.pickgliss.utils.ObjectUtils;   import flash.geom.Rectangle;   import flash.text.TextField;      public class TextButton extends BaseButton   {            public static const P_backOuterRect:String = "backOuterRect";            public static const P_text:String = "text";            public static const P_textField:String = "textField";                   protected var _backgoundInnerRect:InnerRectangle;            protected var _backgoundInnerRectString:String;            protected var _text:String = "";            protected var _textField:TextField;            protected var _textStyle:String;            public function TextButton() { super(); }
            public function set backgoundInnerRectString(value:String) : void { }
            override public function dispose() : void { }
            public function get text() : String { return null; }
            public function set text(value:String) : void { }
            public function get textField() : TextField { return null; }
            public function set textField(f:TextField) : void { }
            public function set textStyle(stylename:String) : void { }
            override protected function addChildren() : void { }
            override protected function onProppertiesUpdate() : void { }
            override public function setFrame(frameIndex:int) : void { }
   }}