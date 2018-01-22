package starling.text
{
   import flash.display.BitmapData;
   import flash.display3D.Context3DTextureFormat;
   import flash.filters.BitmapFilter;
   import flash.geom.Matrix;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.text.TextFormat;
   import flash.utils.Dictionary;
   import starling.core.RenderSupport;
   import starling.core.Starling;
   import starling.display.DisplayObject;
   import starling.display.DisplayObjectContainer;
   import starling.display.Image;
   import starling.display.Quad;
   import starling.display.QuadBatch;
   import starling.display.Sprite;
   import starling.textures.Texture;
   import starling.utils.HAlign;
   import starling.utils.RectangleUtil;
   import starling.utils.VAlign;
   import starling.utils.deg2rad;
   
   public class TextField extends DisplayObjectContainer
   {
      
      private static const BITMAP_FONT_DATA_NAME:String = "starling.display.TextField.BitmapFonts";
      
      private static var sDefaultTextureFormat:String = "BGRA_PACKED" in Context3DTextureFormat?"bgraPacked4444":"bgra";
      
      private static var sHelperMatrix:Matrix = new Matrix();
      
      private static var sNativeTextField:flash.text.TextField = new flash.text.TextField();
      
      private static var sStringCache:Dictionary = new Dictionary();
       
      
      private var mFontSize:Number;
      
      private var mColor:uint;
      
      private var mText:String;
      
      private var mFontName:String;
      
      private var mHAlign:String;
      
      private var mVAlign:String;
      
      private var mBold:Boolean;
      
      private var mItalic:Boolean;
      
      private var mUnderline:Boolean;
      
      private var mAutoScale:Boolean;
      
      private var mAutoSize:String;
      
      private var mKerning:Boolean;
      
      private var mLeading:Number;
      
      private var mNativeFilters:Array;
      
      private var mRequiresRedraw:Boolean;
      
      private var mIsHtmlText:Boolean;
      
      private var mTextBounds:Rectangle;
      
      private var mBatchable:Boolean;
      
      private var mHitArea:Rectangle;
      
      private var mBorder:DisplayObjectContainer;
      
      private var mImage:Image;
      
      private var mQuadBatch:QuadBatch;
      
      public function TextField(param1:int, param2:int, param3:String, param4:String = "Verdana", param5:Number = 12, param6:uint = 0, param7:Boolean = false){super();}
      
      public static function get defaultTextureFormat() : String{return null;}
      
      public static function set defaultTextureFormat(param1:String) : void{}
      
      public static function registerBitmapFont(param1:BitmapFont, param2:String = null) : String{return null;}
      
      public static function unregisterBitmapFont(param1:String, param2:Boolean = true) : void{}
      
      public static function getBitmapFont(param1:String) : BitmapFont{return null;}
      
      private static function get bitmapFonts() : Dictionary{return null;}
      
      private static function convertToLowerCase(param1:String) : String{return null;}
      
      override public function dispose() : void{}
      
      private function onFlatten() : void{}
      
      override public function render(param1:RenderSupport, param2:Number) : void{}
      
      public function redraw() : void{}
      
      private function createRenderedContents() : void{}
      
      protected function formatText(param1:flash.text.TextField, param2:TextFormat) : void{}
      
      private function renderText(param1:Number, param2:Rectangle) : BitmapData{return null;}
      
      private function autoScaleNativeTextField(param1:flash.text.TextField) : void{}
      
      private function calculateFilterOffset(param1:flash.text.TextField, param2:String, param3:String) : Point{return null;}
      
      private function createComposedContents() : void{}
      
      private function updateBorder() : void{}
      
      private function get isHorizontalAutoSize() : Boolean{return false;}
      
      private function get isVerticalAutoSize() : Boolean{return false;}
      
      public function get textBounds() : Rectangle{return null;}
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle{return null;}
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject{return null;}
      
      override public function set width(param1:Number) : void{}
      
      override public function set height(param1:Number) : void{}
      
      public function get text() : String{return null;}
      
      public function set text(param1:String) : void{}
      
      public function get fontName() : String{return null;}
      
      public function set fontName(param1:String) : void{}
      
      public function get fontSize() : Number{return 0;}
      
      public function set fontSize(param1:Number) : void{}
      
      public function get color() : uint{return null;}
      
      public function set color(param1:uint) : void{}
      
      public function get hAlign() : String{return null;}
      
      public function set hAlign(param1:String) : void{}
      
      public function get vAlign() : String{return null;}
      
      public function set vAlign(param1:String) : void{}
      
      public function get border() : Boolean{return false;}
      
      public function set border(param1:Boolean) : void{}
      
      public function get bold() : Boolean{return false;}
      
      public function set bold(param1:Boolean) : void{}
      
      public function get italic() : Boolean{return false;}
      
      public function set italic(param1:Boolean) : void{}
      
      public function get underline() : Boolean{return false;}
      
      public function set underline(param1:Boolean) : void{}
      
      public function get kerning() : Boolean{return false;}
      
      public function set kerning(param1:Boolean) : void{}
      
      public function get autoScale() : Boolean{return false;}
      
      public function set autoScale(param1:Boolean) : void{}
      
      public function get autoSize() : String{return null;}
      
      public function set autoSize(param1:String) : void{}
      
      public function get batchable() : Boolean{return false;}
      
      public function set batchable(param1:Boolean) : void{}
      
      public function get nativeFilters() : Array{return null;}
      
      public function set nativeFilters(param1:Array) : void{}
      
      public function get isHtmlText() : Boolean{return false;}
      
      public function set isHtmlText(param1:Boolean) : void{}
      
      public function get leading() : Number{return 0;}
      
      public function set leading(param1:Number) : void{}
   }
}
