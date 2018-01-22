package morn.core.components
{
   import flash.display.GradientType;
   import flash.display.Shape;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import morn.core.utils.ObjectUtils;
   import morn.core.utils.StringUtils;
   
   [Event(name="change",type="flash.events.Event")]
   public class Label extends Component
   {
       
      
      protected var _textField:TextField;
      
      protected var _format:TextFormat;
      
      protected var _text:String = "";
      
      protected var _isHtml:Boolean;
      
      protected var _stroke:String;
      
      protected var _skin:String;
      
      protected var _bitmap:AutoBitmap;
      
      protected var _margin:Array;
      
      protected var _gradientColor:Array;
      
      protected var _gradientSp:Shape;
      
      protected var _gradientStroke:String;
      
      public function Label(param1:String = "", param2:String = null){super();}
      
      override protected function preinitialize() : void{}
      
      override protected function createChildren() : void{}
      
      override protected function initialize() : void{}
      
      public function get text() : String{return null;}
      
      public function set text(param1:String) : void{}
      
      public function get htmlText() : String{return null;}
      
      public function set htmlText(param1:String) : void{}
      
      protected function changeText() : void{}
      
      override protected function changeSize() : void{}
      
      public function get isHtml() : Boolean{return false;}
      
      public function set isHtml(param1:Boolean) : void{}
      
      public function get stroke() : String{return null;}
      
      public function set stroke(param1:String) : void{}
      
      public function get gradientColor() : String{return null;}
      
      public function set gradientColor(param1:String) : void{}
      
      public function get gradientStroke() : String{return null;}
      
      public function set gradientStroke(param1:String) : void{}
      
      public function updateGradient() : void{}
      
      public function get multiline() : Boolean{return false;}
      
      public function set multiline(param1:Boolean) : void{}
      
      public function get asPassword() : Boolean{return false;}
      
      public function set asPassword(param1:Boolean) : void{}
      
      public function get autoSize() : String{return null;}
      
      public function set autoSize(param1:String) : void{}
      
      public function get wordWrap() : Boolean{return false;}
      
      public function set wordWrap(param1:Boolean) : void{}
      
      public function get selectable() : Boolean{return false;}
      
      public function set selectable(param1:Boolean) : void{}
      
      public function get background() : Boolean{return false;}
      
      public function set background(param1:Boolean) : void{}
      
      public function get backgroundColor() : uint{return null;}
      
      public function set backgroundColor(param1:uint) : void{}
      
      public function get color() : Object{return null;}
      
      public function set color(param1:Object) : void{}
      
      public function get font() : String{return null;}
      
      public function set font(param1:String) : void{}
      
      public function get align() : String{return null;}
      
      public function set align(param1:String) : void{}
      
      public function get bold() : Object{return null;}
      
      public function set bold(param1:Object) : void{}
      
      public function get leading() : Object{return null;}
      
      public function set leading(param1:Object) : void{}
      
      public function get indent() : Object{return null;}
      
      public function set indent(param1:Object) : void{}
      
      public function get size() : Object{return null;}
      
      public function set size(param1:Object) : void{}
      
      public function get underline() : Object{return null;}
      
      public function set underline(param1:Object) : void{}
      
      public function get letterSpacing() : Object{return null;}
      
      public function set letterSpacing(param1:Object) : void{}
      
      public function get margin() : String{return null;}
      
      public function set margin(param1:String) : void{}
      
      public function get embedFonts() : Boolean{return false;}
      
      public function set embedFonts(param1:Boolean) : void{}
      
      public function get format() : TextFormat{return null;}
      
      public function set format(param1:TextFormat) : void{}
      
      public function get textField() : TextField{return null;}
      
      public function appendText(param1:String) : void{}
      
      public function get skin() : String{return null;}
      
      public function set skin(param1:String) : void{}
      
      public function get sizeGrid() : String{return null;}
      
      public function set sizeGrid(param1:String) : void{}
      
      override public function commitMeasure() : void{}
      
      override public function get width() : Number{return 0;}
      
      override public function set width(param1:Number) : void{}
      
      override public function get height() : Number{return 0;}
      
      override public function set height(param1:Number) : void{}
      
      override public function set dataSource(param1:Object) : void{}
      
      override public function dispose() : void{}
   }
}
