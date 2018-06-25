package com.pickgliss.ui.text{   import com.pickgliss.toplevel.StageReferance;   import com.pickgliss.ui.ComponentFactory;   import com.pickgliss.ui.core.Disposeable;   import flash.text.TextField;   import flash.text.TextFormat;      public class FilterFrameText extends TextField implements Disposeable   {            public static const P_frameFilters:String = "frameFilters";            public static var isInputChangeWmode:Boolean = true;                   protected var _currentFrameIndex:int;            protected var _filterString:String;            protected var _frameFilter:Array;            protected var _frameTextFormat:Vector.<TextFormat>;            protected var _id:int;            protected var _width:Number;            protected var _height:Number;            protected var _isAutoFitLength:Boolean = false;            public var stylename:String;            protected var _textFormatStyle:String;            public function FilterFrameText() { super(); }
            public static function getStringWidthByTextField(str:String, size:int = 14, font:String = "Arial", autoSize:String = "left", bold:Boolean = true) : Number { return 0; }
            public function dispose() : void { }
            public function set filterString(filters:String) : void { }
            public function set frameFilters(filter:Array) : void { }
            public function get id() : int { return 0; }
            public function set id(value:int) : void { }
            public function setFocus() : void { }
            public function setFrame(frameIndex:int) : void { }
            protected function set textFormat(tf:TextFormat) : void { }
            public function set textFormatStyle(stylename:String) : void { }
            public function get textFormatStyle() : String { return null; }
            public function set isAutoFitLength(value:Boolean) : void { }
            override public function set visible(value:Boolean) : void { }
            override public function set text(value:String) : void { }
            override public function set htmlText(value:String) : void { }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            override public function set type(value:String) : void { }
   }}