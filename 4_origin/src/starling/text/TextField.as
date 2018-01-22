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
      
      public function TextField(param1:int, param2:int, param3:String, param4:String = "Verdana", param5:Number = 12, param6:uint = 0, param7:Boolean = false)
      {
         super();
         mText = !!param3?param3:"";
         mFontSize = param5;
         mColor = param6;
         mHAlign = "center";
         mVAlign = "center";
         mBorder = null;
         mKerning = true;
         mLeading = 0;
         mBold = param7;
         mAutoSize = "none";
         mHitArea = new Rectangle(0,0,param1,param2);
         this.fontName = param4;
         addEventListener("flatten",onFlatten);
      }
      
      public static function get defaultTextureFormat() : String
      {
         return sDefaultTextureFormat;
      }
      
      public static function set defaultTextureFormat(param1:String) : void
      {
         sDefaultTextureFormat = param1;
      }
      
      public static function registerBitmapFont(param1:BitmapFont, param2:String = null) : String
      {
         if(param2 == null)
         {
            param2 = param1.name;
         }
         bitmapFonts[convertToLowerCase(param2)] = param1;
         return param2;
      }
      
      public static function unregisterBitmapFont(param1:String, param2:Boolean = true) : void
      {
         param1 = convertToLowerCase(param1);
         if(param2 && bitmapFonts[param1] != undefined)
         {
            bitmapFonts[param1].dispose();
         }
      }
      
      public static function getBitmapFont(param1:String) : BitmapFont
      {
         return bitmapFonts[convertToLowerCase(param1)];
      }
      
      private static function get bitmapFonts() : Dictionary
      {
         var _loc1_:Dictionary = Starling.current.contextData["starling.display.TextField.BitmapFonts"] as Dictionary;
         if(_loc1_ == null)
         {
            _loc1_ = new Dictionary();
            Starling.current.contextData["starling.display.TextField.BitmapFonts"] = _loc1_;
         }
         return _loc1_;
      }
      
      private static function convertToLowerCase(param1:String) : String
      {
         var _loc2_:String = sStringCache[param1];
         if(_loc2_ == null)
         {
            _loc2_ = param1.toLowerCase();
            sStringCache[param1] = _loc2_;
         }
         return _loc2_;
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
      
      override public function render(param1:RenderSupport, param2:Number) : void
      {
         if(mRequiresRedraw)
         {
            redraw();
         }
         super.render(param1,param2);
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
      
      protected function formatText(param1:flash.text.TextField, param2:TextFormat) : void
      {
      }
      
      private function renderText(param1:Number, param2:Rectangle) : BitmapData
      {
         var _loc5_:* = Number(mHitArea.width * param1);
         var _loc11_:* = Number(mHitArea.height * param1);
         var _loc6_:String = mHAlign;
         var _loc4_:String = mVAlign;
         if(isHorizontalAutoSize)
         {
            _loc5_ = 2147483647;
            _loc6_ = "left";
         }
         if(isVerticalAutoSize)
         {
            _loc11_ = 2147483647;
            _loc4_ = "top";
         }
         var _loc12_:TextFormat = new TextFormat(mFontName,mFontSize * param1,mColor,mBold,mItalic,mUnderline,null,null,_loc6_);
         _loc12_.kerning = mKerning;
         _loc12_.leading = mLeading;
         sNativeTextField.defaultTextFormat = _loc12_;
         sNativeTextField.width = _loc5_;
         sNativeTextField.height = _loc11_;
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
         formatText(sNativeTextField,_loc12_);
         if(mAutoScale)
         {
            autoScaleNativeTextField(sNativeTextField);
         }
         var _loc10_:Number = sNativeTextField.textWidth;
         var _loc3_:Number = sNativeTextField.textHeight;
         if(isHorizontalAutoSize)
         {
            _loc5_ = Number(Math.ceil(_loc10_ + 5));
            sNativeTextField.width = Math.ceil(_loc10_ + 5);
         }
         if(isVerticalAutoSize)
         {
            _loc11_ = Number(Math.ceil(_loc3_ + 4));
            sNativeTextField.height = Math.ceil(_loc3_ + 4);
         }
         if(_loc5_ < 1)
         {
            _loc5_ = 1;
         }
         if(_loc11_ < 1)
         {
            _loc11_ = 1;
         }
         var _loc7_:* = 0;
         if(_loc6_ == "left")
         {
            _loc7_ = 2;
         }
         else if(_loc6_ == "center")
         {
            _loc7_ = Number((_loc5_ - _loc10_) / 2);
         }
         else if(_loc6_ == "right")
         {
            _loc7_ = Number(_loc5_ - _loc10_ - 2);
         }
         var _loc8_:* = 0;
         if(_loc4_ == "top")
         {
            _loc8_ = 2;
         }
         else if(_loc4_ == "center")
         {
            _loc8_ = Number((_loc11_ - _loc3_) / 2);
         }
         else if(_loc4_ == "bottom")
         {
            _loc8_ = Number(_loc11_ - _loc3_ - 2);
         }
         var _loc15_:Point = calculateFilterOffset(sNativeTextField,_loc6_,_loc4_);
         var _loc13_:BitmapData = new BitmapData(_loc5_,_loc11_,true,0);
         var _loc14_:Matrix = new Matrix(1,0,0,1,_loc15_.x,_loc15_.y + int(_loc8_) - 2);
         var _loc9_:Function = "drawWithQuality" in _loc13_?_loc13_["drawWithQuality"]:null;
         if(_loc9_ is Function)
         {
            _loc9_.call(_loc13_,sNativeTextField,_loc14_,null,null,null,false,"medium");
         }
         else
         {
            _loc13_.draw(sNativeTextField,_loc14_);
         }
         sNativeTextField.text = "";
         param2.setTo((_loc7_ + _loc15_.x) / param1,(_loc8_ + _loc15_.y) / param1,_loc10_ / param1,_loc3_ / param1);
         return _loc13_;
      }
      
      private function autoScaleNativeTextField(param1:flash.text.TextField) : void
      {
         var _loc4_:* = null;
         var _loc5_:Number = param1.defaultTextFormat.size;
         var _loc3_:int = param1.height - 4;
         var _loc2_:int = param1.width - 4;
         while(param1.textWidth > _loc2_ || param1.textHeight > _loc3_)
         {
            if(_loc5_ > 4)
            {
               _loc4_ = param1.defaultTextFormat;
               _loc5_--;
               _loc4_.size = _loc5_;
               param1.defaultTextFormat = _loc4_;
               if(mIsHtmlText)
               {
                  param1.htmlText = mText;
               }
               else
               {
                  param1.text = mText;
               }
               continue;
            }
            break;
         }
      }
      
      private function calculateFilterOffset(param1:flash.text.TextField, param2:String, param3:String) : Point
      {
         var _loc9_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc11_:* = null;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc15_:* = null;
         var _loc12_:Point = new Point();
         var _loc17_:Array = param1.filters;
         if(_loc17_ != null && _loc17_.length > 0)
         {
            _loc9_ = param1.textWidth;
            _loc4_ = param1.textHeight;
            _loc11_ = new Rectangle();
            var _loc21_:int = 0;
            var _loc20_:* = _loc17_;
            for each(var _loc18_ in _loc17_)
            {
               _loc5_ = "blurX" in _loc18_?_loc18_["blurX"]:0;
               _loc6_ = "blurY" in _loc18_?_loc18_["blurY"]:0;
               _loc14_ = "angle" in _loc18_?_loc18_["angle"]:0;
               _loc13_ = "distance" in _loc18_?_loc18_["distance"]:0;
               _loc10_ = deg2rad(_loc14_);
               _loc19_ = _loc5_ * 1.33;
               _loc16_ = _loc6_ * 1.33;
               _loc8_ = Math.cos(_loc10_) * _loc13_ - _loc19_ / 2;
               _loc7_ = Math.sin(_loc10_) * _loc13_ - _loc16_ / 2;
               _loc15_ = new Rectangle(_loc8_,_loc7_,_loc9_ + _loc19_,_loc4_ + _loc16_);
               _loc11_ = _loc11_.union(_loc15_);
            }
            if(param2 == "left" && _loc11_.x < 0)
            {
               _loc12_.x = -_loc11_.x;
            }
            else if(param2 == "right" && _loc11_.y > 0)
            {
               _loc12_.x = -(_loc11_.right - _loc9_);
            }
            if(param3 == "top" && _loc11_.y < 0)
            {
               _loc12_.y = -_loc11_.y;
            }
            else if(param3 == "bottom" && _loc11_.y > 0)
            {
               _loc12_.y = -(_loc11_.bottom - _loc4_);
            }
         }
         return _loc12_;
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
         var _loc5_:BitmapFont = getBitmapFont(mFontName);
         if(_loc5_ == null)
         {
            throw new Error("Bitmap font not registered: " + mFontName);
         }
         var _loc4_:* = Number(mHitArea.width);
         var _loc1_:* = Number(mHitArea.height);
         var _loc3_:String = mHAlign;
         var _loc2_:String = mVAlign;
         if(isHorizontalAutoSize)
         {
            _loc4_ = 2147483647;
            _loc3_ = "left";
         }
         if(isVerticalAutoSize)
         {
            _loc1_ = 2147483647;
            _loc2_ = "top";
         }
         _loc5_.fillQuadBatch(mQuadBatch,_loc4_,_loc1_,mText,mFontSize,mColor,_loc3_,_loc2_,mAutoScale,mKerning,mLeading);
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
         var _loc3_:Number = mHitArea.width;
         var _loc2_:Number = mHitArea.height;
         var _loc1_:Quad = mBorder.getChildAt(0) as Quad;
         var _loc6_:Quad = mBorder.getChildAt(1) as Quad;
         var _loc4_:Quad = mBorder.getChildAt(2) as Quad;
         var _loc5_:Quad = mBorder.getChildAt(3) as Quad;
         _loc1_.width = _loc3_;
         _loc1_.height = 1;
         _loc4_.width = _loc3_;
         _loc4_.height = 1;
         _loc5_.width = 1;
         _loc5_.height = _loc2_;
         _loc6_.width = 1;
         _loc6_.height = _loc2_;
         _loc6_.x = _loc3_ - 1;
         _loc4_.y = _loc2_ - 1;
         var _loc7_:* = mColor;
         _loc5_.color = _loc7_;
         _loc7_ = _loc7_;
         _loc4_.color = _loc7_;
         _loc7_ = _loc7_;
         _loc6_.color = _loc7_;
         _loc1_.color = _loc7_;
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
      
      override public function getBounds(param1:DisplayObject, param2:Rectangle = null) : Rectangle
      {
         if(mRequiresRedraw)
         {
            redraw();
         }
         getTransformationMatrix(param1,sHelperMatrix);
         return RectangleUtil.getBounds(mHitArea,sHelperMatrix,param2);
      }
      
      override public function hitTest(param1:Point, param2:Boolean = false) : DisplayObject
      {
         if(param2 && (!visible || !touchable))
         {
            return null;
         }
         if(mHitArea.containsPoint(param1) && hitTestMask(param1))
         {
            return this;
         }
         return null;
      }
      
      override public function set width(param1:Number) : void
      {
         mHitArea.width = param1;
         mRequiresRedraw = true;
      }
      
      override public function set height(param1:Number) : void
      {
         mHitArea.height = param1;
         mRequiresRedraw = true;
      }
      
      public function get text() : String
      {
         return mText;
      }
      
      public function set text(param1:String) : void
      {
         if(param1 == null)
         {
            param1 = "";
         }
         if(mText != param1)
         {
            mText = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get fontName() : String
      {
         return mFontName;
      }
      
      public function set fontName(param1:String) : void
      {
         if(mFontName != param1)
         {
            if(param1 == "mini" && bitmapFonts[param1] == undefined)
            {
               registerBitmapFont(new BitmapFont());
            }
            mFontName = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get fontSize() : Number
      {
         return mFontSize;
      }
      
      public function set fontSize(param1:Number) : void
      {
         if(mFontSize != param1)
         {
            mFontSize = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get color() : uint
      {
         return mColor;
      }
      
      public function set color(param1:uint) : void
      {
         if(mColor != param1)
         {
            mColor = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get hAlign() : String
      {
         return mHAlign;
      }
      
      public function set hAlign(param1:String) : void
      {
         if(!HAlign.isValid(param1))
         {
            throw new ArgumentError("Invalid horizontal align: " + param1);
         }
         if(mHAlign != param1)
         {
            mHAlign = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get vAlign() : String
      {
         return mVAlign;
      }
      
      public function set vAlign(param1:String) : void
      {
         if(!VAlign.isValid(param1))
         {
            throw new ArgumentError("Invalid vertical align: " + param1);
         }
         if(mVAlign != param1)
         {
            mVAlign = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get border() : Boolean
      {
         return mBorder != null;
      }
      
      public function set border(param1:Boolean) : void
      {
         var _loc2_:int = 0;
         if(param1 && mBorder == null)
         {
            mBorder = new Sprite();
            addChild(mBorder);
            _loc2_ = 0;
            while(_loc2_ < 4)
            {
               mBorder.addChild(new Quad(1,1));
               _loc2_++;
            }
            updateBorder();
         }
         else if(!param1 && mBorder != null)
         {
            mBorder.removeFromParent(true);
            mBorder = null;
         }
      }
      
      public function get bold() : Boolean
      {
         return mBold;
      }
      
      public function set bold(param1:Boolean) : void
      {
         if(mBold != param1)
         {
            mBold = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get italic() : Boolean
      {
         return mItalic;
      }
      
      public function set italic(param1:Boolean) : void
      {
         if(mItalic != param1)
         {
            mItalic = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get underline() : Boolean
      {
         return mUnderline;
      }
      
      public function set underline(param1:Boolean) : void
      {
         if(mUnderline != param1)
         {
            mUnderline = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get kerning() : Boolean
      {
         return mKerning;
      }
      
      public function set kerning(param1:Boolean) : void
      {
         if(mKerning != param1)
         {
            mKerning = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get autoScale() : Boolean
      {
         return mAutoScale;
      }
      
      public function set autoScale(param1:Boolean) : void
      {
         if(mAutoScale != param1)
         {
            mAutoScale = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get autoSize() : String
      {
         return mAutoSize;
      }
      
      public function set autoSize(param1:String) : void
      {
         if(mAutoSize != param1)
         {
            mAutoSize = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get batchable() : Boolean
      {
         return mBatchable;
      }
      
      public function set batchable(param1:Boolean) : void
      {
         mBatchable = param1;
         if(mQuadBatch)
         {
            mQuadBatch.batchable = param1;
         }
      }
      
      public function get nativeFilters() : Array
      {
         return mNativeFilters;
      }
      
      public function set nativeFilters(param1:Array) : void
      {
         mNativeFilters = param1.concat();
         mRequiresRedraw = true;
      }
      
      public function get isHtmlText() : Boolean
      {
         return mIsHtmlText;
      }
      
      public function set isHtmlText(param1:Boolean) : void
      {
         if(mIsHtmlText != param1)
         {
            mIsHtmlText = param1;
            mRequiresRedraw = true;
         }
      }
      
      public function get leading() : Number
      {
         return mLeading;
      }
      
      public function set leading(param1:Number) : void
      {
         if(mLeading != param1)
         {
            mLeading = param1;
            mRequiresRedraw = true;
         }
      }
   }
}
