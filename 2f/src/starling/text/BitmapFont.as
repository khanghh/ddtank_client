package starling.text{   import flash.geom.Rectangle;   import flash.utils.Dictionary;   import starling.display.Image;   import starling.display.QuadBatch;   import starling.display.Sprite;   import starling.textures.Texture;   import starling.utils.cleanMasterString;      public class BitmapFont   {            public static const NATIVE_SIZE:int = -1;            public static const MINI:String = "mini";            private static const CHAR_SPACE:int = 32;            private static const CHAR_TAB:int = 9;            private static const CHAR_NEWLINE:int = 10;            private static const CHAR_CARRIAGE_RETURN:int = 13;            private static var sLines:Array = [];                   private var mTexture:Texture;            private var mChars:Dictionary;            private var mName:String;            private var mSize:Number;            private var mLineHeight:Number;            private var mBaseline:Number;            private var mOffsetX:Number;            private var mOffsetY:Number;            private var mHelperImage:Image;            public function BitmapFont(texture:Texture = null, fontXml:XML = null) { super(); }
            public function dispose() : void { }
            private function parseFontXml(fontXml:XML) : void { }
            public function getChar(charID:int) : BitmapChar { return null; }
            public function addChar(charID:int, bitmapChar:BitmapChar) : void { }
            public function getCharIDs(result:Vector.<int> = null) : Vector.<int> { return null; }
            public function hasChars(text:String) : Boolean { return false; }
            public function createSprite(width:Number, height:Number, text:String, fontSize:Number = -1, color:uint = 16777215, hAlign:String = "center", vAlign:String = "center", autoScale:Boolean = true, kerning:Boolean = true) : Sprite { return null; }
            public function fillQuadBatch(quadBatch:QuadBatch, width:Number, height:Number, text:String, fontSize:Number = -1, color:uint = 16777215, hAlign:String = "center", vAlign:String = "center", autoScale:Boolean = true, kerning:Boolean = true, leading:Number = 0) : void { }
            private function arrangeChars(width:Number, height:Number, text:String, fontSize:Number = -1, hAlign:String = "center", vAlign:String = "center", autoScale:Boolean = true, kerning:Boolean = true, leading:Number = 0) : Vector.<CharLocation> { return null; }
            public function get name() : String { return null; }
            public function get size() : Number { return 0; }
            public function get lineHeight() : Number { return 0; }
            public function set lineHeight(value:Number) : void { }
            public function get smoothing() : String { return null; }
            public function set smoothing(value:String) : void { }
            public function get baseline() : Number { return 0; }
            public function set baseline(value:Number) : void { }
            public function get offsetX() : Number { return 0; }
            public function set offsetX(value:Number) : void { }
            public function get offsetY() : Number { return 0; }
            public function set offsetY(value:Number) : void { }
            public function get texture() : Texture { return null; }
   }}import starling.text.BitmapChar;class CharLocation{      private static var sInstancePool:Vector.<CharLocation> = new Vector.<CharLocation>(0);      private static var sVectorPool:Array = [];      private static var sInstanceLoan:Vector.<CharLocation> = new Vector.<CharLocation>(0);      private static var sVectorLoan:Array = [];          public var char:BitmapChar;      public var scale:Number;      public var x:Number;      public var y:Number;      function CharLocation(char:BitmapChar) { super(); }
      public static function instanceFromPool(char:BitmapChar) : CharLocation { return null; }
      public static function vectorFromPool() : Vector.<CharLocation> { return null; }
      public static function rechargePool() : void { }
      private function reset(char:BitmapChar) : CharLocation { return null; }
}