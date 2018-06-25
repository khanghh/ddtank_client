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
      
      public function BitmapFont(texture:Texture = null, fontXml:XML = null)
      {
         super();
         if(texture == null && fontXml == null)
         {
            texture = MiniBitmapFont.texture;
            fontXml = MiniBitmapFont.xml;
         }
         else if(texture != null && fontXml == null)
         {
            throw new ArgumentError("fontXml cannot be null!");
         }
         mName = "unknown";
         mBaseline = 14;
         mSize = 14;
         mLineHeight = 14;
         mOffsetY = 0;
         mOffsetX = 0;
         mTexture = texture;
         mChars = new Dictionary();
         mHelperImage = new Image(texture);
         parseFontXml(fontXml);
      }
      
      public function dispose() : void
      {
         if(mTexture)
         {
            mTexture.dispose();
         }
      }
      
      private function parseFontXml(fontXml:XML) : void
      {
         var id:int = 0;
         var xOffset:Number = NaN;
         var yOffset:Number = NaN;
         var xAdvance:Number = NaN;
         var region:* = null;
         var texture:* = null;
         var bitmapChar:* = null;
         var first:int = 0;
         var second:int = 0;
         var amount:Number = NaN;
         var scale:Number = mTexture.scale;
         var frame:Rectangle = mTexture.frame;
         var frameX:Number = !!frame?frame.x:0;
         var frameY:Number = !!frame?frame.y:0;
         mName = cleanMasterString(fontXml.info.@face);
         mSize = parseFloat(fontXml.info.@size) / scale;
         mLineHeight = parseFloat(fontXml.common.@lineHeight) / scale;
         mBaseline = parseFloat(fontXml.common.@base) / scale;
         if(fontXml.info.@smooth.toString() == "0")
         {
            smoothing = "none";
         }
         if(mSize <= 0)
         {
            trace("[Starling] Warning: invalid font size in \'" + mName + "\' font.");
            mSize = mSize == 0?16:Number(mSize * -1);
         }
         var _loc19_:int = 0;
         var _loc18_:* = fontXml.chars.char;
         for each(var charElement in fontXml.chars.char)
         {
            id = parseInt(charElement.@id);
            xOffset = parseFloat(charElement.@xoffset) / scale;
            yOffset = parseFloat(charElement.@yoffset) / scale;
            xAdvance = parseFloat(charElement.@xadvance) / scale;
            region = new Rectangle();
            region.x = parseFloat(charElement.@x) / scale + frameX;
            region.y = parseFloat(charElement.@y) / scale + frameY;
            region.width = parseFloat(charElement.@width) / scale;
            region.height = parseFloat(charElement.@height) / scale;
            texture = Texture.fromTexture(mTexture,region);
            bitmapChar = new BitmapChar(id,texture,xOffset,yOffset,xAdvance);
            addChar(id,bitmapChar);
         }
         var _loc21_:int = 0;
         var _loc20_:* = fontXml.kernings.kerning;
         for each(var kerningElement in fontXml.kernings.kerning)
         {
            first = parseInt(kerningElement.@first);
            second = parseInt(kerningElement.@second);
            amount = parseFloat(kerningElement.@amount) / scale;
            if(second in mChars)
            {
               getChar(second).addKerning(first,amount);
            }
         }
      }
      
      public function getChar(charID:int) : BitmapChar
      {
         return mChars[charID];
      }
      
      public function addChar(charID:int, bitmapChar:BitmapChar) : void
      {
         mChars[charID] = bitmapChar;
      }
      
      public function getCharIDs(result:Vector.<int> = null) : Vector.<int>
      {
         if(result == null)
         {
            result = new Vector.<int>(0);
         }
         var _loc4_:int = 0;
         var _loc3_:* = mChars;
         for(result[result.length] in mChars)
         {
         }
         return result;
      }
      
      public function hasChars(text:String) : Boolean
      {
         var charID:int = 0;
         var i:int = 0;
         if(text == null)
         {
            return true;
         }
         var numChars:int = text.length;
         for(i = 0; i < numChars; )
         {
            charID = text.charCodeAt(i);
            if(charID != 32 && charID != 9 && charID != 10 && charID != 13 && getChar(charID) == null)
            {
               return false;
            }
            i++;
         }
         return true;
      }
      
      public function createSprite(width:Number, height:Number, text:String, fontSize:Number = -1, color:uint = 16777215, hAlign:String = "center", vAlign:String = "center", autoScale:Boolean = true, kerning:Boolean = true) : Sprite
      {
         var i:int = 0;
         var charLocation:* = null;
         var char:* = null;
         var charLocations:Vector.<CharLocation> = arrangeChars(width,height,text,fontSize,hAlign,vAlign,autoScale,kerning);
         var numChars:int = charLocations.length;
         var sprite:Sprite = new Sprite();
         for(i = 0; i < numChars; )
         {
            charLocation = charLocations[i];
            char = charLocation.char.createImage();
            char.x = charLocation.x;
            char.y = charLocation.y;
            var _loc16_:* = charLocation.scale;
            char.scaleY = _loc16_;
            char.scaleX = _loc16_;
            char.color = color;
            sprite.addChild(char);
            i++;
         }
         CharLocation.rechargePool();
         return sprite;
      }
      
      public function fillQuadBatch(quadBatch:QuadBatch, width:Number, height:Number, text:String, fontSize:Number = -1, color:uint = 16777215, hAlign:String = "center", vAlign:String = "center", autoScale:Boolean = true, kerning:Boolean = true, leading:Number = 0) : void
      {
         var i:int = 0;
         var charLocation:* = null;
         var charLocations:Vector.<CharLocation> = arrangeChars(width,height,text,fontSize,hAlign,vAlign,autoScale,kerning,leading);
         var numChars:int = charLocations.length;
         mHelperImage.color = color;
         for(i = 0; i < numChars; )
         {
            charLocation = charLocations[i];
            mHelperImage.texture = charLocation.char.texture;
            mHelperImage.readjustSize();
            mHelperImage.x = charLocation.x;
            mHelperImage.y = charLocation.y;
            var _loc16_:* = charLocation.scale;
            mHelperImage.scaleY = _loc16_;
            mHelperImage.scaleX = _loc16_;
            quadBatch.addImage(mHelperImage);
            i++;
         }
         CharLocation.rechargePool();
      }
      
      private function arrangeChars(width:Number, height:Number, text:String, fontSize:Number = -1, hAlign:String = "center", vAlign:String = "center", autoScale:Boolean = true, kerning:Boolean = true, leading:Number = 0) : Vector.<CharLocation>
      {
         var charLocation:* = null;
         var numChars:int = 0;
         var containerWidth:Number = NaN;
         var containerHeight:Number = NaN;
         var scale:Number = NaN;
         var lastWhiteSpace:* = 0;
         var lastCharID:* = 0;
         var currentX:* = NaN;
         var currentY:* = NaN;
         var currentLine:* = undefined;
         var i:int = 0;
         var lineFull:Boolean = false;
         var charID:int = 0;
         var char:* = null;
         var numCharsToRemove:int = 0;
         var removeIndex:int = 0;
         var lineID:int = 0;
         var line:* = undefined;
         var xOffset:int = 0;
         var lastLocation:* = null;
         var right:Number = NaN;
         var c:int = 0;
         if(text == null || text.length == 0)
         {
            return CharLocation.vectorFromPool();
         }
         if(fontSize < 0)
         {
            fontSize = fontSize * -mSize;
         }
         var finished:Boolean = false;
         while(!finished)
         {
            sLines.length = 0;
            scale = fontSize / mSize;
            containerWidth = width / scale;
            containerHeight = height / scale;
            if(mLineHeight <= containerHeight)
            {
               lastWhiteSpace = -1;
               lastCharID = -1;
               currentX = 0;
               currentY = 0;
               currentLine = CharLocation.vectorFromPool();
               numChars = text.length;
               for(i = 0; i < numChars; i++)
               {
                  lineFull = false;
                  charID = text.charCodeAt(i);
                  char = getChar(charID);
                  if(charID == 10 || charID == 13)
                  {
                     lineFull = true;
                  }
                  else if(char == null)
                  {
                     trace("[Starling] Missing character: " + charID);
                  }
                  else
                  {
                     if(charID == 32 || charID == 9)
                     {
                        lastWhiteSpace = i;
                     }
                     if(kerning)
                     {
                        currentX = Number(currentX + char.getKerning(lastCharID));
                     }
                     charLocation = CharLocation.instanceFromPool(char);
                     charLocation.x = currentX + char.xOffset;
                     charLocation.y = currentY + char.yOffset;
                     currentLine[currentLine.length] = charLocation;
                     currentX = Number(currentX + char.xAdvance);
                     lastCharID = charID;
                     if(charLocation.x + char.width > containerWidth)
                     {
                        if(!(autoScale && lastWhiteSpace == -1))
                        {
                           numCharsToRemove = lastWhiteSpace == -1?1:Number(i - lastWhiteSpace);
                           removeIndex = currentLine.length - numCharsToRemove;
                           currentLine.splice(removeIndex,numCharsToRemove);
                           if(currentLine.length == 0)
                           {
                              break;
                           }
                           i = i - numCharsToRemove;
                           lineFull = true;
                        }
                        break;
                     }
                  }
                  if(i == numChars - 1)
                  {
                     sLines[sLines.length] = currentLine;
                     finished = true;
                  }
                  else if(lineFull)
                  {
                     sLines[sLines.length] = currentLine;
                     if(lastWhiteSpace == i)
                     {
                        currentLine.pop();
                     }
                     if(currentY + leading + 2 * mLineHeight <= containerHeight)
                     {
                        currentLine = CharLocation.vectorFromPool();
                        currentX = 0;
                        currentY = Number(currentY + (mLineHeight + leading));
                        lastWhiteSpace = -1;
                        lastCharID = -1;
                        continue;
                     }
                     break;
                  }
               }
            }
            if(autoScale && !finished && fontSize > 3)
            {
               fontSize = fontSize - 1;
            }
            else
            {
               finished = true;
            }
         }
         var finalLocations:Vector.<CharLocation> = CharLocation.vectorFromPool();
         var numLines:int = sLines.length;
         var bottom:Number = currentY + mLineHeight;
         var yOffset:int = 0;
         if(vAlign == "bottom")
         {
            yOffset = containerHeight - bottom;
         }
         else if(vAlign == "center")
         {
            yOffset = (containerHeight - bottom) / 2;
         }
         lineID = 0;
         while(lineID < numLines)
         {
            line = sLines[lineID];
            numChars = line.length;
            if(numChars != 0)
            {
               xOffset = 0;
               lastLocation = line[line.length - 1];
               right = lastLocation.x - lastLocation.char.xOffset + lastLocation.char.xAdvance;
               if(hAlign == "right")
               {
                  xOffset = containerWidth - right;
               }
               else if(hAlign == "center")
               {
                  xOffset = (containerWidth - right) / 2;
               }
               c = 0;
               while(c < numChars)
               {
                  charLocation = line[c];
                  charLocation.x = scale * (charLocation.x + xOffset + mOffsetX);
                  charLocation.y = scale * (charLocation.y + yOffset + mOffsetY);
                  charLocation.scale = scale;
                  if(charLocation.char.width > 0 && charLocation.char.height > 0)
                  {
                     finalLocations[finalLocations.length] = charLocation;
                  }
                  c++;
               }
            }
            lineID++;
         }
         return finalLocations;
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
      
      public function set lineHeight(value:Number) : void
      {
         mLineHeight = value;
      }
      
      public function get smoothing() : String
      {
         return mHelperImage.smoothing;
      }
      
      public function set smoothing(value:String) : void
      {
         mHelperImage.smoothing = value;
      }
      
      public function get baseline() : Number
      {
         return mBaseline;
      }
      
      public function set baseline(value:Number) : void
      {
         mBaseline = value;
      }
      
      public function get offsetX() : Number
      {
         return mOffsetX;
      }
      
      public function set offsetX(value:Number) : void
      {
         mOffsetX = value;
      }
      
      public function get offsetY() : Number
      {
         return mOffsetY;
      }
      
      public function set offsetY(value:Number) : void
      {
         mOffsetY = value;
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
   
   function CharLocation(char:BitmapChar)
   {
      super();
      reset(char);
   }
   
   public static function instanceFromPool(char:BitmapChar) : CharLocation
   {
      var instance:CharLocation = sInstancePool.length > 0?sInstancePool.pop():new CharLocation(char);
      instance.reset(char);
      sInstanceLoan[sInstanceLoan.length] = instance;
      return instance;
   }
   
   public static function vectorFromPool() : Vector.<CharLocation>
   {
      var vector:Vector.<CharLocation> = sVectorPool.length > 0?sVectorPool.pop():new Vector.<CharLocation>(0);
      vector.length = 0;
      sVectorLoan[sVectorLoan.length] = vector;
      return vector;
   }
   
   public static function rechargePool() : void
   {
      var instance:* = null;
      var vector:* = undefined;
      while(sInstanceLoan.length > 0)
      {
         instance = sInstanceLoan.pop();
         instance.char = null;
         sInstancePool[sInstancePool.length] = instance;
      }
      while(sVectorLoan.length > 0)
      {
         vector = sVectorLoan.pop();
         vector.length = 0;
         sVectorPool[sVectorPool.length] = vector;
      }
   }
   
   private function reset(char:BitmapChar) : CharLocation
   {
      this.char = char;
      return this;
   }
}
