package com.pickgliss.ui.controls{   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.utils.ObjectUtils;   import flash.display.DisplayObject;   import flash.text.TextField;      public class SelectedCheckButton extends SelectedButton   {            public static const P_fieldX:String = "fieldX";            public static const P_fieldY:String = "fieldY";            public static const P_text:String = "text";            public static const P_textField:String = "textField";                   protected var _field:DisplayObject;            protected var _fieldX:Number;            protected var _fieldY:Number;            protected var _text:String = "";            protected var _textStyle:String;            public function SelectedCheckButton() { super(); }
            override public function dispose() : void { }
            public function set fieldX(value:Number) : void { }
            public function set fieldY(value:Number) : void { }
            public function set text(value:String) : void { }
            public function set textField(field:DisplayObject) : void { }
            public function set textStyle(stylename:String) : void { }
            public function get textWidth() : int { return 0; }
            public function get field() : TextField { return null; }
            override protected function addChildren() : void { }
            protected function drawClickArea() : void { }
            override protected function onProppertiesUpdate() : void { }
   }}