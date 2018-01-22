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
      
      public function Label(param1:String = "", param2:String = null)
      {
         this._margin = Styles.labelMargin;
         super();
         this.text = param1;
         this.skin = param2;
      }
      
      override protected function preinitialize() : void
      {
         mouseEnabled = false;
      }
      
      override protected function createChildren() : void
      {
         addChild(this._bitmap = new AutoBitmap());
         addChild(this._textField = new TextField());
      }
      
      override protected function initialize() : void
      {
         this._format = this._textField.defaultTextFormat;
         this._format.font = Styles.fontName;
         this._format.size = Styles.fontSize;
         this._format.color = Styles.labelColor;
         this._textField.selectable = false;
         this._textField.autoSize = TextFieldAutoSize.LEFT;
         this._textField.embedFonts = Styles.embedFonts;
         this._bitmap.sizeGrid = Styles.defaultSizeGrid;
      }
      
      public function get text() : String
      {
         return this._text;
      }
      
      public function set text(param1:String) : void
      {
         if(this._text != param1)
         {
            this._text = param1 || "";
            this._text = this._text.replace(/\\n/g,"\n");
            this.changeText();
            sendEvent(Event.CHANGE);
         }
      }
      
      public function get htmlText() : String
      {
         return this._text;
      }
      
      public function set htmlText(param1:String) : void
      {
         this._isHtml = true;
         this.text = param1;
      }
      
      protected function changeText() : void
      {
         this._textField.defaultTextFormat = this._format;
         if(this._isHtml)
         {
            this._textField.htmlText = App.lang.getLang(this._text);
         }
         else
         {
            this._textField.text = App.lang.getLang(this._text);
         }
         if(_layOutEabled)
         {
            callLater(resetPosition);
         }
      }
      
      override protected function changeSize() : void
      {
         if(!isNaN(_width))
         {
            this._textField.autoSize = TextFieldAutoSize.NONE;
            this._textField.width = _width - this._margin[0] - this._margin[2];
            if(isNaN(_height) && this.wordWrap)
            {
               this._textField.autoSize = TextFieldAutoSize.LEFT;
            }
            else
            {
               _height = !!isNaN(_height)?18:Number(_height);
               this._textField.height = _height - this._margin[1] - this._margin[3];
            }
         }
         else
         {
            _width = _height = NaN;
            this._textField.autoSize = TextFieldAutoSize.LEFT;
         }
         super.changeSize();
      }
      
      public function get isHtml() : Boolean
      {
         return this._isHtml;
      }
      
      public function set isHtml(param1:Boolean) : void
      {
         if(this._isHtml != param1)
         {
            this._isHtml = param1;
            callLater(this.changeText);
         }
      }
      
      public function get stroke() : String
      {
         return this._stroke;
      }
      
      public function set stroke(param1:String) : void
      {
         var _loc2_:Array = null;
         if(this._stroke != param1)
         {
            this._stroke = param1;
            ObjectUtils.clearFilter(this._textField,GlowFilter);
            if(Boolean(this._stroke))
            {
               _loc2_ = StringUtils.fillArray(Styles.labelStroke,this._stroke);
               ObjectUtils.addFilter(this._textField,new GlowFilter(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3],_loc2_[4],_loc2_[5]));
            }
         }
      }
      
      public function get gradientColor() : String
      {
         return this._gradientColor.join(",");
      }
      
      public function set gradientColor(param1:String) : void
      {
         this._gradientColor = param1.split(",");
         this.updateGradient();
      }
      
      public function get gradientStroke() : String
      {
         return this._gradientStroke;
      }
      
      public function set gradientStroke(param1:String) : void
      {
         var _loc2_:Array = null;
         if(!this._gradientColor)
         {
            return;
         }
         if(this._gradientStroke != param1)
         {
            this._gradientStroke = param1;
            this.updateGradient();
            ObjectUtils.clearFilter(this._gradientSp,GlowFilter);
            if(Boolean(this._gradientStroke))
            {
               _loc2_ = StringUtils.fillArray(Styles.labelStroke,this._gradientStroke);
               ObjectUtils.addFilter(this._gradientSp,new GlowFilter(_loc2_[0],_loc2_[1],_loc2_[2],_loc2_[3],_loc2_[4],_loc2_[5]));
            }
         }
      }
      
      public function updateGradient() : void
      {
         if(this._gradientSp)
         {
            if(this._gradientSp.parent)
            {
               this._gradientSp.parent.removeChild(this._gradientSp);
            }
            this._gradientSp = null;
         }
         this._gradientSp = new Shape();
         addChild(this._gradientSp);
         var _loc1_:Matrix = new Matrix();
         var _loc2_:Rectangle = new Rectangle(0,0,this.width,this.height);
         _loc1_.createGradientBox(_loc2_.width,_loc2_.height,Math.PI / 2,0,0);
         this._gradientSp.graphics.beginGradientFill(GradientType.LINEAR,[this._gradientColor[0],this._gradientColor[1]],[1,1],[0,255],_loc1_);
         this._gradientSp.graphics.drawRect(0,0,_loc2_.width,_loc2_.height);
         this._gradientSp.graphics.endFill();
         this._gradientSp.cacheAsBitmap = true;
         this.textField.cacheAsBitmap = true;
         this._gradientSp.mask = this.textField;
      }
      
      public function get multiline() : Boolean
      {
         return this._textField.multiline;
      }
      
      public function set multiline(param1:Boolean) : void
      {
         this._textField.multiline = param1;
      }
      
      public function get asPassword() : Boolean
      {
         return this._textField.displayAsPassword;
      }
      
      public function set asPassword(param1:Boolean) : void
      {
         this._textField.displayAsPassword = param1;
      }
      
      public function get autoSize() : String
      {
         return this._textField.autoSize;
      }
      
      public function set autoSize(param1:String) : void
      {
         this._textField.autoSize = param1;
      }
      
      public function get wordWrap() : Boolean
      {
         return this._textField.wordWrap;
      }
      
      public function set wordWrap(param1:Boolean) : void
      {
         this._textField.wordWrap = param1;
      }
      
      public function get selectable() : Boolean
      {
         return this._textField.selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this._textField.selectable = param1;
         mouseEnabled = param1;
      }
      
      public function get background() : Boolean
      {
         return this._textField.background;
      }
      
      public function set background(param1:Boolean) : void
      {
         this._textField.background = param1;
      }
      
      public function get backgroundColor() : uint
      {
         return this._textField.backgroundColor;
      }
      
      public function set backgroundColor(param1:uint) : void
      {
         this._textField.backgroundColor = param1;
      }
      
      public function get color() : Object
      {
         return this._format.color;
      }
      
      public function set color(param1:Object) : void
      {
         this._format.color = param1;
         callLater(this.changeText);
      }
      
      public function get font() : String
      {
         return this._format.font;
      }
      
      public function set font(param1:String) : void
      {
         this._format.font = param1;
         callLater(this.changeText);
      }
      
      public function get align() : String
      {
         return this._format.align;
      }
      
      public function set align(param1:String) : void
      {
         this._format.align = param1;
         callLater(this.changeText);
      }
      
      public function get bold() : Object
      {
         return this._format.bold;
      }
      
      public function set bold(param1:Object) : void
      {
         this._format.bold = param1;
         callLater(this.changeText);
      }
      
      public function get leading() : Object
      {
         return this._format.leading;
      }
      
      public function set leading(param1:Object) : void
      {
         this._format.leading = param1;
         callLater(this.changeText);
      }
      
      public function get indent() : Object
      {
         return this._format.indent;
      }
      
      public function set indent(param1:Object) : void
      {
         this._format.indent = param1;
         callLater(this.changeText);
      }
      
      public function get size() : Object
      {
         return this._format.size;
      }
      
      public function set size(param1:Object) : void
      {
         this._format.size = param1;
         callLater(this.changeText);
      }
      
      public function get underline() : Object
      {
         return this._format.underline;
      }
      
      public function set underline(param1:Object) : void
      {
         this._format.underline = param1;
         callLater(this.changeText);
      }
      
      public function get letterSpacing() : Object
      {
         return this._format.letterSpacing;
      }
      
      public function set letterSpacing(param1:Object) : void
      {
         this._format.letterSpacing = param1;
         callLater(this.changeText);
      }
      
      public function get margin() : String
      {
         return this._margin.join(",");
      }
      
      public function set margin(param1:String) : void
      {
         this._margin = StringUtils.fillArray(this._margin,param1,int);
         this._textField.x = this._margin[0];
         this._textField.y = this._margin[1];
         callLater(this.changeSize);
      }
      
      public function get embedFonts() : Boolean
      {
         return this._textField.embedFonts;
      }
      
      public function set embedFonts(param1:Boolean) : void
      {
         this._textField.embedFonts = param1;
      }
      
      public function get format() : TextFormat
      {
         return this._format;
      }
      
      public function set format(param1:TextFormat) : void
      {
         this._format = param1;
         callLater(this.changeText);
      }
      
      public function get textField() : TextField
      {
         return this._textField;
      }
      
      public function appendText(param1:String) : void
      {
         this.text = this.text + param1;
      }
      
      public function get skin() : String
      {
         return this._skin;
      }
      
      public function set skin(param1:String) : void
      {
         if(this._skin != param1)
         {
            this._skin = param1;
            this._bitmap.bitmapData = App.asset.getBitmapData(this._skin);
            if(this._bitmap.bitmapData)
            {
               _contentWidth = this._bitmap.bitmapData.width;
               _contentHeight = this._bitmap.bitmapData.height;
            }
         }
      }
      
      public function get sizeGrid() : String
      {
         return this._bitmap.sizeGrid.join(",");
      }
      
      public function set sizeGrid(param1:String) : void
      {
         this._bitmap.sizeGrid = StringUtils.fillArray(Styles.defaultSizeGrid,param1,int);
      }
      
      override public function commitMeasure() : void
      {
         exeCallLater(this.changeText);
         exeCallLater(this.changeSize);
      }
      
      override public function get width() : Number
      {
         if(!isNaN(_width) || Boolean(this._skin) || Boolean(this._text))
         {
            return super.width;
         }
         return 0;
      }
      
      override public function set width(param1:Number) : void
      {
         super.width = param1;
         this._bitmap.width = param1;
      }
      
      override public function get height() : Number
      {
         if(!isNaN(_height) || Boolean(this._skin) || Boolean(this._text))
         {
            return super.height;
         }
         return 0;
      }
      
      override public function set height(param1:Number) : void
      {
         super.height = param1;
         this._bitmap.height = param1;
      }
      
      override public function set dataSource(param1:Object) : void
      {
         _dataSource = param1;
         if(param1 is Number || param1 is String)
         {
            this.text = String(param1);
         }
         else
         {
            super.dataSource = param1;
         }
      }
      
      override public function dispose() : void
      {
         super.dispose();
         this._bitmap && this._bitmap.dispose();
         this._textField = null;
         this._format = null;
         this._bitmap = null;
         this._margin = null;
      }
   }
}
