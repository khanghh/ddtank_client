package morn.core.components{   import flash.display.Shape;   import flash.filters.GlowFilter;   import flash.geom.Matrix;   import flash.geom.Rectangle;   import flash.text.TextField;   import flash.text.TextFormat;   import morn.core.utils.ObjectUtils;   import morn.core.utils.StringUtils;      [Event(name="change",type="flash.events.Event")]   public class Label extends Component   {                   protected var _textField:TextField;            protected var _format:TextFormat;            protected var _text:String = "";            protected var _isHtml:Boolean;            protected var _stroke:String;            protected var _skin:String;            protected var _bitmap:AutoBitmap;            protected var _margin:Array;            protected var _gradientColor:Array;            protected var _gradientSp:Shape;            protected var _gradientStroke:String;            public function Label(text:String = "", skin:String = null) { super(); }
            override protected function preinitialize() : void { }
            override protected function createChildren() : void { }
            override protected function initialize() : void { }
            public function get text() : String { return null; }
            public function set text(value:String) : void { }
            public function get htmlText() : String { return null; }
            public function set htmlText(value:String) : void { }
            protected function changeText() : void { }
            override protected function changeSize() : void { }
            public function get isHtml() : Boolean { return false; }
            public function set isHtml(value:Boolean) : void { }
            public function get stroke() : String { return null; }
            public function set stroke(value:String) : void { }
            public function get gradientColor() : String { return null; }
            public function set gradientColor(value:String) : void { }
            public function get gradientStroke() : String { return null; }
            public function set gradientStroke(value:String) : void { }
            public function updateGradient() : void { }
            public function get multiline() : Boolean { return false; }
            public function set multiline(value:Boolean) : void { }
            public function get asPassword() : Boolean { return false; }
            public function set asPassword(value:Boolean) : void { }
            public function get autoSize() : String { return null; }
            public function set autoSize(value:String) : void { }
            public function get wordWrap() : Boolean { return false; }
            public function set wordWrap(value:Boolean) : void { }
            public function get selectable() : Boolean { return false; }
            public function set selectable(value:Boolean) : void { }
            public function get background() : Boolean { return false; }
            public function set background(value:Boolean) : void { }
            public function get backgroundColor() : uint { return null; }
            public function set backgroundColor(value:uint) : void { }
            public function get color() : Object { return null; }
            public function set color(value:Object) : void { }
            public function get font() : String { return null; }
            public function set font(value:String) : void { }
            public function get align() : String { return null; }
            public function set align(value:String) : void { }
            public function get bold() : Object { return null; }
            public function set bold(value:Object) : void { }
            public function get leading() : Object { return null; }
            public function set leading(value:Object) : void { }
            public function get indent() : Object { return null; }
            public function set indent(value:Object) : void { }
            public function get size() : Object { return null; }
            public function set size(value:Object) : void { }
            public function get underline() : Object { return null; }
            public function set underline(value:Object) : void { }
            public function get letterSpacing() : Object { return null; }
            public function set letterSpacing(value:Object) : void { }
            public function get margin() : String { return null; }
            public function set margin(value:String) : void { }
            public function get embedFonts() : Boolean { return false; }
            public function set embedFonts(value:Boolean) : void { }
            public function get format() : TextFormat { return null; }
            public function set format(value:TextFormat) : void { }
            public function get textField() : TextField { return null; }
            public function appendText(newText:String) : void { }
            public function get skin() : String { return null; }
            public function set skin(value:String) : void { }
            public function get sizeGrid() : String { return null; }
            public function set sizeGrid(value:String) : void { }
            override public function commitMeasure() : void { }
            override public function get width() : Number { return 0; }
            override public function set width(value:Number) : void { }
            override public function get height() : Number { return 0; }
            override public function set height(value:Number) : void { }
            override public function set dataSource(value:Object) : void { }
            override public function dispose() : void { }
   }}