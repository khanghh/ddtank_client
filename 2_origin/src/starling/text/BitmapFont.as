package starling.text
{
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import starling.display.Image;
   import starling.display.QuadBatch;
   import starling.display.Sprite;
   import starling.textures.Texture;
   import starling.utils.cleanMasterString;
   
   public class BitmapFont
   {
      
      public static const NATIVE_SIZE:int = -1;
      
      public static const MINI:String = "mini";
      
      private static const CHAR_SPACE:int = 32;
      
      private static const CHAR_TAB:int = 9;
      
      private static const CHAR_NEWLINE:int = 10;
      
      private static const CHAR_CARRIAGE_RETURN:int = 13;
      
      private static var sLines:Array = [];
       
      
      private var mTexture:Texture;
      
      private var mChars:Dictionary;
      
      private var mName:String;
      
      private var mSize:Number;
      
      private var mLineHeight:Number;
      
      private var mBaseline:Number;
      
      private var mOffsetX:Number;
      
      private var mOffsetY:Number;
      
      private var mHelperImage:Image;
      
      public function BitmapFont(param1:Texture = null, param2:XML = null)
      {
         super();
         if(param1 == null && param2 == null)
         {
            param1 = MiniBitmapFont.texture;
            param2 = MiniBitmapFont.xml;
         }
         else if(param1 != null && param2 == null)
         {
            throw new ArgumentError("fontXml cannot be null!");
         }
         mName = "unknown";
         mBaseline = 14;
         mSize = 14;
         mLineHeight = 14;
         mOffsetY = 0;
         mOffsetX = 0;
         mTexture = param1;
         mChars = new Dictionary();
         mHelperImage = new Image(param1);
         parseFontXml(param2);
      }
      
      public function dispose() : void
      {
         if(mTexture)
         {
            mTexture.dispose();
         }
      }
      
      private function parseFontXml(param1:XML) : void
      {
         var _loc12_:int = 0;
         var _loc14_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc2_:* = null;
         var _loc8_:* = null;
         var _loc10_:* = null;
         var _loc16_:int = 0;
         var _loc5_:int = 0;
         var _loc11_:Number = NaN;
         var _loc3_:Number = mTexture.scale;
         var _loc13_:Rectangle = mTexture.frame;
         var _loc15_:Number = !!_loc13_?_loc13_.x:0;
         var _loc17_:Number = !!_loc13_?_loc13_.y:0;
         mName = cleanMasterString(param1.info.@face);
         mSize = parseFloat(param1.info.@size) / _loc3_;
         mLineHeight = parseFloat(param1.common.@lineHeight) / _loc3_;
         mBaseline = parseFloat(param1.common.@base) / _loc3_;
         if(param1.info.@smooth.toString() == "0")
         {
            smoothing = "none";
         }
         if(mSize <= 0)
         {
            trace("[Starling] Warning: invalid font size in \'" + mName + "\' font.");
            mSize = mSize == 0?16:Number(mSize * -1);
         }
         var _loc19_:int = 0;
         var _loc18_:* = param1.chars.char;
         for each(var _loc9_ in param1.chars.char)
         {
            _loc12_ = parseInt(_loc9_.@id);
            _loc14_ = parseFloat(_loc9_.@xoffset) / _loc3_;
            _loc4_ = parseFloat(_loc9_.@yoffset) / _loc3_;
            _loc7_ = parseFloat(_loc9_.@xadvance) / _loc3_;
            _loc2_ = new Rectangle();
            _loc2_.x = parseFloat(_loc9_.@x) / _loc3_ + _loc15_;
            _loc2_.y = parseFloat(_loc9_.@y) / _loc3_ + _loc17_;
            _loc2_.width = parseFloat(_loc9_.@width) / _loc3_;
            _loc2_.height = parseFloat(_loc9_.@height) / _loc3_;
            _loc8_ = Texture.fromTexture(mTexture,_loc2_);
            _loc10_ = new BitmapChar(_loc12_,_loc8_,_loc14_,_loc4_,_loc7_);
            addChar(_loc12_,_loc10_);
         }
         var _loc21_:int = 0;
         var _loc20_:* = param1.kernings.kerning;
         for each(var _loc6_ in param1.kernings.kerning)
         {
            _loc16_ = parseInt(_loc6_.@first);
            _loc5_ = parseInt(_loc6_.@second);
            _loc11_ = parseFloat(_loc6_.@amount) / _loc3_;
            if(_loc5_ in mChars)
            {
               getChar(_loc5_).addKerning(_loc16_,_loc11_);
            }
         }
      }
      
      public function getChar(param1:int) : BitmapChar
      {
         return mChars[param1];
      }
      
      public function addChar(param1:int, param2:BitmapChar) : void
      {
         mChars[param1] = param2;
      }
      
      public function getCharIDs(param1:Vector.<int> = null) : Vector.<int>
      {
         if(param1 == null)
         {
            param1 = new Vector.<int>(0);
         }
         var _loc4_:int = 0;
         var _loc3_:* = mChars;
         for(param1[param1.length] in mChars)
         {
         }
         return param1;
      }
      
      public function hasChars(param1:String) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         if(param1 == null)
         {
            return true;
         }
         var _loc2_:int = param1.length;
         _loc4_ = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = param1.charCodeAt(_loc4_);
            if(_loc3_ != 32 && _loc3_ != 9 && _loc3_ != 10 && _loc3_ != 13 && getChar(_loc3_) == null)
            {
               return false;
            }
            _loc4_++;
         }
         return true;
      }
      
      public function createSprite(param1:Number, param2:Number, param3:String, param4:Number = -1, param5:uint = 16777215, param6:String = "center", param7:String = "center", param8:Boolean = true, param9:Boolean = true) : Sprite
      {
         var _loc14_:int = 0;
         var _loc15_:* = null;
         var _loc12_:* = null;
         var _loc11_:Vector.<CharLocation> = arrangeChars(param1,param2,param3,param4,param6,param7,param8,param9);
         var _loc10_:int = _loc11_.length;
         var _loc13_:Sprite = new Sprite();
         _loc14_ = 0;
         while(_loc14_ < _loc10_)
         {
            _loc15_ = _loc11_[_loc14_];
            _loc12_ = _loc15_.char.createImage();
            _loc12_.x = _loc15_.x;
            _loc12_.y = _loc15_.y;
            var _loc16_:* = _loc15_.scale;
            _loc12_.scaleY = _loc16_;
            _loc12_.scaleX = _loc16_;
            _loc12_.color = param5;
            _loc13_.addChild(_loc12_);
            _loc14_++;
         }
         CharLocation.rechargePool();
         return _loc13_;
      }
      
      public function fillQuadBatch(param1:QuadBatch, param2:Number, param3:Number, param4:String, param5:Number = -1, param6:uint = 16777215, param7:String = "center", param8:String = "center", param9:Boolean = true, param10:Boolean = true, param11:Number = 0) : void
      {
         var _loc14_:int = 0;
         var _loc15_:* = null;
         var _loc13_:Vector.<CharLocation> = arrangeChars(param2,param3,param4,param5,param7,param8,param9,param10,param11);
         var _loc12_:int = _loc13_.length;
         mHelperImage.color = param6;
         _loc14_ = 0;
         while(_loc14_ < _loc12_)
         {
            _loc15_ = _loc13_[_loc14_];
            mHelperImage.texture = _loc15_.char.texture;
            mHelperImage.readjustSize();
            mHelperImage.x = _loc15_.x;
            mHelperImage.y = _loc15_.y;
            var _loc16_:* = _loc15_.scale;
            mHelperImage.scaleY = _loc16_;
            mHelperImage.scaleX = _loc16_;
            param1.addImage(mHelperImage);
            _loc14_++;
         }
         CharLocation.rechargePool();
      }
      
      private function arrangeChars(param1:Number, param2:Number, param3:String, param4:Number = -1, param5:String = "center", param6:String = "center", param7:Boolean = true, param8:Boolean = true, param9:Number = 0) : Vector.<CharLocation>
      {
         var _loc32_:* = null;
         var _loc21_:int = 0;
         var _loc14_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc10_:* = 0;
         var _loc27_:* = 0;
         var _loc36_:* = NaN;
         var _loc34_:* = NaN;
         var _loc30_:* = undefined;
         var _loc29_:int = 0;
         var _loc25_:Boolean = false;
         var _loc18_:int = 0;
         var _loc15_:* = null;
         var _loc16_:int = 0;
         var _loc19_:int = 0;
         var _loc35_:int = 0;
         var _loc17_:* = undefined;
         var _loc31_:int = 0;
         var _loc28_:* = null;
         var _loc20_:Number = NaN;
         var _loc23_:int = 0;
         if(param3 == null || param3.length == 0)
         {
            return CharLocation.vectorFromPool();
         }
         if(param4 < 0)
         {
            param4 = param4 * -mSize;
         }
         var _loc26_:Boolean = false;
         while(!_loc26_)
         {
            sLines.length = 0;
            _loc11_ = param4 / mSize;
            _loc14_ = param1 / _loc11_;
            _loc24_ = param2 / _loc11_;
            if(mLineHeight <= _loc24_)
            {
               _loc10_ = -1;
               _loc27_ = -1;
               _loc36_ = 0;
               _loc34_ = 0;
               _loc30_ = CharLocation.vectorFromPool();
               _loc21_ = param3.length;
               _loc29_ = 0;
               for(; _loc29_ < _loc21_; _loc29_++)
               {
                  _loc25_ = false;
                  _loc18_ = param3.charCodeAt(_loc29_);
                  _loc15_ = getChar(_loc18_);
                  if(_loc18_ == 10 || _loc18_ == 13)
                  {
                     _loc25_ = true;
                  }
                  else if(_loc15_ == null)
                  {
                     trace("[Starling] Missing character: " + _loc18_);
                  }
                  else
                  {
                     if(_loc18_ == 32 || _loc18_ == 9)
                     {
                        _loc10_ = _loc29_;
                     }
                     if(param8)
                     {
                        _loc36_ = Number(_loc36_ + _loc15_.getKerning(_loc27_));
                     }
                     _loc32_ = CharLocation.instanceFromPool(_loc15_);
                     _loc32_.x = _loc36_ + _loc15_.xOffset;
                     _loc32_.y = _loc34_ + _loc15_.yOffset;
                     _loc30_[_loc30_.length] = _loc32_;
                     _loc36_ = Number(_loc36_ + _loc15_.xAdvance);
                     _loc27_ = _loc18_;
                     if(_loc32_.x + _loc15_.width > _loc14_)
                     {
                        if(!(param7 && _loc10_ == -1))
                        {
                           _loc16_ = _loc10_ == -1?1:Number(_loc29_ - _loc10_);
                           _loc19_ = _loc30_.length - _loc16_;
                           _loc30_.splice(_loc19_,_loc16_);
                           if(_loc30_.length != 0)
                           {
                              _loc29_ = _loc29_ - _loc16_;
                              _loc25_ = true;
                           }
                           break;
                        }
                        break;
                     }
                  }
                  if(_loc29_ == _loc21_ - 1)
                  {
                     sLines[sLines.length] = _loc30_;
                     _loc26_ = true;
                  }
                  else if(_loc25_)
                  {
                     sLines[sLines.length] = _loc30_;
                     if(_loc10_ == _loc29_)
                     {
                        _loc30_.pop();
                     }
                     if(_loc34_ + param9 + 2 * mLineHeight <= _loc24_)
                     {
                        _loc30_ = CharLocation.vectorFromPool();
                        _loc36_ = 0;
                        _loc34_ = Number(_loc34_ + (mLineHeight + param9));
                        _loc10_ = -1;
                        _loc27_ = -1;
                        continue;
                     }
                     break;
                  }
               }
            }
            if(param7 && !_loc26_ && param4 > 3)
            {
               param4 = param4 - 1;
            }
            else
            {
               _loc26_ = true;
            }
         }
         var _loc22_:Vector.<CharLocation> = CharLocation.vectorFromPool();
         var _loc13_:int = sLines.length;
         var _loc33_:Number = _loc34_ + mLineHeight;
         var _loc12_:int = 0;
         if(param6 == "bottom")
         {
            _loc12_ = _loc24_ - _loc33_;
         }
         else if(param6 == "center")
         {
            _loc12_ = (_loc24_ - _loc33_) / 2;
         }
         _loc35_ = 0;
         while(_loc35_ < _loc13_)
         {
            _loc17_ = sLines[_loc35_];
            _loc21_ = _loc17_.length;
            if(_loc21_ != 0)
            {
               _loc31_ = 0;
               _loc28_ = _loc17_[_loc17_.length - 1];
               _loc20_ = _loc28_.x - _loc28_.char.xOffset + _loc28_.char.xAdvance;
               if(param5 == "right")
               {
                  _loc31_ = _loc14_ - _loc20_;
               }
               else if(param5 == "center")
               {
                  _loc31_ = (_loc14_ - _loc20_) / 2;
               }
               _loc23_ = 0;
               while(_loc23_ < _loc21_)
               {
                  _loc32_ = _loc17_[_loc23_];
                  _loc32_.x = _loc11_ * (_loc32_.x + _loc31_ + mOffsetX);
                  _loc32_.y = _loc11_ * (_loc32_.y + _loc12_ + mOffsetY);
                  _loc32_.scale = _loc11_;
                  if(_loc32_.char.width > 0 && _loc32_.char.height > 0)
                  {
                     _loc22_[_loc22_.length] = _loc32_;
                  }
                  _loc23_++;
               }
            }
            _loc35_++;
         }
         return _loc22_;
      }
      
      public function get name() : String
      {
         return mName;
      }
      
      public function get size() : Number
      {
         return mSize;
      }
      
      public function get lineHeight() : Number
      {
         return mLineHeight;
      }
      
      public function set lineHeight(param1:Number) : void
      {
         mLineHeight = param1;
      }
      
      public function get smoothing() : String
      {
         return mHelperImage.smoothing;
      }
      
      public function set smoothing(param1:String) : void
      {
         mHelperImage.smoothing = param1;
      }
      
      public function get baseline() : Number
      {
         return mBaseline;
      }
      
      public function set baseline(param1:Number) : void
      {
         mBaseline = param1;
      }
      
      public function get offsetX() : Number
      {
         return mOffsetX;
      }
      
      public function set offsetX(param1:Number) : void
      {
         mOffsetX = param1;
      }
      
      public function get offsetY() : Number
      {
         return mOffsetY;
      }
      
      public function set offsetY(param1:Number) : void
      {
         mOffsetY = param1;
      }
      
      public function get texture() : Texture
      {
         return mTexture;
      }
   }
}

import starling.text.BitmapChar;

class CharLocation
{
   
   private static var sInstancePool:Vector.<CharLocation> = new Vector.<CharLocation>(0);
   
   private static var sVectorPool:Array = [];
   
   private static var sInstanceLoan:Vector.<CharLocation> = new Vector.<CharLocation>(0);
   
   private static var sVectorLoan:Array = [];
    
   
   public var char:BitmapChar;
   
   public var scale:Number;
   
   public var x:Number;
   
   public var y:Number;
   
   function CharLocation(param1:BitmapChar)
   {
      super();
      reset(param1);
   }
   
   public static function instanceFromPool(param1:BitmapChar) : CharLocation
   {
      var _loc2_:CharLocation = sInstancePool.length > 0?sInstancePool.pop():new CharLocation(param1);
      _loc2_.reset(param1);
      sInstanceLoan[sInstanceLoan.length] = _loc2_;
      return _loc2_;
   }
   
   public static function vectorFromPool() : Vector.<CharLocation>
   {
      var _loc1_:Vector.<CharLocation> = sVectorPool.length > 0?sVectorPool.pop():new Vector.<CharLocation>(0);
      _loc1_.length = 0;
      sVectorLoan[sVectorLoan.length] = _loc1_;
      return _loc1_;
   }
   
   public static function rechargePool() : void
   {
      var _loc2_:* = null;
      var _loc1_:* = undefined;
      while(sInstanceLoan.length > 0)
      {
         _loc2_ = sInstanceLoan.pop();
         _loc2_.char = null;
         sInstancePool[sInstancePool.length] = _loc2_;
      }
      while(sVectorLoan.length > 0)
      {
         _loc1_ = sVectorLoan.pop();
         _loc1_.length = 0;
         sVectorPool[sVectorPool.length] = _loc1_;
      }
   }
   
   private function reset(param1:BitmapChar) : CharLocation
   {
      this.char = param1;
      return this;
   }
}
