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
      
      public function TextField(width:int, height:int, text:String, fontName:String = "Verdana", fontSize:Number = 12, color:uint = 0, bold:Boolean = false)
      {
         super();
         mText = !!text?text:"";
         mFontSize = fontSize;
         mColor = color;
         mHAlign = "center";
         mVAlign = "center";
         mBorder = null;
         mKerning = true;
         mLeading = 0;
         mBold = bold;
         mAutoSize = "none";
         mHitArea = new Rectangle(0,0,width,height);
         this.fontName = fontName;
         addEventListener("flatten",onFlatten);
      }
      
      public static function get defaultTextureFormat() : String
      {
         return sDefaultTextureFormat;
      }
      
      public static function set defaultTextureFormat(value:String) : void
      {
         sDefaultTextureFormat = value;
      }
      
      public static function registerBitmapFont(bitmapFont:BitmapFont, name:String = null) : String
      {
         if(name == null)
         {
            name = bitmapFont.name;
         }
         bitmapFonts[convertToLowerCase(name)] = bitmapFont;
         return name;
      }
      
      public static function unregisterBitmapFont(name:String, dispose:Boolean = true) : void
      {
         name = convertToLowerCase(name);
         if(dispose && bitmapFonts[name] != undefined)
         {
            bitmapFonts[name].dispose();
         }
      }
      
      public static function getBitmapFont(name:String) : BitmapFont
      {
         return bitmapFonts[convertToLowerCase(name)];
      }
      
      private static function get bitmapFonts() : Dictionary
      {
         var fonts:Dictionary = Starling.current.contextData["starling.display.TextField.BitmapFonts"] as Dictionary;
         if(fonts == null)
         {
            fonts = new Dictionary();
            Starling.current.contextData["starling.display.TextField.BitmapFonts"] = fonts;
         }
         return fonts;
      }
      
      private static function convertToLowerCase(string:String) : String
      {
         var result:String = sStringCache[string];
         if(result == null)
         {
            result = string.toLowerCase();
            sStringCache[string] = result;
         }
         return result;
      }
      
      override public function dispose() : void
      {
         removeEventListener("flatten",onFlatten);
         if(mImage)
         {
            mImage.texture.dispose();
         }
         if(mQuadBatch)
         {
            mQuadBatch.dispose();
         }
         super.dispose();
      }
      
      private function onFlatten() : void
      {
         if(mRequiresRedraw)
         {
            redraw();
         }
      }
      
      override public function render(support:RenderSupport, parentAlpha:Number) : void
      {
         if(mRequiresRedraw)
         {
            redraw();
         }
         super.render(support,parentAlpha);
      }
      
      public function redraw() : void
      {
         if(mRequiresRedraw)
         {
            if(getBitmapFont(mFontName))
            {
               createComposedContents();
            }
            else
            {
               createRenderedContents();
            }
            updateBorder();
            mRequiresRedraw = false;
         }
      }
      
      private function createRenderedContents() : void
      {
         if(mQuadBatch)
         {
            mQuadBatch.removeFromParent(true);
            mQuadBatch = null;
         }
         if(mTextBounds == null)
         {
            mTextBounds = new Rectangle();
         }
         var scale:Number = Starling.contentScaleFactor;
         var bitmapData:BitmapData = renderText(scale,mTextBounds);
         var format:String = sDefaultTextureFormat;
         var maxTextureSize:int = Texture.maxSize;
         var shrinkHelper:Number = 0;
         while(bitmapData.width > maxTextureSize || bitmapData.height > maxTextureSize)
         {
            scale = scale * Math.min((maxTextureSize - shrinkHelper) / bitmapData.width,(maxTextureSize - shrinkHelper) / bitmapData.height);
            bitmapData.dispose();
            bitmapData = renderText(scale,mTextBounds);
            shrinkHelper = shrinkHelper + 1;
         }
         mHitArea.width = bitmapData.width / scale;
         mHitArea.height = bitmapData.height / scale;
         var texture:Texture = Texture.fromBitmapData(bitmapData,false,false,scale,format);
         texture.root.onRestore = function():void
         {
            if(mTextBounds == null)
            {
               mTextBounds = new Rectangle();
            }
            bitmapData = renderText(scale,mTextBounds);
            texture.root.uploadBitmapData(bitmapData);
            bitmapData.dispose();
            bitmapData = null;
         };
         bitmapData.dispose();
         bitmapData = null;
         if(mImage == null)
         {
            mImage = new Image(texture);
            mImage.touchable = false;
            addChild(mImage);
         }
         else
         {
            mImage.texture.dispose();
            mImage.texture = texture;
            mImage.readjustSize();
         }
      }
      
      protected function formatText(textField:flash.text.TextField, textFormat:TextFormat) : void
      {
      }
      
      private function renderText(scale:Number, resultTextBounds:Rectangle) : BitmapData
      {
         var width:* = Number(mHitArea.width * scale);
         var height:* = Number(mHitArea.height * scale);
         var hAlign:String = mHAlign;
         var vAlign:String = mVAlign;
         if(isHorizontalAutoSize)
         {
            width = 2147483647;
            hAlign = "left";
         }
         if(isVerticalAutoSize)
         {
            height = 2147483647;
            vAlign = "top";
         }
         var textFormat:TextFormat = new TextFormat(mFontName,mFontSize * scale,mColor,mBold,mItalic,mUnderline,null,null,hAlign);
         textFormat.kerning = mKerning;
         textFormat.leading = mLeading;
         sNativeTextField.defaultTextFormat = textFormat;
         sNativeTextField.width = width;
         sNativeTextField.height = height;
         sNativeTextField.antiAliasType = "advanced";
         sNativeTextField.selectable = false;
         sNativeTextField.multiline = true;
         sNativeTextField.wordWrap = true;
         if(mIsHtmlText)
         {
            sNativeTextField.htmlText = mText;
         }
         else
         {
            sNativeTextField.text = mText;
         }
         sNativeTextField.embedFonts = true;
         sNativeTextField.filters = mNativeFilters;
         if(sNativeTextField.textWidth == 0 || sNativeTextField.textHeight == 0)
         {
            sNativeTextField.embedFonts = false;
         }
         formatText(sNativeTextField,textFormat);
         if(mAutoScale)
         {
            autoScaleNativeTextField(sNativeTextField);
         }
         var textWidth:Number = sNativeTextField.textWidth;
         var textHeight:Number = sNativeTextField.textHeight;
         if(isHorizontalAutoSize)
         {
            width = Number(Math.ceil(textWidth + 5));
            sNativeTextField.width = Math.ceil(textWidth + 5);
         }
         if(isVerticalAutoSize)
         {
            height = Number(Math.ceil(textHeight + 4));
            sNativeTextField.height = Math.ceil(textHeight + 4);
         }
         if(width < 1)
         {
            width = 1;
         }
         if(height < 1)
         {
            height = 1;
         }
         var textOffsetX:* = 0;
         if(hAlign == "left")
         {
            textOffsetX = 2;
         }
         else if(hAlign == "center")
         {
            textOffsetX = Number((width - textWidth) / 2);
         }
         else if(hAlign == "right")
         {
            textOffsetX = Number(width - textWidth - 2);
         }
         var textOffsetY:* = 0;
         if(vAlign == "top")
         {
            textOffsetY = 2;
         }
         else if(vAlign == "center")
         {
            textOffsetY = Number((height - textHeight) / 2);
         }
         else if(vAlign == "bottom")
         {
            textOffsetY = Number(height - textHeight - 2);
         }
         var filterOffset:Point = calculateFilterOffset(sNativeTextField,hAlign,vAlign);
         var bitmapData:BitmapData = new BitmapData(width,height,true,0);
         var drawMatrix:Matrix = new Matrix(1,0,0,1,filterOffset.x,filterOffset.y + int(textOffsetY) - 2);
         var drawWithQualityFunc:Function = "drawWithQuality" in bitmapData?bitmapData["drawWithQuality"]:null;
         if(drawWithQualityFunc is Function)
         {
            drawWithQualityFunc.call(bitmapData,sNativeTextField,drawMatrix,null,null,null,false,"medium");
         }
         else
         {
            bitmapData.draw(sNativeTextField,drawMatrix);
         }
         sNativeTextField.text = "";
         resultTextBounds.setTo((textOffsetX + filterOffset.x) / scale,(textOffsetY + filterOffset.y) / scale,textWidth / scale,textHeight / scale);
         return bitmapData;
      }
      
      private function autoScaleNativeTextField(textField:flash.text.TextField) : void
      {
         var format:* = null;
         var size:Number = textField.defaultTextFormat.size;
         var maxHeight:int = textField.height - 4;
         var maxWidth:int = textField.width - 4;
         while(textField.textWidth > maxWidth || textField.textHeight > maxHeight)
         {
            if(size > 4)
            {
               format = textField.defaultTextFormat;
               size--;
               format.size = size;
               textField.defaultTextFormat = format;
               if(mIsHtmlText)
               {
                  textField.htmlText = mText;
               }
               else
               {
                  textField.text = mText;
               }
               continue;
            }
            break;
         }
      }
      
      private function calculateFilterOffset(textField:flash.text.TextField, hAlign:String, vAlign:String) : Point
      {
         var textWidth:Number = NaN;
         var textHeight:Number = NaN;
         var bounds:* = null;
         var blurX:Number = NaN;
         var blurY:Number = NaN;
         var angleDeg:Number = NaN;
         var distance:Number = NaN;
         var angle:Number = NaN;
         var marginX:Number = NaN;
         var marginY:Number = NaN;
         var offsetX:Number = NaN;
         var offsetY:Number = NaN;
         var filterBounds:* = null;
         var resultOffset:Point = new Point();
         var filters:Array = textField.filters;
         if(filters != null && filters.length > 0)
         {
            textWidth = textField.textWidth;
            textHeight = textField.textHeight;
            bounds = new Rectangle();
            var _loc21_:int = 0;
            var _loc20_:* = filters;
            for each(var filter in filters)
            {
               blurX = "blurX" in filter?filter["blurX"]:0;
               blurY = "blurY" in filter?filter["blurY"]:0;
               angleDeg = "angle" in filter?filter["angle"]:0;
               distance = "distance" in filter?filter["distance"]:0;
               angle = deg2rad(angleDeg);
               marginX = blurX * 1.33;
               marginY = blurY * 1.33;
               offsetX = Math.cos(angle) * distance - marginX / 2;
               offsetY = Math.sin(angle) * distance - marginY / 2;
               filterBounds = new Rectangle(offsetX,offsetY,textWidth + marginX,textHeight + marginY);
               bounds = bounds.union(filterBounds);
            }
            if(hAlign == "left" && bounds.x < 0)
            {
               resultOffset.x = -bounds.x;
            }
            else if(hAlign == "right" && bounds.y > 0)
            {
               resultOffset.x = -(bounds.right - textWidth);
            }
            if(vAlign == "top" && bounds.y < 0)
            {
               resultOffset.y = -bounds.y;
            }
            else if(vAlign == "bottom" && bounds.y > 0)
            {
               resultOffset.y = -(bounds.bottom - textHeight);
            }
         }
         return resultOffset;
      }
      
      private function createComposedContents() : void
      {
         if(mImage)
         {
            mImage.removeFromParent(true);
            mImage.texture.dispose();
            mImage = null;
         }
         if(mQuadBatch == null)
         {
            mQuadBatch = new QuadBatch();
            mQuadBatch.touchable = false;
            addChild(mQuadBatch);
         }
         else
         {
            mQuadBatch.reset();
         }
         var bitmapFont:BitmapFont = getBitmapFont(mFontName);
         if(bitmapFont == null)
         {
            throw new Error("Bitmap font not registered: " + mFontName);
         }
         var width:* = Number(mHitArea.width);
         var height:* = Number(mHitArea.height);
         var hAlign:String = mHAlign;
         var vAlign:String = mVAlign;
         if(isHorizontalAutoSize)
         {
            width = 2147483647;
            hAlign = "left";
         }
         if(isVerticalAutoSize)
         {
            height = 2147483647;
            vAlign = "top";
         }
         bitmapFont.fillQuadBatch(mQuadBatch,width,height,mText,mFontSize,mColor,hAlign,vAlign,mAutoScale,mKerning,mLeading);
         mQuadBatch.batchable = mBatchable;
         if(mAutoSize != "none")
         {
            mTextBounds = mQuadBatch.getBounds(mQuadBatch,mTextBounds);
            if(isHorizontalAutoSize)
            {
               mHitArea.width = mTextBounds.x + mTextBounds.width;
            }
            if(isVerticalAutoSize)
            {
               mHitArea.height = mTextBounds.y + mTextBounds.height;
            }
         }
         else
         {
            mTextBounds = null;
         }
      }
      
      private function updateBorder() : void
      {
         if(mBorder == null)
         {
            return;
         }
         var width:Number = mHitArea.width;
         var height:Number = mHitArea.height;
         var topLine:Quad = mBorder.getChildAt(0) as Quad;
         var rightLine:Quad = mBorder.getChildAt(1) as Quad;
         var bottomLine:Quad = mBorder.getChildAt(2) as Quad;
         var leftLine:Quad = mBorder.getChildAt(3) as Quad;
         topLine.width = width;
         topLine.height = 1;
         bottomLine.width = width;
         bottomLine.height = 1;
         leftLine.width = 1;
         leftLine.height = height;
         rightLine.width = 1;
         rightLine.height = height;
         rightLine.x = width - 1;
         bottomLine.y = height - 1;
         var _loc7_:* = mColor;
         leftLine.color = _loc7_;
         _loc7_ = _loc7_;
         bottomLine.color = _loc7_;
         _loc7_ = _loc7_;
         rightLine.color = _loc7_;
         topLine.color = _loc7_;
      }
      
      private function get isHorizontalAutoSize() : Boolean
      {
         return mAutoSize == "horizontal" || mAutoSize == "bothDirections";
      }
      
      private function get isVerticalAutoSize() : Boolean
      {
         return mAutoSize == "vertical" || mAutoSize == "bothDirections";
      }
      
      public function get textBounds() : Rectangle
      {
         if(mRequiresRedraw)
         {
            redraw();
         }
         if(mTextBounds == null)
         {
            mTextBounds = mQuadBatch.getBounds(mQuadBatch);
         }
         return mTextBounds.clone();
      }
      
      override public function getBounds(targetSpace:DisplayObject, resultRect:Rectangle = null) : Rectangle
      {
         if(mRequiresRedraw)
         {
            redraw();
         }
         getTransformationMatrix(targetSpace,sHelperMatrix);
         return RectangleUtil.getBounds(mHitArea,sHelperMatrix,resultRect);
      }
      
      override public function hitTest(localPoint:Point, forTouch:Boolean = false) : DisplayObject
      {
         if(forTouch && (!visible || !touchable))
         {
            return null;
         }
         if(mHitArea.containsPoint(localPoint) && hitTestMask(localPoint))
         {
            return this;
         }
         return null;
      }
      
      override public function set width(value:Number) : void
      {
         mHitArea.width = value;
         mRequiresRedraw = true;
      }
      
      override public function set height(value:Number) : void
      {
         mHitArea.height = value;
         mRequiresRedraw = true;
      }
      
      public function get text() : String
      {
         return mText;
      }
      
      public function set text(value:String) : void
      {
         if(value == null)
         {
            value = "";
         }
         if(mText != value)
         {
            mText = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get fontName() : String
      {
         return mFontName;
      }
      
      public function set fontName(value:String) : void
      {
         if(mFontName != value)
         {
            if(value == "mini" && bitmapFonts[value] == undefined)
            {
               registerBitmapFont(new BitmapFont());
            }
            mFontName = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get fontSize() : Number
      {
         return mFontSize;
      }
      
      public function set fontSize(value:Number) : void
      {
         if(mFontSize != value)
         {
            mFontSize = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get color() : uint
      {
         return mColor;
      }
      
      public function set color(value:uint) : void
      {
         if(mColor != value)
         {
            mColor = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get hAlign() : String
      {
         return mHAlign;
      }
      
      public function set hAlign(value:String) : void
      {
         if(!HAlign.isValid(value))
         {
            throw new ArgumentError("Invalid horizontal align: " + value);
         }
         if(mHAlign != value)
         {
            mHAlign = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get vAlign() : String
      {
         return mVAlign;
      }
      
      public function set vAlign(value:String) : void
      {
         if(!VAlign.isValid(value))
         {
            throw new ArgumentError("Invalid vertical align: " + value);
         }
         if(mVAlign != value)
         {
            mVAlign = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get border() : Boolean
      {
         return mBorder != null;
      }
      
      public function set border(value:Boolean) : void
      {
         var i:int = 0;
         if(value && mBorder == null)
         {
            mBorder = new Sprite();
            addChild(mBorder);
            for(i = 0; i < 4; )
            {
               mBorder.addChild(new Quad(1,1));
               i++;
            }
            updateBorder();
         }
         else if(!value && mBorder != null)
         {
            mBorder.removeFromParent(true);
            mBorder = null;
         }
      }
      
      public function get bold() : Boolean
      {
         return mBold;
      }
      
      public function set bold(value:Boolean) : void
      {
         if(mBold != value)
         {
            mBold = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get italic() : Boolean
      {
         return mItalic;
      }
      
      public function set italic(value:Boolean) : void
      {
         if(mItalic != value)
         {
            mItalic = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get underline() : Boolean
      {
         return mUnderline;
      }
      
      public function set underline(value:Boolean) : void
      {
         if(mUnderline != value)
         {
            mUnderline = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get kerning() : Boolean
      {
         return mKerning;
      }
      
      public function set kerning(value:Boolean) : void
      {
         if(mKerning != value)
         {
            mKerning = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get autoScale() : Boolean
      {
         return mAutoScale;
      }
      
      public function set autoScale(value:Boolean) : void
      {
         if(mAutoScale != value)
         {
            mAutoScale = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get autoSize() : String
      {
         return mAutoSize;
      }
      
      public function set autoSize(value:String) : void
      {
         if(mAutoSize != value)
         {
            mAutoSize = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get batchable() : Boolean
      {
         return mBatchable;
      }
      
      public function set batchable(value:Boolean) : void
      {
         mBatchable = value;
         if(mQuadBatch)
         {
            mQuadBatch.batchable = value;
         }
      }
      
      public function get nativeFilters() : Array
      {
         return mNativeFilters;
      }
      
      public function set nativeFilters(value:Array) : void
      {
         mNativeFilters = value.concat();
         mRequiresRedraw = true;
      }
      
      public function get isHtmlText() : Boolean
      {
         return mIsHtmlText;
      }
      
      public function set isHtmlText(value:Boolean) : void
      {
         if(mIsHtmlText != value)
         {
            mIsHtmlText = value;
            mRequiresRedraw = true;
         }
      }
      
      public function get leading() : Number
      {
         return mLeading;
      }
      
      public function set leading(value:Number) : void
      {
         if(mLeading != value)
         {
            mLeading = value;
            mRequiresRedraw = true;
         }
      }
   }
}
