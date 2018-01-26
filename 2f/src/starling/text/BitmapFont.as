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
      
      public function BitmapFont(param1:Texture = null, param2:XML = null){super();}
      
      public function dispose() : void{}
      
      private function parseFontXml(param1:XML) : void{}
      
      public function getChar(param1:int) : BitmapChar{return null;}
      
      public function addChar(param1:int, param2:BitmapChar) : void{}
      
      public function getCharIDs(param1:Vector.<int> = null) : Vector.<int>{return null;}
      
      public function hasChars(param1:String) : Boolean{return false;}
      
      public function createSprite(param1:Number, param2:Number, param3:String, param4:Number = -1, param5:uint = 16777215, param6:String = "center", param7:String = "center", param8:Boolean = true, param9:Boolean = true) : Sprite{return null;}
      
      public function fillQuadBatch(param1:QuadBatch, param2:Number, param3:Number, param4:String, param5:Number = -1, param6:uint = 16777215, param7:String = "center", param8:String = "center", param9:Boolean = true, param10:Boolean = true, param11:Number = 0) : void{}
      
      private function arrangeChars(param1:Number, param2:Number, param3:String, param4:Number = -1, param5:String = "center", param6:String = "center", param7:Boolean = true, param8:Boolean = true, param9:Number = 0) : Vector.<CharLocation>{return null;}
      
      public function get name() : String{return null;}
      
      public function get size() : Number{return 0;}
      
      public function get lineHeight() : Number{return 0;}
      
      public function set lineHeight(param1:Number) : void{}
      
      public function get smoothing() : String{return null;}
      
      public function set smoothing(param1:String) : void{}
      
      public function get baseline() : Number{return 0;}
      
      public function set baseline(param1:Number) : void{}
      
      public function get offsetX() : Number{return 0;}
      
      public function set offsetX(param1:Number) : void{}
      
      public function get offsetY() : Number{return 0;}
      
      public function set offsetY(param1:Number) : void{}
      
      public function get texture() : Texture{return null;}
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
   
   function CharLocation(param1:BitmapChar){super();}
   
   public static function instanceFromPool(param1:BitmapChar) : CharLocation{return null;}
   
   public static function vectorFromPool() : Vector.<CharLocation>{return null;}
   
   public static function rechargePool() : void{}
   
   private function reset(param1:BitmapChar) : CharLocation{return null;}
}
