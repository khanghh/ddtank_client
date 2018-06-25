package starling.text{   import flash.display.BitmapData;   import flash.display3D.Context3DTextureFormat;   import flash.filters.BitmapFilter;   import flash.geom.Matrix;   import flash.geom.Point;   import flash.geom.Rectangle;   import flash.text.TextFormat;   import flash.utils.Dictionary;   import starling.core.RenderSupport;   import starling.core.Starling;   import starling.display.DisplayObject;   import starling.display.DisplayObjectContainer;   import starling.display.Image;   import starling.display.Quad;   import starling.display.QuadBatch;   import starling.display.Sprite;   import starling.textures.Texture;   import starling.utils.HAlign;   import starling.utils.RectangleUtil;   import starling.utils.VAlign;   import starling.utils.deg2rad;      public class TextField extends DisplayObjectContainer   {            private static const BITMAP_FONT_DATA_NAME:String = "starling.display.TextField.BitmapFonts";            private static var sDefaultTextureFormat:String = "BGRA_PACKED" in Context3DTextureFormat?"bgraPacked4444":"bgra";            private static var sHelperMatrix:Matrix = new Matrix();            private static var sNativeTextField:flash.text.TextField = new flash.text.TextField();            private static var sStringCache:Dictionary = new Dictionary();                   private var mFontSize:Number;            private var mColor:uint;            private var mText:String;            private var mFontName:String;            private var mHAlign:String;            private var mVAlign:String;            private var mBold:Boolean;            private var mItalic:Boolean;            private var mUnderline:Boolean;            private var mAutoScale:Boolean;            private var mAutoSize:String;            private var mKerning:Boolean;            private var mLeading:Number;            private var mNativeFilters:Array;            private var mRequiresRedraw:Boolean;            private var mIsHtmlText:Boolean;            private var mTextBounds:Rectangle;            private var mBatchable:Boolean;            private var mHitArea:Rectangle;            private var mBorder:DisplayObjectContainer;            private var mImage:Image;            private var mQuadBatch:QuadBatch;            public function TextField(width:int, height:int, text:String, fontName:String = "Verdana", fontSize:Number = 12, color:uint = 0, bold:Boolean = false) { super(); }
            public static function get defaultTextureFormat() : String { return null; }
            public static function set defaultTextureFormat(value:String) : void { }
            public static function registerBitmapFont(bitmapFont:BitmapFont, name:String = null) : String { return null; }
            public static function unregisterBitmapFont(name:String, dispose:Boolean = true) : void { }
            public static function getBitmapFont(name:String) : BitmapFont { return null; }
            private static function get bitmapFonts() : Dictionary { return null; }
            private static function convertToLowerCase(string:String) : String { return null; }
            override public function dispose() : void { }
            private function onFlatten() : void { }
            override public function render(support:RenderSupport, parentAlpha:Number) : void { }
            public function redraw() : void { }
            private function createRenderedContents() : void { }
            protected function formatText(textField:flash.text.TextField, textFormat:TextFormat) : void { }
            private function renderText(scale:Number, resultTextBounds:Rectangle) : BitmapData { return null; }
            private function autoScaleNativeTextField(textField:flash.text.TextField) : void { }
            private function calculateFilterOffset(textField:flash.text.TextField, hAlign:String, vAlign:String) : Point { return null; }
            private function createComposedContents() : void { }
            private function updateBorder() : void { }
            private function get isHorizontalAutoSize() : Boolean { return false; }
            private function get isVerticalAutoSize() : Boolean { return false; }
            public function get textBounds() : Rectangle { return null; }
            override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle { return null; }
            override public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject { return null; }
            override public function set width(value:Number) : void { }
            override public function set height(value:Number) : void { }
            public function get text() : String { return null; }
            public function set text(value:String) : void { }
            public function get fontName() : String { return null; }
            public function set fontName(value:String) : void { }
            public function get fontSize() : Number { return 0; }
            public function set fontSize(value:Number) : void { }
            public function get color() : uint { return null; }
            public function set color(value:uint) : void { }
            public function get hAlign() : String { return null; }
            public function set hAlign(value:String) : void { }
            public function get vAlign() : String { return null; }
            public function set vAlign(value:String) : void { }
            public function get border() : Boolean { return false; }
            public function set border(value:Boolean) : void { }
            public function get bold() : Boolean { return false; }
            public function set bold(value:Boolean) : void { }
            public function get italic() : Boolean { return false; }
            public function set italic(value:Boolean) : void { }
            public function get underline() : Boolean { return false; }
            public function set underline(value:Boolean) : void { }
            public function get kerning() : Boolean { return false; }
            public function set kerning(value:Boolean) : void { }
            public function get autoScale() : Boolean { return false; }
            public function set autoScale(value:Boolean) : void { }
            public function get autoSize() : String { return null; }
            public function set autoSize(value:String) : void { }
            public function get batchable() : Boolean { return false; }
            public function set batchable(value:Boolean) : void { }
            public function get nativeFilters() : Array { return null; }
            public function set nativeFilters(value:Array) : void { }
            public function get isHtmlText() : Boolean { return false; }
            public function set isHtmlText(value:Boolean) : void { }
            public function get leading() : Number { return 0; }
            public function set leading(value:Number) : void { }
   }}