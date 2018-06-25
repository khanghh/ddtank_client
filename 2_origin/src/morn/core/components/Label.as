package morn.core.components
{
   import flash.display.Shape;
   import flash.filters.GlowFilter;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.text.TextField;
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
      
      public function Label(text:String = "", skin:String = null)
      {
         _margin = Styles.labelMargin;
         super();
         this.text = text;
         this.skin = skin;
      }
      
      override protected function preinitialize() : void
      {
         mouseEnabled = false;
      }
      
      override protected function createChildren() : void
      {
         _bitmap = new AutoBitmap();
         addChild(new AutoBitmap());
         _textField = new TextField();
         addChild(new TextField());
      }
      
      override protected function initialize() : void
      {
         _format = _textField.defaultTextFormat;
         _format.font = Styles.fontName;
         _format.size = Styles.fontSize;
         _format.color = Styles.labelColor;
         _textField.selectable = false;
         _textField.autoSize = "left";
         _textField.embedFonts = Styles.embedFonts;
         _bitmap.sizeGrid = Styles.defaultSizeGrid;
      }
      
      public function get text() : String
      {
         return _text;
      }
      
      public function set text(value:String) : void
      {
         if(_text != value)
         {
            _text = value || "";
            _text = _text.replace(/\\n/g,"\n");
            changeText();
            sendEvent("change");
         }
      }
      
      public function get htmlText() : String
      {
         return _text;
      }
      
      public function set htmlText(value:String) : void
      {
         _isHtml = true;
         text = value;
      }
      
      protected function changeText() : void
      {
         _textField.defaultTextFormat = _format;
         if(_isHtml)
         {
            var _loc1_:* = App.lang.getLang(_text);
            _textField.htmlText = _loc1_;
            §§push(_loc1_);
         }
         else
         {
            _loc1_ = App.lang.getLang(_text);
            _textField.text = _loc1_;
            §§push(_loc1_);
         }
         §§pop();
         if(_layOutEabled)
         {
            callLater(resetPosition);
         }
      }
      
      override protected function changeSize() : void
      {
         if(!isNaN(_width))
         {
            _textField.autoSize = "none";
            _textField.width = _width - _margin[0] - _margin[2];
            if(isNaN(_height) && wordWrap)
            {
               _textField.autoSize = "left";
            }
            else
            {
               _height = !!isNaN(_height)?18:Number(_height);
               _textField.height = _height - _margin[1] - _margin[3];
            }
         }
         else
         {
            _height = NaN;
            _width = NaN;
            _textField.autoSize = "left";
         }
         super.changeSize();
      }
      
      public function get isHtml() : Boolean
      {
         return _isHtml;
      }
      
      public function set isHtml(value:Boolean) : void
      {
         if(_isHtml != value)
         {
            _isHtml = value;
            callLater(changeText);
         }
      }
      
      public function get stroke() : String
      {
         return _stroke;
      }
      
      public function set stroke(value:String) : void
      {
         var a:* = null;
         if(_stroke != value)
         {
            _stroke = value;
            ObjectUtils.clearFilter(_textField,GlowFilter);
            if(_stroke)
            {
               a = StringUtils.fillArray(Styles.labelStroke,_stroke);
               ObjectUtils.addFilter(_textField,new GlowFilter(a[0],a[1],a[2],a[3],a[4],a[5]));
            }
         }
      }
      
      public function get gradientColor() : String
      {
         return _gradientColor.join(",");
      }
      
      public function set gradientColor(value:String) : void
      {
         _gradientColor = value.split(",");
         updateGradient();
      }
      
      public function get gradientStroke() : String
      {
         return _gradientStroke;
      }
      
      public function set gradientStroke(value:String) : void
      {
         var a:* = null;
         if(!_gradientColor)
         {
            return;
         }
         if(_gradientStroke != value)
         {
            _gradientStroke = value;
            updateGradient();
            ObjectUtils.clearFilter(_gradientSp,GlowFilter);
            if(_gradientStroke)
            {
               a = StringUtils.fillArray(Styles.labelStroke,_gradientStroke);
               ObjectUtils.addFilter(_gradientSp,new GlowFilter(a[0],a[1],a[2],a[3],a[4],a[5]));
            }
         }
      }
      
      public function updateGradient() : void
      {
         if(_gradientSp)
         {
            if(_gradientSp.parent)
            {
               _gradientSp.parent.removeChild(_gradientSp);
            }
            _gradientSp = null;
         }
         _gradientSp = new Shape();
         addChild(_gradientSp);
         var _currentMatrix:Matrix = new Matrix();
         var rect:Rectangle = new Rectangle(0,0,width,height);
         _currentMatrix.createGradientBox(rect.width,rect.height,3.14159265358979 / 2,0,0);
         _gradientSp.graphics.beginGradientFill("linear",[_gradientColor[0],_gradientColor[1]],[1,1],[0,255],_currentMatrix);
         _gradientSp.graphics.drawRect(0,0,rect.width,rect.height);
         _gradientSp.graphics.endFill();
         _gradientSp.cacheAsBitmap = true;
         textField.cacheAsBitmap = true;
         _gradientSp.mask = textField;
      }
      
      public function get multiline() : Boolean
      {
         return _textField.multiline;
      }
      
      public function set multiline(value:Boolean) : void
      {
         _textField.multiline = value;
      }
      
      public function get asPassword() : Boolean
      {
         return _textField.displayAsPassword;
      }
      
      public function set asPassword(value:Boolean) : void
      {
         _textField.displayAsPassword = value;
      }
      
      public function get autoSize() : String
      {
         return _textField.autoSize;
      }
      
      public function set autoSize(value:String) : void
      {
         _textField.autoSize = value;
      }
      
      public function get wordWrap() : Boolean
      {
         return _textField.wordWrap;
      }
      
      public function set wordWrap(value:Boolean) : void
      {
         _textField.wordWrap = value;
      }
      
      public function get selectable() : Boolean
      {
         return _textField.selectable;
      }
      
      public function set selectable(value:Boolean) : void
      {
         _textField.selectable = value;
         mouseEnabled = value;
      }
      
      public function get background() : Boolean
      {
         return _textField.background;
      }
      
      public function set background(value:Boolean) : void
      {
         _textField.background = value;
      }
      
      public function get backgroundColor() : uint
      {
         return _textField.backgroundColor;
      }
      
      public function set backgroundColor(value:uint) : void
      {
         _textField.backgroundColor = value;
      }
      
      public function get color() : Object
      {
         return _format.color;
      }
      
      public function set color(value:Object) : void
      {
         _format.color = value;
         callLater(changeText);
      }
      
      public function get font() : String
      {
         return _format.font;
      }
      
      public function set font(value:String) : void
      {
         _format.font = value;
         callLater(changeText);
      }
      
      public function get align() : String
      {
         return _format.align;
      }
      
      public function set align(value:String) : void
      {
         _format.align = value;
         callLater(changeText);
      }
      
      public function get bold() : Object
      {
         return _format.bold;
      }
      
      public function set bold(value:Object) : void
      {
         _format.bold = value;
         callLater(changeText);
      }
      
      public function get leading() : Object
      {
         return _format.leading;
      }
      
      public function set leading(value:Object) : void
      {
         _format.leading = value;
         callLater(changeText);
      }
      
      public function get indent() : Object
      {
         return _format.indent;
      }
      
      public function set indent(value:Object) : void
      {
         _format.indent = value;
         callLater(changeText);
      }
      
      public function get size() : Object
      {
         return _format.size;
      }
      
      public function set size(value:Object) : void
      {
         _format.size = value;
         callLater(changeText);
      }
      
      public function get underline() : Object
      {
         return _format.underline;
      }
      
      public function set underline(value:Object) : void
      {
         _format.underline = value;
         callLater(changeText);
      }
      
      public function get letterSpacing() : Object
      {
         return _format.letterSpacing;
      }
      
      public function set letterSpacing(value:Object) : void
      {
         _format.letterSpacing = value;
         callLater(changeText);
      }
      
      public function get margin() : String
      {
         return _margin.join(",");
      }
      
      public function set margin(value:String) : void
      {
         _margin = StringUtils.fillArray(_margin,value,int);
         _textField.x = _margin[0];
         _textField.y = _margin[1];
         callLater(changeSize);
      }
      
      public function get embedFonts() : Boolean
      {
         return _textField.embedFonts;
      }
      
      public function set embedFonts(value:Boolean) : void
      {
         _textField.embedFonts = value;
      }
      
      public function get format() : TextFormat
      {
         return _format;
      }
      
      public function set format(value:TextFormat) : void
      {
         _format = value;
         callLater(changeText);
      }
      
      public function get textField() : TextField
      {
         return _textField;
      }
      
      public function appendText(newText:String) : void
      {
         text = text + newText;
      }
      
      public function get skin() : String
      {
         return _skin;
      }
      
      public function set skin(value:String) : void
      {
         if(_skin != value)
         {
            _skin = value;
            _bitmap.bitmapData = App.asset.getBitmapData(_skin);
            if(_bitmap.bitmapData)
            {
               _contentWidth = _bitmap.bitmapData.width;
               _contentHeight = _bitmap.bitmapData.height;
            }
         }
      }
      
      public function get sizeGrid() : String
      {
         return _bitmap.sizeGrid.join(",");
      }
      
      public function set sizeGrid(value:String) : void
      {
         _bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid,value,int);
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(changeText);
         exeCallLater(changeSize);
      }
      
      override public function get width() : Number
      {
         if(!isNaN(_width) || _skin || _text)
         {
            return super.width;
         }
         return 0;
      }
      
      override public function set width(value:Number) : void
      {
         .super.width = value;
         _bitmap.width = value;
      }
      
      override public function get height() : Number
      {
         if(!isNaN(_height) || _skin || _text)
         {
            return super.height;
         }
         return 0;
      }
      
      override public function set height(value:Number) : void
      {
         .super.height = value;
         _bitmap.height = value;
      }
      
      override public function set dataSource(value:Object) : void
      {
         _dataSource = value;
         if(value is Number || value is String)
         {
            text = String(value);
         }
         else
         {
            .super.dataSource = value;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         _bitmap && _bitmap.dispose();
         _textField = null;
         _format = null;
         _bitmap = null;
         _margin = null;
      }
   }
}
